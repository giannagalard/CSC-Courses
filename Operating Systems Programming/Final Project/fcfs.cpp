/*
						   _     _     _     _     _     _     _     _
						  (c).-.(c)   (c).-.(c)   (c).-.(c)   (c).-.(c)
						   / ._. \     / ._. \     / ._. \     / ._. \
						 __\( Y )/__ __\( Y )/__ __\( Y )/__ __\( Y )/__
						(_.-/'-'\-._|_.-/'-'\-._|_.-/'-'\-._|_.-/'-'\-._)
						   || F ||     || C ||     || F ||     || S ||
						 _.' `-' '._ _.' `-' '._ _.' `-' '._ _.' `-' '._
						(.-./`-'\.-.|.-./`-'\.-.|.-./`-'\.-.|.-./`-`\.-.)
						 `-'     `-' `-'     `-' `-'     `-' `-'     `-'
	   					                   ...............
							     	   |~ Formulas: ~|
								   |RT = ST - AT |
								   |TAT = CT - AT|
								   |WT = TAT - BT|
								   '''''''''''''''
*/

#include <algorithm>
#include <fstream>
#include <iostream>

using namespace std;

struct process {
	int p_id; //process id
	int start_time, end_time, //measure time spent
		arrival_time, burst_time, response_time,
		turnaround_time, waiting_time;
};

// compares the arrival time between the processes
bool compareArrivalTime(process p1, process p2)
	{return p1.arrival_time < p2.arrival_time;}

// compares the ID between the processes
bool compareProcessID(process p1, process p2)
	{return p1.p_id < p2.p_id;}

// main function
int main() {

	struct process p[50]; // 50 processes
	int x;
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
	cin >> x; // prompt user for input

	for (int i = 0; i < x; i++) {
		ifstream infile("input.txt");
		while (!infile.eof()) { // while reading the file ...
			infile >> p[i].p_id >> p[i].arrival_time >> p[i].burst_time;
			i++; // dude. 
		}
		p[i].p_id = i + 1; 
	}
		sort(p, p + x, compareArrivalTime);

		// calculating with formulas 
		for (int i = 0; i < x; i++) { 
			p[i].start_time = (i == 0) ? p[i].arrival_time : max(p[i - 1].end_time, p[i].arrival_time);
			p[i].end_time = p[i].start_time + p[i].burst_time;
			p[i].turnaround_time = p[i].end_time - p[i].arrival_time; 
			p[i].waiting_time = p[i].turnaround_time - p[i].burst_time;
			p[i].response_time = p[i].start_time - p[i].arrival_time;

			total_tat += p[i].turnaround_time;
			total_wt += p[i].waiting_time;
			total_rt += p[i].response_time;
			total_idle += (i == 0) ? (p[i].arrival_time) : (p[i].start_time - p[i - 1].end_time);
		}

		// calculating the average c: !
		avg_tat = (float)total_tat / x;
		avg_wt = (float)total_wt / x;
		avg_rt = (float)total_rt / x;


		cpu_efficiency = ((p[x].end_time - total_idle) / p[x].end_time) * 100 ;

		sort(p, p + x, compareProcessID);

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
		cout << ":::::::::: ::::::::  :::::::::: ::::::::  " << endl;
		cout << ":+:       :+:    :+: :+:       :+:    :+: " << endl;
		cout << "+:+       +:+        +:+       +:+        " << endl;
		cout << ":#::+::#  +#+        :#::+::#  +#++:++#++ " << endl;
		cout << "+#+       +#+        +#+              +#+ " << endl;
		cout << "#+#       #+#    #+# #+#       #+#    #+# " << endl;
		cout << "###        ########  ###        ########  " << endl << endl << endl;

		cout << "Total Time required is " << total_tat << " time units" << endl;
		cout << "Average turn around time is " << avg_tat << " time units" << endl;
		cout << "Average waiting time is " << avg_wt << " time units" << endl;
		cout << "CPU Efficiency is " << cpu_efficiency << "%" << endl << endl;

		// this loop prints the output
		for (int i = 0; i < x; i++) {
			cout << "Process " << p[i].p_id << ":\n";
			cout << "Service time = " << p[i].burst_time << endl;
			cout << "Turnaround time = " << p[i].turnaround_time << endl;
		}
	}
