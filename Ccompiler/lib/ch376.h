#include "stdlib.h" 

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
int CH376_spiTransfer(int dataByte)
{
	int *p = (int *) 0xC02631; // set address (SPI address)

	*p = dataByte; // write value

	int retVal = *p; // read value

	return retVal;
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


// resets and intitializes CH376
void CH376_init()
{
	CH376_spiEndTransfer(); // start with cs high
	delay(60);
	
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_RESET_ALL);
	CH376_spiEndTransfer();
	delay(CH376_LOOP_DELAY);
	uprintln("reset done");

	

	uprintln("Setting USB mode to HOST_0");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_SET_USB_MODE);
	CH376_spiEndTransfer();
	delay(1);

	CH376_spiBeginTransfer();
	CH376_spiTransfer(MODE_HOST_0);
	CH376_spiEndTransfer();
	delay(1);

	// read return value
	CH376_spiBeginTransfer();
	int retval = CH376_spiTransfer(0x00);
	CH376_spiEndTransfer();

	char buffer[10];
	itoah(retval, &buffer[0]);
	uprint(&buffer[0]);
	uprintln(", USB mode set to HOST_0 (51 == operation successful)");
	delay(CH376_COMMAND_DELAY);
}


// waits for drive connection,
// sets usb host mode
// waits for drive to be ready
// mounts drive
void CH376_connectDrive() {

	int retval = 0;
	char buffer[10];

	while (retval != 0x15)
	{
		uprintln("Checking disk connection status");

		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		CH376_spiEndTransfer();

		CH376_spiBeginTransfer();
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Disk connection checked (15 == new device connected)");
	}



	uprintln("Setting USB mode to HOST_1");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_SET_USB_MODE);
	CH376_spiEndTransfer();
	delay(1);

	CH376_spiBeginTransfer();
	CH376_spiTransfer(MODE_HOST_1);
	CH376_spiEndTransfer();
	delay(1);

	CH376_spiBeginTransfer();
	retval = CH376_spiTransfer(0x00);
	CH376_spiEndTransfer();

	itoah(retval, &buffer[0]);
	uprint(&buffer[0]);
	uprintln(", USB mode set to HOST_1 (51 == operation successful)");



	uprintln("Setting USB mode to HOST_2");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_SET_USB_MODE);
	CH376_spiEndTransfer();
	delay(1);

	CH376_spiBeginTransfer();
	CH376_spiTransfer(MODE_HOST_2);
	CH376_spiEndTransfer();
	delay(1);

	CH376_spiBeginTransfer();
	retval = CH376_spiTransfer(0x00);
	CH376_spiEndTransfer();

	itoah(retval, &buffer[0]);
	uprint(&buffer[0]);
	uprintln(", USB mode set to HOST_2 (51 == operation successful)");


	retval = 0;
	while (retval != 0x15)
	{
		uprintln("Checking disk connection status");

		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		CH376_spiEndTransfer();

		CH376_spiBeginTransfer();
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Disk connection checked (15 == new device connected)");
	}


	uprintln("Checking if drive is ready");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_DISK_CONNECT);
	CH376_spiEndTransfer();


	retval = 0;
	while (retval != 0x14)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		CH376_spiEndTransfer();

		CH376_spiBeginTransfer();
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Drive ready check done (14 == success)");
	}

	uprintln("Mounting drive");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_DISK_MOUNT);
	CH376_spiEndTransfer();

	retval = 0;
	while (retval != 0x14)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		CH376_spiEndTransfer();

		CH376_spiBeginTransfer();
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();


		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Mounting done (14 == success)");
	}
	delay(CH376_COMMAND_DELAY);
}




// sets cursor
// todo add position argument (currently sets to end)
void CH376_setCursor() 
{
	uprintln("Setting cursor to end");

	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_BYTE_LOCATE);
	CH376_spiTransfer(0xff);
	CH376_spiTransfer(0xff);
	CH376_spiTransfer(0xff);
	CH376_spiTransfer(0xff);
	CH376_spiEndTransfer();

	int retval = 0;
	char buffer[10];

	while (retval != 0x14)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		CH376_spiEndTransfer();

		CH376_spiBeginTransfer();
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Cursor setting done (14 == success)");
	}
	delay(CH376_COMMAND_DELAY);
}


