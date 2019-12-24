# FPGC4

## Introduction
The fourth version of the FPGC, based on the FPGC3, which is designed from scratch using Verilog.
The FPGC4 as a whole is designed for use on a QMTECH EP4CE15 board (old revision with Micron SDRAM. Newer version has Winbond SDRAM and has not been tested yet). However, the CPU of the project is completely modular and should work on any FPGA.

The FPGC4 is a game console/PC that is implemented in an FPGA. 
The console runs on a self designed CPU called the B322 (B4rt 32bit processor v2) and a self designed GPU called the FSX2 (Frame Synthesizer v2). As reference for the performance of this system, one should expect something similar to a Commodore 64 or NES, but with a relative huge amount of memory.

## Hardware description

### Specifications
These are the current specifications of the FPGC4:

- 25MHz CPU clock   
- 9MHz GPU clock
- 16MiB SPI flash. 32bit addresses. Read only
- 32MiB SDRAM @ 25MHz. 32bit addresses. Readable and writeable
- 8.24KB VRAM (SRAM). TODO(fix info) 1024+16 addresses @ 32bit and 2x2040 addresses @ 8bit
- 2KiB ROM as bootloader. 32bit addresses
- 16 32bit registers
- 32bit instructions
- 27bit program counter, for a possible future address space of 0.5GiB
- 480x256 frames with 256 colors (60 x 32 tiles of 8x8 pixels)
- Frames rendered on a 480x272 4.3 inch TFT screen (with the worst viewing angles EVER!) over a 40pin TTL interface
- Three CTC timers
- 4 interrupt pins (currently attached to all three timers and the frameDrawn signal of the FSX2)
- 2 square wave tone generators with each 4 tones

### Computer Architecture
The FPGC4 consists of three main parts: the CPU, GPU and MU.

The CPU, called the B322, is the main part that executes all instructions. It reads and writes to the MU. The CPU consists of an timer that handles the timing of the CPU phases, an instruction decoder that splits the 32 bits of each instructions, an PC unit that handles all program counter related functions like jumps and interrupts, an ALU that can do 16 different operations on two 32 bit inputs, a register bank that contains 16 32 bit registers, a stack and finally a control unit that directs certain signals based on the instruction.
 
The GPU, called the FSX2, is completely separate from the CPU. It contains the logic for generating a video signal and for creating an image on this signal based on the contents of VRAM. The GPU has its own read port with clock on the VRAM, allowing it to run on a completely different clock domain than the rest of the FPGC4.

The MU, or memory unit, handles all memory access between the CPU and all the different memories used in the FPGC4. These memories includes: SDRAM, SPI flash, internal ROM, 8 bit VRAM, 32 bit VRAM and (future) I/O. It makes use of a memory map. The goal of the MU is to have the CPU access all memories without the CPU having to care about the type or timing of the memory, making an easy memory interface for the CPU. This is achieved using a start signal from the CPU to the MU to indicate the start of a memory read or write, and a busy signal from the MU to the CPU which only goes high when the start signal is received, and goes low when the data is read or written. However, there is one cycle of overhead per operation on the MU.

Because there is no seperation between program data and instruction data, this computer design uses the Von Neumann architecture.

Drawing of this architecture:

```
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
|  SDRAM  |<----->|                     |<----->|  VRAM32 |<----->|         |
|         |       |                     |       |         |       |         |
+---------+       |                     |       +---------+       |  FSX2   |
                  |       Memory        |                         |   GPU   |
+---------+       |        Unit         |       +---------+       |         |
|         |       |                     |       |         |       |         |
|   ROM   |<----->|                     |<----->|  VRAM8  |<----->|         |
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

#### Memory map
There are two different memory maps. One for the CPU and one for the GPU.

##### CPU memory map
This memory map is used when the CPU accesses memory

```
$000000 +------------------------+ 
        |                        | 
        |         SDRAM          | 
        |                        | $7FFFFF 
$800000 +------------------------+ 
        |                        | 
        |       SPI FLASH        | 
        |                        | $BFFFFF 
$C00000 +------------------------+ 
        |                        | 
        |         VRAM32         | 
        |                        | 
        | $C00000                | 
        |     Pattern Table      | 
        |                $C003FF | 
        |                        | 
        | $C04000                | 
        |     Palette Table      | 
        |                $C0041F | 
        |                        | $C0041F 
$C00420 +------------------------+ 
        |                        | 
        |         VRAM8          | 
        |                        | 
        | $C00420                | 
        |    BG Pattern Table    | 
        |                $C00C1F | 
        |                        | 
        | $C00C20                | 
        |    BG Palette Table    | 
        |                $C0141F | 
        |                        | $C02421 
        | $C01420                | 
        |  Window Pattern Table  | 
        |                $C01C1F | 
        |                        | 
        | $C01C20                | 
        |  Window Palette Table  | 
        |                $C0241F | 
        | $C02420                | 
        |       Parameters       | 
        |                $C02421 |  
        |                        | $C02421 
$C02422 +------------------------+ 
        |                        | 
        |          ROM           | 
        |                        | $C02621
