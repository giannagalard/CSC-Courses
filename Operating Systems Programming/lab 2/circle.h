#include <math.h>
#include <iostream>
#ifndef CIRCLE_H
#define CIRCLE_H

using namespace std;

class Circle
{

      private:
              double radius;
              double *area;
              double *circumference;
              const double pi = 3.1415;
      public:
              Circle(){radius = 0;area = new double; *area = 0; circumference = new double;}
              void set_rad(double rad) {radius = rad;};
              double compute_area()
              {*area = (pi*pow(radius, 2.0)); return *area;};
              double compute_circumference()
              {*circumference = 2 * pi * radius; return *circumference;}
              ~Circle();
};
#endif
