#include "stdlib.h" 

#define CH376_DEBUG 			 1
#define CH376_LOOP_DELAY 		 100
#define CH376_COMMAND_DELAY		 20
#define CMD_GET_IC_VER           0x01
#define CMD_SET_BAUDRATE         0x02
#define CMD_ENTER_SLEEP          0x03
#define CMD_SET_USB_SPEED        0x04
#define CMD_RESET_ALL            0x05
#define CMD_CHECK_EXIST          0x06
#define CMD_SET_SD0_INT          0x0b
#define CMD_SET_RETRY            0x0b
#define CMD_GET_FILE_SIZE        0x0c
#define CMD_SET_FILE_SIZE        0x0d
#define CMD_SET_USB_ADDRESS      0x13
#define CMD_SET_USB_MODE         0x15
#define MODE_HOST_0              0x05
#define MODE_HOST_1              0x07
#define MODE_HOST_2              0x06
#define CMD_GET_STATUS           0x22
#define CMD_RD_USB_DATA0         0x27
#define CMD_WR_USB_DATA          0x2c
#define CMD_WR_REQ_DATA          0x2d
#define CMD_WR_OFS_DATA          0x2e
#define CMD_SET_FILE_NAME        0x2f
#define CMD_DISK_CONNECT         0x30
#define CMD_DISK_MOUNT           0x31
#define CMD_FILE_OPEN            0x32
#define CMD_FILE_ENUM_GO         0x33
#define CMD_FILE_CREATE          0x34
#define CMD_FILE_ERASE           0x35
#define CMD_FILE_CLOSE           0x36
#define CMD_DIR_INFO_READ        0x37
#define CMD_DIR_INFO_SAVE        0x38
#define CMD_BYTE_LOCATE          0x39
#define CMD_BYTE_READ            0x3a
#define CMD_BYTE_RD_GO           0x3b
#define CMD_BYTE_WRITE           0x3c
#define CMD_BYTE_WR_GO           0x3d
#define CMD_DISK_CAPACITY        0x3e
#define CMD_DISK_QUERY           0x3f
#define CMD_DIR_CREATE           0x40
#define CMD_SET_ADDRESS          0x45
#define CMD_GET_DESCR            0x46
#define CMD_SET_CONFIG           0x49
#define CMD_AUTO_CONFIG          0x4D
#define CMD_ISSUE_TKN_X          0x4E

#define ANSW_RET_SUCCESS         0x51
#define ANSW_USB_INT_SUCCESS     0x14
#define ANSW_USB_INT_CONNECT     0x15
#define ANSW_USB_INT_DISCONNECT  0x16
#define ANSW_USB_INT_USB_READY   0x18
#define ANSW_USB_INT_DISK_READ   0x1d
#define ANSW_USB_INT_DISK_WRITE  0x1e
#define ANSW_RET_ABORT           0x5F
#define ANSW_USB_INT_DISK_ERR    0x1f
#define ANSW_USB_INT_BUF_OVER    0x17
#define ANSW_ERR_OPEN_DIR        0x41
#define ANSW_ERR_MISS_FILE       0x42
#define ANSW_ERR_FOUND_NAME      0x43
#define ANSW_ERR_DISK_DISCON     0x82
#define ANSW_ERR_LARGE_SECTOR    0x84
#define ANSW_ERR_TYPE_ERROR      0x92
#define ANSW_ERR_BPB_ERROR       0xa1
#define ANSW_ERR_DISK_FULL       0xb1
#define ANSW_ERR_FDT_OVER        0xb2
#define ANSW_ERR_FILE_CLOSE      0xb4
#define ERR_LONGFILENAME         0x01
#define ATTR_READ_ONLY           0x01
#define ATTR_HIDDEN              0x02
#define ATTR_SYSTEM              0x04
#define ATTR_VOLUME_ID           0x08
#define ATTR_DIRECTORY           0x10 
#define ATTR_ARCHIVE             0x20


// Sets GPO[0] (cs) low
void CH376_spiBeginTransfer()
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
    load 0b1111111011111111 r2  // r2 = bitmask ;\
    and r1 r2 r1                // set GPO[0] low ;\
    write 0 r3 r1               // write GPIO ;\
    \
    // restore regs ;\
    pop r3 ;\
    pop r2 ;\
    pop r1 ;\
    ");
}

// Sets GPO[0] (cs) high
void CH376_spiEndTransfer()
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
    load 0b100000000 r2         // r2 = bitmask ;\
    or r1 r2 r1                 // set GPO[0] high ;\
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
// Writes byte over SPI to CH376
// INPUT:
//   r5: byte to write
// OUTPUT:
//   r1: read value
int CH376_spiTransfer(int dataByte)
{
	ASM("\
    load32 0xC02631 r1      // r1 = 0xC02631 | SPI address    	;\
    write 0 r1 r5           // write r5 over SPI				;\
    read 0 r1 r1            // read return value				;\
    ");
}