$C02622 +------------------------+ 
        |                        | 
        |          I/O           | 
        |                        |
        | NESpad         $C02622 |
        | Keyboard[0]    $C02623 |
        | Keyboard[1]    $C02624 |
        | Keyboard[2]    $C02625 |
        | Timer1_val     $C02626 |
        | Timer1_ctrl    $C02627 |
        | Timer2_val     $C02628 |
        | Timer2_ctrl    $C02629 |
        | Timer3_val     $C0262A |
        | Timer3_ctrl    $C0262B |
        | TonePlayer1    $C0262C |
        | TonePlayer2    $C0262D |
        | GPIO (TODO)    $C0262E |
        |                        |
        |                        | $C0262E 
        +------------------------+ 

```

##### GPU memory map
This memory map is only used in the GPU
```
VRAM32
$000  +------------------------+ 
      |                        | 
      |     Pattern Table      | 
      |                        | $3FF
$400  +------------------------+ 
      |                        |
      |     Palette Table      |
      |                        | $41F
      +------------------------+


VRAM8
$000  +------------------------+
      |                        | 
      |     BG Tile Table      | 
      |                        | $7FF
$800  +------------------------+ 
      |                        |
      |     BG Color Table     |
      |                        | $FFF
$1000 +------------------------+
      |                        | 
      |   Window Tile Table    | 
      |                        | $17FF
$1800 +------------------------+ 
      |                        |
      |   Window Color Table   |
      |                        | $1FFF
      +------------------------+
```

#### CPU (B322)
The B322 (B4rt 32 bit processor v2) executes instructions from memory with the program counter as address. It is a 32 bit RISC CPU implementing the BR322 instruction set

##### B322 ISA
The B322 instruction set architecture is a RISC architecture.
Each instruction is 32 bits and can be one of the following instructions:
```
         |31|30|29|28|27|26|25|24|23|22|21|20|19|18|17|16|15|14|13|12|11|10|09|08|07|06|05|04|03|02|01|00|
----------------------------------------------------------------------------------------------------------
1 HALT     1  1  1  1| 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
2 READ     1  1  1  0||----------------16 BIT CONSTANT---------------||--A REG---| x  x  x  x |--D REG---|
3 WRITE    1  1  0  1||----------------16 BIT CONSTANT---------------||--A REG---||--B REG---| x  x  x  x
4 COPY     1  1  0  0||----------------16 BIT CONSTANT---------------||--A REG---||--B REG---| x  x  x  x
5 PUSH     1  0  1  1| x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x |--B REG---| x  x  x  x
6 POP      1  0  1  0| 0  0  0  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x |--D REG---|
7 JUMP     1  0  0  1||--------------------------------27 BIT CONSTANT--------------------------------||O|
8 JUMPR    1  0  0  0||----------------16 BIT CONSTANT---------------| x  x  x  x |--B REG---| x  x  x |O|
9 LOAD     0  1  1  1||----------------16 BIT CONSTANT---------------| x  x  x |H| x  x  x  x |--D REG---|
10 BEQ     0  1  1  0||----------------16 BIT CONSTANT---------------||--A REG---||--B REG---| x  x  x  x
11 BNE     0  1  0  1||----------------16 BIT CONSTANT---------------||--A REG---||--B REG---| x  x  x  x
12 BGT     0  1  0  0||----------------16 BIT CONSTANT---------------||--A REG---||--B REG---| x  x  x  x
13 BGE     0  0  1  1||----------------16 BIT CONSTANT---------------||--A REG---||--B REG---| x  x  x  x
14 SAVPC   0  0  1  0| 0  0  0  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x |--D REG---|
15 RETI    0  0  0  1| x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x  x
16 ARITH   0  0  0  0||C||--OPCODE--||--------11 BIT CONSTANT--------||--A REG---||--B REG---||--D REG---|
```

1.  HALT:   Will prevent the CPU to go to the next instruction by jumping to the same address. Can be interrupted.
2.  READ:   Read from memory at address in AREG + 16 bit offset. Store value in DREG.
3.  WRITE:  Write value from BREG to memory at address stored in AREG + 16 bit offset.
4.  COPY:   Read memory from address in AREG + 16 bit offset, then write result to memory at address in BREG + 16 bit offset.
7.  PUSH:   Pushes value in AREG to stack.
8.  POP:    Pops value from stack into DREG.
9.  JUMP:   Set PC to 27 bit constant if O is 0. If O is 1, then add the 27 bit constant to PC. 
9.  JUMR:   Set PC to DREG + 16 bit constant if O is 0. If O is 1, then add the value from DREG + 16 bit constant to PC. 
5.  LOAD:   Write 16 bit constant to DREG. If H is 0, then write data to lowest 16 bits and set highest 16 bits to 0. If H is 1, then write data to highest 16 bits and ignore lowest 16 bits.
11. BEQ:    If AREG == BREG, add 16 bit constant to PC.
12. BNE:    If AREG != BREG, add 16 bit constant to PC.
13. BGT:    If AREG >  BREG, add 16 bit constant to PC.
14. BGE:    If AREG >= BREG, add 16 bit constant to PC.
15. SAVPC:  Save current PC to DREG.
16. RETI:   Restore PC after interrupt and re-enable interrupts.
10. ARITH:  Execute operation specified by OPCODE on AREG and BREG. Write result to DREG. Use 11-bit constant in stead of BREG if C is 1.

##### Components
The CPU consists out of the following components:

###### Timer
Handles the timing of the CPU phases.

The Timer creates four phases for the CPU to execute each instruction:

1. fetch: Get instruction from memory
2. getRegs: Get register values from register bank
3. readMem: Read memory from address
4. writeBack: Write result back to register bank or memory and change the program counter

The fetch, readMem and writeBack phase can take multiple clock cycles because of the memory timings.
Because of the current memory access design, it is fundamentally impossible to pipeline instructions. This was never a goal of this project.

###### Instruction Decoder
Splits the 32 bits of each instructions.

These parts are then connected to various other components of the CPU. 
The instruction decoder does not use a clock.

###### Regbank
Contains 16 32 bit registers.

The 16 32 bit registers have the current functions:
```
0 : Always zero
1 : GP/Arg1
2 : GP/Arg2
3 : GP/Arg3
4 : GP/Arg4
5 : GP
6 : GP
7 : GP
8 : GP
9 : GP
10: GP
11: GP
12: GP/Return Value 3
13: GP/Return Value 2
14: GP/Return Value 1
15: Return pointer/GP
```
The register bank has two read ports and one write port. Internally on the FPGA, the registers are not implemented in block RAM, but I might change this in the future to save elements.

###### Stack
Stack memory with internal stack pointer. The stack is mostly used for backing up and restoring registers in interrupt handlers or functions. In combination with the SavPC instruction, one can jump to (and return from) functions.

The stack is 1024 words deep. The stack pointer is not accessable by the rest of the CPU. The pointer wraps around in case of a push when the stack is full or in case of a pop when the stack is empty.

###### ALU
Can execute 16 different operations on two 32 bit inputs. Has two flags.

The 4 bit opcode can specify the following operations:
```
Operation|Opcode|Description
-------------------------
  OR       0000  A OR   B
  AND      0001  A AND  B
  XOR      0010  A XOR  B
  ADD      0011  A  +   B
  SUB      0100  A  -   B
  SHIFTL   0101  A  <<  B
  SHIFTR   0110  A  >>  B
  NOTA     0111  ~A
  MULT     1000  A  *   B
