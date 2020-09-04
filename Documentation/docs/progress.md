# Progress
Here I keep a list of my latest progress and a TODO list

## Big Progress log (truncated to latest progress)
- Added 4 extension interrupts
- Changed PS/2 controller to only check for scan codes and send an interrupt
- Reimplemented programmable timer
- Moved documentation to mkdocs website
- Modified an existing C compiler (written in python, outputs x86_64 asm) to output B322 asm
- Added UART DTR reset like an Arduino
- C compiler is pretty usable, still some errors here and there with certain code
- Libraries for CH376 and GFX added
- Added support for reading interrupt signal from CH376
- Ported code from personal Arduino project to read MIDI USB keybaord using CH376
- Added ESP32 as APU (ESP32Synth), replacing the two square wave TonePlayers on the FPGA (still need to disable the TonePlayers!)
- ESP32 APU uses I2S DAC, and now has a bidirectional UART communication port with the MU
- Added W5500 in hardware and software
- Reimplemented SPI module. Now uses 6.25MHz SPI clock (verified stable for CH376)

## Future plans
These are kinda ordered based on priority

- Improve C compiler
- Improve ESP32Synth
- Improve and write more libraries
- Enable third UART port
- Change all static paths in the project to relative ones
- Write a USB loader program
- Write a platformer game
- Create a pattern and palette table generator
- Add logo to USB loader
- Change speed of FT232RL to 1Mboud
- Write an OS (when C is super stable)
- Add Gameboy printer via Arduino to I/O (Best way to do this currently is using UART3)
- Change SPI Flash for SDCARD (if yes, then use an SRAM cache for blocks and rewrite bootloader), 
   or add a way to reprogram the flash directly from the FPGA (better idea)

## Todo documentation
- really, I should add more pictures and examples (of video output, simulation, hardware)
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
- add picture of SPI flasher, and add/improve instructions on how to use them (seperate page + commands + hardware mod of spi module)
- add something about WSL2
- note that r7 is used as temp reg to store address of label in read/write instructions
- only global int and int[x] are allowed, no char, since size allocation goes wrong
- register/assembly info for c compiler
- add schematic of pcb
- add info about w5500 hardware and software


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
- [done] Fix empty label problem in ASSEMBLER! by adding a nop when detected
- Fix global array indexing using variables in global variables
- Fix commenting out asm code
- Remove requirement to add intX() functions
- Add wrapper for extended interrupts
- Improve performance of certain libraries by using assembly
- Add timer 1 interrupt code to assembly wrapper
- Change or r0 const rx to load const rx
- Maybe add some hotfix for number not fitting in register by using temp reg


## Future improvements (FPGC5?)
- Better bus protocol between CPU and MU, with no cyles ovehead
- Maybe byte addressable memory
- Maybe pipelining
- Maybe DMA controller
- Maybe some way to use 3D rendering with a frame buffer
- Optimize SPI to SDRAM by using one (two including size) big sequential read


## TODO soon
- CH376 Subdirs
- CH376 Binary files (images)
- W5500 Set buffer to 10KB
- W5500 Send image of < 10KB
- W5500 Headers
- Documentation
- CCompiler Change Int size to 1 word