package realty;

import javax.swing.*;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;
import java.util.stream.Collectors;

public class Location {

	public static void main(String[] args) {
//		List<StateData> listOfStates = AccessibleStateDataAPI.findStateDataByID("1");
		List<StateData> listOfStates = AccessibleStateDataAPI.findStateDataByZipcode("10314");
		String values = "";
		for(StateData state: listOfStates) {
			values += "Address: " + state.getAddress() + " " + ", City: " + state.getCity()
			+ ", State: " + state.getState() + ", Zipcode: " + state.getZipcode() + ", Money Value: " + state.getHomeValue() + "\n";
		}
		JOptionPane.showMessageDialog(null, values);
	}
}

// This is a model class nothing important here just your typical getters and setters.
class StateData {
	private String id;
	private String address;
	private String city;
	private String state;
	private String zipcode;
	private String homeValue;
	private String rentValue;
	private String sqft;
	private String school;

	public StateData(String id, String address, String city, String state, String zipcode, String homeValue, String rentValue, String sqft, String school) {
		this.id = id;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zipcode = zipcode;
		this.homeValue = homeValue;
		this.rentValue = rentValue;
		this.sqft = sqft;
		this.school = school;
	}

	// Getters
	public String getID() {
		return id;
	}

	public String getAddress() {
		return address;
	}

	public String getCity() {
		return city;
	}

	public String getState() {
		return state;
	}

	public String getZipcode() {
		return zipcode;
	}
	
	public String getHomeValue() {
		return homeValue;
	}
	
	public String getRentValue() {
		return rentValue;
	}
	
	public String getSqft() {
		return sqft;
	}
	
	public String getSchool() {
		return school;
	}

	// Setters
	public void setID(String id) {
		this.id = id;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public void setState(String state) {
		this.state = state;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	
	public void setHomeValue(String homeValue) {
		this.homeValue = homeValue;
	}
	
	public void setRentValue(String rentValue) {
		this.rentValue = rentValue;
	}
	
	public void setAcres(String sqft) {
		this.sqft = sqft;
	}
	
	public void setSchool(String school) {
		this.school = school;
	}
}
// line 104 - 107 search through whatever parameters u want
class AccessibleStateDataAPI {
	public static ArrayList<StateData> STATE_DATA = new ArrayList<>();
	public static String STATE_DATA_FILE_PATH = "src\\realty\\file.csv";

	public static List<StateData> findStateDataByID(String id) {
		return AccessibleStateDataAPI.getStateData().stream()
				.filter(stateData -> stateData.getID().equalsIgnoreCase(id)).collect(Collectors.toList());
	}

	public static List<StateData> findStateDataByAddress(String address) {
		return AccessibleStateDataAPI.getStateData().stream()
				.filter(stateData -> stateData.getAddress().equalsIgnoreCase(address)).collect(Collectors.toList());
	}

	public static List<StateData> findStateDataByCity(String city) {
		return AccessibleStateDataAPI.getStateData().stream()
				.filter(stateData -> stateData.getCity().equalsIgnoreCase(city)).collect(Collectors.toList());
	}

	public static List<StateData> findStateDataByState(String state) {
		return AccessibleStateDataAPI.getStateData().stream()
				.filter(stateData -> stateData.getState().equalsIgnoreCase(state)).collect(Collectors.toList());
	}

	public static List<StateData> findStateDataByZipcode(String zipcode) {
		return AccessibleStateDataAPI.getStateData().stream()
				.filter(stateData -> stateData.getZipcode().equalsIgnoreCase(zipcode)).collect(Collectors.toList());
	}
	
	public static List<StateData> findStateDataByMoneyValue(String moneyValue) {
		return AccessibleStateDataAPI.getStateData().stream()
				.filter(stateData -> stateData.getHomeValue().equalsIgnoreCase(moneyValue)).collect(Collectors.toList());
	}
	
	public static List<StateData> findStateDataByRentValue(String rentValue) {
		return AccessibleStateDataAPI.getStateData().stream()
				.filter(stateData -> stateData.getRentValue().equalsIgnoreCase(rentValue)).collect(Collectors.toList());
	}
	
	public static List<StateData> findStateDataByAcres(String sqft) {
		return AccessibleStateDataAPI.getStateData().stream()
				.filter(stateData -> stateData.getSqft().equalsIgnoreCase(sqft)).collect(Collectors.toList());
	}
	
	public static List<StateData> findStateDataBySchool(String school) {
		return AccessibleStateDataAPI.getStateData().stream()
				.filter(stateData -> stateData.getSchool().equalsIgnoreCase(school)).collect(Collectors.toList());
	}

	
	private static ArrayList<StateData> getStateData() {
		String id = " ";
		String address = " ";
		String city = " ";
		String state = " ";
		String zipcode = " ";
		String homeValue = " ";
		String rentValue = " ";
		String sqft = " ";
		String school = " ";

		ArrayList<StateData> list = new ArrayList<>();
		try {
			Scanner x = new Scanner(new File(AccessibleStateDataAPI.STATE_DATA_FILE_PATH));
			String nextLine;
			while (x.hasNextLine()) {
				nextLine = x.nextLine();
				if (nextLine == "") {
					break;
				}
				StringTokenizer tokenNextLine = new StringTokenizer(nextLine, ",");
				id = tokenNextLine.nextToken();
				address = tokenNextLine.nextToken();
				city = tokenNextLine.nextToken();
				state = tokenNextLine.nextToken();
				zipcode = tokenNextLine.nextToken();
				homeValue = tokenNextLine.nextToken();
				rentValue = tokenNextLine.nextToken();
				sqft = tokenNextLine.nextToken();
				school = tokenNextLine.nextToken();

				list.add(new StateData(id, address, city, state, zipcode, homeValue, rentValue, sqft, school));
			}
			STATE_DATA = list;
		} 
		catch (Exception e) {
			System.out.println("That's an error");
			e.printStackTrace();
		}

		return STATE_DATA;
	}
}