```

The remaining seven Opcodes are reserved for future (signed?) operations.

Internally, the CPU uses flags for executing the branch instructions. However these are not readable by other instructions, because they are not saved in a register:
```
Flags
---------
BGA: B is greater than A
BEA: B is equal to A
```

###### PC
Handles all program counter related functions like jumps and interrupts.

Every writeBack cycle, the PC is increased by one. In case of a jump, the PC is set to or increased by the jump address.

The CPU has 4 interrupt pins. When a rising edge on one of these pins is detected and interrupts are enabled, interrupts will be disabled, the PC will be stored and the set to the value of the interrupt pin (1, 2, 3, or 4). When a RETI instruction is issued, the PC will be restored and interrupts re-enabled. Interrupts are only registered on the rising edge, to prevent the same interrupt from repeating itself when the handler is already done, but the signal is still high. In case of multiple interrupts at the same time, the lowest pin number has the highest priority.

###### CU
Directs all signals to the corresponding components based on the instruction.

#### MU
The MU, or memory unit, handles all memory access between the CPU and all the different memories used in the FPGC4. The MU makes use of a memory map so it know from or to which memory it should read or write. The goal of the MU is to have the CPU access all memories without the having to care about the type or timing of the memory, making an easy memory interface for the CPU. This is achieved using a start signal from the CPU to the MU to indicate the start of a memory read or write, and a busy signal from the MU to the CPU which only goes high when the start signal is received, and goes low when the data is read or written. However, there is one cycle of overhead per operation on the MU.

The MU is connected to the following memories:

##### SPI flash
The SPI flash contains the program of FPGC4, since it is located on a modular chip which can be easily removed and then reprogrammed by something like an Arduino. The size of the flash we use is currently 16MiB. The MU makes use of an SPI flash controller which accesses the flash chip in quad SPI mode with continuous reading for the fastest performance possible. The maximum speed without modifying the amount of dummy clocks for each read is 25MHz, which is currently the speed of most of the FPGC4, which is very convenient. Only read instructions are implemented, so no writing or erasing is possible on the FPGC4. Because of the SPI interface, it takes many cycles to read one 32 bit instruction. Therefore, the contents are copied to the faster SDRAM by the bootloader. While the SPI flash chip uses 8 bit addresses internally, the controller can be addressed by 32 bit words. The values of 'empty' addresses are all ones.

To test the timing system, I added a simulation model of a W25Q128JV SPI chip, which is compatible with the W25Q128BV I use in hardware. The SPI flash controller reads from this chip when a trigger occurs. When done reading it sets a recvDone signal high. Before all of this can happen, the chip has to be initialized. This is done by sending a 'reset continuous reading' command and a read command with the continuous reading bits set. This way each read does not have to start with an 8 cycle instruction. After initialization, an initDone signal is set high. When the MU gets a request from the CPU to read from SPI flash while the chip is not initialized yet, then the MU will wait until initialization is done before reading.

##### SDRAM
The SDRAM is used as the main memory for the FPGC4. It has a size of 32MiB. Since it is SDRAM, it requires a controller that handles all access and refreshes. The MU contains such controller to interface with the SDRAM. During initialization, the chip is set to a CAS latency of 2 and a programmable burst length of 2 (since we have 32bit words). The controller also handles refreshes. To reduce the amount of latency, the MU sets its busy flag low right after the read data is available or the written data is sent to the SDRAM chip. This way the CPU does not have to wait for row closing operations to be performed. If the MU gets a request from the CPU to read from or write to SDRAM, while the SDRAM controller is busy, then the MU will wait until the SDRAM controller is ready. While the SDRAM chip uses 16 bit addresses internally, the controller can be addressed by 32 bit words. The data of the SDRAM at powerup is undefined, but probably zero.

The first addresses of the SDRAM contain the program copied from SPI flash by the bootloader. I also added a simulation model of the SDRAM to the project. The currently used SDRAM chip is the Micron MT48LC16M16A2. The Winbond SDRAM chip will be tested later.

##### ROM
Internally on the FPGA, 2KiB of SRAM/Block RAM is used as ROM. It contains the bootloader of the FPGC4, which copies data from SPI flash to SDRAM, and jumps to SDRAM. This code is read only and can only be modified by reprogramming the FPGA.

##### VRAM32
VRAM32 is the 32 bit wide dual port dual clock video RAM used by the CPU and the GPU. It contains the pattern table and palette table for the GPU. It is implemented using internal SRAM/Block RAM.
The values of this memory at powerup are all zero.

##### VRAM8
VRAM8 is the 8 bit wide dual port dual clock video RAM used by the CPU and the GPU. It contains the background tile table, background color table, window tile table and window color table for the GPU. It is implemented using internal SRAM/Block RAM. The final two addresses are the horizontal tile offset and horizontal pixel offset for scrolling.
The values of this memory at powerup are all zero.

##### I/O
Several registers of I/O devices are mapped to the I/O memory block

###### NESpad
A NES/SNES controller reader. Tested with both NES and SNES controllers. All button pressed states are written to a 16 bit register, and is readable from the memory map. The button values are stored on the right side of the 32 bit word.
```
TODO: Test the button values!!!
Button | Bit
------------------
A      | 00000000000X
B      | 0000000000X0
Sel    | 000000000X00
Start  | 00000000X000
Up     | 0000000X0000
Down   | 000000X00000
Left   | 00000X000000
Right  | 0000X0000000
X      | 000X00000000
Y      | 00X000000000
L      | 0X0000000000
R      | X00000000000
```

###### PS/2 Keyboard
A PS/2 Keyboard reader. Reads 79 buttons from the keyboard. The pressed states are readable from three adjacent addresses on the memory map.
```
TODO: Rethink this way of having keyboard buttons, and change the layout of all buttons
      Then, write a table here with all the buttons with bit addresses
