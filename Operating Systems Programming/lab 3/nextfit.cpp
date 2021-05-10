#include <iostream>

using namespace std;

int main()
{

    int memorySize[10][2], processSize[10][3];
    int i, j, totalProcess = 0, totalMemory = 0;

    cout << "\nNext Fit:\n";
    cout << "\nEnter the Total Number of Processes: ";
    cin >> totalProcess;
    cout << "\nEnter number of memory partitions: ";
    cin >> totalMemory;

    cout << "\nEnter the Size of Each Process\n";
    for (int i = 0; i < totalProcess; i++)
    {
        cout << "Enter size of process " << i + 1 << ": ";
        cin >> processSize[i][0];
        processSize[i][1] = 0;
        processSize[i][2] = i;
    }
    cout << "\nEnter the Size of Memory Partitions:\n";
    for (i = 0; i < totalProcess; i++)
    {
        cout << "Enter size of memory partition " << i + 1 << ": ";
        cin >> memorySize[i][0];
        memorySize[i][1] = 0;
    }
    for (i = 0; i < totalProcess; i++)
    {
        while (j < totalMemory)
        {
            if (memorySize[j][1] == 0 && processSize[i][0] <= memorySize[j][0])
            {
                processSize[i][1] = 1;
                memorySize[j][1] = 1;
                cout << "\nProcess "
                     << "[" << i + 1 << "]"
                     << " Allocated to Memory Block: " << j + 1;
                break;
            }
            j++;
        }
    }
    for (i = 0; i < totalMemory; i++)
    {
        if (processSize[i][1] == 0)
        {
            cout << "\nProcess "
                 << "[" << i + 1 << "]"
                 << " Unallocated";
        }
    }
    cout << "\n";
    return 0;
}
