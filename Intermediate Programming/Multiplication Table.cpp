/*
this program uses 2d arrays that will produce a
multiplication table
*/
#include <iostream>
#include <iomanip>
using namespace std;
 
int main()
{
const int row = 12, col = 12; // declare constant
int mult[row][col]; // declare array
// calculations
for(int x = 0; x < row; x++)
 {
   for(int y = 0; y < col; y++)
   {
     mult[x][y] = (x + 1) * (y + 1); // storing values in array
   }
 }
// for loop outputs and formats mult table
for(int x = 0; x < row; x++)
 {
   for(int y = 0; y < col; y++)
   {
     cout << setw(5) << right << mult[x][y];
   }
 cout << " " << endl;
 }
 return 0;
}
