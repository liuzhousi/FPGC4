"""This module defines and implements classes representing assembly commands.

The _ASMCommand object is the base class for most ASM commands. Some commands
inherit from _ASMCommandMultiSize or _JumpCommand instead.

"""

import shivyc.spots as spots

class _B322Base2Command:
    """Base class for a command with 2 args

    """

    name = None

    def __init__(self, arg1=None, arg2=None, size=None):
        self.arg1 = arg1.asm_str(size) if arg1 else None
        self.arg2 = arg2.asm_str(size) if arg2 else None
        self.size = size

    def __str__(self):
        s = "\t" + self.name
        if self.arg1:
            s += " " + self.arg1
        if self.arg2:
            s += " " + self.arg2
        return s








class Load(_B322Base2Command): name = "load"

class Write:
    name = None

    def __init__(self, arg1=None, arg2=None, size=None):
        self.arg1 = arg1
        self.arg2 = arg2
        self.size = size

    def __str__(self):


        s = ""
        if not isinstance(self.arg1, spots.MemSpot):
            s += "\twrite"

            s += " " + "0"
            if self.arg1:
                s += " " + str(self.arg1.asm_str(self.size))
            if self.arg2:
                s += " " + self.arg2.asm_str(self.size)

        else:
            s += "\twrite"

            if isinstance(self.arg1.count, spots.LiteralSpot):
                s += " " + str(self.arg1.offset + (self.arg1.chunk * self.arg1.count.value))
            else:
                s += " " + str(self.arg1.offset)
            if self.arg1:
                s += " " + str(self.arg1.base)
            if self.arg2:
                s += " " + self.arg2.asm_str(self.size)
        return s


class Read:
    name = None

    def __init__(self, arg1=None, arg2=None, size=None):
        self.arg1 = arg1
        self.arg2 = arg2
        self.size = size

    def __str__(self):
        s = ""
        if not isinstance(self.arg1, spots.MemSpot):
            s += "\tread"

            s += " " + "0"
            if self.arg1:
                s += " " + str(self.arg1.asm_str(self.size))
            if self.arg2:
                s += " " + self.arg2.asm_str(self.size)

        else:
            s += "\tread"

            if isinstance(self.arg1.count, spots.LiteralSpot):
                s += " " + str(self.arg1.offset + (self.arg1.chunk * self.arg1.count.value))
            else:
                s += " " + str(self.arg1.offset)
            if self.arg1:
                s += " " + str(self.arg1.base)
            if self.arg2:
                s += " " + self.arg2.asm_str(self.size)

        return s


class Mov:
    "move by using logical or with zero (r0)"
    name = None

    def __init__(self, arg1=None, arg2=None, size=None):
        self.arg1 = arg1.asm_str(size)
        self.arg2 = arg2.asm_str(size)
        self.size = size

    def __str__(self):
        s = "\tor"
        if self.arg1:
            s += " r0"
        if self.arg2:
            s += " " + self.arg2
        if self.arg1:
            s += " " + self.arg1
        return s




class Add:
    name = "add"

    def __init__(self, arg1=None, arg2=None, size=None):
        self.arg1 = arg1.asm_str(size) if arg1 else None
        self.arg2 = arg2.asm_str(size) if arg2 else None
        self.size = size

    def __str__(self):
        s = "\t" + self.name
        if self.arg1:
            s += " " + self.arg1
        if self.arg2:
            s += " " + self.arg2
        if self.arg1:
            s += " " + self.arg1
        return s



class Sub:
    name = "sub"

    def __init__(self, arg1=None, arg2=None, size=None):
        self.arg1 = arg1.asm_str(size) if arg1 else None
        self.arg2 = arg2.asm_str(size) if arg2 else None
        self.size = size

    def __str__(self):
        s = "\t" + self.name
        if self.arg1:
            s += " " + self.arg1
        if self.arg2:
            s += " " + self.arg2
        if self.arg1:
            s += " " + self.arg1
        return s



