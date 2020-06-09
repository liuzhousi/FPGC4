"""IL commands for mathematical operations."""

import shivyc.asm_cmds as asm_cmds
import shivyc.spots as spots
from shivyc.il_cmds.base import ILCommand


class _AddMult(ILCommand):
    """Base class for ADD, MULT, and SUB."""

    # Indicates whether this instruction is commutative. If not,
    # a "neg" instruction is inserted when the order is flipped. Override
    # this value in subclasses.
    comm = False

    # The ASM instruction to generate for this command. Override this value
    # in subclasses.
    Inst = None

    def __init__(self, output, arg1, arg2): # noqa D102
        self.output = output
        self.arg1 = arg1
        self.arg2 = arg2

    def inputs(self): # noqa D102
        return [self.arg1, self.arg2]

    def outputs(self): # noqa D102
        return [self.output]

    def rel_spot_pref(self): # noqa D102
        return {self.output: [self.arg1, self.arg2]}

    def make_asm(self, spotmap, home_spots, get_reg, asm_code): # noqa D102
        """Make the ASM for ADD, MULT, and SUB."""
        ctype = self.arg1.ctype
        size = ctype.size

        arg1_spot = spotmap[self.arg1]
        arg2_spot = spotmap[self.arg2]

        # Get temp register for computation.
        temp = get_reg([spotmap[self.output],
                        arg1_spot,
                        arg2_spot])

        if temp == arg1_spot:
            if not self._is_imm64(arg2_spot):
                asm_code.add(self.Inst(temp, arg2_spot, size))
            
        elif temp == arg2_spot:
            if not self._is_imm64(arg1_spot):
                #print("todo2")

                if isinstance(arg1_spot, spots.LiteralSpot):
                    asm_code.add(asm_cmds.Load(arg1_spot, spots.RegSpot("r12"), size))
                elif isinstance(arg1_spot, spots.MemSpot):
                    asm_code.add(asm_cmds.Read(arg1_spot, spots.RegSpot("r12"), size))
                elif isinstance(arg1_spot, spots.RegSpot):
                    asm_code.add(asm_cmds.Mov(spots.RegSpot("r12"), arg1_spot, size))

                asm_code.add(self.Inst(temp, spots.RegSpot("r12"), size))
            

            if not self.comm:
                #print("todo3")
                asm_code.add(asm_cmds.Neg(temp, size))

        else:
            if (not self._is_imm64(arg1_spot) and
                 not self._is_imm64(arg2_spot)):

                if isinstance(arg1_spot, spots.RegSpot) and isinstance(arg2_spot, spots.RegSpot):
                    asm_code.add(asm_cmds.Mov(temp, arg1_spot, size))
                    asm_code.add(self.Inst(temp, arg2_spot, size))

                elif isinstance(arg2_spot, spots.LiteralSpot):
                    if isinstance(arg1_spot, spots.MemSpot):
                        asm_code.add(asm_cmds.Read(arg1_spot, temp, size))
                    else:
                        asm_code.add(asm_cmds.Mov(temp, arg1_spot, size))
                    asm_code.add(self.Inst(temp, arg2_spot, size))


                else:    
                    asm_code.add(asm_cmds.Read(arg1_spot, temp, size))
                    asm_code.add(asm_cmds.Read(arg2_spot, spots.RegSpot("r12"), size))
                    asm_code.add(self.Inst(temp, spots.RegSpot("r12"), size))
            

            else:  # both are imm64
                raise NotImplementedError(
                    "never reach because of constant folding")

        if temp != spotmap[self.output]:
            asm_code.add(asm_cmds.Mov(spotmap[self.output], temp, size))


class Add(_AddMult):
    """Adds arg1 and arg2, then saves to output.

    IL values output, arg1, arg2 must all have the same type. No type
    conversion or promotion is done here.
    """
    comm = True
    Inst = asm_cmds.Add


class Subtr(_AddMult):
    """Subtracts arg1 and arg2, then saves to output.

    ILValues output, arg1, and arg2 must all have types of the same size.
    """
    comm = False
    Inst = asm_cmds.Sub


