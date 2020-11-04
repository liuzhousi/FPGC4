"""Base ILCommand interface definition."""

import shivyc.ctypes as ctypes
from shivyc.spots import LiteralSpot
import shivyc.spots as spots
import shivyc.asm_cmds as asm_cmds


class ILCommand:
    """Base interface for all IL commands."""

    def inputs(self):
        """Return list of ILValues used as input for this command."""
        raise NotImplementedError

    def outputs(self):
        """Return list of values output by this command.

        No command executed after this one should rely on the previous value of
        any ILValue in the list returned here. ("Previous value" denotes the
        value of the ILValue before this command was executed.)
        """
        raise NotImplementedError

    def clobber(self):
        """Return list of Spots this command may clobber, other than outputs.

        Every Spot this command may change the value at (not including
        the Spots of the outputs returned above) must be included in the
        return list of this function. For example, signed division clobbers
        RAX and RDX.
        """
        return []

    def rel_spot_conf(self):
        """Return the relative conflict list of this command.

        This function returns a dictionary mapping an ILValue to a list of
        ILValues. If this contains a key value pair k: [t1, t2], then the
        register allocator will attempt to place ILValue k in a different spot
        than t1 and t2. It is assumed by default that the inputs do
        not share the same spot.
        """
        return {}

    def abs_spot_conf(self):
        """Return the absolute conflict list of this command.

        This function returns a dictionary mapping an ILValue to a list of
        spots. If this contains a key value pair k: [s1, s2], then the
        register allocator will attempt to place ILValue k in a spot which
        is not s1 or s2.
        """
        return {}

    def rel_spot_pref(self):
        """Return the relative spot preference list (RSPL) for this command.

        A RSPL is a dictionary mapping an ILValue to a list of ILValues. For
        each key k in the RSPL, the register allocator will attempt to place k
        in the same spot as an ILValue in RSPL[k] is placed. RSPL[k] is
        ordered by preference; that is, the register allocator will
        first attempt to place k in the same spot as RSPL[k][0], then the
        same spot as RSPL[k][1], etc.
        """
        return {}

    def abs_spot_pref(self):
        """Return the absolute spot preference list (ASPL) for this command.

        An ASPL is a dictionary mapping an ILValue to a list of Spots. For
        each key k in the ASPL, the register allocator will attempt to place k
        in one of the spots listed in ASPL[k]. ASPL[k] is ordered by
        preference; that is, the register allocator will first attempt to
        place k in ASPL[k][0], then in ASPL[k][1], etc.
        """
        return {}

    def references(self):
        """Return the potential reference list (PRL) for this command.

        The PRL is a dictionary mapping an ILValue to a list of ILValues.
        If this command may directly set some ILValue k to be a pointer to
        other ILValue(s) v1, v2, etc., then PRL[k] must include v1, v2,
        etc. That is, suppose the PRL was {t1: [t2]}. This means that
        ILValue t1 output from this command may be a pointer to the ILValue t2.

        In addition, the PRL may have a None key. The value of this key is a
        list of ILValue which are being internally referenced, but no
        pointers to them are being externally returned.
        """
        return {}

    def indir_write(self):
        """Return list of values that may be dereferenced for indirect write.

        For example, suppose this list is [t1, t2]. Then, this command may
        be changing the value of the ILValue pointed to by t1 or the value
        of the ILValue pointed to by t2.
        """
        return []

    def indir_read(self):
        """Return list of values that may be dereferenced for indirect read.

        For example, suppose this list is [t1, t2]. Then, this command may
        be reading the value of the ILValue pointed to by t1 or the value of
        the ILValue pointed to by t2.
        """
        return []

    def label_name(self):
        """If this command is a label, return its name."""
        return None

    def targets(self):
        """Return list of any labels to which this command may jump."""
        return []

    def make_asm(self, spotmap, home_spots, get_reg, asm_code):
        """Generate assembly code for this command.

        spotmap - Dictionary mapping every input and output ILValue to a spot.

        home_spots - Dictionary mapping every ILValue that appears in any of
        self.references().values() to a memory spot. This is used for
        commands which need the address of an ILValue.

        get_reg - Function to get a usable register. Accepts two arguments,
        first is a list of Spot preferences, and second is a list of
        unacceptable spots. This function returns a register which is not
        in the list of unacceptable spots and can be clobbered. Note this
        could be one of the registers the input is stored in, if the input
        ILValues are not being used after this command executes.

        asm_code - ASMCode object to add code to
        """
        raise NotImplementedError

    def _is_imm(self, spot):
        """Return True iff given spot is an immediate operand."""
        return isinstance(spot, LiteralSpot)

    def _is_imm8(self, spot):
        """Return True if given spot is a 8-bit immediate operand."""
        return self._is_imm(spot) and int(spot.detail) < ctypes.unsig_char_max

    def _is_imm64(self, spot):
        """Return True if given spot is a 64-bit immediate operand."""
        return False
        
        # ignore this for simplicity sake.

        return (isinstance(spot, LiteralSpot) and
                (int(spot.detail) > ctypes.int_max or
                 int(spot.detail) < ctypes.int_min))

    def move(self, src_spot, dst_spot, asm_code):
        # Move data from src_spot to dst_spot

        """
        The following spot type combinations are possible:
        src     dst
        -----------
        lit     reg
        lit     mem
        reg     reg
        reg     mem
        mem     reg
        mem     mem

        Note: moving towards a literal spot makes no sense
        """

        # this stays here until I removed size from all functions
        size = None

        # temporary register spot
        r12_spot = spots.RegSpot("r12")
        r13_spot = spots.RegSpot("r13")
        r7_spot = spots.RegSpot("r7") # Warning! also used by read/write cmds
        

        # handle memspots with counts that are registers
        # reminder: base + offset + (chunk * count)
        # TODO: test
        if isinstance(src_spot, spots.MemSpot):
            if isinstance(src_spot.count, spots.RegSpot):
                asm_code.add(asm_cmds.Load(spots.LiteralSpot(src_spot.chunk), r7_spot, size))
                asm_code.add(asm_cmds.Mult(r7_spot, src_spot.count, size))
                if src_spot.offset < 0:
                    asm_code.add(asm_cmds.Sub(r7_spot, spots.LiteralSpot(abs(src_spot.offset)), size))
                else:
                    asm_code.add(asm_cmds.Add(r7_spot, spots.LiteralSpot(abs(src_spot.offset)), size))
                asm_code.add(asm_cmds.Add(r7_spot, spots.LiteralSpot(src_spot.base), size))
                asm_code.add(asm_cmds.Read(r7_spot, r12_spot, size))
                src_spot = r12_spot

         
        orig_dst_spot = dst_spot
        changed_dst_spot = False       
            
        # we write to the correct dst_spot later on
        if isinstance(dst_spot, spots.MemSpot):
            if isinstance(dst_spot.count, spots.RegSpot):
                dst_spot = r13_spot
                changed_dst_spot = True

        

        # lit, reg
        if isinstance(src_spot, spots.LiteralSpot) and isinstance(dst_spot, spots.RegSpot):
            # load the literal to the destination reg
            asm_code.add(asm_cmds.Load(src_spot, dst_spot, size))

        # lit, mem
        elif isinstance(src_spot, spots.LiteralSpot) and isinstance(dst_spot, spots.MemSpot):
            # load the literal to r12, then write r12 to dst
            
            # change r12 to r13 if r12 is the destination address
            tmp_spot = r12_spot
            if dst_spot == r12_spot:
                tmp_spot = r13_spot
            asm_code.add(asm_cmds.Load(src_spot, r12_spot, size))
            asm_code.add(asm_cmds.Write(dst_spot, r12_spot, size))

        # reg, reg
        elif isinstance(src_spot, spots.RegSpot) and isinstance(dst_spot, spots.RegSpot):
            # move the register content using OR r0
            asm_code.add(asm_cmds.Mov(dst_spot, src_spot, size))

        # reg, mem
        elif isinstance(src_spot, spots.RegSpot) and isinstance(dst_spot, spots.MemSpot):
            # write the src reg to dst
            asm_code.add(asm_cmds.Write(dst_spot, src_spot, size))

        # mem, reg
        elif isinstance(src_spot, spots.MemSpot) and isinstance(dst_spot, spots.RegSpot):
            # read the src to dst reg
            asm_code.add(asm_cmds.Read(src_spot, dst_spot, size))

        # mem, mem
        elif isinstance(src_spot, spots.MemSpot) and isinstance(dst_spot, spots.MemSpot):
            # TODO: add COPY to the assembly list, and use that instead
            # for now, read src to r12, and write r12 to dst
            if dst_spot == r12_spot:
                print("ERROR: destination is R12. To fix implement copy instruction")
            asm_code.add(asm_cmds.Read(src_spot, r12_spot, size))
            asm_code.add(asm_cmds.Write(dst_spot, r12_spot, size))


        # if we changed the dst_spot, write it to the original dst_spot
        if changed_dst_spot:
            asm_code.add(asm_cmds.Load(spots.LiteralSpot(orig_dst_spot.chunk), r7_spot, size))
            asm_code.add(asm_cmds.Mult(r7_spot, orig_dst_spot.count, size))
            if orig_dst_spot.offset < 0:
                asm_code.add(asm_cmds.Sub(r7_spot, spots.LiteralSpot(abs(orig_dst_spot.offset)), size))
            else:
                asm_code.add(asm_cmds.Add(r7_spot, spots.LiteralSpot(orig_dst_spot.offset), size))
            asm_code.add(asm_cmds.Add(r7_spot, spots.LiteralSpot(orig_dst_spot.base), size))
            asm_code.add(asm_cmds.Write(r7_spot, dst_spot, size))