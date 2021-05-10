#include <iostream>
#include <string>
#include <fstream>
#include <iomanip>
 
using namespace std;
//  struct method for lab 3
typedef struct 
{
  string name;
  int emplid;
  int exams[5];
  float average;
  char letter;
} student;
 
int main() 
{
  // current line string
  string line; 
  // current line index
  int counter = 0;
  // average value of the class
  float classAvg;
 
  // the list of students
  student students[15];
 
  // the input stream of the text file
  ifstream uwu;
  uwu.open("grades.txt");
 
  // exit with error if unable to open text file
  if (!uwu) 
  {
    cout << "Unable to open text file";
    exit(1);
  }
 
  // output the header
  cout << " NAME          Exam 1     Exam 2     Exam 3     Exam 4     Exam 5   "
          " EMPLID     Average    Letter Grade"
       << endl;
 
  // while not to the end of the line in file
  while (!uwu.eof()) 
  {
    // Get the current line
    getline(uwu, line);
 
    // to make sure that the average is accurate, 0 it out at the start
    students[counter].average = 0.f;
 
    students[counter].name = line.substr(0, line.find(" "));
 
    // advance the line to emplid
    line = line.substr(line.find(" ") + 1);
 
    // convert the string to integer for emplid
    students[counter].emplid = stoi(line.substr(0, line.find(" ")));
 
    // advance the line to Exam 1
    line = line.substr(line.find(" ") + 1);
 
    // for each exam, get the score
    for (int i = 0; i < 5; ++i) 
    {
      if (i != 4) 
      {
        // convert the substring to integer for the specific exam
        students[counter].exams[i] = stoi(line.substr(0, line.find(" ")));
        // advance to the next substring
        line = line.substr(line.find(" ") + 1);
      } 
      else 
      {
        // don't advance to the next substring if at the end of line (max exams)
        students[counter].exams[i] = stoi(line.substr(0));
      }
 
      // add to the class average
      classAvg += students[counter].exams[i];
 
      // add to the average based on the exam scores
      students[counter].average += students[counter].exams[i];
    }
 
    // average out the number based on the number of exams
    students[counter].average = students[counter].average / 5;
 
    // calculate the letter grade
    bool gradeW;
 
    // output the student's name
    cout << students[counter].name << setw(11);
 
    // check all of the exams for if any was missed for outputting W instead and output
    //the grade of the exam
    for (int i = 0; i < 5; ++i) 
    {
      if (students[counter].exams[i] == 0) 
      {
        gradeW = true;
      }
 
      // output that exam's grade
      cout << students[counter].exams[i] << setw(11);
    }
 
    // output the emplid and average of each student
    cout << setw(13) << students[counter].emplid << setw(11)
         << students[counter].average << setw(13);
 
    // calculate the student's letter grade
    if (gradeW) 
    {
      students[counter].letter = 'W';
    } 
    else 
    {
      if (students[counter].average > 89.5) 
        students[counter].letter = 'A';
      else if (students[counter].average >= 79.5) 
        students[counter].letter = 'B';
      else if (students[counter].average >= 69.5) 
        students[counter].letter = 'C';
      else if (students[counter].average >= 59.5) 
        students[counter].letter = 'D';
      else 
        students[counter].letter = 'F';
    }
 
    // output the student's letter grade
    cout << students[counter].letter << endl;
  }
 
  // average out the class average based on the number of students
  classAvg /= 15 * 5;
 
  // close the text file stream
  uwu.close();
 
  // added empty lines to look neater
  cout << " " << endl;
  cout << " " << endl;
  // output the class avg
  cout << "CLASS AVERAGE: " << setprecision(3) << classAvg << endl;
}
