int main() {

   unsigned int a = 60;	/* 60 = 0011 1100 */  
   unsigned int b = 13;	/* 13 = 0000 1101 */
   int c = 0;           

   c = a & b;       /* 12 = 0000 1100 */ 
   c = a | b;       /* 61 = 0011 1101 */
   c = a ^ b;       /* 49 = 0011 0001 */
   c = ~a;          /*-61 = 1100 0011 */
   c = a &&& b;     /* 240 = 1111 0000 */
   c = a &&& c;
   c = a >> 2; 
   c = a << 2; 

   return c;
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