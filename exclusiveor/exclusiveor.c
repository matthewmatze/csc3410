/*
      Name: Matthew Matze
      Date: 9/8/2015
      Class: csc3410
      Location:~/csc3410/exclusiveor.c
*/

#include<stdio.h>

int main(void)
{
	char x,y;
	
	printf("Please type in the x and y variable we should switch with a white space in between: ");
	scanf("%c\n",&x);
	scanf("%c",&y);
	x=x^y;
	y=x^y;
	x=x^y;
	printf("x is now %c y is now %c\n",x, y);

   return 0;
}
