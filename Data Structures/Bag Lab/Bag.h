#include <cstddef>

#ifndef _BAG
#define _BAG

#include <iostream>
using namespace std;

template <class ItemType>
class Bag 
{
private:
	static const int DEFAULT_BAG_SIZE = 6;  
	ItemType items[DEFAULT_BAG_SIZE]; // array of bag items
   int itemCount;                    // current count of bag items 
   int maxItems;                     // max capacity of the bag
   
   // Returns either the index of the element in the array items that
   // contains the given target or -1, if the array does not contain 
   // the target.
     int getIndexOf(const ItemType& target) const;

public:
	Bag();
	int getCurrentSize() const;
	bool isEmpty() const;
	bool add(const ItemType& newEntry);
	bool remove(const ItemType& anEntry);
	void clear();
	bool contains(const ItemType& anEntry) const;
	int getFrequencyOf(const ItemType& anEntry) const;
	void displayBagContents(); // Doesn't have to return anything, just printing when we do the method displayed by contents.
	
	};  // end Bag
/*template <class ItemType>
void Bag<ItemType>::displayBagContents(class Bag)
{
	for (x = 0; x < (sizeof(Bag) / sizeof(Bag[0])); x++)
	{

	}
}
*/

template<class ItemType>
Bag<ItemType>::Bag() : itemCount(0), maxItems(DEFAULT_BAG_SIZE)
{
}  // end default constructor

// ******
// Displays the bag contents ............... ( called in main ).
template<class ItemType>
void Bag<ItemType>::displayBagContents() {
	for (int x = 0; x < itemCount; x++)
	{
		cout << items[x] << endl;
	}
}

template<class ItemType>
int Bag<ItemType>::getCurrentSize() const
{
	return itemCount;
}  // end getCurrentSize

template<class ItemType>
bool Bag<ItemType>::isEmpty() const
{
	return itemCount == 0;
}  // end isEmpty

template<class ItemType>
bool Bag<ItemType>::add(const ItemType& newEntry)
{
	bool hasRoomToAdd = (itemCount < maxItems);
	if (hasRoomToAdd)
	{
		items[itemCount] = newEntry;
		itemCount++;
	}  // end if
    
	return hasRoomToAdd;
}  // end add

template<class ItemType>
bool Bag<ItemType>::remove(const ItemType& anEntry)
{
   int locatedIndex = getIndexOf(anEntry);
	bool canRemoveItem = !isEmpty() && (locatedIndex > -1);
	if (canRemoveItem)
	{
		itemCount--;
		items[locatedIndex] = items[itemCount];
	}  // end if
    
	return canRemoveItem;
}  // end remove

template<class ItemType>
void Bag<ItemType>::clear()
{
	itemCount = 0;
}  // end clear

template<class ItemType>
int Bag<ItemType>::getFrequencyOf(const ItemType& anEntry) const
{
   int frequency = 0;
   int searchIndex = 0;
   while (searchIndex < itemCount)
   {
      if (items[searchIndex] == anEntry)
      {
         frequency++;
      }  // end if
      
      searchIndex++;
   }  // end while
   
   return frequency;
}  // end getFrequencyOf

template<class ItemType>
bool Bag<ItemType>::contains(const ItemType& anEntry) const
{
	return getIndexOf(anEntry) > -1;
}  // end contains


// private
template<class ItemType>
int Bag<ItemType>::getIndexOf(const ItemType& target) const
{
	bool found = false;
   int result = -1;
   int searchIndex = 0;
   // if the bag is empty, itemCount is zero, so loop is skipped
   while (!found && (searchIndex < itemCount))
   {
      if (items[searchIndex] == target)
      {
         found = true;
         result = searchIndex;
      } 
      else
      {
         searchIndex++;
      }  // end if
   }  // end while
   
   return result;
}  // end getIndexOf


#endif
