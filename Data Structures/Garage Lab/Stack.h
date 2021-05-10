
#ifndef Stackh
#define Stackh
#include <cstdlib>
#include <iostream>
#include <string>

using namespace std;

struct Cars //Struct class implementation
{
    string plate;
    int moved;
    Cars() { moved = 0; }
};

template <class StackType>
class Stack
{

public:
    Stack(int MaxStackSize = 10);
    ~Stack() { delete[] stack; }
    bool IsEmpty() const { return top == -1; }
    bool IsFull() const { return top == MaxTop; } //checks if stack is full
    StackType Top() const;                        // returns full struct from top
    void push(StackType x);
    void pop();

    bool search(Cars x); //Returns the index of the plate

private:
    int top;          // current top of stack
    int MaxTop;       // max value for top
    StackType *stack; // element array
};

template <class StackType>
Stack<StackType>::Stack(int MaxStackSize)
{
    //Pre: none
    //Post: Array of size MaxStackSize to implement stack
    //Stack constructor
    MaxTop = MaxStackSize - 1;
    stack = new StackType[MaxStackSize];
    top = -1;
}

template <class StackType>
StackType Stack<StackType>::Top() const
{
    //Pre: stack is not empty
    //Post: Returns top element
    if (IsEmpty())
        throw logic_error("Top fails: Stack is empty"); // Top Fails
    return stack[top];
}
template <class StackType>
void Stack<StackType>::push(StackType x)
{
    //Pre: Stack is not full
    //Post: Push x to stack
    // Stack has one more element
    if (IsFull())
        throw logic_error("Push fails: full stack"); // Push Fails
    stack[++top] = x;
}
template <class StackType>
void Stack<StackType>::pop()
{
    //Pre: Stack is not empty
    //Post: Stack has one less element
    if (IsEmpty())
    {
        throw logic_error("Pop fails: Stack is empty");
        exit(1);
    }; //pop fails
    top--;
}

//Pre: Accepts a string
//Post: Returns the index if string is located

template <class StackType> //looks to see if the stack is full
bool Stack<StackType>::search(Cars x)
{
    if (top != -1)
        for (int i = 0; i <= top; i++)
        {
            if (stack[i].plate == x.plate)
                return true;
        }
    return false;
}
#endif