class Mult(_AddMult):
    """Multiplies arg1 and arg2, then saves to output.

    IL values output, arg1, arg2 must all have the same type. No type
    conversion or promotion is done here.
    """
    comm = True
    Inst = asm_cmds.Mult


class _BitShiftCmd(ILCommand):
    """Base class for bitwise shift commands."""

    # The ASM instruction to generate for this command. Override this value
    # in subclasses.
    Inst = None

    def __init__(self, output, arg1, arg2): # noqa D102
        self.output = output
        self.arg1 = arg1
        self.arg2 = arg2

    def inputs(self): # noqa D102
        return [self.arg1, self.arg2]

    def outputs(self): # noqa D102
        return [self.output]

    def clobber(self):  # noqa D102
        return [spots.RCX]

    def abs_spot_pref(self): # noqa D102
        return {self.arg2: [spots.RCX]}

    def rel_spot_pref(self): # noqa D102
        return {self.output: [self.arg1]}

    def make_asm(self, spotmap, home_spots, get_reg, asm_code): # noqa D102
        arg1_spot = spotmap[self.arg1]
        arg1_size = self.arg1.ctype.size
        arg2_spot = spotmap[self.arg2]
        arg2_size = self.arg2.ctype.size

        # todo optimize this
        if not self._is_imm8(arg2_spot) and arg2_spot != spots.RCX:
            if arg1_spot == spots.RCX:
                out_spot = spotmap[self.output]
                temp_spot = get_reg([out_spot, arg1_spot],
                                    [arg2_spot, spots.RCX])
                asm_code.add(asm_cmds.Mov(temp_spot, arg1_spot, arg1_size))
                arg1_spot = temp_spot
            asm_code.add(asm_cmds.Mov(spots.RCX, arg2_spot, arg2_size))
            arg2_spot = spots.RCX

        if spotmap[self.output] == arg1_spot:
            asm_code.add(self.Inst(arg1_spot, arg2_spot, arg1_size))
        else:
            out_spot = spotmap[self.output]
            temp_spot = get_reg([out_spot, arg1_spot], [arg2_spot])
            if arg1_spot != temp_spot:
                asm_code.add(asm_cmds.Mov(temp_spot, arg1_spot, arg1_size))
            asm_code.add(self.Inst(temp_spot, arg2_spot, arg1_size))
            if temp_spot != out_spot:
                asm_code.add(asm_cmds.Mov(out_spot, temp_spot, arg1_size))


class RBitShift(_BitShiftCmd):
    """Right bitwise shift operator for IL value.
    Shifts each bit in IL value left operand to the right by position
    indicated by right operand."""

    Inst = asm_cmds.Shiftr


class LBitShift(_BitShiftCmd):
    """Left bitwise shift operator for IL value.
    Shifts each bit in IL value left operand to the left by position
    indicated by right operand."""

    Inst = asm_cmds.Shiftl



class _AndOrXorCmd(ILCommand):
    """Base class for bitwise And Or and Xor commands.
    A plain copy of the _BitShiftCmd class"""

    # The ASM instruction to generate for this command. Override this value
    # in subclasses.
    Inst = None

    def __init__(self, output, arg1, arg2): # noqa D102
        self.output = output
        self.arg1 = arg1
        self.arg2 = arg2

    def inputs(self): # noqa D102
        return [self.arg1, self.arg2]

    def outputs(self): # noqa D102
        return [self.output]

    def clobber(self):  # noqa D102
        return [spots.RCX]

    def abs_spot_pref(self): # noqa D102
        return {self.arg2: [spots.RCX]}

    def rel_spot_pref(self): # noqa D102
        return {self.output: [self.arg1]}

    def make_asm(self, spotmap, home_spots, get_reg, asm_code): # noqa D102
        arg1_spot = spotmap[self.arg1]
        arg1_size = self.arg1.ctype.size
        arg2_spot = spotmap[self.arg2]
        arg2_size = self.arg2.ctype.size

        # todo optimize this
        if not self._is_imm8(arg2_spot) and arg2_spot != spots.RCX:
            if arg1_spot == spots.RCX:
                out_spot = spotmap[self.output]
                temp_spot = get_reg([out_spot, arg1_spot],
                                    [arg2_spot, spots.RCX])
                asm_code.add(asm_cmds.Mov(temp_spot, arg1_spot, arg1_size))
                arg1_spot = temp_spot
            asm_code.add(asm_cmds.Mov(spots.RCX, arg2_spot, arg2_size))
            arg2_spot = spots.RCX

        if spotmap[self.output] == arg1_spot:
            asm_code.add(self.Inst(arg1_spot, arg2_spot, arg1_size))
        else:
            out_spot = spotmap[self.output]
            temp_spot = get_reg([out_spot, arg1_spot], [arg2_spot])
            if arg1_spot != temp_spot:
                asm_code.add(asm_cmds.Mov(temp_spot, arg1_spot, arg1_size))
            asm_code.add(self.Inst(temp_spot, arg2_spot, arg1_size))
            if temp_spot != out_spot:
                asm_code.add(asm_cmds.Mov(out_spot, temp_spot, arg1_size))