```

###### GPIO
TODO implement this.
This one address on the memory map is mapped to GPIO pins on the FPGA. Only the right 16 bits are used. The left 8 of these 16 bits are read only and are the state of the 8 input ports. The right 8 of these 16 bits are the state of the 8 output ports. The output ports can also be read.
```
TODO: Make a list pins with bit value and in/out
```

#### GPU (FSX2)
```
TODO(rewrite this for new gpu)
```
The GPU generates a 480x272@60-ish hz TTL signal (or as I like to call it, digital VGA) using a pixel clock of 9MHz. For each tile, the GPU has to read the BG Tile table, Pattern table, BG Color table, Palette table, Window Tile table, Pattern table, Window Color table and Palette table (in this order) to know which color to draw. This is heavily inspired by the PPU of the NES, which uses the same principle. One big difference is that I currently implemented a line buffer which is being filled each line. This line buffer takes a lot of space and delay in the FPGA, and is temporarily. The color contents of the current pixel are then read from this line buffer. Because the linebuffer is only being filled when the pixel clock is on the most left pixel (outside blanking), the first tile cannot be shown. Therefore the actual horizontal resolution is currently 480-16, which means 58 tiles instead of 60. Currently the code is a complete mess with registers clocking the VRAM and bad things like that. Eventually I will rewrite everything specifically for this 480x272 display (or another if I can find a better one). Then I can also think about sprite rendering and HW scrolling support, which are not available now.

The GPU currently allows for 57x34 tiles of 8x8 pixels with 8 bit colors.
The pattern table allows for 256 different tiles.
The palette table allows for 16 different palettes with four colors per palette.
Each address in the background tile table and the background color table is mapped to one tile of the 57x34 tiles (actually 60x34 tiles, but the last 3x24 tiles are not used)

## Bootloader code
The bootloader is the first thing that is executed by the CPU. The bootloader is used to copy data from the slow SPI flash to the faster SDRAM, and to jump to address 0 on the SDRAM. Since the bootloader has room for 512 instructions, I will probably add a boot screen with logo.
There are two modes for the bootloader:
- If GPI[0] is high (which should be by default, because of a pull-up resistor), then the bootloader will copy X addresses, where X is the number in (32 bit) address 5 of the SPI flash.
- If GPI[0] is low, then the bootloader will only copy the first 16 addresses, and the last 512 addresses. This is because the code of the UARTbootloader has to run at the end of the 16'th MiB of the SPI flash to prevent that the bootloader overwrites its own code. If all 16MiB is copied, then the copying would take about ten seconds, which is way to long. By only copying the start and end, the UARTbootloader still works, and is copied almost instantly.
Furthermore, all registers are reset before jumping to address 0, because the UARTbootloader has to halt in the first instruction and therefore has to assume all registers are empty. The code could be space optimized by jumping to one of the two clear registers code, if needed.

This is the assembly code of the bootloader:
```
load 0x2630 r1
loadhi 0xC0 r1          ; r1 = GPIO address: 0xC02630
read 0 r1 r2            ; r2 = GPIO values
load 0b00000001 r3      ; r3 = bitmask for GPI[0]
and r2 r3 r3            ; r3 = GPI[0]

