package edu.cuny.csi.csc330.lab1;

/**
* Generates a non-leap year perpetual Julian Calendar
* @author lji
*
*/
public class JulianCalendar {
  
// Max number of Days in a month
static private final int MAX_DAY = 31;
  
// abbreviated Month names
static private final String [] MONTH_NAMES = {
"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
};
  
// day length of each month
static private final int [] MONTH_SIZES = {
31, 28, 31,30,31, 30, 31, 31, 30, 31, 30, 31
};

/**
* display The "DAY" Column Heading
*/
static private void displayDayHeading() {
System.out.printf("%5s", "Day");
  
}
  
/**
* display Month names between Day .... Day
*/
static private void displayHeading() {
displayDayHeading();
  
for(int i = 0 ; i < MONTH_NAMES.length ; ++i ) {
System.out.printf("%5s", MONTH_NAMES[i]);
}
  
displayDayHeading();
}
  

static public void display() {
displayHeading(); // display heading
  
//for each of the days
for(int day = 1; day <= MAX_DAY; day++)
{
System.out.printf("\n%5d", day);

//iterate over each of the months
int prevMonthEnd = 0;
for(int month = 0; month < 12; month++)
{
if(day > MONTH_SIZES[month]) //display blank if this day is not applicable for the month
System.out.printf("%5s", " ");
else
System.out.printf(" %03d", prevMonthEnd + day);
prevMonthEnd += MONTH_SIZES[month];
}
System.out.printf("%5d", day);
}

}
  
/**
* @param args
*/
public static void main(String[] args) {
// invoke display method
display();
}
}
