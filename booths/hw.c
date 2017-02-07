#include<stdio.h>

int booths(int a,int b);

int main(){

int a,b;
int  c;

printf("Enter two integers:");
scanf("%i %i",&a,&b);

c = booths(a,b);

printf("The Output is %i\n",c);

	return 0;
}