// Get status after waiting for an interrupt
int CH376_WaitGetStatus() {
	int intValue = 1;
	while(intValue)
    {
    	int *i = (int *) 0xC02624;
    	intValue = *i;
    }
    CH376_spiBeginTransfer();
    CH376_spiTransfer(CMD_GET_STATUS);
    CH376_spiEndTransfer(); 
    delay(1);

    CH376_spiBeginTransfer();
    int retval = CH376_spiTransfer(0x00);
    CH376_spiEndTransfer(); 

    return retval;
}

// Get status without using interrupts
int CH376_noWaitGetStatus() {
    CH376_spiBeginTransfer();
    CH376_spiTransfer(CMD_GET_STATUS);
    int retval = CH376_spiTransfer(0x00);
    CH376_spiEndTransfer(); 

    return retval;
}


// Function to send a string (without terminating 0)
void CH376_sendString(char* str)
{
	char chr = *str; 			// first character of str

	while (chr != 0) 			// continue until null value
	{
		CH376_spiTransfer(chr);
		str++; 					// go to next character address
		chr = *str; 			// get character from address
	}
}


// Function to send data d of size s
void CH376_sendData(char* d, int s)
{
	char chr = *d; 			// first byte of data

	for(int i = 0; i < s; i++) 	// write s bytes
	{
		CH376_spiTransfer(chr);
		d++; 					// go to next data address
		chr = *d; 			// get data from address
	}
}


// Good test to know if the communication works
void CH376_printICver()
{
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_GET_IC_VER);
	delay(1);

	int icVer = CH376_spiTransfer(0x00);
	CH376_spiEndTransfer();

	char buffer[10];
	itoah(icVer, &buffer[0]);
	uprint(&buffer[0]);
	uprintln(", IC version");
}

// Sets USB mode to mode, returns status code
// Which should be 0x51 when successful
int CH376_setUSBmode(int mode)
{
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_SET_USB_MODE);
	CH376_spiEndTransfer();
	delay(1);

	CH376_spiBeginTransfer();
	CH376_spiTransfer(mode);
	CH376_spiEndTransfer();
	delay(1);

	CH376_spiBeginTransfer();
	int status = CH376_spiTransfer(0x00);
	CH376_spiEndTransfer();
	delay(1);

	return status;
}


// resets and intitializes CH376
// returns 1 on success
int CH376_init()
{
	CH376_spiEndTransfer(); // start with cs high
	delay(60);
	

	// Reset
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_RESET_ALL);
	CH376_spiEndTransfer();
	delay(100); // wait after reset
	if (CH376_DEBUG)
		uprintln("reset done");


	// USB mode 0
	if (CH376_DEBUG)
		uprintln("Setting USB mode to HOST_0");

	int retval = CH376_setUSBmode(MODE_HOST_0);

	if (CH376_DEBUG)
	{
		char buffer[10];
		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", USB mode set to HOST_0 (51 == operation successful)");
	}

	if (retval == 0x51)
		return 1;
	else
		return 0;
}


// waits for drive connection,
// sets usb host mode
// waits for drive to be ready
// mounts drive
// returns 1 on success
int CH376_connectDrive() {

	int retval = 0;
	char buffer[10];

	// Device connection
	if (CH376_DEBUG)
		uprintln("Waiting for device to be connected");

	// Wait forever until an USB device is connected
	while(CH376_WaitGetStatus() != ANSW_USB_INT_CONNECT);

	if (CH376_DEBUG)
		uprintln("Device connected");

	// USB mode 1
	if (CH376_DEBUG)
		uprintln("Setting USB mode to HOST_1");

	retval = CH376_setUSBmode(MODE_HOST_1);
	
	if (CH376_DEBUG)
	{
		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", USB mode set to HOST_1 (51 == operation successful)");
	}

	// Return on error
	if (retval != 0x51)
		return 0;

	// USB mode 2
	if (CH376_DEBUG)
		uprintln("Setting USB mode to HOST_2");

	retval = CH376_setUSBmode(MODE_HOST_2);
	
	if (CH376_DEBUG)
	{
		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", USB mode set to HOST_2 (51 == operation successful)");
	}

	// Return on error
	if (retval != 0x51)
		return 0;


	// Device connection
	if (CH376_DEBUG)
		uprintln("Waiting for device to be connected");

	while(CH376_WaitGetStatus() != ANSW_USB_INT_CONNECT);

	if (CH376_DEBUG)
		uprintln("Device connected");


	// Drive ready
	if (CH376_DEBUG)
		uprintln("Checking if drive is ready");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_DISK_CONNECT);
	CH376_spiEndTransfer();

	if (CH376_WaitGetStatus() != ANSW_USB_INT_SUCCESS)
	{
		if (CH376_DEBUG)
			uprintln("Drive not ready");

		// Return on error
		return 0;
	}
	
	if (CH376_DEBUG)
		uprintln("Drive ready");

	// Mounting drive
	if (CH376_DEBUG)
		uprintln("Mounting drive");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_DISK_MOUNT);
	CH376_spiEndTransfer();

	if (CH376_WaitGetStatus() != ANSW_USB_INT_SUCCESS)
	{
		if (CH376_DEBUG)
			uprintln("Drive not mounted");

		// Return on error
		return 0;
	}

	if (CH376_DEBUG)
		uprintln("Drive mounted");

	return 1;
}


