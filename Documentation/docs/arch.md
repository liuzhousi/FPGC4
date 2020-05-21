# Architecture
The FPGC4 consists of three main parts: the CPU, GPU and MU.

The CPU, called the B322, is the main part that executes all instructions. It reads and writes to the MU. The CPU consists of an timer that handles the timing of the CPU phases, an instruction decoder that splits the 32 bits of each instructions, an PC unit that handles all program counter related functions like jumps and interrupts, an ALU that can do 16 different operations on two 32 bit inputs, a register bank that contains 16 32 bit registers, a stack and finally a control unit that directs certain signals based on the instruction.
 
The GPU, called the FSX2, is completely separate from the CPU. It contains the logic for generating a video signal and for creating an image on this signal based on the contents of VRAM. The GPU has its own read port with clock on the VRAM, since all of it is true dual port SRAM, allowing it to run on a completely different clock domain than the rest of the FPGC4.

The MU, or memory unit, handles all memory access between the CPU and all the different memories used in the FPGC4. These memories includes: SDRAM, SPI flash, internal ROM, 8 bit VRAM, 9 bit VRAM, 32 bit VRAM and a lot of I/O. It makes use of a memory map. The goal of the MU is to have the CPU access all memories without the CPU having to care about the type or timing of the memory, making an easy memory interface for the CPU. This is achieved using a start signal from the CPU to the MU to indicate the start of a memory read or write, and a busy signal from the MU to the CPU which only goes high when the start signal is received, and goes low when the data is read or written. However, there is one cycle of overhead per operation on the MU.

Block diagram of FPGC4:

``` text
                  +---------------------+
                  |                     |
                  |        B322         |
                  |         CPU         |
                  |                     |
                  |                     |
                  +---------------------+
                             ^
                             |
                             v
+---------+       +---------------------+       +---------+       +---------+
|         |       |                     |       |         |       |         |
|  SDRAM  |<----->|                     |       |         |       |         |
|         |       |                     |       |         |       |         |
+---------+       |                     |       |         |       |  FSX2   |
                  |       Memory        |<----->|  VRAM   |<----->|   GPU   |
+---------+       |        Unit         |       |         |       |         |
|         |       |                     |       |         |       |         |
|   ROM   |<----->|                     |       |         |       |         |
|         |       |                     |       |         |       |         |
+---------+       +---------------------+       +---------+       +---------+
                        ^          ^  
                        |          |
                        v          v
                    +-------+  +-------+ 
                    |       |  |       |
                    |  SPI  |  |  I/O  |
                    | flash |  |       |
                    |       |  +-------+
                    +-------+
```