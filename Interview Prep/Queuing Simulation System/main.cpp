#include <iostream>
#include <cstdlib>
#include <iomanip>
#include <cmath>
 
#include "Simulation.h"
#include "queueAsArray.h" 
 
using namespace std;

void setSimulationParameters(int& sTime, int& numOfServers,
							 int& transTime,
							 int& tBetweenCArrival);
bool isCustomerArrived(double arvTimeDiff);

void generateStatistics(serverListType& serverList, 
						waitingCustomerQueueType& CQueue, 
						int numOfCustArrived,
						int waitTimeServedCustomers);
void runSimulation();

int main()
{
    runSimulation();

    return 0;
}

void setSimulationParameters(int& sTime, int& numOfServers,
                             int& transTime,
                             int& tBetweenCArrival)
{
    cout << "Enter the simulation time: ";
    cin >> sTime;
    cout << endl;

    cout << "Enter the number of servers: ";
    cin >> numOfServers;
    cout << endl;

    cout << "Enter the transaction time: ";
    cin >> transTime;
    cout << endl;

    cout << "Enter the time between customer arrivals: ";
    cin >> tBetweenCArrival;
    cout << endl;
}

bool isCustomerArrived(double arvTimeDiff)
{
    double value;
    
    value = static_cast<double> (rand()) / static_cast<double>(RAND_MAX);

    return (value > exp(- 1.0/arvTimeDiff));
}

void runSimulation()
{
    int simulationTime;
    int numberOfServers;
    int transactionTime;
    int timeBetweenCustomerArrival; //These 4 variables get input data via setSimulationParameters();

    waitingCustomerQueueType customerQueue;

    customerType customer;

    int custNumber = 0;
	
    int totalWaitTimeServedCustomers = 0;
    int clock = 0;
    int serverID;

    setSimulationParameters(simulationTime, numberOfServers,
                            transactionTime, timeBetweenCustomerArrival);

    serverListType serverList(numberOfServers);

/* ============================================================================*/
    for (clock = 1; clock <= simulationTime; clock++)
  {
    serverList.updateServers(cout);
    if (!customerQueue.isEmptyQueue())
      customerQueue.updateWaitingQueue();
    if (isCustomerArrived(timeBetweenCustomerArrival))
    {
      custNumber++;
      customer.setCustomerInfo(custNumber, clock, 0,
                   transactionTime);
      customerQueue.addQueue(customer);
      cout << "Customer number " << custNumber
         << " arrived at time unit " << clock << endl;
    }
        
    serverID = serverList.getFreeServerID();
    if (serverID != -1 && !customerQueue.isEmptyQueue())
    {
      customer = customerQueue.front();
      customerQueue.deleteQueue();
      totalWaitTimeServedCustomers = totalWaitTimeServedCustomers
                      + customer.getWaitingTime();
      serverList.setServerBusy(serverID, customer);
    }
  }
/* ============================================================================*/

    cout << endl;

    cout << "The simulation ran for " << simulationTime
         << " time units" << endl;
    cout << "Number of servers: " << numberOfServers << endl;
    cout << "Average transaction time: "
         << transactionTime << endl;
    cout << "Average arrival time difference between customers: "
         << timeBetweenCustomerArrival << endl;

    generateStatistics(serverList, customerQueue, 
                        custNumber, totalWaitTimeServedCustomers); //generate and output statistics
}

void generateStatistics(serverListType& serverList, 
            waitingCustomerQueueType& CQueue, 
            int numOfCustArrived,
            int waitTimeServedCustomers)
{
  int customersLeftInQueue = 0;
  int totalWaitTime = waitTimeServedCustomers;
  customerType customer;
  while (!CQueue.isEmptyQueue())
  {
    customer = CQueue.front();
    CQueue.deleteQueue();
    totalWaitTime = totalWaitTime + customer.getWaitingTime();
    customersLeftInQueue++;
  }
      //Find number of customers left in servers
  int customersLeftInServers = serverList.getNumberOfBusyServers();
      //Find number of customers completely served
  int numberOfCustomersServed = numOfCustArrived - customersLeftInServers -
                  customersLeftInQueue;
  double averageWaitTime = 0;
  cout << "Total waiting time: " << totalWaitTime << endl;
  cout << "Number of customers that completed a transaction: "
     << numberOfCustomersServed << endl;
  cout << "Number of customers left in the servers: "
     << customersLeftInServers << endl;
  cout << "The number of customers left in queue: " << customersLeftInQueue
   << endl;
        
  if (numOfCustArrived > 0) // If number of customers arrived is > 0
    averageWaitTime = (static_cast<double>(totalWaitTime)) / numOfCustArrived;
  cout << fixed << showpoint;
  cout << setprecision(2);
  cout << "Average waiting time: " << averageWaitTime << endl;
  cout << "************** END SIMULATION *************" << endl;
}