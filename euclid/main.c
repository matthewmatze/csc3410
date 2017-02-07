#include<stdio.h>
#include<stdlib.h>

int gcd(int x,int y);

int main(int argv, char**argc){
	
	int x,y,ans;

	x=atoi(argc[1]);
	y=atoi(argc[2]);

	ans=gcd(x,y);

	printf("The answer is %i",ans);
	return 0;
}
