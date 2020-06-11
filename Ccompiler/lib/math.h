/*
div(int dividend, int divisor) 

Very slow way of unsiged integer division
Works by substracting until the divisor is bigger
than the dividend
*/
int div(int dividend, int divisor) 
{
	// We do not want to divide by 0
	if (divisor == 0)
	{
		return 0;
	}

	int result = 0;
	while (dividend >= divisor)
	{
		dividend = dividend - divisor;
		result += 1;
	}
	
	return result;
}


/*
mod(int dividend, int divisor) 

Very slow way of unsiged integer modulo operation
Works by substracting until the divisor is bigger
than the dividend, followed by
returning the remainder of the dividend
*/
int mod(int dividend, int divisor) 
{
	// We do not want to divide by 0
	if (divisor == 0)
	{
		return dividend;
	}

	while (dividend >= divisor)
	{
		dividend = dividend - divisor;
	}
	
	return dividend;
}