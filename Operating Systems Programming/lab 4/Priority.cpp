// pre-emptive priority scheduling

#include <iostream>

#include <algorithm>

#include <string.h>

using namespace std;

typedef struct process {
  string procId;
  int arrivalTime, burstTime, completionTime, tat, waitingTime, burstX, pr;

}
schedule;

bool arrivalcompare(schedule a, schedule b) {
  // will always return true if condition is met
  return a.arrivalTime < b.arrivalTime;
}

bool prioritycompare(schedule a, schedule b) {
  // will always return true if condition is met
  return a.pr > b.pr;

}

int main() {
  schedule proc[10];
  int num, i, j, pcom;

  cout << "Please enter the number of Processes: ";
  cin >> num;

  for (i = 0; i < num; i++) {
    cout << "Process ID:";
    cin >> proc[i].procId;
    cout << "Enter the Arrival time for " << proc[i].procId << ": ";
    cin >> proc[i].arrivalTime;
    cout << "Enter the Burst Time for " << proc[i].procId << ": ";
    cin >> proc[i].burstTime;
    proc[i].burstX = proc[i].burstTime;
    cout << "Enter the Priority for " << proc[i].procId << ": ";
    cin >> proc[i].pr;
    cout << " " << endl;
  }

  // sorting based on arrival time
  sort(proc, proc + num, arrivalcompare);

  i = 0;
  pcom = 0;
  while (pcom < num) {
    for (j = 0; j < num; j++) {
      if (proc[j].arrivalTime > i)
        break;
    }
    sort(proc, proc + j, prioritycompare);
    if (j > 0) {
      for (j = 0; j < num; j++) {
        if (proc[j].burstTime != 0)
          break;
      }
      if (proc[j].arrivalTime > i)
        i += proc[j].arrivalTime - i;
      proc[j].completionTime = i + 1;
      proc[j].burstTime--;
    }

    i++;
    pcom = 0;
    for (j = 0; j < num; j++) {
      if (proc[j].burstTime == 0)
        pcom++;
    }
  }

  cout << " " << endl;
  cout << "Process ID" << "\tArrival Time" << "\tBurst Time" << "\tCompletion Time" << "\tTurn Around Time" << "\tWait Time" << "\tPriority" << endl;

  for (i = 0; i < num; i++) {
    proc[i].tat = proc[i].completionTime - proc[i].arrivalTime;
    proc[i].waitingTime = proc[i].tat - proc[i].burstX;

    cout << "\t" << proc[i].procId << " \t\t" << proc[i].arrivalTime << "\t\t" << proc[i].burstX << " \t\t " << proc[i].completionTime << "\t\t " << proc[i].tat << "\t\t" << proc[i].waitingTime << "\t \t " << proc[i].pr;
    cout << endl;
  }

  return 0;
}
