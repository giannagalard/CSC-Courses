package edu.cuny.csi.csc330.lab4;

public class Radio extends ElectronicDevice {
    private final static int MAX_VOLUME = 10;
    private final static int MINIMAL_VOLUME = 0;

    private double station;
    private int volume;

    public Radio(String deviceName, boolean isTurnedOn, boolean isInternetRequired, boolean isConnectedToInternet,
            double station, int volume) {
        super(deviceName, isTurnedOn, isInternetRequired, isConnectedToInternet);
        this.station = station;
        setVolume(volume);
    }

    public void setStation(double station) {
        this.station = station;
    }

    public double getStation() {
        return station;
    }

    public void setVolume(int newVolume) {
        if (newVolume < MINIMAL_VOLUME) {
            this.volume = MINIMAL_VOLUME;
        } else if (newVolume > MAX_VOLUME) {
            this.volume = MAX_VOLUME;
        } else {
            this.volume = newVolume;
        }
    }
        public int getVolume() {
        return this.volume;
    }

    @Override
    public String toString() {
        String val = "Radio: " + getDeviceName() + "\nCurrently playing " + getStation() + ".\nThis device is ";
        if (isTurnedOn()) {
            val += "turned on. \nThe radio is now playing " + getStation();
            val += "\nThis radio is "
                    + (isConnectedToInternet() ? "connected to the internet." : "not connected to the internet.");
        } else {
            val += "turned off.";
        }
        val += "\nThe volume is at " + (double) getVolume() / MAX_VOLUME * 100 + "%";
        return val;
    }

    @Override
    protected void turnedOnAction() {
        System.out.println("FROM OVERRIDING FUNCTION: The radio has been turned on.");
    }

    @Override
    protected void turnedOffAction() {
        System.out.println("FROM OVERRIDING FUNCTION: The radio has been turned off");
    }

    public static void main(String[] args) {
        Radio radio = new Radio("SONY", true, false, false, 100.3, 4);
        System.out.println(radio);
        System.out.println();

        radio.turnOff();
        radio.turnOn();
        System.out.println(radio);
        radio.setStation(97.1);
        System.out.println(radio.getStation() + " is the new station");
        System.out.println();

        Radio radio2 = new Radio("PANASONIC", false, true, false, 98.5, 1);
        System.out.println(radio2);
        radio2.turnOn();
    }
}
abstract class ElectronicDevice {
    private String deviceName; // What's the devices name?
    private boolean isTurnedOn; // On or off?
    private boolean isInternetRequired; // Does this device need internet?
    private boolean isConnectedToInternet; // Is the device connected to the internet?

    public ElectronicDevice(String deviceName, boolean isTurnedOn, boolean isInternetRequired,
            boolean isConnectedToInternet) {
        this.deviceName = deviceName;
        this.isTurnedOn = isTurnedOn;
        this.isInternetRequired = isInternetRequired;
        this.isConnectedToInternet = isConnectedToInternet;
        if (isTurnedOn())
            turnedOnAction();
    }

    public void turnOn() {
        if (this.isTurnedOn)
            return;
        this.isTurnedOn = true;
        turnedOnAction();
    }

    public void turnOff() {
        if (!this.isTurnedOn)
            return;
        this.isTurnedOn = false;
        turnedOffAction();
    }

    public boolean isTurnedOn() {
        return isTurnedOn;
    }

    public boolean isInternetRequired() {
        return isInternetRequired;
    }
       public boolean isConnectedToInternet() {
        return isConnectedToInternet;
    }

    public String getDeviceName() {
        return deviceName;
    }

    protected abstract void turnedOnAction();

    protected abstract void turnedOffAction();

}
    
