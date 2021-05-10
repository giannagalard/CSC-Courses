 
/*
This program sets retrieves, and prints the time, then increments the  time by one second, minute, and hour. Finally, it compares the two times.
USE THESE VARIABLES :::   int hr;    int min;   int sec;
FUNCTIONS NAMES ::: setTime, getTime, printTime, incrementSeconds, incrementMinutes, incrementHours, and equalTime.
Note 1:  IN the Main Program, we should INVOKE/ CALL each of the FUNCTIONS
*/
 
#include <iostream>
 
using namespace std;
 
class clock {
    // Default constructor variables for clock object.
    int hr;
    int min;
    int sec;
 
public:
    // Define clock objects with values.
    clock() {
         this->hr = 0;
         this->min = 0;
         this->sec = 0;
    }
 
    // Parameterized constructor.
    clock(int hr, int min, int sec) {
         this->hr = hr;
         this->min = min;
         this->sec = sec;
    }
 
    // Getter method.
    int getHr() { return this->hr; }
    int getMin() { return this->min; }
    int getSec() { return this->sec; }
 
    // Setter method.
    void setTime(int hr, int min, int sec) {
         this->hr = hr;
         this->min = min;
         this->sec = sec;
    }
 
    // Default object return.
    clock getTime() { return *this; }
 
    // Display the time.
    void printTime() {
         cout << "time is - " << this->hr << ":" << this->min << ":"
              << this->sec << endl;
    }
    // Method to increment the seconds variable for the object
    void incrementSeconds() {
         if (this->sec == 59) // If 59 secs pass, it increment mins at the 60 sec mark.
         {
              this->sec = 0;
              this->incrementMinutes();
         }
         else
              this->sec++;
    }
 
    // Method to increment the minutes variable for the object.
    void incrementMinutes() // If 59 mins pass, it increment hours at the 60 sec mark.
    
    {
         if (this->min == 59) {
              this->min = 0;
              this->incrementHours();
         }
         else
              this->min++;
    }
   
    // Method to increment the hours variable for the object.
    void incrementHours() {
   
         if (this->hr == 23) // 23 hrs pass.
              this->hr = 0;
         else
              this->hr++;
    }
 
    // Method to compare time values between two clock objects.
    bool equalTime(clock ob) {
         return this->hr == ob.getHr() && this->min == ob.getMin() &&
              this->sec == ob.getSec();
    }
};
 
int main() {
    int minutes, hours, seconds;
    cout << "~First~ " << endl;
    cout << "\n" << endl;
    cout << "Enter hours: " << endl;
    cin >> hours;
    cout << "Enter minutes: " << endl;
    cin >> minutes;
    cout << "Enter seconds: " << endl;
    cin >> seconds;
 
    // Create the first object.
    class clock ob1(hours, minutes, seconds);
 
    cout << "\n" << endl;
    cout << "~Second~ " << endl;
    cout << "\n" << endl;
    cout << "Enter hours: " << endl;
    cin >> hours;
    cout << "Enter minutes: " << endl;
    cin >> minutes;
    cout << "Enter seconds: " << endl;
    cin >> seconds;
 
    // Create a second object.
    class clock ob2(hours, minutes, seconds);
 
    cout << "\n" << endl;
    cout << "First ";
    ob1.printTime();
    cout << "Second ";
    ob2.printTime();
 
    ob1.incrementSeconds();
    ob2.incrementMinutes();
    ob2.incrementHours();
 
    cout << "\n" << endl;
    cout << "Incremented: " << endl;
    cout << "First ";
    ob1.printTime();
    cout << "Second ";
    ob2.printTime();
    cout << "Equal ? - " << ob1.equalTime(ob2);
    return -1; // returns if errors on exit
}
