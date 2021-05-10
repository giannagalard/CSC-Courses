/*
this program reads in data from a txt file and determines whether or not you should buy a gift or not based on price and rating
*/
  
#include <iostream>
#include <fstream> // reads data from txt
 
using namespace std;
//define the function above main
int gift(float price, float stars);
 
// main function
int main(){
// variable declaration
string name; // lists names of gifts
float price, stars; // ratings of gifts
int i;
int buy = 0;
int maybe = 0;
 
// open txt file
ifstream open("gifts.txt");
cout << "NAME-----PRICE-----RATING-----BUY?" << endl;
while(!open.eof())
{
 open >> name >> price >> stars;
 
 if(gift(price,stars)==true)
 {
   cout << name << "----" << price << "-----" << stars << "-----" << "Y" << endl;
   buy++;
  }
  else
    {
    cout << name << "---" << price << "---" << stars << "---" << "M" << "\n";
    maybe++;
    }
}
 
// output statements
cout << " " << endl;
cout << "Number of gifts we will buy: " << buy << endl;
cout << "Number of gifts we will maybe buy: " << maybe << endl;
}
 
int gift(float price, float stars)
{
 if(price < 30 && stars > 4.3)
  {
    return true;
  }
   else
  {
      return false;
  }
}
