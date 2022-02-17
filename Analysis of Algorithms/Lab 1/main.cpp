#include <iostream>
#include <string>
#include <iomanip>
#include <ctime>
#include <time.h>   

using namespace std;

int const max1 = 10;

// recursive algo
int FiboR(int n); 
// non recursive algo
int FiboNR(int n);
// modified recursive algo
int MODfibR(int n);

int main() {
	// time required to execute
	clock_t time_req; 
	int fibNums[max1] = { 1,5,10,15,20,25,30,35,40,45 }; 

	// arrays to store the RECURSIVE fibonacci values and times
	int fibValuesR[max1];
	float fibTimesR[max1];

	// arrays to store the NON RECURSIVE fibonacci values and times
	int fibValuesNR[max1];
	float fibTimesNR[max1];

	// arrays to store the MODIFIED RECURSIVE fibonacci values and times
	int MODfibRvalues[max1];
	float MODfibRTimes[max1]; 

	// output table header 
	cout << left 
  << setw(25) << "INTEGER" 
  << setw(25) << "FiboR (seconds)"
  << setw(25) << "MODfibR" 
  << setw(25) << "FiboNR (seconds)" 
  << setw(25) << "Fibo-value-r" 
  << setw(25) << "Fibo-value-nr" 
  << endl;
	cout << "-------------------------------------------------------------------------------------------------------------------------------------------" << endl;
	
    // recursive algo
	for (int i = 0; i < max1; i++) {
		// start timer
		time_req = clock(); 
		// call recursive algo
		fibValuesR[i] = FiboR(fibNums[i]); 
		// end timer
		time_req = clock() - time_req; 
		// store time in seconds
		fibTimesR[i] = time_req; 
	}

	// non recursive 
	for (int i = 0; i < max1; i++) {
		// start timer
		time_req = clock();
		// call non recursive algo
		fibValuesNR[i] = FiboNR(fibNums[i]);
		// end timer
		time_req = clock() - time_req;
		// store time in seconds
		fibTimesNR[i] = time_req;
	}

  //make a for loop to run the modified recursion here (look at lines 44 through 49) 
  	for (int i = 0; i < max1; i++) {
		// start timer
    	time_req = clock();
		// call modified recursive algo 
    	MODfibRvalues[i] = MODfibR(fibNums[i]);
		// end timer
    	time_req = clock() - time_req;
		// store time in seconds
    	MODfibRTimes[i] = time_req;
  }
  
	//output values
	for (int i = 0; i < max1; i++) {
		cout << left << setw(25) 
        << fibNums[i] << setw(25) 
        << (float)fibTimesR[i] / CLOCKS_PER_SEC 
        << setw(25) << (float)MODfibRvalues[i] / CLOCKS_PER_SEC
        << setw(25) << (float)fibTimesNR[i] / CLOCKS_PER_SEC 
        << setw(25) << fibValuesR[i] 
        << setw(25) << fibValuesNR[i] << endl;
	}
}


// recursive 
int FiboR(int n) {
	if (n == 0 || n == 1)
		return(n);
	else
		return(FiboR(n - 1) + FiboR(n - 2));
}

// non recursive
int FiboNR(int n) {
	if (n <= 1) {
		return n;
	}
	int fibo = 1;
	int fiboPrev = 1;
	for (int i = 2; i < n; ++i) {
		int temp = fibo;
		fibo += fiboPrev;
		fiboPrev = temp;
	}
	return fibo;
}

int dp[10000]; 
// modified recursive algo
int MODfibR(int n) {
	if (n == 0 || n == 1)
		return n;
	if (dp[n] != -1) {
		return dp[n];
	}
	dp[n] = MODfibR(n - 1) + MODfibR(n - 2);
	return dp[n];
}