#include "lib/gfx.h"
#include "data/tables.h"

int main() 
{
	GFX_initVram();
	GFX_copyPaletteTable((int)DATA_PALETTE_DEFAULT); // add offset to data
	GFX_copyPatternTable((int)DATA_ASCII_DEFAULT); // add offset to data

	// note that a line in background is 64 tiles, while in window it is just 40
	GFX_printWindowColored((int)"hallo", 5, 44, 2); // pos 4, line 2
	GFX_printBGColored((int)"DERPYEET", 8, 66, 1); // pos 2, line 2
	return 48;
}

// timer1 interrupt handler
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