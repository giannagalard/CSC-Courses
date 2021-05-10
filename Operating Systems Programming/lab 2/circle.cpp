#include <iostream>
#include "circle.h"

using namespace std;

int main() 
{
        double users_radius;
        Circle *first_circle;
        first_circle = new Circle();

        cout << "This program computes various metrics of a circle" << endl;
        cout << "Please enter the radius of the circle:";
        cin >> users_radius;

        first_circle->set_rad(users_radius);

        cout << "Area of circle is: " << first_circle->compute_area()<<endl;
        cout << "The circumference of the circle is: " << first_circle->compute_circumference()<<endl;
        return 0;
}
