/*
This program has two bag objects named storeBag and fragileBag that hold string values to represent grocery items. Fragile items
such as eggs and bread are moved from the storeBag into the fragileBag. In the header file, there is a method named displayBagContents that is
executed in the main function that was added to Bag class.  There is a 2 argument function in main that removes and counts all occurences
from the Bag object. The function returns the number of items removed to the user. 
*/
#include <iostream> // For cout and cin
#include <string>   // For string objects
#include "Bag.h"    // For ADT bag
using namespace std;


// This function removes item from bag and counts the occurences.
int remove(Bag<string>& bag, string item){
	int count = 0;
	while (bag.contains(item))
	{
		bag.remove(item);
		count++;
	}
	return count;
}

// Main function ( do output here ).
int main()
{
	// Groceries
	string store[] = { "Banana", "Apple", "Kiwi" , "Eggs", "Bread", "Eggs" };



	// Creating our bags to hold groceries.
	Bag<string> storeBag;
	Bag<string> fragileBag;

	// Placing all of the groceries in the storeBag.
	storeBag.add(store[0]);
	storeBag.add(store[1]);
	storeBag.add(store[2]);
	storeBag.add(store[3]);
	storeBag.add(store[4]);
	storeBag.add(store[5]);

	int breadCount = remove(storeBag, string("Bread"));
	int eggCount = remove(storeBag, string("Eggs"));

	// Remove fragile items (eggs and bread) from store bag and move them into fragile bag...
	// Points to the memory location where the array starts.
	int y = 0;  // By adding this and using this index for y itll looks like [3,,,,] instead of [,,3,].

	for (int x = 0; x < (sizeof(store) / sizeof(store[0])); x++) {   // x iterates through array by array length.
		if (store[x].compare("Eggs") == 0 || store[x].compare("Bread") == 0)
		{
			fragileBag.add(store[x]);
			storeBag.remove(store[x]);
			y++;
		}
	}

	// displaying the bag contents
	cout << "YOUR BAGS CONTAIN: \n" << "Store bag: \n";
	storeBag.displayBagContents();
	cout << " " << endl;
	cout << "Fragile bag: \n";
	fragileBag.displayBagContents();
	cout << " " << endl;
	cout << "Amount of bread purchased: " << breadCount << endl;
	cout << "Amount of eggs purchased: " << eggCount << endl;

}