class And(_AndOrXorCmd):
    """Bitwise AND"""

    Inst = asm_cmds.And


class Or(_AndOrXorCmd):
    """Bitwise OR"""

    Inst = asm_cmds.Or

class Xor(_AndOrXorCmd):
    """Bitwise XOR"""

    Inst = asm_cmds.Xor



class _DivMod(ILCommand):
    """Base class for ILCommand Div and Mod."""

    # Register which contains the value we want after the x86 div or idiv
    # command is executed. For the Div IL command, this is spots.RAX,
    # and for the Mod IL command, this is spots.RDX.
    return_reg = None

    def __init__(self, output, arg1, arg2):
        self.output = output
        self.arg1 = arg1
        self.arg2 = arg2

    def inputs(self):  # noqa D102
        return [self.arg1, self.arg2]

    def outputs(self):  # noqa D102
        return [self.output]

    def clobber(self):  # noqa D102
        return [spots.RAX, spots.RDX]

    def abs_spot_conf(self): # noqa D102
        return {self.arg2: [spots.RDX, spots.RAX]}

    def abs_spot_pref(self): # noqa D102
        return {self.output: [self.return_reg],
                self.arg1: [spots.RAX]}

    def make_asm(self, spotmap, home_spots, get_reg, asm_code): # noqa D102
        raise NotImplementedError 
        # div and mod are not implemented in b332
        # to make them work, they need to be converted to a series of equivalent instructions


class Div(_DivMod):
    """Divides given IL values.

    IL values output, arg1, arg2 must all have the same type of size at least
    int. No type conversion or promotion is done here.

    """

    return_reg = spots.RAX


class Mod(_DivMod):
    """Divides given IL values.

    IL values output, arg1, arg2 must all have the same type of size at least
    int. No type conversion or promotion is done here.

    """

    return_reg = spots.RDX


class _NegNot(ILCommand):
    """Base class for NEG and NOT."""

    # The ASM instruction to generate for this command. Override this value
    # in subclasses.
    Inst = None

    def __init__(self, output, arg):  # noqa D102
        self.output = output
        self.arg = arg

    def inputs(self):  # noqa D102
        return [self.arg]

    def outputs(self):  # noqa D102
        return [self.output]

    def rel_spot_pref(self):  # noqa D102
        return {self.output: [self.arg]}

    def make_asm(self, spotmap, home_spots, get_reg, asm_code): # noqa D102
        size = self.arg.ctype.size

        output_spot = spotmap[self.output]
        arg_spot = spotmap[self.arg]

        if output_spot != arg_spot:
            asm_code.add(asm_cmds.Mov(output_spot, arg_spot, size))
        asm_code.add(asm_cmds.Not(output_spot, size))


class Neg(_NegNot):
    """Negates given IL value (two's complement).

    No type promotion is done here.

    """

    # for B322 we just do a not



class Not(_NegNot):
    """Logically negates each bit of given IL value (one's complement).

    No type promotion is done here.

    """

    # for B322 we just do a not