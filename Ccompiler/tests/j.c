int main() {

	// get pointer from address
	int a = 3;
	int *p;
	p = &a;

	// set pointer to manual address
	p = (int *)99;

	// write value at pointer address
	*p = 20;
	
	return 0;
}