#include<stdbool.h>
#include<stdio.h>

int booths(int x, int y);

int main(void)
{
   int x;
   int y;
	int ans;
	printf("Please Enters two ints to multiply:");
   scanf("%d",&x);
   scanf("%d",&y);
      ans=booths(x,y); 
   printf("%d x %d = %d\n",x,y,ans);

   return 0;

   
}

int booths(int x, int y)
{
	long long int ans = 0;
	for(int i=0;i<16;i++){
		if(x%2==1)
			ans+=y<<16;
		x=x>>1;
		ans=ans>>1;
	}	
   return ans;
}
