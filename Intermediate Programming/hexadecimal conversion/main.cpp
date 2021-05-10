#include <iostream>
#include <cmath>
#include <fstream>
#include <cstring>
#include <cstdlib>

using namespace std;

// hexadecimal to decimal conversion
int hexToDec(char *a)
{
   int l,x;
   int n = 0, c = 0;
   l = strlen(a); // strlen returns the length of string passed
   for(x = l-1; x >= 0; x--) // this for loop converts hex to dec
   { // convert both lowercase and uppercase, they have dif values ascii
       if((a[x]>='A')&&(a[x]<='F')) // converting upperclass letters
       {
           n=n+pow(16,c)*(a[x]-'A'+10);
       }
       else if((a[x]>='a')&&(a[x]<='f')) // converting lowercase letters
       {
           n=n+pow(16,c)*(a[x]-'a'+10);
       }
       else
       {
           n=n+pow(16,c)*(a[x]-48);
       }
       c++;
   }
   return n;
}

// decimal to hexadecimal conversion
char* decToHex(int y)
{
   char * a;
   int d;
   a = new char[(int)log(y)+1];
   while(y!= 0) // while loop converts dec to hex 
   {
       d = y % 16;
       if(d<10)
       {
           strcat(a,(char *)(char)(48+d)); 
       }
       else
       {
           strcat(a,(char *)(char)(65+d-10));
       }
       y = y/16;
   }
   return a;
}


int main() { 
  // reads through txt file
   ifstream uwu; // name change
   uwu.open("hexList.txt");
   char data[100];
   int sum = 0; // set some to 0 so it could be manipulated
   if (!uwu) // if unable to open, output error code and exit 
   {
       cerr<<"Unable to open the file.";
       exit(-1);
   }
   while (uwu >> data)
   {
       sum=sum+hexToDec(data);
   }
   cout << "Sum = " << sum << endl;
   cout << "Sum = " << decToHex(sum) <<endl;
   uwu.close();
   return 0;
}
