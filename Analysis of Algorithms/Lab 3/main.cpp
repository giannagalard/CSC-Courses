#include <iostream>
#include <iomanip>
#include <cmath>
#include <ctime>

using namespace std;

int modInsertion(int A[], int);

int main()
{
  srand(time(NULL));
  int n[] = {100, 500, 1000, 2500, 3000, 3500};
  double calculateAverage, realAverage;
  int bound = 10000;
  int repeat = 100000;

  cout << "Input Size" << setw(20) << "Calculated Average" << setw(15) << "Real Average" << endl;
  // so cute
  cout << "—————♡———————————————♡————————————————♡——————" << endl;

  for (int i = 0; i < sizeof(n); i++)
  {
    int inputSize = n[i];
    int *array = new int[inputSize];
    long long int totalNumSteps = 0;

    // generate 100,000 random sequences
    for (int j = 0; j < repeat; j++)
    {
      for (int k = 0; k < inputSize; k++)
      {
        array[k] = rand() % bound;
      }

      // calling modInsertion
      int insertionFunc = modInsertion(array, inputSize);
      // update totalNumSteps
      totalNumSteps += insertionFunc;
    }

    // calculate average
    calculateAverage = (pow(inputSize, 2) / 4) + (3 * inputSize / 4);
    // real average
    realAverage = static_cast<double>(totalNumSteps) / repeat;

    cout << setprecision(2) << fixed;
    cout << setw(5) << inputSize << setw(20) << calculateAverage << setw(20) << realAverage << endl;
  }
  return 0;
}

int modInsertion(int A[], int n)
{ // in reality the elements to be sorted are indexed from index 1 to index n
  int i, j, temp;
  int steps = 0;
  A[0] = -32768; // smallest possible integer using 2 bytes integer representation
  for (i = 1; i <= n; i++)
  {
    j = i;
    while (A[j] < A[j - 1])
    { // swap
      temp = A[j];
      A[j] = A[j - 1];
      A[j - 1] = temp;
      j--;
      steps++;
    }
    steps++;
  }
  return steps;
}
