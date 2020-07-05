#include "lib/ch376.h"

/*
	Global Variables
*/

int endp_mode = 0x80;

// list of currently pressed notes
// values are the note ids. 0 = idle
int noteList[10] = 0;

void setUSBspeed()   
{      
    CH376_spiBeginTransfer();
    CH376_spiTransfer(0x0b);
    CH376_spiTransfer(0x17);
    CH376_spiTransfer(0xd8);
    CH376_spiEndTransfer();
    delay(20);
}   

int noWaitGetStatus() {
    CH376_spiBeginTransfer();
    int retval = CH376_spiTransfer(CMD_GET_STATUS);
    CH376_spiEndTransfer(); 
    return retval;
}

void connectDevice()
{
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
		uprintln(", Device connection checked (15 == new device connected)");
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
		uprintln("Checking Device connection status");

		delay(CH376_LOOP_DELAY);
		CH376_spiBeginTransfer();
		CH376_spiTransfer(CMD_GET_STATUS);
		CH376_spiEndTransfer();

		CH376_spiBeginTransfer();
		retval = CH376_spiTransfer(0x00);
		CH376_spiEndTransfer();

		itoah(retval, &buffer[0]);
		uprint(&buffer[0]);
		uprintln(", Device connection checked (15 == new device connected)");
	}
}


void toggle_recv()
{
  int val = endp_mode;
  endp_mode = endp_mode ^0x40;
  CH376_spiBeginTransfer();
  CH376_spiTransfer( 0x1C );
  CH376_spiTransfer( val );
  CH376_spiEndTransfer();

}

void issue_token2(int endp_and_pid)
{
  CH376_spiBeginTransfer();
  CH376_spiTransfer( 0x4F );
  CH376_spiTransfer( endp_and_pid );  /* Bit7~4 for EndPoint No, Bit3~0 for Token PID */
  CH376_spiEndTransfer(); 
}


void press_note(int noteID)
{
  	int done = 0;
  	for (int i = 0; i < 8; i++)
  	{
  		if (done == 0)
  		{
  			int *p = noteList;
	  		if (*(p+i) == 0)
	  		{
	  			*(p+i) = noteID;
	  			done = 1;
	  		}
  		}
  	}
}

void release_note(int noteID)
{
  	for (int i = 0; i < 8; i++)
  	{
  		int *p = noteList;
  		if (*(p+i) == noteID)
  		{
  			*(p+i) = 0;
  		}
  	}
}


void RD_USB_DATA() 
{     
    CH376_spiBeginTransfer();
    CH376_spiTransfer(0x28); 
    CH376_spiTransfer(0x00);  //ignore len :P, just read 4 bytes
   
    int b0 = CH376_spiTransfer(0x00);
    int b1 = CH376_spiTransfer(0x00);
    int b2 = CH376_spiTransfer(0x00);
    int b3 = CH376_spiTransfer(0x00);

    CH376_spiEndTransfer();

    char buffer[10];

    /*
	uprintln("--RAW DATA--");
	itoah(b0, &buffer[0]);
	uprintln(&buffer[0]);

	itoah(b1, &buffer[0]);
	uprintln(&buffer[0]);

	itoah(b2, &buffer[0]);
	uprintln(&buffer[0]);

	itoah(b3, &buffer[0]);
	uprintln(&buffer[0]);
	*/

	
	int cableNumber = b0 &&& 0b11110000;
 	int CIN = b0 &&& 0b00001111;
  	int channel = b1 &&& 0b00001111;
  	int event = b1 &&& 0b11110000;
  	int noteID = b2;
  	int velocity = b3;

  	if (event == 0x90)
  	{
	  	press_note(noteID);
  	}

  	if (event == 0x80)
  	{
	  	release_note(noteID);
  	}


  	/*
	uprintln("--PARSED DATA--");

  	uprint("Cable Number: ");
	itoah(cableNumber, &buffer[0]);
	uprintln(&buffer[0]);

	uprint("CIN: ");
	itoah(CIN, &buffer[0]);
	uprintln(&buffer[0]);

	uprint("Channel: ");
	itoah(channel, &buffer[0]);
	uprintln(&buffer[0]);

	uprint("Event: ");
	itoah(event, &buffer[0]);
	uprintln(&buffer[0]);

	uprint("NoteID: ");
	itoah(noteID, &buffer[0]);
	uprintln(&buffer[0]);

	uprint("Velocity: ");
	itoah(velocity, &buffer[0]);
	uprintln(&buffer[0]);

    uprintln("\n");
	*/
  	
}  


void writeTP2()
{
	// write notelist to toneplayer
	int quadNoteWord = noteList[4];
	quadNoteWord = quadNoteWord | (noteList[5] << 8);
	quadNoteWord = quadNoteWord | (noteList[6] << 16);
	quadNoteWord = quadNoteWord | (noteList[7] << 24);
	
	int *tp2 = (int *)0xC0262D;
	*tp2 = quadNoteWord;
}


void writeTP1()
{
	// write notelist to toneplayer
	int quadNoteWord = noteList[0];
	quadNoteWord = quadNoteWord | (noteList[1] << 8);
	quadNoteWord = quadNoteWord | (noteList[2] << 16);
	quadNoteWord = quadNoteWord | (noteList[3] << 24);
	
	int *tp1 = (int *)0xC0262C;
	*tp1 = quadNoteWord;
}

void get_int_in()   
{   
    toggle_recv();
  
    issue_token2(89);
    
    int s = noWaitGetStatus();   

    while (s != 0x14)
	{
		s = noWaitGetStatus();
    }

      RD_USB_DATA();


    // print notelist
    /*
	for (int i = 0; i < 8; i++)
	{
		int q = i;
		char buffer[10];
		int *p = noteList;
		itoah(*(p+q), &buffer[0]);
		uprintln(&buffer[0]);
	}
	*/
   
         
}  


void set_addr(int addr) {    

    CH376_spiBeginTransfer();
    CH376_spiTransfer( 0x45 );     
    CH376_spiTransfer( addr );  
    CH376_spiEndTransfer();   
 
 	delay(100);
    noWaitGetStatus();
    
    uprintln("------Host addr set------");

    CH376_spiBeginTransfer();
    CH376_spiTransfer( 0x13 ); 
    CH376_spiTransfer( addr ); 
    CH376_spiEndTransfer();   

    uprintln("------Slave addr set------");
}   


void set_config(int cfg) {  
  CH376_spiBeginTransfer();   
  CH376_spiTransfer( 0x49 );     
  CH376_spiTransfer( cfg ); 
  CH376_spiEndTransfer();   
   
  delay(100);
  noWaitGetStatus(); 
}  

int main() 
{

	CH376_init();

	setUSBspeed();

	connectDevice();

	delay(10);

	set_addr(5);

	delay(10);

    set_config(1);

    uprintln("------Ready to receive------");
    delay(10);

    while(1)
    {
    	get_int_in();
    	writeTP1();
    	writeTP2();
    }

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