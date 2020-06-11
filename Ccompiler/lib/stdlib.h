/*
uprintc(char c)

Prints a single char by writing it to 0xC0262E
*/
void uprintc(char c) 
{
	int *p = (int *)0xC0262E; 	// address of UART TX
	*p = (int)c; 			// write char over UART
}


/*
uprint(char* str)

Sends each character from str over UART
by writing them to 0xC0262E
until a 0 value is found.
Does not send a newline afterwards.
*/
void uprint(char* str) 
{
	int *p = (int *)0xC0262E; 	// address of UART TX
	char chr = *str; 			// first character of str

	while (chr != 0) 			// continue until null value
	{
		*p = (int)chr; 			// write char over UART
		str++; 					// go to next character address
		chr = *str; 			// get character from address
	}
}


/*
uprintln(char* str)

Same as uprint(char* str),
except it sends a newline afterwards.
*/
void uprintln(char* str) 
{
	uprint(str);
	uprint("\n");
}


/*
itoa(int value, char* str)

Currently do not know of a more solid implementation
therefore it currently only supports numbers up to
1 million, and is probably not that efficient
*/
void itoa(int value, char* str)
{
	int tens = 0;
	int singles = 0;

	while(value >= 10)
	{
		tens++;
		value = value - 10;
	}
	singles = value;

	*str = 'x';

	str++;
	*str = 'y';

	str++;
	*str = 'z';

	//TODO implement this function


	// add a terminator
	str++;
	*str = 0;
}