// non pre-emptive sjn

#include<iostream>

using namespace std;
int mat[10][6];

void swap(int * a, int * b) {
  int temp = * a;
  * a = * b;
  * b = temp;
}

void arrivalTime(int num, int mat[][6]) {
  for (int i = 0; i < num; i++) {
    for (int j = 0; j < num - i - 1; j++) {
      if (mat[j][1] > mat[j + 1][1]) {
        for (int k = 0; k < 5; k++) {
          swap(mat[j][k], mat[j + 1][k]);
        }
      }
    }
  }
}

void completionTime(int num, int mat[][6]) {
  int temp, val;
  mat[0][3] = mat[0][1] + mat[0][2];
  mat[0][5] = mat[0][3] - mat[0][1];
  mat[0][4] = mat[0][5] - mat[0][2];

  for (int i = 1; i < num; i++) {
    temp = mat[i - 1][3];
    int low = mat[i][2];
    for (int j = i; j < num; j++) {
      if (temp >= mat[j][1] && low >= mat[j][2]) {
        low = mat[j][2];
        val = j;
      }
    }
    mat[val][3] = temp + mat[val][2];
    mat[val][5] = mat[val][3] - mat[val][1];
    mat[val][4] = mat[val][5] - mat[val][2];
    for (int k = 0; k < 6; k++) {
      swap(mat[val][k], mat[i][k]);
    }
  }
}

int main() {
  int num, temp;

  cout << "Please enter the number of Processes: ";
  cin >> num;

  for (int i = 0; i < num; i++) {
    cout << "Enter Process Id for " << i + 1 << ": ";
    cin >> mat[i][0];
    cout << "Enter Arrival Time for " << i + 1 << ": ";
    cin >> mat[i][1];
    cout << "Enter Burst Time for " << i + 1 << ": ";
    cin >> mat[i][2];
  }

  cout << " " << endl;
  arrivalTime(num, mat);
  completionTime(num, mat);

  cout << "Process ID" << "\tArrive Time" << "\tBurst Time" << "\tWaiting Time" << "\tTurnaround Time" << endl;
  for (int i = 0; i < num; i++) {
    cout << "\t" << mat[i][0] << "\t\t" << mat[i][1] << "\t\t" << mat[i][2] << "\t\t" << mat[i][4] << "\t\t" << mat[i][5] << "\n";
  }
}
