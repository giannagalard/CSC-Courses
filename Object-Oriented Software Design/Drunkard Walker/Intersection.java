/**
 * Class that represents a Street Corner 
 * Instances of this Class will be used to track the history 
 * and current location of DrunkWalker(s)
 */
package edu.cuny.csi.csc330.lab5;



public class Intersection implements Comparable<Intersection>  {

	private int avenue;
	private int street;


	/*
	* Why do we need this constructor?
	* It's an easy way to copy the class instead of passing to bypass references.
	*/

	public Intersection(Intersection intersection) {
		this.avenue = intersection.getAvenue();
		this.street = intersection.getStreet();
	}

	public Intersection(int avenue, int street) {
		this.avenue = avenue;
		this.street = street;
	}

	public int getAvenue() {
		return avenue;
	}

	public void setAvenue(int avenue) {
		this.avenue = avenue;
	}

	public int getStreet() {
		return street;
	}

	public void setStreet(int street) {
		this.street = street;
	}

	public String getMapKey() {
		return "ave="+getAvenue()+"street="+getStreet();
	}
	/**
	 * toString() method  !!!!!!!!!!!!!!!!!
	 */
	
	@Override
	public String toString() {
		return "[Intersection ave= " + avenue + ", street=" + street + " ]";
	}

	/**
	 * hashCode() and equals() methods 
	 */
	
	@Override
	public int compareTo(Intersection corner) {
		return Integer.compare(this.street, corner.street);
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// Implement a Testing main()   !!!!!!!!!!!!!!!!
		
		// Complete the methods implied through comments above 
		// Then uncomment the test code below, and run. 
		
		/*
		Intersection corner1 = new Intersection(6, 23); 
		Intersection corner2 = new Intersection(7, 41); 
		Intersection corner3 = new Intersection(1, 3); 
		Intersection corner4 = new Intersection(3, 4); 
		Intersection corner5 = new Intersection(7, 34); 
		
		System.out.println("Corner 1: " + corner1); 
		System.out.println("Corner 2: " + corner2); 
		
		if(corner1.equals(corner2 ) == false ) 
				System.out.println("Corners are not equal."); 
		
		
		// Test Sorting ... for lab5 req 
		Set<Intersection> set = new TreeSet<Intersection>(); 
		set.add(corner1);
		set.add(corner2);
		set.add(corner3);
		set.add(corner4);
		set.add(corner5);
		
		System.out.println(set);
		
		System.exit(0);
		 
		 */

	}

}
