#include <iostream>
#include <iomanip>
#include <cmath>
#include <ctime>
#include <limits.h>

using namespace std;

const int n = 50;

int Find(int x, int A[], int n); 
void Generator(int sequence[n], int currentBound, int x); 

int main() {
  int sequence[n];
  int currentBound;

  //random number generator seed
  srand(time(NULL));

  //this must be an int type
  int bound[7] = {
    30,
    50,
    80,
    100,
    1000,
    10000,
    INT_MAX
  };

  // fun output <333
  cout << left << setw(25) << "Bound" << setw(20) << "Calculated Average" << setw(25) << " Real Averge" << endl;
  cout << "_________________________________________________________________" << endl;

  //integer between 0 and bound
  for (int i = 0; i < 7; i++) {
    int x = rand() % bound[i];
    currentBound = bound[i];
    Generator(sequence, currentBound, x);
  }
}

void Generator(int sequence[], int currentBound, int x) {
  double hits = 0;
  double q = 0;
  double average_case = 0;
  double total_steps = 0;
  double findReturn = 0;
  double real_average = 0.0;

  //loop to count averages
  for (int j = 0; j < 10000; j++) {
    for (int i = 0; i < n; i++) {
      sequence[i] = rand() % currentBound;
      if (x == sequence[i]) {
        hits++;
      }
    }

    findReturn = Find(x, sequence, n);

    if (findReturn == 0) {
      total_steps += 50;
    } else if (findReturn != 0) {
      total_steps += findReturn;
    }
    total_steps++;
  }

  //counting q
  q = hits / 10000;

  ////function derived in class to calculate the probability n is in the sequence
  average_case = (n - ((n * q) / 2) + (q / 2));

  //function derived in classs to calculate the probability n is in the sequence
  real_average = total_steps / 10000;

  //output
  cout << fixed << setprecision(2);
  cout << left << setw(25) << currentBound << setw(25) << average_case << setw(25) << real_average << endl;

}

int Find(int x, int A[], int n) // array of size n
{
  int j;
  for (j = 0; j < n; j++) {
    if (x == A[j]) {
      return (j + 1); //the position is 1 more than the index
    }
  }
  return 0; // x is not an element of the array
}