; if GPI[0] is low (button has pullup), then jump to UART optimized copy function
bne r0 r3 2
    jump CopyUartLoader


load 0 r1
loadhi 0x80 r1          ; r1 = address 0 of SPI: 0x800000
load 0 r2               ; r2 = address 0 of SDRAM: 0x00, and loop var
read 5 r1 r3            ; r3 = last address to copy +1, which is in line 6 of SPI code

CopyLoop:
    copy 0 r1 r2            ; copy SPI to SDRAM

    add r1 1 r1             ; incr SPI address 
    add r2 1 r2             ; incr SDRAM address

    beq r2 r3 2             ; copy is done when SDRAM address == number of lines to copy
    jump CopyLoop           ; copy is not done yet, copy next address

; clear registers
load 0 r1
load 0 r2
load 0 r3
load 0 r4
load 0 r5
load 0 r6
load 0 r7
load 0 r8
load 0 r9
load 0 r10
load 0 r11
load 0 r12
load 0 r13
load 0 r14
load 0 r15

jump 0                  ; copy is done, jump to sdram
halt                    ; should not get here, halt if we do


CopyUartLoader:

    load 0 r1
    loadhi 0x80 r1          ; r1 = address 0 of SPI: 0x800000
    load 0 r2               ; r2 = address 0 of SDRAM: 0x00, and loop var
    read 5 r1 r3            ; r3 = last address to copy +1, which is in line 6 of SPI code
    load 16 r4              ; r4 = number of words to copy at the start

    CopyStartLoop:
        copy 0 r1 r2            ; copy SPI to SDRAM

        add r1 1 r1             ; incr SPI address 
        add r2 1 r2             ; incr SDRAM address

        beq r2 r4 2             ; copy is done when SDRAM address == number of words to copy at the start
        jump CopyStartLoop      ; copy is not done yet, copy next address


    load 0 r1
    loadhi 0x80 r1          ; r1 = address 0 of SPI: 0x800000
    load 0 r2               ; r2 = address 0 of SDRAM: 0x00, and loop var
    read 5 r1 r3            ; r3 = last address to copy +1, which is in line 6 of SPI code
    sub r3 512 r4           ; r4 = starting address, 512 addresses before last address
    add r4 r1 r1            ; apply starting address offset to SPI address
    add r4 r2 r2            ; apply starting address offset to SDRAM address

    CopyEndLoop:
        copy 0 r1 r2            ; copy SPI to SDRAM

        add r1 1 r1             ; incr SPI address 
        add r2 1 r2             ; incr SDRAM address

        beq r2 r3 2             ; copy is done when SDRAM address == number of lines to copy
        jump CopyEndLoop        ; copy is not done yet, copy next address

    ; clear registers
    load 0 r1
    load 0 r2
    load 0 r3
    load 0 r4
    load 0 r5
    load 0 r6
    load 0 r7
    load 0 r8
    load 0 r9
    load 0 r10
    load 0 r11
    load 0 r12
    load 0 r13
    load 0 r14
    load 0 r15

    jump 0                  ; copy is done, jump to sdram
    halt                    ; should not get here, halt if we do 
