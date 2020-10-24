#include "lib/ch376.h"

char fileBuffer[512] = 0;
// Test reading file
int main()
{
	if (!CH376_init())
		return 49;

	if (!CH376_connectDrive())
		return 50;

	if (!CH376_sendFileName("/INDEX.HTM"))
		return 51;

	if (!CH376_openFile())
		return 52;

	char buffer[10];
	int fzise = CH376_getFileSize();

	itoa(fzise, &buffer[0]);
	uprint("File size: ");
	uprintln(&buffer[0]);


	if (!CH376_sendFileName("/INDEX.HTM"))
		return 51;

	if (!CH376_openFile())
		return 52;

	if (!CH376_setCursor(0))
		return 53;

	if (!CH376_readFile(fileBuffer, fzise))
		return 54;

	if (!CH376_closeFile())
		return 55;

	char *p_fileBuffer = fileBuffer;
	*(p_fileBuffer+fzise) = 0;

	uprintln(fileBuffer);

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