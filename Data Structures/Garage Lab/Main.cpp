
#include <iostream>
#include "GarageClass.h"
#include <fstream>

using namespace std;

int main()
{
    ifstream infile; // rename infile
    ofstream outfile;
    Cars car;
    GarageClass StackGarage;

    char input;

    infile.open("Lanes.txt");
    // check for error
    if (infile.fail())
    {
        cout << "ERROR opening text file" << endl;
        exit(1);
    }

    while (!infile.eof())
    {
        infile >> input >> car.plate;

        switch (input)
        {
        case 'A':
            StackGarage.AddCar(car);
            break;
        case 'D':
            StackGarage.DepartingCar(car);
            break;
        }
    }
    infile.close();
    system("pause");
}