```
And that translates to these instructions:
```
01110010011000110000000000000001 //Set r1 to 0x2630   (this is address 0xC02422)
01110000000011000000000100000001 //Set highest 16 bits of r1 to 0xC0
11100000000000000000000100000010 //Read at address in r1 with offset 0 to r2
01110000000000000001000000000011 //Set r3 to 0b00000001
00000000100000000000001000110011 //Compute r2 AND r3 and write result to r3
01010000000000000010000000110000 //If r0 != r3, then jump to offset 2
10010001100000000100100010000110 //Jump to load r1 instruction in line 34 (0xC02422 + 34 - 1)
01110000000000000000000000000001 //Set r1 to 0
01110000000010000000000100000001 //Set highest 16 bits of r1 to 0x80
01110000000000000000000000000010 //Set r2 to 0
11100000000000000101000100000011 //Read at address in r1 with offset 5 to r3
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001000110000 //If r2 == r3, then jump to offset 2
10010001100000000100100001011010 //Jump to copy instruction in line 12 (0xC02422 + 12 - 1)
01110000000000000000000000000001 //Set r1 to 0
01110000000000000000000000000010 //Set r2 to 0
01110000000000000000000000000011 //Set r3 to 0
01110000000000000000000000000100 //Set r4 to 0
01110000000000000000000000000101 //Set r5 to 0
01110000000000000000000000000110 //Set r6 to 0
01110000000000000000000000000111 //Set r7 to 0
01110000000000000000000000001000 //Set r8 to 0
01110000000000000000000000001001 //Set r9 to 0
01110000000000000000000000001010 //Set r10 to 0
01110000000000000000000000001011 //Set r11 to 0
01110000000000000000000000001100 //Set r12 to 0
01110000000000000000000000001101 //Set r13 to 0
01110000000000000000000000001110 //Set r14 to 0
01110000000000000000000000001111 //Set r15 to 0
10010000000000000000000000000000 //Jump to constant address 0
11111111111111111111111111111111 //Halt
01110000000000000000000000000001 //Set r1 to 0
01110000000010000000000100000001 //Set highest 16 bits of r1 to 0x80
01110000000000000000000000000010 //Set r2 to 0
11100000000000000101000100000011 //Read at address in r1 with offset 5 to r3
01110000000000010000000000000100 //Set r4 to 16
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001001000000 //If r2 == r4, then jump to offset 2
10010001100000000100100010010000 //Jump to copy instruction in line 39 (0xC02422 + 39 - 1)
01110000000000000000000000000001 //Set r1 to 0
01110000000010000000000100000001 //Set highest 16 bits of r1 to 0x80
01110000000000000000000000000010 //Set r2 to 0
11100000000000000101000100000011 //Read at address in r1 with offset 5 to r3
00001010001000000000001100000100 //Compute r3 - 512 and write result to r4
00000001100000000000010000010001 //Compute r4 + r1 and write result to r1
00000001100000000000010000100010 //Compute r4 + r2 and write result to r2
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001000110000 //If r2 == r3, then jump to offset 2
10010001100000000100100010101000 //Jump to copy instruction in line 51 (0xC02422 + 51 - 1)
01110000000000000000000000000001 //Set r1 to 0
01110000000000000000000000000010 //Set r2 to 0
01110000000000000000000000000011 //Set r3 to 0
01110000000000000000000000000100 //Set r4 to 0
01110000000000000000000000000101 //Set r5 to 0
01110000000000000000000000000110 //Set r6 to 0
01110000000000000000000000000111 //Set r7 to 0
01110000000000000000000000001000 //Set r8 to 0
01110000000000000000000000001001 //Set r9 to 0
01110000000000000000000000001010 //Set r10 to 0
01110000000000000000000000001011 //Set r11 to 0
01110000000000000000000000001100 //Set r12 to 0
01110000000000000000000000001101 //Set r13 to 0
01110000000000000000000000001110 //Set r14 to 0
01110000000000000000000000001111 //Set r15 to 0
10010000000000000000000000000000 //Jump to constant address 0
11111111111111111111111111111111 //Halt
```


```
01110010011000110000000000000001 //Set r1 to 0x2630
01110000000011000000000100000001 //Set highest 16 bits of r1 to 0xC0
11100000000000000000000100000010 //Read at address in r1 with offset 0 to r2
01110000000000000001000000000011 //Set r3 to 0b00000001
00000000100000000000001000110011 //Compute r2 AND r3 and write result to r3
01010000000000000010000000110000 //If r0 != r3, then jump to offset 2
10010001100000000100100001101000 //Jump to load r1 instruction in line 19 (0xC02422 + 18)
01110000000000000000000000000001 //Set r1 to 0
01110000000010000000000100000001 //Set highest 16 bits of r1 to 0x80
01110000000000000000000000000010 //Set r2 to 0
11100000000000000101000100000011 //Read at address in r1 with offset 5 to r3
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001000110000 //If r2 == r3, then jump to offset 2
10010001100000000100100001011010 //Jump to copy instruction in line 12 (0xC02422 + 11)
10010000000000000000000000000000 //Jump to constant address 0
11111111111111111111111111111111 //Halt
01110000000000000000000000000001 //Set r1 to 0
01110000000010000000000100000001 //Set highest 16 bits of r1 to 0x80
01110000000000000000000000000010 //Set r2 to 0
11100000000000000101000100000011 //Read at address in r1 with offset 5 to r3
01110000000000010000000000000100 //Set r4 to 16
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001001000000 //If r2 == r4, then jump to offset 2
10010001100000000100100001110010 //Jump to copy instruction in line 24 (0xC02422 + 23)
01110000000000000000000000000001 //Set r1 to 0
01110000000010000000000100000001 //Set highest 16 bits of r1 to 0x80
01110000000000000000000000000010 //Set r2 to 0
11100000000000000101000100000011 //Read at address in r1 with offset 5 to r3
00001010001000000000001100000100 //Compute r3 - 512 and write result to r4
00000001100000000000010000010001 //Compute r4 + r1 and write result to r1
00000001100000000000010000100010 //Compute r4 + r2 and write result to r2
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001001000000 //If r2 == r4, then jump to offset 2
10010001100000000100100010001010 //Jump to copy instruction in line 36 (0xC02422 + 35)
10010000000000000000000000000000 //Jump to constant address 0
11111111111111111111111111111111 //Halt
```

## Assembler for B322
To simplify writing code for the B322, one can use the B322 assembly language.
The assembler compiles the assembly code to 32 bit machine instructions. The input file is currently code.asm, and the output is printed to stdout.

### Line types
Each line is parsed on its own. There are four types of lines:

- Comments
- Defines
- Labels
- Instructions

#### Comments
Comments can be added by using the ';' character. For each line, only the part until the first ';' occurrence will be used by the assembler. This means that anything can be written after the ';'. This all does not go for .ds lines. They must not have any comments. This way it is not needed to use escape characters in the strings

#### Defines
Defines are the first type of lines that are processed by the assembler. A define line should have the following structure:
```
define TEXTTOREPLACE = textToReplaceWith
```
It is not necessary for 'define' to be in lower caps and 'TEXTTOREPLACE' to be in all caps. However, it is recommended to do so as a coding style. Also, it is recommended to place all define statements at the top of the file before the first instruction or label.
The define statement is used as a textual replacement. This means that no values or anything will be processed or converted during the processing of the define statements. This also means that is not smart to replace text that are used in instructions or labels.
Furthermore, 'TEXTTOREPLACE' should be unique for each define statement. If not, the assembler will complain.

#### Labels
Labels can be used to get the address in the assembled code of the instruction below the label. To define a label, one should use the following syntax:
```
LabelName:
```
LabelName can consist of any character, including numbers and special characters, as long as it is just one word (so no spaces, newlines etc.) The label must end with a ':' character. On the same line after this ':' character, no other text is allowed, except comments.

A label can be referenced by using the LabelName in certain instructions at specific places (see section Instructions).
The assembler will eventually compute the address of the label and replace all LabelName occurrences with this address. One can make forward and backward references, which means that one does not have to define a label earlier in the code before referencing, as long as the label is defined somewhere in the code.

Each program should at least contain the following labels (if not, the assembler will complain):
```
Main: (this is where the CPU will initially jump to)
Int1: (interrupt 1 handler)
Int2: (interrupt 2 handler)
Int3: (interrupt 3 handler)
Int4: (interrupt 4 handler)
```

It is recommended to start each label with a capital letter, however this is not mandatory.
One should not use two labels directly after each other without any instruction in between, and one should not use a label at the end of the file. The assembler will complain if this happens.
When two identical labels are defined, the assembler will complain.
It does not matter if a label is never referenced.
However, it does matter when a reference is made to a label that is not defined. In that case the assembler will complain.
Each of the interrupt handler labels should 'end' with a reti instruction, otherwise the CPU will not return from the interrupt and could highly probably softlock. However, this is not checked by the assembler.

#### Instructions
The instructions are the lines that will be assembled into machine code. Each instruction has its own format with the following description:
```
Instr   | Arg1  | Arg2 | Arg3   || Description
================================||=====================================================================
HALT    |       |       |       || Halts CPU by jumping to the current address
READ    | C16   | R     | R     || Read from addr in Arg2 with 16 bit offset from Arg1. Write to Arg3
WRITE   | C16   | R     | R     || Write to addr in Arg2 with 16 bit offset from Arg1. Data to write is in Arg3
COPY    | C16   | R     | R     || Copy from address in Arg2 to addr in Arg3 with 16 bit offset from Arg1
PUSH    | R     |       |       || Push Arg1 to stack
POP     | R     |       |       || Pop from stack to Arg1
JUMP    | L/C27 |       |       || Jump to Label or 27 bit constant in Arg1
JUMPO   | C27   |       |       || Jump to 27 bit constant offset in Arg1
JUMPR   | C16   | R     |       || Jump to Arg2 with 16 bit offset in Arg1
JUMPRO  | C16   | R     |       || Jump to offset in Arg2 with 16 bit offset in Arg1
LOAD    | C16   | R     |       || Load 16 bit constant from Arg1 into Arg2
LOADHI  | C16   | R     |       || Load 16 bit constant from Arg1 into highest 16 bits of Arg2
BEQ     | R     | R     | C16   || If Arg1 == Arg2, jump to 16 bit offset in Arg3
BNE     | R     | R     | C16   || If Arg1 != Arg2, jump to 16 bit offset in Arg3
BGT     | R     | R     | C16   || If Arg1 >  Arg2, jump to 16 bit offset in Arg3
BGE     | R     | R     | C16   || If Arg1 >= Arg2, jump to 16 bit offset in Arg3
SAVPC   | R     |       |       || Save program counter to Arg1
RETI    |       |       |       || Return from interrupt
OR      | R     | C11/R | R     || Compute Arg1 OR  Arg2, write result to Arg3
AND     | R     | C11/R | R     || Compute Arg1 AND Arg2, write result to Arg3
XOR     | R     | C11/R | R     || Compute Arg1 XOR Arg2, write result to Arg3
ADD     | R     | C11/R | R     || Compute Arg1 +   Arg2, write result to Arg3
SUB     | R     | C11/R | R     || Compute Arg1 -   Arg2, write result to Arg3
SHIFTL  | R     | C11/R | R     || Compute Arg1 <<  Arg2, write result to Arg3
SHIFTR  | R     | C11/R | R     || Compute Arg1 >>  Arg2, write result to Arg3
MULT    | R     | C11/R | R     || Compute Arg1 *   Arg2, write result to Arg3
NOT     | C11/R | R     |       || Compute NOT Arg1, write result to Arg3
NOP     |       |       |       || Does nothing, is converted to the instruction OR r0 r0 r0
ADDR2REG| L     | R     |       || Loads address from Arg1 to Arg2. Is converted into LOAD and LOADHI
.DW     | N32   | *     | *     || Data: Each argument is converted to 32bit binary
.DD     | N16   | *     | *     || Data: Each argument is converted to 16bit binary **
.DB     | N8    | *     | *     || Data: Each argument is converted to 8bit binary **
.DS     | N8    | S     |       || Data: Each character of the string is converted to 8bit ASCII **