// Returns file size of currently opened file (32 bits)
int CH376_getFileSize()
{
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_GET_FILE_SIZE);
	CH376_spiTransfer(0x68);
	int retval = CH376_spiTransfer(0);
	retval = retval + (CH376_spiTransfer(0) << 8);
	retval = retval + (CH376_spiTransfer(0) << 16);
	retval = retval + (CH376_spiTransfer(0) << 24);
	CH376_spiEndTransfer();

	return retval;
}


// Sets cursor to position s
// Returns 1 on success
int CH376_setCursor(int s) 
{
	if (CH376_DEBUG)
		uprintln("Setting cursor to s");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_BYTE_LOCATE);
	CH376_spiTransfer(s);
	CH376_spiTransfer(s >> 8);
	CH376_spiTransfer(s >> 16);
	CH376_spiTransfer(s >> 24);
	CH376_spiEndTransfer();

	if (CH376_WaitGetStatus() != ANSW_USB_INT_SUCCESS)
	{
		if (CH376_DEBUG)
			uprintln("Cursor not set");

		// Return on error
		return 0;
	}

	if (CH376_DEBUG)
		uprintln("Cursor set");

	return 1;
}


// Reads s bytes into buf
// Can read 65536 bytes per call
// Returns 1 on success
int CH376_readFile(char* buf, int s) 
{
	if (CH376_DEBUG)
		uprintln("Request read for s bytes");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_BYTE_READ);
	CH376_spiTransfer(s);
	CH376_spiTransfer(s >> 8);
	CH376_spiEndTransfer();

	char buffer[10];

	if (CH376_WaitGetStatus() != ANSW_USB_INT_DISK_READ)
	{
		if (CH376_DEBUG)
			uprintln("Read request failed");
		return 0;
	}

	int bytesRead = 0; 
	int doneReading = 0;

	while (doneReading == 0)
	{
		// Read set of bytes (max 255)
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_RD_USB_DATA0);
		int readLen = CH376_spiTransfer(0x00);

		if (CH376_DEBUG)
		{
			itoa(readLen, &buffer[0]);
			uprint(&buffer[0]);
			uprintln(", Read USB data size");
		}

		int readByte;

		for (int i = 0; i < readLen; i++) 
		{
			readByte = CH376_spiTransfer(0x00);
			buf[bytesRead] = (char)readByte;
			bytesRead = bytesRead + 1;
		}
		CH376_spiEndTransfer();

		// requesting another set of data
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_BYTE_RD_GO);
		CH376_spiEndTransfer();

		int IntStatus = CH376_WaitGetStatus();
		if (IntStatus == ANSW_USB_INT_SUCCESS)
		{
			// done with reading, exit loop
			doneReading = 1;
		}
		else if (IntStatus == ANSW_USB_INT_DISK_READ)
		{
			// read another block
		}
		else
		{
			if (CH376_DEBUG)
				uprintln("Error while reading data");
			return 0;
		}
	}

	return 1;
}


