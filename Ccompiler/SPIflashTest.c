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

int main() 
{
	char buffer[10];
	int i;

	int *f = (int *) 0x800001;
	i = *f;

	itoah((i >> 24) &&& 0xFF, &buffer[0]);
	uprintln(&buffer[0]);

	itoah((i >> 16) &&& 0xFF, &buffer[0]);
	uprintln(&buffer[0]);

	itoah((i >> 8) &&& 0xFF, &buffer[0]);
	uprintln(&buffer[0]);

	itoah((i) &&& 0xFF, &buffer[0]);
	uprintln(&buffer[0]);

	SpiEndTransfer();



	delay(10);
	int *p = (int *) 0xC02736; // set address (SPI3 enable)
   	*p = 1; // write value
   	delay(10);

   	SpiEndTransfer();


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
	delay(10);


	
	
	SpiBeginTransfer();
	SpiTransfer(0x03);
	SpiTransfer(0);
	SpiTransfer(0);
	SpiTransfer(0);

	for (int x = 0; x < 16; x++)
	{
		for (int y = 0; y < 4; y++)
		{
			i = SpiTransfer(0x00);
			itoah(i, &buffer[0]);
			uprint(&buffer[0]);
			uprint(" ");
		}
		uprintln("");
	}

	SpiEndTransfer();


	int *q = (int *) 0xC02736;
	*q = 0;

	int *w = (int *) 0x800001;
	i = *w;

	itoah((i >> 24) &&& 0xFF, &buffer[0]);
	uprintln(&buffer[0]);

	itoah((i >> 16) &&& 0xFF, &buffer[0]);
	uprintln(&buffer[0]);

	itoah((i >> 8) &&& 0xFF, &buffer[0]);
	uprintln(&buffer[0]);

	itoah((i) &&& 0xFF, &buffer[0]);
	uprintln(&buffer[0]);

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
   
}

void int4()
{
}