/   = Or
R   = Register
Cx  = Constant that fits within x bits
L   = Label
S   = String

*  Optional argument with same type as Arg1. Has 'no limit' on number of arguments
** Data is placed after each other to make blocks of 32 bits. If a block cannot be made, it will be padded by zeros
```

Each Cx type argument (constant) can be written in decimal, binary (with 0b prefix) or hex (with 0x prefix).

The assembler creates the first six lines of the program, since these are always the same instructions plus the length of the program:
```
Jump Main
Jump Int1
Jump Int2
Jump Int3
Jump Int4
*Length of program*
```

### Assembling process
The assembler does the following things the the following order:

1. Remove all comments, while reading the input file line by line
2. Process the define statements
3. Compile all lines that can directly be compiled (so without labels)
4. Create new lines for instructions that become multiple lines
5. Process all labels
6. Recompile the lines that had a label before
8. calculate and write program length
7. Write result to output file

#### Input and output files
Currently one cannot pass arguments to the assembler. The assembler will read the code from code.asm and write the result to stdout. While arguments and file handling are easy to implement, I do not need it right now and have not plans to change this unless I restructure the build/flash process (most likely to happen if I change SPI flash for SDcard.

### Important notes
One important assumption is that the code will be executed from addr 0 of the SDRAM. Otherwise the label addresses will not be calculated correctly. In the future I might add an offset argument where all labels are offsetted by this argument, and a flag to disable the required Interrupt handlers

### Other things
I could create my own syntax highlighting for Sublime Text 3, however its Z80 syntax highlighting is already kinda decent. Might modify it in the future to support my assembly instead.

## Quartus
The Quartus folder contains all files for actually implementing the FPGC4 into hardware on an FPGA. The targeted development board is the QMTECH EP4CE15 core board with 32MiB Micron SDRAM.

There are some slight changes between the code in the Verilog folder and the code in the Quartus folder. For example, the Verilog folder contains simulation files for the SPI flash and SDRAM memory. The Quartus project is on the top level slightly modified to work on an actual FPGA. This also includes the use of PLLs for creating clocks.

## Programmer
The Programmer folder contains all files related to programming the SPI flash. To do this, I use an Arduino (In my case an Teensy 2.0) and the code from https://github.com/nfd/spi-flash-programmer (Credits to Nicholas FitzRoy-Dale). 

The compileROM.sh script converts the code.list file, the file with machine instructions, to the code.bin file. The file size will be a multiple of 4096 bytes, because the SPI flash programmer expects a file of this size. Then, the flash.sh file uses the SPI flash programmer client Python file to program the code.bin file to the SPI flash chip using the Arduino.

TODO add more information about the functionality of the flash.sh file.

## About the Project
### Structure of project files
All Verilog related files are in the Verilog folder. The Quartus files are in the Quartus folder. The SPI flash programmer files are in the Programmer folder. The assembler files are in the Assembler folder. The SublimeText3 folder contains the build scripts I use for compiling certain files in this project. In the future, I might add a custom syntax highlighting file for the assembly language.

### Progress log
- MU seems to work
- B322 seems to work
- FSX2 is ugly hacked to work for now. Priority lies with the CPU and MU for now. Will properly redo FSX2 later when most things are tested
- Assembler updated for B322
- Tested in hardware, simple bootloader written that copies some SPI data to SDRAM and jumps to SDRAM. Somehow it worked first try, which means the SPI and SDRAM timings are somewhat correct
- Created documentation
- Bootloader works
- Added SNES and Keyboard back
- Improved flasher
- Rewritten FSX2
- Created logo
- Created Timers and Sound
- Created MIDI to assembly data converter
- Implemented UART tx and rx
- Created UARTbootloader
- Improved ROM bootloader
- Fixed reset button
- Added GPIO

### Future plans
These are kinda ordered based on priority

- Update documentation again
- Add "library" support for assembler (Using include copy paste?)
- Create a pattern and palette table generator
- Add logo to boot screen animation in bootloader
- Add mass storage (SDCARD)
- Change SPI Flash for SDCARD
- Write a simplistic C compiler. Use software stack with dedicated stack pointer register.
- Add Gameboy printer via Arduino to I/O
- Write an OS