class Mult:
    name = "mult"

    def __init__(self, arg1=None, arg2=None, size=None):
        self.arg1 = arg1.asm_str(size)
        self.arg2 = arg2.asm_str(size)

    def __str__(self):
        s = "\t" + self.name
        s += " " + self.arg1
        s += " " + self.arg2
        s += " " + self.arg1
        return s


class Cmp:
    name = "sub"

    def __init__(self, arg1=None, arg2=None, size=None):
        self.arg1 = arg1.asm_str(size) if arg1 else None
        self.arg2 = arg2.asm_str(size) if arg2 else None
        self.size = size

    def __str__(self):
        s = "\t" + self.name
        if self.arg1:
            s += " " + self.arg1
        if self.arg2:
            s += " " + self.arg2
        if self.arg1:
            s += " " + spots.RegSpot("r12").asm_str(self.size)
        return s

class Bge:
    name = "bge"

    def __init__(self, arg1=None, arg2=None, arg3=None):
        self.arg1 = arg1.asm_str(0)
        self.arg2 = arg2.asm_str(0)
        self.arg3 = arg3.asm_str(0)

    def __str__(self):
        s = "\t" + self.name
        s += " " + self.arg1
        s += " " + self.arg2
        s += " " + self.arg3
        return s

class Bgt:
    name = "bgt"

    def __init__(self, arg1=None, arg2=None, arg3=None):
        self.arg1 = arg1.asm_str(0)
        self.arg2 = arg2.asm_str(0)
        self.arg3 = arg3.asm_str(0)

    def __str__(self):
        s = "\t" + self.name
        s += " " + self.arg1
        s += " " + self.arg2
        s += " " + self.arg3
        return s

class Bne:
    name = "bne"

    def __init__(self, arg1=None, arg2=None, arg3=None):
        self.arg1 = arg1.asm_str(0)
        self.arg2 = arg2.asm_str(0)
        self.arg3 = arg3.asm_str(0)

    def __str__(self):
        s = "\t" + self.name
        s += " " + self.arg1
        s += " " + self.arg2
        s += " " + self.arg3
        return s

class Beq:
    name = "beq"

    def __init__(self, arg1=None, arg2=None, arg3=None):
        self.arg1 = arg1.asm_str(0)
        self.arg2 = arg2.asm_str(0)
        self.arg3 = arg3.asm_str(0)

    def __str__(self):
        s = "\t" + self.name
        s += " " + self.arg1
        s += " " + self.arg2
        s += " " + self.arg3
        return s

class Addr2Reg:
    """Class for addr2reg command."""

    name = "addr2reg"

    def __init__(self, dest, source):  # noqa: D102
        self.dest = dest
        self.source = source

    def __str__(self):  # noqa: D102
        return ("\t" + self.name + " Label_" + self.dest.asm_str(0) + " "
                "" + self.source.asm_str(0))

class SavPC:
    """Class for savpc command."""

    name = "savpc"

    def __init__(self, dest):  # noqa: D102
        self.dest = dest

    def __str__(self):  # noqa: D102
        return ("\t" + self.name + " " + self.dest.asm_str(0))



class Jumpr:

    name = "jumpr"

    def __init__(self, offset=None, dest=None, size=None):
        self.offset = offset.asm_str(size)
        self.dest = dest.asm_str(size)
        self.size = size

    def __str__(self):
        s = "\t" + self.name
        s += " " + self.offset
        s += " " + self.dest
        return s

class Jump:

    name = "jump"

    def __init__(self, dest=None, size=None):
        self.dest = dest
        self.size = size

    def __str__(self):
        s = "\t" + self.name
        s += " Label_" + self.dest
        return s




class _ASMCommand:
    """Base class for a standard ASMCommand, like `add` or `imul`.

    This class is used for ASM commands which take arguments of the same
    size.
    """

    name = None

    def __init__(self, dest=None, source=None, size=None):
        self.dest = dest.asm_str(size) if dest else None
        self.source = source.asm_str(size) if source else None
        self.size = size

    def __str__(self):
        s = "\t" + self.name
        if self.dest:
            s += " " + self.dest
        if self.source:
            s += ", " + self.source
        return s


