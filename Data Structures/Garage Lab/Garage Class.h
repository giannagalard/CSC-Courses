
#ifndef Garageh
#define Garageh

#include "Stack.h"

class GarageClass
{
public:
    void AddCar(Cars car);
    void DepartingCar(Cars car);
    void EmptyStreet(string x);

private:
    Stack<Cars> Lane1;
    Stack<Cars> Lane2;
    Stack<Cars> Street;
};
#endif

//AddCar implementation
void GarageClass::AddCar(Cars car)
{
    cout << "A car has arrived !!" << endl;
    cout << "Its License Plate is: " << car.plate << endl
         << endl;

    if (!Lane1.IsFull())
    {
        Lane1.push(car);
    }
    else if (!Lane2.IsFull())
    {
        Lane2.push(car);
    }
    else
    {
        cout << "Sorry! Both lanes are full" << endl;
    }
}

// DepartingCar implementation

void GarageClass::DepartingCar(Cars car)
{
    Cars temp;
    cout << "Searching for car with license plate: " << car.plate << endl;

    // Search in Lane 1
    if (Lane1.search(car) == true)
    {
        temp = Lane1.Top();
        while (temp.plate != car.plate)
        {
            if (Lane2.IsFull() != 1)
            {
                temp.moved++;
                Lane2.push(temp);
            }
            else
            {
                temp.moved++;
                Street.push(temp);
            }
            Lane1.pop();
            temp = Lane1.Top();
        }
        cout << "The car with license plate" << temp.plate << " has departed."
             << "\nIt has been moved" << temp.moved << " times" << endl
             << endl;
        Lane1.pop();
    }

    // Search in Lane 2

    else if (Lane2.search(car) == true)
    {
        temp = Lane2.Top();
        while (temp.plate != car.plate)
        {
            if (Lane1.IsFull() != 1)
            {
                temp.moved++;
                Lane1.push(temp);
            }
            else
            {
                temp.moved++;
                Street.push(temp);
            }
            Lane2.pop();
            temp = Lane2.Top();
        }

        cout << "The car with license plate" << temp.plate << "has departed" << endl;
        cout << " It has been moved" << temp.moved << "times" << endl
             << endl;
        Lane2.pop();
        EmptyStreet("Lane2");
    }
    else
        cout << "The car with license plate" << car.plate << " is not here" << endl
             << endl;
}

// Empty Street implementation

void GarageClass::EmptyStreet(string x)
{
    Cars temp;

    if (x == "Lane1")
    {
        while (Street.IsEmpty() != 1)
        {
            temp = Street.Top();
            temp.moved++;
            Lane1.push(temp);
            Street.pop();
        }
    }

    else if (x == "Lane2")
    {
        while (Street.IsEmpty() != 1)
        {
            temp = Street.Top();
            temp.moved++;
            Lane2.push(Street.Top());
            Street.pop();
        }
    }
}
