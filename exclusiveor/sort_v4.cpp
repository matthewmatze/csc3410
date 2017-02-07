/*
      Name: Matthew Matze
      Date: 9/6/2015
      Class: csc1720
      Location:~/csc3410
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
   int answer=0;
	int base=0;
	string number;
	int n=0;
	printf("Please enter the base of the number you would like to convert to decimal: ");
	scanf("%i",&base);
	printf("Please enter a number you would like to convert to decimal: ");
	cin>>number;
	n=number.size();
	int* numarray = new int[n];
	for(int i=n-1;i>=0;i--)
	{
		numarray[n-i-1]=number[i]-48;
		if(numarray[n-i-1]>16)
			numarray[n-i-1]=numarray[n-i-1]-7;	
		if(numarray[n-i-1]>41)
			numarray[n-i-1]=numarray[n-i-1]-32;
	//	printf("%i\n",numarray[i]);
	}
	for(int i=n-1; i>=0; i--)
	{
		answer += numarray[i] * (int)pow(base,i);
	}
	printf("Your number is in decimal is %i\n", answer);

   return 0;
}
