/*





                                         _     _     _     _
                                        (c).-.(c)   (c).-.(c)
                                         / ._. \     / ._. \
                                       __\( Y )/__ __\( Y )/__
                                      (_.-/'-'\-._|_.-/'-'\-._)
                                         || R ||     || R ||
                                       _.' `-' '._ _.' `-' '._
                                      (.-./`-`\.-.|.-./`-`\.-.)
                                       `-'     `-' `-'     `-'
                                            ...............
                                            |~ Formulas: ~|
                                            |RT = ST - AT |
                                            |TAT = CT - AT|
                                            |WT = TAT - BT|
                                            '''''''''''''''
*/

#include <algorithm>
#include <cstring>
#include <fstream>
#include <iostream>
#include <queue>

using namespace std;

struct process {
     int p_id; //process id
     int start_time, end_time, //measure time spent
          arrival_time, burst_time, response_time,
          turnaround_time, waiting_time;
};


bool compareX(process p1, process p2)
{
     return p1.arrival_time < p2.arrival_time;
}

bool compareY(process p1, process p2)
{
     return p1.p_id < p2.p_id;
}

int main() {

     struct process p[50];
     int burst_R[100]; // burst remaining
     int j, idx;
     int time_quantum;
     int total_idle = 0,
          total_rt = 0,
          total_tat = 0,
          total_wt = 0;
     float avg_rt, // avg response time
          avg_tat, // avg turn around time
          avg_wt, // avg waiting time
          cpu_efficiency; // when cpu isn't idle

  // by doing this, you can run either all 50 pro-
  // cesses or you can run only the first couple
  // for example 3 ... etc, however many you want
     cout << "How many processes ? - ";
     cin >> j; // prompt user for input

     cout << "Whats the time quantum ? - ";
     cin >> time_quantum; // prompt user

     for (int i = 0; i < j; i++) {

          ifstream infile("input.txt");
          while (!infile.eof()) { // while reading the file ...
               infile >> p[i].p_id >> p[i].arrival_time >> p[i].burst_time;
               burst_R[i] = p[i].burst_time;
               i++; // dude. 
          }
          p[i].p_id = i + 1;
     }

     // sort the proccesses
     // bases on arrival time
     sort(p, p + j, compareX);

     // FIFO QUEUE
     queue<int> q;
     int current_time = 0;
     q.push(0);
     int completed = 0;
     int mark[100];
     memset(mark, 0, sizeof(mark));
     mark[0] = 1;

     // push first first process from the 
     // sorted list into the queue ***
     while (completed != j) {
          idx = q.front();
          q.pop();

          // check if the process is in the queue or not
          if (burst_R[idx] == p[idx].burst_time) {
               p[idx].start_time = max(current_time, p[idx].arrival_time);
               total_idle += p[idx].start_time - current_time;
               current_time = p[idx].start_time;
          }

          // if proccess is getting cpu for 
          // first time, record start time as
          // current_time
          if (burst_R[idx] - time_quantum > 0) {
               burst_R[idx] -= time_quantum;
               current_time += time_quantum;
          }

          // if the burst time of the proccess
          // becomes 0, calculate TAT,WT,RT,CT
          else {
               current_time += burst_R[idx];
               burst_R[idx] = 0;
               completed++;

               p[idx].end_time = current_time;
               p[idx].turnaround_time = p[idx].end_time - p[idx].arrival_time;
               p[idx].waiting_time = p[idx].turnaround_time - p[idx].burst_time;
               p[idx].response_time = p[idx].start_time - p[idx].arrival_time;

               total_tat += p[idx].turnaround_time;
               total_wt += p[idx].waiting_time;
               total_rt += p[idx].response_time;
          }

          for (int i = 1; i < j; i++) {
               // if some processes have arrived when this process was executing, insert
               // them into the queue
               if (burst_R[i] > 0 && p[i].arrival_time <= current_time && mark[i] == 0) {
                    q.push(i);
                    mark[i] = 1;
               }
          }
          // if the current proccess
          // has burst time remaining
          // push the process into queue
          if (burst_R[idx] > 0) {
               q.push(idx);
          }

          // if the queue is empty, pick the
          // first process from the list that
          // is not completed
          if (q.empty()) {
               for (int i = 1; i < j; i++) {
                    if (burst_R[i] > 0) {
                         q.push(i);
                         mark[i] = 1;
                         break;
                    }
               }
          }


     }

     avg_tat = (float)total_tat / j;
     avg_wt = (float)total_wt / j;
     avg_rt = (float)total_rt / j;
     cpu_efficiency = ((p[j - 1].end_time - total_idle) / (float)p[j - 1].end_time) * 100;

     sort(p, p + j, compareY);

     /*
               OUTPUT !~ fun part hehe
               layout plan :
               1. title
               2. total time, avg wt, cpu efficiency
               3. Process 1:
                  Service time =
                  Turnaround time =
                  Process 2: ... etc
          */

     cout << endl; // cute title UwU <3
     cout << ":::::::::  :::::::::  " << endl;
     cout << ":+:    :+: :+:    :+: " << endl;
     cout << "+:+    +:+ +:+    +:+ " << endl;
     cout << "+#++:++#:  +#++:++#:  " << endl;
     cout << "+#+    +#+ +#+    +#+ " << endl;
     cout << "#+#    #+# #+#    #+# " << endl;
     cout << "###    ### ###    ### " << endl << endl << endl;

     cout << "Total Time required is " << total_tat << " time units" << endl;
     cout << "Average turn around time is " << avg_tat << " time units" << endl;
     cout << "Average waiting time is " << avg_wt << " time units" << endl;
     cout << "CPU Efficiency is " << cpu_efficiency << "%" << endl << endl;

     for (int i = 0; i < j; i++) {
          cout << "Process " << p[i].p_id << ":\n";
          cout << "Service time = " << p[i].burst_time << endl;
          cout << "Turnaround time = " << p[i].turnaround_time << endl;
     }

     // SAVING DATA TO 
     // CSV FILE *****
     /*
     ofstream toCSV;
     string filename;
     filename += "data100.csv";
     cout << filename << endl;
     toCSV.open(filename);
     toCSV << "Process ID, Service Time, Turn Around Time" << endl;
     for (int i = 0; i < j; i++) {
         toCSV << p[i].p_id << ","
               << p[i].burst_time << ","
               << p[i].turnaround_time << endl;
     }
     toCSV.close();
     */
 }
