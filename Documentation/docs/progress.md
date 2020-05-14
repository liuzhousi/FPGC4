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

## Future plans
These are kinda ordered based on priority

- Improve and write more libraries
- Write a platformer game
- Create a pattern and palette table generator
- Add logo to boot screen animation in bootloader
- Create webpage on b4rt.nl with documentation, since this file is getting pretty big
- Create a web server with W5500 chip
- Write an OS
- Add Gameboy printer via Arduino to I/O
- Write a simplistic C compiler. Use software stack with dedicated stack pointer register.
- Change SPI Flash for SDCARD

## Todo documentation
- add DSUB9 pinout
- talk about memory bottleneck, Instruction per clock cycle.
- add design mistakes for io wing (uart pulldown, no shield to ground)