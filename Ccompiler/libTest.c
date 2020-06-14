#include "lib/stdlib.h" 
#include "lib/math.h" 


int main() 
{
	char* testString = "Hello? Is it me you're looking for?";
	uprintln(testString);

	char buffer[10];

	int i = 0x400;
	itoa(i, &buffer[0]);

	uprintln(&buffer[0]);

	itoah(i, &buffer[0]);

	uprintln(&buffer[0]);

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