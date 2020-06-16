#include "lib/ch376.h"

int main() 
{
	CH376_init();
	CH376_connectDrive();


	uprintln("------Sending filename------");
	CH376_sendFileName("Lorum.txt");
	uprintln("------Filename sent------");

	
	uprintln("------Opening File------");
	CH376_openFile();
	uprintln("------File Opened------");

	uprintln("------Reading file------");
	CH376_readFile();
	uprintln("------Reading done------");

	uprintln("------Closing File------");
	CH376_closeFile();
	uprintln("------Closing done------");
	

	/*
	uprintln("------Deleting file------");
	CH376_deleteFile();
	uprintln("------File deleted------");
	*/


	/*
	uprintln("------Creating File------");
	CH376_createFile();
	uprintln("------File Created------");
	*/

	/*
	uprintln("------Opening File------");
	CH376_openFile();
	uprintln("------File Opened------");

	uprintln("------Set cursor to end------");
	CH376_setCursor();
	uprintln("------Cursor set to end------");

	uprintln("------Writing in File------");
	CH376_writeFile();
	uprintln("------Writing done------");

	uprintln("------Closing File------");
	CH376_closeFile();
	uprintln("------Closing done------");
	*/

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