 #include <iostream>

 using namespace std;

 void waitingT(int processes[], int j, int bTime[], int wTime[]) {
   wTime[0] = 0;

   for (int i = 1; i < j; i++)
     wTime[i] = bTime[i - 1] + wTime[i - 1];

 }

 void turnAroundTime(int processes[], int j, int bTime[], int wTime[], int tat[]) {
   for (int i = 0; i < j; i++)
     tat[i] = bTime[i] + wTime[i];
 }

 void firstComeFirstServe(int processes[], int j, int bTime[]) {
   int wTime[j], tat[j], totalWait = 0, totalTAT = 0;

   waitingT(processes, j, bTime, wTime);
   turnAroundTime(processes, j, bTime, wTime, tat);

   cout << "Processes " << "Burst Time " << "Waiting Time " << "Turn Around Time" << endl;

   for (int i = 0; i < j; i++) {
     totalWait = totalWait + wTime[i];
     totalTAT = totalTAT + tat[i];
     cout << "\t" << i + 1 << "\t  " << bTime[i] << "\t  " << wTime[i] << "\t\t" << tat[i] << endl;
   }

   cout << "Average Waiting Time = " << (float) totalWait / (float) j;
   cout << " " << endl;
   cout << "Average Turn Around Time = " << (float) totalTAT / (float) j;
 }

 // Driver Code
 int main() {
   int j;

   cout << "Please enter the number of Processes: ";
   cin >> j;

   int processes[j];
   for (int i = 0; i < j; i++)
     processes[i] = i + 1;

   int burstTime[j];
   for (int i = 0; i < j; i++) {
     cout << "Please enter the Burst time of Processes: " << i + 1 << "--> ";
     cin >> burstTime[i];
   }

   cout << " " << endl;
   cout << "----------------------------------------" << endl;
   cout << "   FIRST COME FIRST SERVE SCHEDULING" << endl;
   firstComeFirstServe(processes, j, burstTime);
 }
