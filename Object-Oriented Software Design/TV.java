package edu.cuny.csi.csc330.lab4;

public class TV {

	int serialNumber = 94793284;
	boolean isOn;
	int currentChannel = 0;
	int[] avaiableChannels = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 };
	int currentVolume = 7;

	public void turnOff() {
		this.isOn = false;
		System.out.println("\n\nTV powered off");
		System.out.println(toString());
	}

	public void turnON() {
		this.isOn = true;
		System.out.println("\n\nTV powered on");
		System.out.println(toString());
	}

	public void changeChannel(int channelNumber) {
		if (channelNumber >= avaiableChannels.length) {
			System.out.println("Invalid channel");
			return;
		}
		this.currentChannel = avaiableChannels[channelNumber];
		System.out.println("\n\nChannel changed to " + channelNumber);
		System.out.println(toString());
	}

	public void printCurrentChannel() {
		System.out.println("\n\nCurrent channel is " + this.currentChannel);
	}

	public void increaseVolume() {
		this.currentVolume++;
		System.out.println("\n\nVolume incresed ");
		System.out.println(toString());
	}

	public void decreseVolume() {
		this.currentVolume--;
		System.out.println("\n\nVolume decresed ");
		System.out.println(toString());
	}

	private String printChannels() {
		String channels = "";
		for (int cha : avaiableChannels)
			channels += (cha + ", ");
		return channels;
	}

	// returns all the variables as a string
	public String toString() {
		String state = "Serial Number = " + serialNumber + ", Power state = " + isOn + "\nCurrent channel = "
				+ currentChannel + ", Current volume = " + currentVolume + "\nAvailable Channels = [" + printChannels()
				+ "";
		return "\nTV Instance :-[ " + state + " ]";

	}

	public static void main(String[] args) {

		TV myTV = new TV();
		System.out.println("New Instance of TV");
		System.out.println(myTV.toString());

		myTV.turnON();

		myTV.changeChannel(7);

		myTV.increaseVolume();
		myTV.decreseVolume();

		myTV.printCurrentChannel();

		myTV.turnOff();
	}
}
