#include "lib/ch376.h"

char fileBuffer[4096] = 0;

// Test reading file
int TestReadingFile()
{
	if (!CH376_init())
		return 49;

	if (!CH376_connectDrive())
		return 50;

	CH376_sendFileName("/Y1.HTM");

	if (!CH376_openFile())
		return 51;

	char buffer[10];
	int fzise = CH376_getFileSize();

	itoa(fzise, &buffer[0]);
	uprint("File size: ");
	uprintln(&buffer[0]);

	if (!CH376_setCursor(0))
		return 52;

	if (!CH376_readFile(fileBuffer, fzise))
		return 53;

	if (!CH376_closeFile())
		return 54;

	char *p_fileBuffer = fileBuffer;
	*(p_fileBuffer+fzise) = 0;

	uprintln(fileBuffer);

	return 48;
}

int TestCreatingFile()
{
	if (!CH376_init())
		return 49;

	if (!CH376_connectDrive())
		return 50;

	CH376_sendFileName("/Y1.HTM");

	if (!CH376_createFile())
		return 51;

	if (!CH376_openFile())
		return 52;

	char buffer[10];
	int fzise = CH376_getFileSize();
	itoa(fzise, &buffer[0]);
	uprint("File size: ");
	uprintln(&buffer[0]);

	if (!CH376_closeFile())
		return 53;

	return 48;
}


int TestWritingFile()
{
	if (!CH376_init())
		return 49;

	if (!CH376_connectDrive())
		return 50;

	CH376_sendFileName("/Y1.HTM");

	if (!CH376_createFile())
		return 51;

	CH376_sendFileName("/Y1.HTM");

	if (!CH376_openFile())
		return 52;

	if (!CH376_setCursor(0))
		return 53;

	if (!CH376_writeFile("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabcd", 713))
		return 54;

	char buffer[10];
	int fzise = CH376_getFileSize();
	itoa(fzise, &buffer[0]);
	uprint("File size: ");
	uprintln(&buffer[0]);

	if (!CH376_closeFile())
		return 55;

	return 48;
}

int main() 
{
	//CH376_printICver();
	//TestReadingFile();
	//TestCreatingFile();
	TestWritingFile();
	TestReadingFile();
	return 48;



	//----------OLD-----------


	//char* d = "Lorum ipsum dolor est jemoeder enzo.";
	//int s = 36;

	//uprintln("------Sending filename------");
	//CH376_sendFileName("/LORUM.TXT");
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

	/*
	char buf[50];
	if (CH376_openFile() == 1)
	{
		CH376_setCursor(0);
		CH376_readFile(&buf[0], s);
		CH376_closeFile();

		buf[s] = 0;
		uprintln(&buf[0]);
	}
	else
	{
		uprintln("could not open file");
	}
	*/

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

	//return 48;
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