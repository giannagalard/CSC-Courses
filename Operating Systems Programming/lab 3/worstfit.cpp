#include <bits/stdc++.h>

using namespace std;

void worstFit(int blockSize[], int m, int processSize[], int n)
{
    int alloc[n];

    for (int i = 0; i < n; i++)
    {
        int ws = -1;
        for (int j = 0; j < m; j++)
        {
            if (blockSize[j] >= processSize[i])
            {
                if (ws == -1)
                    ws = j;
                else if (blockSize[ws] < blockSize[j])
                    ws = j;
            }
        }
        
        if (ws != -1)
        {
            alloc[i] = ws;
            blockSize[ws] -= processSize[i];
        }
    }

    cout << "\nProcess No.\tProcess Size\tBlock no.\n";
    for (int i = 0; i < n; i++)
    {
        cout << " " << i + 1 << "\t\t" << processSize[i] << "\t\t";
        if (alloc[i] != -1)
            cout << alloc[i] + 1;
        else
            cout << "Not Allocated";
        cout << endl;
    }
}

int main()
{
    int m, n;
    cout << "Enter no. of memory partitions: ";
    cin >> m;
    cout << "\nEnter the number of processes: ";
    cin >> n;

    int blockSize[m];
    int processSize[n];
    cout << "\nEnter size of each mermory partition: \n";
    for (int i = 1; i <= m; i++)
    {
        cout << "Partition no." << i << ": ";
        cin >> blockSize[i];
    }

    cout << "\nEnter the size of each process: \n";
    for (int i = 1; i <= n; i++)
    {
        cout << "Process number " << i << ": ";
        cin >> processSize[i];
    }

    worstFit(blockSize, m, processSize, n);

    return 0;
}