// todo parameter arguments
void CH376_readFile() 
{
	uprintln("Request read for 10 bytes");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_BYTE_READ);
	CH376_spiTransfer(20);
	CH376_spiTransfer(0);
	CH376_spiEndTransfer();

	int retval = 0;
	char buffer[10];

	while (retval != 0x1d)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Read request done (1d == disk read)");
	}

	delay(CH376_COMMAND_DELAY);
	uprintln("Byte RD usb data0");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_RD_USB_DATA0);
	retval = CH376_spiTransfer(0x00);

	int readByte;

	for (int i = 0; i < 20; i++) 
	{
		readByte = CH376_spiTransfer(0x00);
		uprintc((char)readByte);
	}
	uprint("\n");
	CH376_spiEndTransfer();

	itoah(retval, &buffer[0]);
	uprint(&buffer[0]);
	uprintln(", Byte rd usb done (retval == data size)");
	delay(CH376_COMMAND_DELAY);
}


// Writes data d of size s
// currently only works for sizes up to 255, because one byte
void CH376_writeFile(char* d, int s) 
{
	uprintln("Request write for s bytes");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_BYTE_WRITE);
	CH376_spiTransfer(s);
	CH376_spiTransfer(0);
	CH376_spiEndTransfer();

	int retval = 0;
	char buffer[10];

	while (retval != 0x1e)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Write request done (1e == disk write)");
	}


	uprintln("Byte WR req data");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_WR_REQ_DATA);
	retval = CH376_spiTransfer(0x00);

	CH376_sendData(d, s);
	CH376_spiEndTransfer();


	itoah(retval, &buffer[0]);
	uprint(&buffer[0]);
	uprintln(", Byte WR req done (retval == data size)");


	uprintln("Byte WR go (updating file size)");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_BYTE_WR_GO);
	CH376_spiEndTransfer();

	retval = 0;

	while (retval != 0x14)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Byte WR go done (14 == success)");
	}
	delay(CH376_COMMAND_DELAY);
}


void CH376_openFile() 
{
	uprintln("Opening file");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_FILE_OPEN);
	CH376_spiEndTransfer();

	int retval = 0;
	char buffer[10];

	while (retval != 0x14)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Opening done (14 == success)");
	}
	delay(CH376_COMMAND_DELAY);
}


void CH376_createFile() 
{
	uprintln("Creating file");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_FILE_CREATE);
	CH376_spiEndTransfer();

	int retval = 0;
	char buffer[10];

	while (retval != 0x14)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		CH376_spiEndTransfer();

		CH376_spiBeginTransfer();
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Creating done (14 == success)");
	}
	delay(CH376_COMMAND_DELAY);
}


void CH376_deleteFile() 
{
	uprintln("Deleting file");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_FILE_ERASE);
	CH376_spiEndTransfer();

	int retval = 0;
	char buffer[10];

	while (retval != 0x14)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Deleting done (14 == success)");
	}
	delay(CH376_COMMAND_DELAY);
}


void CH376_closeFile() 
{  
	uprintln("Closing file");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_FILE_CLOSE);
	CH376_spiTransfer(0x01); //0x01 if update filesize, else 0x00 (0x00 for closing folders?)
	CH376_spiEndTransfer();

	int retval = 0;
	char buffer[10];

	while (retval != 0x14)
	{
		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Closing done (14 == success)");
	}
	delay(CH376_COMMAND_DELAY);
}



// Sends filename f
void CH376_sendFileName(char* f) 
{
	
	uprintln("Sending filename");
	CH376_spiBeginTransfer();
	CH376_spiTransfer(CMD_SET_FILE_NAME);
	CH376_spiTransfer('/'); 	// start with /
	CH376_sendString(f); 		// send filename
	CH376_spiTransfer(0); 		// close with null
	CH376_spiEndTransfer();
	uprintln("Filename sent");
	delay(CH376_COMMAND_DELAY);
	
}