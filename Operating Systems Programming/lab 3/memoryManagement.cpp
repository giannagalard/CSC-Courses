// cpp file that contains all of the memory management algorithms
// better than submitting 4 different cpp files

#include<iostream>
using namespace std;

int main() {
  int p[10], np, b[10], nb, ch, w[10], i, j, total;
  total = 0;

  // prompt user for number of processes
  cout << "Enter the number of processes: ";
  cin >> np;
  // prompt user for the size of each process
  for (i = 0; i < np; i++) {
    cout << "Size of process " << i + 1 << ": ";
    cin >> p[i];
  }
  // prompt user for number of partitions
  cout << "\nEnter the number of partitions: ";
  cin >> nb;
  // prompt user for the size of each partition
  for (i = 0; i < nb; i++) {
      cout << "Size of partition " << i + 1 << ": ";
      cin >> b[i];
  }

  //int* k = new int [np];
  //memset(k, -1, sizeof(k));

  int* alloc = new int[np];
  memset(alloc, -1, sizeof(alloc));

  // prompt user for the choice of algorithm
  cout << "\n1.First Fit\n2.Next Fit\n3.Best Fit\n4.Worst Fit\n";
  cout << "\nEnter the choice of algorithm: ";
  cin >> ch;

  // switch cases
  switch (ch) {
  case 1: {
      // first fit algorithm 
      for (i = 0; i < np; i++) {
          for (j = 0; j < nb; j++) {
              if (p[i] <= b[j]) {
                  alloc[i] = j;
                  b[j] -= p[i];
                  w[i] = b[j];
                  break;
              }
          }
      }
      cout << "\nProcess ID\tPartition ID\tStatus\tWaste";
      for (int i = 0; i < np; i++) {
          cout << "\n" << i + 1 << "\t\t";
          if (alloc[i] >= -1)
              cout << alloc[i] + 1 << "\t\tRun\t";
          else
              cout << "-\t\tWait\t";
          if (w[i] >= -1) {
              total += w[i];
              cout << w[i];
          }
          else
              cout << "-";
          cout << endl;
      }
      cout << "\nTotal Waste: " << total << endl;
      break;
  }
  case 2: {
      // next fit algorithm
      j = 0;
      for (i = 0; i < np; i++) {
          int count = 0;
          while (count < nb) {
              count++;
              if (p[i] <= b[j]) {
                  alloc[i] = j;
                  b[j] -= p[i];
                  w[i] = b[j];
                  b[j] = -1;

                  break;
              }
              j = (j + 1) % nb;
          }
      }
      cout << "\nProcess ID\tPartition ID\tStatus\tWaste";
      for (int i = 0; i < np; i++) {
          cout << "\n" << i + 1 << "\t\t";
          if (alloc[i] >= -1)
              cout << alloc[i] + 1 << "\t\tRun\t";
          else
              cout << "-\t\tWait\t";
          if (w[i] >= -1) {
              total += w[i];
              cout << w[i];
          }
          else
              cout << "-";
          cout << endl;
      }
      cout << "\nTotal Waste: " << total << endl;
      break;
  }
  case 3: {
      // best fit algorithm
      for (i = 0; i < np; i++) {
          int bestIndex = -1;
          for (j = 0; j < nb; j++) {
              if (p[i] <= b[j]) {
                  if (bestIndex == -1)
                      bestIndex = j;
                  else if (b[bestIndex] > b[j])
                      bestIndex = j;
              }
          }
          if (bestIndex != -1) {
              alloc[i] = bestIndex;
              b[bestIndex] -= p[i];
              w[i] = b[bestIndex];
          }
      }
      cout << "\nProcess ID\tPartition ID\tStatus\tWaste";
      for (int i = 0; i < np; i++) {
          cout << "\n" << i + 1 << "\t\t";
          if (alloc[i] >= -1)
              cout << alloc[i] + 1 << "\t\tRun\t";
          else
              cout << "-\t\tWait\t";
          if (w[i] >= -1) {
              total += w[i];
              cout << w[i];
          }
          else
              cout << "-";
          cout << endl;
      }
      cout << "\nTotal Waste: " << total << endl;
      break;
  }
  case 4: {
      // worst fit algorithm
      for (i = 0; i < np; i++) {
          int worstIndex = -1;
          for (j = 0; j < nb; j++) {
              if (p[i] <= b[j]) {
                  if (worstIndex == -1)
                      worstIndex = j;
                  else if (b[worstIndex] < b[j])
                      worstIndex = j;
              }
          }
          if (worstIndex != -1) {
              alloc[i] = worstIndex;
              b[worstIndex] -= p[i];
              w[i] = b[worstIndex];
          }
      }
      cout << "\nProcess ID\tPartition ID\tStatus\tWaste";
      for (int i = 0; i < np; i++) {
          cout << "\n" << i + 1 << "\t\t";
          if (alloc[i] >= -1)
              cout << alloc[i] + 1 << "\t\tRun\t";
          else
              cout << "-\t\tWait\t";
          if (w[i] >= -1) {
              total += w[i];
              cout << w[i];
          }
          else
              cout << "-";
          cout << endl;
      }
      cout << "\nTotal Waste: " << total << endl;
      break;
  }
  }
};