# Progress
Here I keep a simple list of my latest progress and a simple TODO list

## Progress log
- Added library support in assembler
- Added sprites
- Rewrote FSX2 for CRT display
- Finally updated the documentation a bit
- Created and ordered PCB
- PCB received, assembled and tested
- Updated documentation quite a bit
- Added 4 extension interrupts
- Changes PS/2 controller to only check for scan codes and send an interrupt
- Reimplemented programmable timer
- Modified an existing C compiler (written in python, outputs x86_64 asm) to output B322 asm

## Future plans
These are kinda ordered based on priority

- Improve and write more libraries
- Improve hardware stack (size, check usage, get pointer, etc.)
- Enable second SPI and UART port
- Change all static paths in the project to relative ones
- Optimize TonePlayer modules to not use division and therefore decrease size
- Write a USB bootloader
- Write a platformer game
- Create a pattern and palette table generator
- Add logo to boot screen animation in bootloader
- Add a custom syntax highlighting for the assembly language.
- Create webpage on b4rt.nl with documentation, since this file is getting pretty big
- Create a web server with W5500 chip
- Write an OS
- Add Gameboy printer via Arduino to I/O
- Change SPI Flash for SDCARD, or add a way to reprogram the flash directly from the FPGA

## Todo documentation
- add DSUB9 pinout
- add (probably in specs section) the FPGA usage statistics
	- note that the sprite renderer takes almost half of the FPGA, because many big registers
- talk about memory bottleneck, Instructions per clock cycle
- add design mistakes for io wing (uart pulldown, no shield to ground)
- add uart bootloader code/description to bootloader section
- think about removing bootloader code in documentation
- add some snippet of code + binary in assembler documentation
- check if uart bootloader jumpt to addr 5 or addr 0 when done
- add something about the nconf button remapping wire on the PCB page
- add something about the SPI flash module modification to QIO on the PCB page
- add something about the automatic dtr reset
- add new functions to assembler page
	- rbp rsp mapped to r14 r15 for c compiler
	- added negative offset option for read, write and copy instruction
- add page for C compiler
	- add that r12 is used as tmp register (use example)
	- explain x86_64 -> b332 and similarities
	- note about the 4 word int offset because x86_64 has byte addressable memory (FPGC4 has word addressable memory). But because plenty of space and simplification for print statements in text, it is not worth it (for now) to change it to 1 word offset and risk more compiler bugs. This means that chars are stored in 32 bit spaces and therefore have no overflow. This also means that using variables longer that 32 bits (longs) are cutoff at 32 bits. Should not be a big issue, since we only have 27 bits addresses anyways.
	- testing compiler: currently by hand using gtkwave. In the future: 1) create single command for compiling c -> asm, asm -> machine -> uploading to FPGC4. 2) add software reset over UART, so we can upload without user interaction. 3) add asm code in tests.c files (at end of main) that send return code over UART back to pc. 4) use automated compiling, reset+upload, listen for return code, to verify if a test was successful. 5) create muliple tests.c files to test all functionality.
	- make a list of what is supported and some things that are not supported (division, switch)
	- note about bitwise and not having & as sign, because it is already taken by get pointer to var.
	- talk about the assembly wrapper for c program code (setup stack, interrupts)
	- note that the functions int1() int2() int3() and int4() should be present (void)
	- talk about define only doing supporting integer values, without brackets.
	- inline assembly specification:
		- the programmer is responsible to backup and restore the registers used in the asm code
		- note about how the code should be used (comments, semicolon and backslash)
		- useful for quickly copying to VRAM, or optimizing slow functions
	- includes guards are not implemented. However, a list is used to keep track of the files that are already included. This also fixes circular dependencies.
	- only one source file is allowed. So all code of the includes need to be inside the .h files. So no object files are created and no linking needs to take place. Eventually the code is compiles as one big C file.
	- defines are allowed, but may only be integers. must not have brackets, may have comments
	- defines from included code carry over to the normal code (which is intended), so it is good to use prefixes.
	- hex and binary integers are allowed, and should have a 0x or 0b prefix. They are also allowed in defines
	- coding style recommendation:
		- write at top of program/library which variables are stored where in the heap/memory
		- show memory map of 32MiB RAM, with what to put where as a programmer, and why
		- use prefixes for defines, as they carry over
		- use specific (not generic) function names, as they otherwise may conflict with included code

## Todo C compiler related
- [done] Add neg offset flag in READ and WRITE and COPY instructions
- [done] Implement neg offset for READ and WRITE and COPY instructions
- [done] Map the name rbp and rsp to r14 and r15 in assembler
- [done] add int1-4 functions, with automatic backup and restore of ALL registers to HW stack
- [done] add prefix main (as header) with load 0x700000 rsp
- [done] in asm main prefix header, get return value from label_main and send it over UART
- [done] add more instructions and test files
- eventually clean up code, remove size arg
- [done] add inline assembly for fast code like copying tables
- [done] add static defines
- [done] add hex support!!! (and binary while at it) (also in defines)
- [done] add bitwise | ^ and & operators (look at commit 31180511de0f95cf5dbda0bf98df71901a2fd1ed)
- [done] print static string in correct asm format (.dw without commas)


## Future improvements (FPGC5?)
- Better bus protocol between CPU and MU, with no cyles ovehead
- Maybe byte addressable memory
- Maybe pipelining
- Maybe DMA controller
- Maybe some way to use 3D rendering with a frame buffer
- Optimize SPI to SDRAM by using one (two including size) big sequential read