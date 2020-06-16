void uprintc(char c) 
{
	int *p = (int *)0x700000; 	// fake address of UART TX
	*p = (int)c; 			// fake write char over UART
}

void CH376_sendFileName(char* str)
{
	//int *p = (int *)0xC0262E; 	// address of UART TX
	char chr = *str; 			// first character of str

	while (chr != 0) 			// continue until null value
	{
		uprintc(chr);
		//*p = (int)chr;
		str++; 					// go to next character address
		chr = *str; 			// get character from address
	}
}

int main() 
{
	
	CH376_sendFileName("Lorum.txt");
	
	return 48;
}


void int1()
{

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