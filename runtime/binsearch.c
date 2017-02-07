#include<stdbool.h>
#include<stdio.h>

bool binSearch(int x[], int l, int r, int sv);

int main(void)
{
   int x[]={4,6,14,17,25,29,32,34,43,50};
   int sv;
   bool f;
   scanf("%d",&sv);
      f=binSearch(x,0,9,sv); 
   if(f)
      printf("found\n");
   else
      printf("not\n");

   return 0;

   
}

bool binSearch(int x[], int l, int r, int sv)
{
   if(l<=r) {
      int m = (l+r)/2;
      if(sv == x[m])
         return true;
      else if(sv < x[m])
         return binSearch(x,l,m-1,sv);
      else
         return binSearch(x,m+1,r,sv);

   }
   return false;
}
