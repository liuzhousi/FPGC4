# Software Libraries
- Add a section for each library
	- Give introduction
	- List public functions
		- Description
		- Input
		- Output

## Libraries
Using the include statements, you can include other files, which can be used as libraries.
I started on making a few libraries, which I explain here.

### GFX.asm
Contains basic graphics functions like printing text and copying VRAM tables
Should write more here in the future.

### STD.asm
Contains some standard functions. Currently only contains a function to convert a byte to a ASCII Hex string with 0x prefix.
Should write more here in the future.

### UART.asm
Contains functions to send certain data over UART. Receiving is done in interrupts and therefore not included in this library.
Should write more here in the future.

### SPI.asm
Library for writing and reading to the SPI module. Uses GPO[0] as CS and can read and send a byte. Should write more here in the future.

### CH376.asm
Library for reading and writing files using the CH376 USB controller. Uses SPI for communication and UART/STD for debugging.
Currently not finished. Should write more here in the future.