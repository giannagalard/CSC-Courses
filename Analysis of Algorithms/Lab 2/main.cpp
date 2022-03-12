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

  // seed the random number generator
  srand(time(NULL)); 

  
  int bound[7] = { 
    30,
    50,
    80,
    100,
    1000,
    10000,
    INT_MAX
  };

  // table header
  cout << left << setw(25) << "Bound" << setw(20) << "Calculated Average" << setw(25) << " Real Average" << endl;
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
  double averageCase = 0;
  double totalSteps = 0;
  double findReturn = 0;
  double realAverage = 0.0;

  // loop to count average
  for (int j = 0; j < 10000; j++) {
    for (int i = 0; i < n; i++) {
      sequence[i] = rand() % currentBound; 
      if (x == sequence[i]) {
        hits++;
      }
    }

    findReturn = Find(x, sequence, n); 

    if (findReturn == 0) { 
      // if x is not found, add 50 steps
      totalSteps += 50; 
    } else if (findReturn != 0) { 
      // if x is found, add steps to findReturn
      totalSteps += findReturn; 
    }
    // add 1 step for the for loop
    totalSteps++; 
  } 

  
  q = hits / 10000; 

   // calculate average case
  averageCase = (n - ((n * q) / 2) + (q / 2));

  // calculate real average
  realAverage = totalSteps / 10000;

  // output
  cout << fixed << setprecision(2);
  cout << left << setw(25) << currentBound << setw(25) << averageCase << setw(25) << realAverage << endl;

}

// array of size n
int Find(int x, int A[], int n) 
{
  int j;
  for (j = 0; j < n; j++) {
    if (x == A[j]) {
      return (j + 1); 
    }
  }
  return 0; 
}