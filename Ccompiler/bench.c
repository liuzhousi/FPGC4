#include "lib/stdlib.h" 
#include "lib/math.h" 


int main() 
{
	char* testString = "Hello? Is it me you're looking for?";
	uprintln(testString);

	char buffer[5];

	buffer[0] = 'a';
	buffer[1] = 'b';
	buffer[2] = 'c';
	buffer[3] = 'd';
	buffer[4] = 0;

	itoa(73, &buffer[0]);

	uprintln(&buffer[0]);


	int divres = div(36, 5);
	int modres = mod(39, 5);
	

	return 48; //modres + 48;
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