#include <iostream>

using namespace std;

int main()
{
    int bsize[10], psize[10], nb, np, flags[10], allocation[10], i, j;

    for (i = 0; i < 10; i++)
    {
        flags[i] = 0;
        allocation[i] = -1;
    }

    cout << "\nFirst Fit:\n";
    cout << "Enter number of memory partitions: ";
    cin >> nb;
    cout << "\nEnter number of processes: ";
    cin >> np;

    cout << "\nEnter size of memory partitions: \n";
    for (i = 0; i < nb; i++)
        cin >> bsize[i];

    cout << "\nEnter size of each process: \n";
    for (i = 0; i < np; i++)
        cin >> psize[i];

    for (i = 0; i < np; i++)
        for (j = 0; j < nb; j++)
            if (flags[j] == 0 && bsize[j] >= psize[i])
            {
                allocation[j] = i;
                flags[j] = 1;
                break;
            }

    cout << "\nBlock no.\t\tsize\t\tprocess no.\t\tsize";
    for (i = 0; i < nb; i++)
    {
        cout << "\n"
             << i + 1 << "\t\t\t" << bsize[i] << "\t\t\t";
        if (flags[i] == 1)
            cout << allocation[i] + 1 << "\t\t\t" << psize[allocation[i]];
        else
            cout << "not allocated";
    }
    return 0;
}
