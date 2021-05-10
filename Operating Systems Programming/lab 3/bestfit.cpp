#include <iostream>
using namespace std;

int main()
{
    int fragment[20], b[20], p[20], i, j, nb, np, temp, lowest = 9999;
    static int arrayX[20], arrayY[20];
    cout << "\nBest Fit:\n";
    cout << "Enter number of memory partitions: ";
    cin >> nb;
    cout << "\nEnter number of processes: ";
    cin >> np;

    cout << "\nEnter size of each mermory partition: \n";
    for (i = 1; i <= nb; i++)
    {
        cout << "Partition number " << i << ": ";
        cin >> b[i];
    }

    cout << "\nEnter size of each process :\n";
    for (i = 1; i <= np; i++)
    {
        cout << "Process number " << i << ": ";
        cin >> p[i];
    }

    for (i = 1; i <= np; i++)
    {
        for (j = 1; j <= nb; j++)
        {
            if (arrayX[j] != 1)
            {
                temp = b[j] - p[i];
                if (temp >= 0)
                    if (lowest > temp)
                    {
                        arrayY[i] = j;
                        lowest = temp;
                    }
            }
        }

        fragment[i] = lowest;
        arrayX[arrayY[i]] = 1;
        lowest = 10000;
    }

    cout << "\nProcess_no\tProcess_size\tBlock_no\tBlock_size\tFragment";
    for (i = 1; i <= np && arrayY[i] != 0; i++)
        cout << "\n"
             << i << "\t\t\t" << p[i] << "\t\t\t" << arrayY[i] << "\t\t\t" << b[arrayY[i]] << "\t\t\t" << fragment[i];

    return 0;
}
