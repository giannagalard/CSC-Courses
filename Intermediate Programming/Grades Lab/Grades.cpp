#include <iostream>
#include <string>
#include <fstream>
#include <iomanip>
 
using namespace std;
// main func
int main()
{
// variable/array declaration
int open; // open txt
string names[15]; // create a string for names
int emplids[15]; // student id
int exam1[15]; // exam grades
int exam2[15];
int exam3[15];
int exam4[15];
int exam5[15];
float average[15]; // average score
char letter[15]; // letter grade
ifstream uwu;
string line; // used for while loop
int counter = 0; // what line we are reading
float total; // total score
int classAvg; // overall class average
 
// open txt file
uwu.open("grades.txt");
if (!uwu)
   {
       cout << "Unable to open file";
       exit(1); // terminate with error
   }
 while(!uwu.eof())
 {
   getline(uwu,line);
   names[counter] = line.substr(0,line.find(" ")); // starts at first char, stops at space
   line = line.substr(line.find(" ") + 1); // separates name
   emplids[counter] = stoi(line.substr(0,line.find(" "))); // use stoi to convert from string to int
   line = line.substr(line.find(" ")+ 1); // separates emplid
   exam1[counter] = stoi(line.substr(0,line.find(" ")));
   line = line.substr(line.find(" ")+ 1); // separates exam 1
   exam2[counter] = stoi(line.substr(0,line.find(" ")));
   line = line.substr(line.find(" ")+ 1); // separates exam 2
   exam3[counter] = stoi(line.substr(0,line.find(" ")));
   line = line.substr(line.find(" ")+ 1); // separates exam 3
   exam4[counter] = stoi(line.substr(0,line.find(" ")));
   line = line.substr(line.find(" ")+ 1); // separates exam 4
   exam5[counter] = stoi(line.substr(0));
   counter++;
 }
 uwu.close(); // close file
total = 0;
// for loop finding average of each students grades
for(int x = 0; x < 15; x++) // for loop will go 15 times
 { // use x to make simpler, starts at 0 and ends at 14, every iteration starts at 1
 // casted as a float
     average[x] = (float)(exam1[x] + exam2[x] + exam3[x] + exam4[x] + exam5[x]) / 5;
    
     total += exam1[x] + exam2[x] + exam3[x] + exam4[x] + exam5[x]; // total points of all
 }
total = (float)total / 75;
// nested loop finding letter grade
for(int y = 0; y < 15; y++) 
{
 bool gradeW;
 // if statement to find missed test grade to output w instead of actual letter grade
 if(exam1[y] == 0 || exam2[y] == 0 || exam3[y] == 0 || exam4[y]==0 || exam5[y]==0)
   gradeW = true;
 if(average[y] >= 89.5 && !gradeW) // and if we havent said grade is w , grade is a ... etc
 {
   letter[y] = 'A'; // greater than 89 and if isnt w its an a
 }
 else if (average[y] >= 79.5 && !gradeW) // if not grade w and greater than 79 its a b
 {
   letter[y] = 'B';
 }
 else if (average[y] >= 69.5 && !gradeW) // if not grade w and avg is larger than 69 its a c
 {
   letter[y] = 'C';
 }
 else if (average[y] >= 59.5 && !gradeW) // if not grade w and greater than 59 its a d
 {
   letter[y] = 'D';
 }
 else if (gradeW) // if its w output w
   letter[y] = 'W';
 else
 {
   letter[y]='F'; // default, anything other than the grades listen is an f
 }
}
// output the header
cout << " NAME          Exam 1     Exam 2     Exam 3     Exam 4     Exam 5      EMPLID     Average    Letter Grade" << endl;
// format output using a for loop
for(int z = 0; z < 15; z++)
{
 cout << names[z] << setw(13) << exam1[z] << setw(11) << exam2[z] << setw(11) << exam3[z] << setw(11) << exam4[z]  << setw(11) << exam5[z] << setw(14) << emplids[z] << setw(11) << average[z] << setw(13) << letter[z] << endl;
}
// creating a blank space
cout << " " << endl;
cout << " " << endl;
// outputting class avg with a set precision of 3 --- should be 71.5
cout << "CLASS AVERAGE: " << setprecision(3) << total << endl;
}
