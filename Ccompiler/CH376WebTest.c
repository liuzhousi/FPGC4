#include "lib/ch376.h"

char fileBuffer[4096] = 0;

int main() 
{
	CH376_init();
	CH376_connectDrive();

	CH376_sendFileName("/INDEX.HTM"); //1247
	//CH376_sendFileName("/INFO.HTM"); //127
	//CH376_sendFileName("LORUM.TXT"); //36

	
	CH376_openFile();
	
	int fileSize = CH376_getFileSize();

	CH376_setCursor(0);
	CH376_readFile(fileBuffer, fileSize);
	CH376_closeFile();

	//fileBuffer[fileSize] = 0;
	char *p_fileBuffer = fileBuffer;
	*(p_fileBuffer+fileSize) = 0;

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