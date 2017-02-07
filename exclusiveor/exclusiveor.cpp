/*
      Name: Matthew Matze
      Date: 9/8/2015
      Class: csc3410
      Location:~/csc3410/exclusiveor.cpp
*/

#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<limits.h>
#include<math.h>
#include<string>

using namespace std;

int main(void)
{
	int x,y;
	printf("Please type in the x variable we should switch: ");
	scanf("%i",&x);
	printf("Please type in the y variable we should switch: ");
	scanf("%i",&y);

	x=x^y;
	y=x^y;
	x=x^y;
	printf("x is now %i y is now %i\n",x, y);

   return 0;
}
