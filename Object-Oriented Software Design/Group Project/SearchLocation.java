package realty;

import java.awt.*;
import java.awt.event.*;
import java.util.List;

import javax.swing.*;

public class SearchLocation extends JFrame{

	JPanel panel;
	JLabel address, city, state, zipcode, text;
	JButton addressButton, cityButton, stateButton, zipcodeButton;
	JTextField addressText, cityText, stateText, zipcodeText;
	
	public SearchLocation() {	
		address = new JLabel();
		address.setText("     Address:"); // (must be 5 spaces )
		addressText = new JTextField();
		city = new JLabel();
		city.setText("     City:"); // (must be 5 spaces )
		cityText = new JTextField();
		state = new JLabel();
		state.setText("     State:"); // (must be 5 spaces )
		stateText = new JTextField();
		zipcode = new JLabel();
		zipcode.setText("     Zipcode:"); // (must be 5 spaces )
		zipcodeText = new JTextField();
		
		addressButton = new JButton("Search");
		cityButton = new JButton("Search");
		stateButton = new JButton("Search");
		zipcodeButton = new JButton("Search");

		panel = new JPanel(new GridLayout(5, 1));
		panel.add(address);
		panel.add(addressText);
		panel.add(addressButton);
		panel.add(city);
		panel.add(cityText);
		panel.add(cityButton);
		panel.add(state);
		panel.add(stateText);
		panel.add(stateButton);
		panel.add(zipcode);
		panel.add(zipcodeText);
		panel.add(zipcodeButton);
		text = new JLabel();
		
		ClickListener click = new ClickListener();
		addressButton.addActionListener(click);
		cityButton.addActionListener(click);
		stateButton.addActionListener(click);
		zipcodeButton.addActionListener(click);

		setTitle("Search for houses:");
		setSize(450, 200); // setting the size of the window
		setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		add(panel, BorderLayout.CENTER);
	}
	
	public class ClickListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			String address = addressText.getText();
			String city = cityText.getText();
			String state = stateText.getText();
			String zipcode = zipcodeText.getText();
			String values = "";
			
			if(e.getSource() == addressButton) {
				List<StateData> listOfStates = AccessibleStateDataAPI.findStateDataByAddress(address);
				for(StateData theState: listOfStates) {
					values += "Address: " + theState.getAddress() + ", " + theState.getCity() + ", " + theState.getState() + ", " + theState.getZipcode() 
					+ "\nHome Value: " + theState.getHomeValue() 
					+ "\nRent Value: " + theState.getRentValue() 
					+ "\nSqft Lot: " + theState.getSqft() 
					+ "\nNearby School: " + theState.getSchool() + "\n\n";
				}
				if (values == "") {
					JOptionPane.showMessageDialog(null, "Not Found!");
				}
				else {
					JOptionPane.showMessageDialog(null, values);
				}
			}
			else if(e.getSource() == cityButton) {
				List<StateData> listOfStates = AccessibleStateDataAPI.findStateDataByCity(city);
				for(StateData theState: listOfStates) {
					values += "Address: " + theState.getAddress() + ", " + theState.getCity() + ", " + theState.getState() + ", " + theState.getZipcode() 
					+ "\nHome Value: " + theState.getHomeValue() 
					+ "\nRent Value: " + theState.getRentValue() 
					+ "\nSqft Lot: " + theState.getSqft() 
					+ "\nNearby School: " + theState.getSchool() + "\n\n";
				}
				if (values == "") {
					JOptionPane.showMessageDialog(null, "Not Found!");
				}
				else {
					JOptionPane.showMessageDialog(null, values);
				}
			}
			else if(e.getSource() == stateButton) {
				List<StateData> listOfStates = AccessibleStateDataAPI.findStateDataByState(state);
				for(StateData theState: listOfStates) {
					values += "Address: " + theState.getAddress() + ", " + theState.getCity() + ", " + theState.getState() + ", " + theState.getZipcode() 
					+ "\nHome Value: " + theState.getHomeValue() 
					+ "\nRent Value: " + theState.getRentValue() 
					+ "\nSqft Lot: " + theState.getSqft() 
					+ "\nNearby School: " + theState.getSchool() + "\n\n";
				}
				if (values == "") {
					JOptionPane.showMessageDialog(null, "Not Found!");
				}
				else {
					JOptionPane.showMessageDialog(null, values);
				}
			}
			else if(e.getSource() == zipcodeButton) {
				List<StateData> listOfStates = AccessibleStateDataAPI.findStateDataByZipcode(zipcode);
				for(StateData theState: listOfStates) {
					values += "Address: " + theState.getAddress() + ", " + theState.getCity() + ", " + theState.getState() + ", " + theState.getZipcode() 
					+ "\nHome Value: " + theState.getHomeValue() 
					+ "\nRent Value: " + theState.getRentValue() 
					+ "\nSqft Lot: " + theState.getSqft() 
					+ "\nNearby School: " + theState.getSchool() + "\n\n";
				}
				if (values == "") {
					JOptionPane.showMessageDialog(null, "Not Found!");
				}
				else {
					JOptionPane.showMessageDialog(null, values);
				}
			}			
		}
	}
	
	public static void main(String[] args) {
		new SearchLocation();
 	}
	
//	List<StateData> listOfStates = AccessibleStateDataAPI.findStateDataByStreet("forest ave");
//	StateData state = listOfStates.get(0);
//	JOptionPane.showMessageDialog(null,
//			"Address: " + state.getStreetNum() + " " + state.getStreet() + ", City: " + state.getCity()
//					+ ", State: " + state.getState() + ", Zipcode: " + state.getZipcode());
}
