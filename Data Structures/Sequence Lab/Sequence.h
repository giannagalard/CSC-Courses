
#ifndef SEQUENCE_H
#define SEQUENCE_H
#include<iostream>
using namespace std;
template<class value_type>
class sequence
{
public:
   sequence();
   sequence(int size);
   ~sequence();
   bool full()const;
   bool empty()const;
   int num_element()const;
   int max_capacity()const;
   value_type at(int position)const;
   void set(const value_type& entry, int position);
   void insert(const value_type& entry, int position);
   void push_back(const value_type& entry);
   void remove_current(int postion);
   void print()const;
private:
   value_type * data;
   int num_used;
   int capacity;
   void double_size();
};
#endif // !SEQUENCE_h

template<class value_type>
sequence <value_type>::sequence()
{
   capacity = 10;
   data = new value_type[capacity];
   num_used = 0;
}

template<class value_type>
sequence <value_type>::sequence(int size)
{
   capacity = size;
   data = new value_type[capacity];
   num_used = 0;
}

template<class value_type>
bool sequence <value_type>::full()const
{
   return num_used == capacity;
}

template<class value_type>
bool sequence <value_type>::empty()const
{
   return num_used == 0;
}
template<class value_type>
int sequence <value_type>::num_element()const
{
   return num_used;
}
template<class value_type>
int sequence <value_type>::max_capacity()const
{
   return capacity;
}

template<class value_type>
value_type sequence <value_type>::at(int position)const
{
   return data[position];
}
template<class value_type>
void sequence <value_type>::set(const value_type& entry, int position)
{
   if (position >=1 && position <= num_used)
       data[position-1] = entry;
   else
       cout << "Position out of bound!!" << endl;
}
template<class value_type>
void sequence <value_type>::insert(const value_type& entry, int position)
{  
   if (position >= 1 && position <= num_used)
   {
       if (num_used == capacity)
           double_size();
       // if max is reached, its size will double
       for (int i = num_used; i >= position; i--)
           data[i] = data[i - 1];

       
       data[position - 1] = entry;
       num_used++;
   }
   else
       cout << "Out of bounds" << endl;
}
template<class value_type>
void sequence <value_type>::push_back(const value_type& entry)
{
   if (num_used == capacity)
       double_size();
   data[num_used] = entry;
   num_used++;
}
template<class value_type>
void sequence <value_type>::remove_current(int position)
{
   if (position >= 1 && position <= num_used)
   {
       for (int i = position-1; i < num_used; ++i) {
           data[i] = data[i + 1];
       }
       num_used--;
   }
   else
       cout << "Out of bounds" << endl;
}
template<class value_type>
void sequence <value_type>::print()const
{
   int i;
   for (i = 0; i < num_used - 1; i++)
       cout << data[i] << ", ";
   cout << data[i] <<endl;
}
template<class value_type>
void sequence <value_type>::double_size()
{
   value_type *temp = new value_type[capacity * 2];
   capacity *= 2;
   for (int i = 0; i < num_used; i++)
       temp[i] = data[i];
   delete[]data;
   data = temp;
}

template<class value_type>
sequence <value_type>::~sequence()
{
   delete[]data;
}
