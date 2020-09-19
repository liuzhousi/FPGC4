#include "lib/stdlib.h" 

// Sets GPO[2] (cs) low
void SpiBeginTransfer()
{
	ASM("\
	// backup regs ;\
    push r1	;\
    push r2	;\
    push r3	;\
    \
    load32 0xC02630 r3          // r3 = 0xC02630 | GPIO ;\
    \
    read 0 r3 r1                // r1 = GPIO values ;\
    load 0b1111101111111111 r2  // r2 = bitmask ;\
    and r1 r2 r1                // set GPO[2] low ;\
    write 0 r3 r1               // write GPIO ;\
    \
    // restore regs ;\
    pop r3 ;\
    pop r2 ;\
    pop r1 ;\
    ");
}

// Sets GPO[2] (cs) high
void SpiEndTransfer()
{
	ASM("\
	// backup regs ;\
    push r1	;\
    push r2	;\
    push r3	;\
    \
    load32 0xC02630 r3          // r3 = 0xC02630 | GPIO ;\
    \
    read 0 r3 r1                // r1 = GPIO values ;\
    load 0b10000000000 r2       // r2 = bitmask ;\
    or r1 r2 r1                 // set GPO[2] high ;\
    write 0 r3 r1               // write GPIO ;\
    \
    // restore regs ;\
    pop r3 ;\
    pop r2 ;\
    pop r1 ;\
    ");
}

// write dataByte and return read value
// write 0x00 for a read
// INPUT:
//   r5: byte to write
// OUTPUT:
//   r1: read value
int SpiTransfer(int dataByte)
{
	ASM("\
    load32 0xC02735 r1      // r1 = 0xC02735 | SPI address    	;\
    write 0 r1 r5           // write r5 over SPI				;\
    read 0 r1 r1            // read return value				;\
    ");
}


#define COMMAND_IDLE 					0
#define COMMAND_FLASH_READ 				114 // 'r'
#define COMMAND_FLASH_ERASE_SECTOR 		101 // 'e'
#define COMMAND_FLASH_WRITE				119 // 'w'

#define SECTOR_SIZE 4096
#define PAGE_SIZE 256


// the current command the program is busy with
// if idle, should listen to UART for new command
int currentCommand = COMMAND_IDLE;

// UART buffer that stores a line until \n
int UARTbufferIndex = 0;
int UARTbuffer[32] = 0;

/* Description of commands:

READ x(24bit) Bytes from address y(24bit):
	b1: 'r'
	b2: x[23:16]
	b3: x[15:8]
	b4: x[7:0]
	b5: y[23:16]
	b6: y[15:8]
	b7: y[7:0]
	b8: '\n' (indicate end of command)
*/

// inits SPI by enabling SPI3 and resetting the chip
void initSPI()
{
	// already set CS high before enabling SPI3
	SpiEndTransfer();

	// enable SPI3
	int *p = (int *) 0xC02736; // set address (SPI3 enable)
   	*p = 1; // write value
   	delay(10);

   	// reset to get out of continuous read mode
   	SpiBeginTransfer();
	SpiTransfer(0x66);
	SpiEndTransfer();
	delay(1);
	SpiBeginTransfer();
	SpiTransfer(0x99);
	SpiEndTransfer();
	delay(1);
	SpiBeginTransfer();
	SpiTransfer(0x66);
	SpiEndTransfer();
	delay(1);
	SpiBeginTransfer();
	SpiTransfer(0x99);
	SpiEndTransfer();
	delay(1);
}

void waitWriteEnable()
{
  int statreg = 1;

  while((statreg &&& 1) == 1) 
  {
    // Wait for the chip
    SpiBeginTransfer();
    SpiTransfer(0x05);
    statreg = SpiTransfer(0x05);
    SpiEndTransfer();
  }
}


void enableWrite()
{
	SpiBeginTransfer();
	SpiTransfer(0x06);
	SpiEndTransfer();
	delay(10);
}

void readAndPrint(int len, int addr24, int addr16, int addr8)
{
	int l = len;
	int a24 = addr24;
	int a16 = addr16;
	int a8 = addr8;

	SpiBeginTransfer();
	SpiTransfer(0x03);
	SpiTransfer(a24);
	SpiTransfer(a16);
	SpiTransfer(a8);


	for (int i = 0; i < l; i++)
	{
		int b = SpiTransfer(0x00);
		uprintc((char)b);
	}

	SpiEndTransfer();
}

void eraseSector(int addr24, int addr16, int addr8)
{
	int a24 = addr24;
	int a16 = addr16;
	int a8 = addr8;
	
	SpiBeginTransfer();
	SpiTransfer(0x20);
	SpiTransfer(a24);
	SpiTransfer(a16);
	SpiTransfer(a8);
	SpiEndTransfer();
}

void processCommand()
{
	if (currentCommand == COMMAND_IDLE)
	{
		// do nothing
	}

	if (currentCommand == COMMAND_FLASH_READ)
	{

		int len = UARTbuffer[1] << 16;
		len += UARTbuffer[2] << 8;
		len += UARTbuffer[3];

		int addr24 = UARTbuffer[4];
		int addr16 = UARTbuffer[5];
		int addr8 = UARTbuffer[6];

		readAndPrint(len, addr24, addr16, addr8);
	}

	if (currentCommand == COMMAND_FLASH_ERASE_SECTOR)
	{
		enableWrite();

		int addr24 = UARTbuffer[4];
		int addr16 = UARTbuffer[5];
		int addr8 = UARTbuffer[6];

		eraseSector(addr24, addr16, addr8);

		waitWriteEnable();
	}

	currentCommand = COMMAND_IDLE;
}


int main() 
{
	
	initSPI();

	/*
	int i = 0;
	char buffer[10];
	i = SpiTransfer(0x00);
	itoah(i, &buffer[0]);
	uprint(&buffer[0]);
	*/

	uprintc(64);

	while (1)
	{
		processCommand();
	}

	return 48;
}

void int1()
{
	int *p = (int *) 0x4C0000; // set address (timer1 state)
   	*p = 1; // write value
}

void int2()
{
   
}


void int3()
{
	// UART RX interrupt
	if (currentCommand == COMMAND_IDLE)
	{
		// read byte
		int *p = (int *)0xC0262F; 	// address of UART RX
		int b = *p; 				// read byte from UART

		// write byte to buffer, increase index
		int *p_UARTbuffer = UARTbuffer;
		*(p_UARTbuffer + UARTbufferIndex) = b;
		UARTbufferIndex++;

		// execute command when 8 bytes received
		if (UARTbufferIndex == 8)
		{
			currentCommand = *(p_UARTbuffer);
			UARTbufferIndex = 0;
		}

	}
   
}

void int4()
{
}