class _ASMCommandMultiSize:
    """Base class for an ASMCommand which takes arguments of different sizes.

    For example, `movsx` and `movzx`.
    """

    name = None

    def __init__(self, dest, source, source_size, dest_size):
        self.dest = dest.asm_str(source_size)
        self.source = source.asm_str(dest_size)
        self.source_size = source_size
        self.dest_size = dest_size

    def __str__(self):
        s = "\t" + self.name
        if self.dest:
            s += " " + self.dest
        if self.source:
            s += ", " + self.source
        return s


class _JumpCommand:
    """Base class for jump commands."""

    name = None

    def __init__(self, target):
        self.target = target

    def __str__(self):
        s = "\t" + self.name + " " + self.target
        return s



class Comment:
    """Class for comments."""

    def __init__(self, msg):  # noqa: D102
        self.msg = msg

    def __str__(self):  # noqa: D102
        return "\t; " + self.msg


class Label:
    """Class for label."""

    def __init__(self, label):  # noqa: D102
        self.label = label

    def __str__(self):  # noqa: D102
        return "Label_" + self.label + ":"


class Lea:
    """Class for lea command."""

    name = "lea"

    def __init__(self, dest, source):  # noqa: D102
        self.dest = dest
        self.source = source

    def __str__(self):  # noqa: D102
        return ("\t" + self.name + " " + self.dest.asm_str(8) + ", "
                "" + self.source.asm_str(0))


class Je(_JumpCommand): name = "je"  # noqa: D101


class Jne(_JumpCommand): name = "jne"  # noqa: D101


class Jg(_JumpCommand): name = "jg"  # noqa: D101


class Jge(_JumpCommand): name = "jge"  # noqa: D101


class Jl(_JumpCommand): name = "jl"  # noqa: D101


class Jle(_JumpCommand): name = "jle"  # noqa: D101


class Ja(_JumpCommand): name = "ja"  # noqa: D101


class Jae(_JumpCommand): name = "jae"  # noqa: D101


class Jb(_JumpCommand): name = "jb"  # noqa: D101


class Jbe(_JumpCommand): name = "jbe"  # noqa: D101


class Jmp(_JumpCommand): name = "jmp"  # noqa: D101


class Movsx(_ASMCommandMultiSize): name = "movsx"  # noqa: D101


class Movzx(_ASMCommandMultiSize): name = "movzx"  # noqa: D101


#class Mov(_ASMCommand): name = "mov"  # noqa: D101


#class Add(_ASMCommand): name = "add"  # noqa: D101


#class Sub(_ASMCommand): name = "sub"  # noqa: D101


class Neg(_ASMCommand): name = "neg"  # noqa: D101


class Not(_ASMCommand): name = "not"  # noqa: D101


class Div(_ASMCommand): name = "div"  # noqa: D101


class Imul(_ASMCommand): name = "imul"  # noqa: D101


class Idiv(_ASMCommand): name = "idiv"  # noqa: D101


class Cdq(_ASMCommand): name = "cdq"  # noqa: D101


class Cqo(_ASMCommand): name = "cqo"  # noqa: D101


class Xor(_ASMCommand): name = "xor"  # noqa: D101


#class Cmp(_ASMCommand): name = "cmp"  # noqa: D101


class Pop(_ASMCommand): name = "pop"  # noqa: D101


class Push(_ASMCommand): name = "push"  # noqa: D101


class Call(_ASMCommand): name = "call"  # noqa: D101


class Ret(_ASMCommand): name = "ret"  # noqa: D101


class Sar(_ASMCommandMultiSize): name = "sar"  # noqa: D101


class Sal(_ASMCommandMultiSize): name = "sal"  # noqa: D101
