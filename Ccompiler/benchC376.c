#include "lib/ch376.h"

int main() 
{
	CH376_init();
	CH376_connectDrive();

	//CH376_printICver();

	char* d = "Lorum ipsum dolor est jemoeder enzo.";
	int s = 36;

	//uprintln("------Sending filename------");
	CH376_sendFileName("/LORUM.TXT");
	//uprintln("------Filename sent------");

	
	
	//uprintln("------Opening File------");
	//CH376_openFile();
	//uprintln("------File Opened------");

	//uprintln("------Reading file------");
	//CH376_readFile();
	//uprintln("------Reading done------");

	//uprintln("------Closing File------");
	//CH376_closeFile();
	//uprintln("------Closing done------");
	


	//uprintln("------Deleting file------");
	//CH376_deleteFile();
	//uprintln("------File deleted------");




	//uprintln("------Creating File------");
	//CH376_createFile();
	//uprintln("------File Created------");



	//uprintln("------Opening File------");
	//CH376_openFile();
	//uprintln("------File Opened------");

	//uprintln("------Set cursor to end------");
	//CH376_setCursor();
	//uprintln("------Cursor set to end------");

	//uprintln("------Writing in File------");
	//CH376_writeFile(d, s);
	//uprintln("------Writing done------");

	//uprintln("------Closing File------");
	//CH376_closeFile();
	//uprintln("------Closing done------");


	// send filename again after create, because the file get closed afterwards
	/*
	CH376_createFile();

	CH376_sendFileName("/LORUM.TXT");
	CH376_openFile();
	CH376_setCursor(0);
	CH376_writeFile(d, s);
	CH376_closeFile();
	*/

	char buf[50];
	CH376_openFile();
	CH376_setCursor(0);
	CH376_readFile(&buf[0], s);
	CH376_closeFile();

	buf[s] = 0;
	uprintln(&buf[0]);


	/*
	NOTES:
	open file in subdirectory:
	- set filename to /FOLDER1
	- send open file
	- set filename to FOLDER2
	- send open file
	- set filename to A.TXT
	- send open file
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