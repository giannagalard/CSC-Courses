package edu.cuny.csi.csc330.lab5;

import java.util.Scanner;

public class DrunkWalkTester {
	
	private Scanner input;

	public DrunkWalkTester() {
		init();  
	}
	
	private void init() {
		input = new Scanner(System.in);
	}
	
	public void runTest(int steps ) { 
		
		
		System.out.print("Enter the starting avenue value: ");
		int avenue = input.nextInt();
		System.out.print("Enter the starting street value: ");
		int street = input.nextInt();
		
		//////////////////////// start test 
		// make the Drunkard with initial position
		DrunkWalker billy = new DrunkWalker(avenue,street);

		// have him move/step 200 time 
		billy.fastForward(steps);
		
		// get his current location
		String location = billy.getLocation();
		
		// get distance from start
		int distance = billy.howFar();

		System.out.println("Billy's " + location);
		System.out.println("That's " + distance + " blocks from start.");
		
		billy.displayWalkDetails();
		
		//////////////////// end test 
		/*
		 * Expand the test above to include the following ... 
		 * Create a 2nd instances of DrunkWalker - Harvey  
		 * Have then race each - which instance (billy or harvey)  
		 * manages to walk a greater distance with 200 steps?  
		 * 
		 * Also invoke the displayWalkDetails() on both instances.
 		 */
		DrunkWalker erlichBachman = new DrunkWalker(avenue,street);
		DrunkWalker richardHendricks = new DrunkWalker(avenue,street);

		erlichBachman.fastForward(200);
		richardHendricks.fastForward(200);

		System.out.println("Erlich Bachman: Below");
		System.out.println(erlichBachman.getLocation());
		erlichBachman.displayWalkDetails();
		System.out.println("Richard Hendricks Below");
		System.out.println(richardHendricks.getLocation());
		richardHendricks.displayWalkDetails();

		if (erlichBachman.howFar() > richardHendricks.howFar()) {
			System.out.println("Erlich Bachman is the winner with " + erlichBachman.howFar() + "steps");
		} else if (richardHendricks.howFar() > erlichBachman.howFar()) {
			System.out.println("Richard Hendricks is the winner with " + richardHendricks.howFar() + "steps");
		} else {
			System.out.println("They tied");
		}

	}

	/**
	 * @param args 
	 * 
	 */
	public static void main(String[] args) {
		DrunkWalkTester tester = new DrunkWalkTester();
		
		int steps = 2000; 
		if(args.length == 1) {
			steps = Integer.parseInt(args[0]);
		}
		
		tester.runTest(steps); 
		
		System.exit(0);

	}

}
