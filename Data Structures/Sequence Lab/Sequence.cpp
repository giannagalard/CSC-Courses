/*
This code asks the user to create a sequence of numbers with a max capacity of 10. 
This lab will also ask the student if they would like to remove or replace values.
If user selects a sequence that has more than ten values, the max capacity will double.
*/

#include"Sequence.h"

using namespace std;
int main()
{
    sequence<int> seq;
    int number;
    int placement;
    int amount;
    char userchoice;

    cout << "The current max capacity of the sequence is " << seq.max_capacity() <<endl;
    cout <<"Please enter the amount of numbers you want in the sequence" << endl;
    cin >> amount;
    cout << "Enter numbers for a sequence below, seperate them by a space: " << endl;

    //Enter Numbers in sequence

    for (int i = 0; i < amount; i++) {
       
            cin >> number;
            seq.push_back(number);
    }
    int spacesLeft = seq.max_capacity() - seq.num_element();
    cout << "\nCurrently the sequence is " << endl;
    // Print 
    if (seq.empty() == false) {
        seq.print();
    }
    if (seq.full() == true) {
        
        cout << "\nMax capacity is " << seq.max_capacity() << ". There are "
            << spacesLeft << " spaces left. This sequence is at max capacity" << endl;
    }
    //Statement will output the max cap as well as let you know how many spaces are left
    else if (seq.empty() == true) {

        cout << "\nThe Sequence is empty" << endl;
    }else {
     
        cout << "\nThere are " << spacesLeft << " spaces left" << endl;
    }
    // This will state that the sequence is empty

       
    cout << "\nWould you like to replace a value from the sequence? If so, enter 'y', if not enter 'n'" << endl;
    cin >> userchoice;
    if (userchoice == 'y') {
        cout << "\nPlease enter a number that you would like to replace the value with: ";
        cin >> number;
        cout << "Enter the postion of the number you would like to replace betweeen 1 to " << seq.num_element() << ": ";
        cin >> placement;

        seq.set(number, placement);

        cout << "After setting " << number << " at position " << placement << " sequence is : ";
        seq.print();
    }
    else if (userchoice == 'n') {
        cout << "The sequence remains the same" << endl;
        seq.print();
    }
// this is replace any value by the user with any other value they wish

      cout << "\nWould you like to remove any values from the current sequence? If so, enter 'y', if not enter 'n' " << endl;
    cin >> userchoice;
    if (userchoice == 'y') {
        cout << "\nEnter position of the number that you would like to remove betweeen 1 to " << seq.num_element() << ": ";
        cin >> placement;

        seq.remove_current(placement);
        cout << "After removing the value at position " << placement << ", your new sequence is: ";
        seq.print();

    }
    else if (userchoice == 'n') {
        cout << "The sequence remains the same" << endl;
        seq.print();
    }
// this will remove any value chosen by the user 

    cout << "\nWould you like to insert a new value into the current sequence? If so, enter 'y', if not enter 'n' " << endl;
    if (userchoice == 'y') {
        cin >> userchoice;
        cout << "\nEnter a number that you would like to add into the current sequence: ";
        cin >> number;
        cout << "Enter the postion you would like the number to be placed betweeen 1 to " << seq.num_element() << ": ";
        cin >> placement;

        seq.insert(number, placement);

        cout << "After inserting " << number << " at position " << placement << ", the new sequence is : ";
        seq.print();
    }
    else if (userchoice == 'n'){
        cout << "The sequence remains the same:" << endl;
        seq.print();
    }
    //this will insert a new value into the sequence
}

