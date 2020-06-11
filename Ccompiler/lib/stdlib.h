#include "math.h" 

/*
uprintc(char c)

Prints a single char c by writing it to 0xC0262E
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
itoar(int n, char *s)

Recursive helper function for itoa
Eventually returns the number of digits in n
*/
int itoar(int n, char *s)
{
	int digit = mod(n, 10);
    int i = 0;

    n = div(n,10);
    if (n > 0)
    	i += itoar(n, s);

    s[i++] = digit + '0';

    return i;
}


/*
itoa(int n, char *s)

Converts integer n to a characters.
The characters are placed in the buffer s.
The buffer is terminated with a 0 value.
Uses recursion, division and mod to compute.
*/
void itoa(int n, char *s)
{
	// compute and fill the buffer
	int i = itoar(n, s);

	// end with terminator
	s[i] = 0;
} 