// Writes data d of size s
// Can only write 65536 bytes at a time
// returns 1 on success
int CH376_writeFile(char* d, int s) 
{
	if (s == 0)
		return 0;

	char buffer[10];

	if (CH376_DEBUG)
		uprintln("Request write for s bytes");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_BYTE_WRITE);
	CH376_spiTransfer(s);
	CH376_spiTransfer(s >> 8);
	CH376_spiEndTransfer();

	if (CH376_WaitGetStatus() != ANSW_USB_INT_DISK_WRITE)
	{
		if (CH376_DEBUG)
			uprintln("Write request failed");
		return 0;
	}


	int bytesWritten = 0;
	int doneWriting = 0;

	while (doneWriting == 0)
	{
		// Write set of bytes (max 255)
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_WR_REQ_DATA);
		int wrLen = CH376_spiTransfer(0x00);

		if (CH376_DEBUG)
		{
			itoa(wrLen, &buffer[0]);
			uprint(&buffer[0]);
			uprintln(", Write USB data size");
		}

		CH376_sendData(d + bytesWritten, wrLen);
		bytesWritten = bytesWritten + wrLen;
		CH376_spiEndTransfer();

		// update file size
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_BYTE_WR_GO);
		CH376_spiEndTransfer();


		int IntStatus = CH376_WaitGetStatus();
		if (IntStatus == ANSW_USB_INT_SUCCESS)
		{
			// done with writing, exit loop
			doneWriting = 1;
		}
		else if (IntStatus == ANSW_USB_INT_DISK_WRITE)
		{
			// write another block
		}
		else
		{
			if (CH376_DEBUG)
				uprintln("Error while writing data");
			return 0;
		}

	}
	
	return 1;
}


// returns 1 on success
int CH376_openFile() 
{
	if (CH376_DEBUG)
		uprintln("Opening file");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_FILE_OPEN);
	CH376_spiEndTransfer();

	if (CH376_WaitGetStatus() == ANSW_USB_INT_SUCCESS)
	{
		if (CH376_DEBUG)
			uprintln("File opened");
		
		return 1;
	}
	else
	{
		if (CH376_DEBUG)
			uprintln("Could not open file");

		return 0;
	}
	
}


// returns 1 on success
int CH376_deleteFile() 
{
	if (CH376_DEBUG)
		uprintln("Deleting file");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_FILE_ERASE);
	CH376_spiEndTransfer();

	if (CH376_WaitGetStatus() == ANSW_USB_INT_SUCCESS)
	{
		if (CH376_DEBUG)
			uprintln("File deleted");
		
		return 1;
	}
	else
	{
		if (CH376_DEBUG)
			uprintln("Could not delete file");

		return 0;
	}
}


// returns 1 on success
int CH376_closeFile() 
{  
	if (CH376_DEBUG)
		uprintln("Closing file");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_FILE_CLOSE);
	CH376_spiTransfer(0x01); //0x01 if update filesize, else 0x00
	CH376_spiEndTransfer();

	if (CH376_WaitGetStatus() == ANSW_USB_INT_SUCCESS)
	{
		if (CH376_DEBUG)
			uprintln("File closed");
		
		return 1;
	}
	else
	{
		if (CH376_DEBUG)
			uprintln("Could not close file");

		return 0;
	}
}


// returns 1 on success
int CH376_createDir() 
{
	if (CH376_DEBUG)
		uprintln("Creating directory");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_DIR_CREATE);
	CH376_spiEndTransfer();

	if (CH376_WaitGetStatus() == ANSW_USB_INT_SUCCESS)
	{
		if (CH376_DEBUG)
			uprintln("Directory created");
		
		return 1;
	}
	else
	{
		if (CH376_DEBUG)
			uprintln("Could not create directory");

		return 0;
	}
}


// Creates file (recreates if exists)
// New files are 1 byte long
// Have not found a way to set it to 0 bytes, 
// since CMD_SET_FILE_SIZE does not work
// Automatically closes file
// returns 1 on success
int CH376_createFile() 
{
	if (CH376_DEBUG)
		uprintln("Creating file");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_FILE_CREATE);
	CH376_spiEndTransfer();

	if (CH376_WaitGetStatus() == ANSW_USB_INT_SUCCESS)
	{
		if (CH376_DEBUG)
			uprintln("File created");
	}
	else
	{
		if (CH376_DEBUG)
			uprintln("Could not open file");

		return 0;
	}

	if (!CH376_openFile())
		return 0;

	// setting file size to 0
	// works in memory, but does not update on disk
	/*
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_SET_FILE_SIZE);
	CH376_spiTransfer(0x68);
	CH376_spiTransfer(0);
	CH376_spiTransfer(0);
	CH376_spiTransfer(0);
	CH376_spiTransfer(0);
	CH376_spiEndTransfer();
	*/

	// closing file
	if (!CH376_closeFile())
		return 0;

	return 1;
}


// Sends filename f
// REQUIRES CAPITAL LETTERS IF YOU WANT TO OPEN IT ON YOUR PC AS WELL!
// TODO: handle (split with open()) directories
void CH376_sendFileName(char* f) 
{
	if (CH376_DEBUG)
		uprintln("Sending filename");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_SET_FILE_NAME);
	//CH376_spiTransfer('/'); 	// start with / (now should be included in f)
	CH376_sendString(f); 		// send filename
	CH376_spiTransfer(0); 		// close with null
	CH376_spiEndTransfer();

	if (CH376_DEBUG)
		uprintln("Filename sent");	
}