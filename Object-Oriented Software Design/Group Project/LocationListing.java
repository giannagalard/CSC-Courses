package realty;

import java.awt.*;
import java.awt.event.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import javax.swing.*;

public class LocationListing extends JFrame implements ActionListener {

	JPanel panel, buttonPanel, errorPanel, successPanel;
	JLabel address, city, state, zipcode, houseValue, rentValue, sqft, schools, successMsg;
	JTextField addressText, cityText, stateText, zipcodeText, houseValueText, rentValueText, sqftText, schoolsText;
	JButton submitButton;
	
	public LocationListing() { //create UI
		
		address = new JLabel();
		address.setText("     Address:");
		addressText = new JTextField();
		
		city = new JLabel();
		city.setText("     City:"); 
		cityText = new JTextField();
		
		state = new JLabel();
		state.setText("     State:"); 
		stateText = new JTextField();
		
		zipcode = new JLabel();
		zipcode.setText("     Zipcode:");
		zipcodeText = new JTextField();
		
		houseValue = new JLabel();
		houseValue.setText("     House Value:");
		houseValueText = new JTextField();
		
		rentValue = new JLabel();
		rentValue.setText("     Rent Value:");
		rentValueText = new JTextField();
		
		sqft = new JLabel();
		sqft.setText("     Sqft:"); 
		sqftText = new JTextField();
		
		schools = new JLabel();
		schools.setText("     Schools Nearby:"); 
		schoolsText = new JTextField();
		
		successMsg = new JLabel();
		successMsg.setText("     Listing added successfully!");
		
		submitButton = new JButton("Submit");
		submitButton.addActionListener(this);
		
		panel = new JPanel(new GridLayout(8, 1));
		panel.add(address); 
		panel.add(addressText); 
		panel.add(city); 
		panel.add(cityText); 
		panel.add(state); 
		panel.add(stateText); 
		panel.add(zipcode); 
		panel.add(zipcodeText); 
		panel.add(houseValue); 
		panel.add(houseValueText); 
		panel.add(rentValue); 
		panel.add(rentValueText); 
		panel.add(sqft); 
		panel.add(sqftText); 
		panel.add(schools); 
		panel.add(schoolsText);
		
		buttonPanel = new JPanel(new GridLayout(1,1));
		buttonPanel.add(submitButton);
		
		
		setTitle("Create Your Listing");
		add(panel, BorderLayout.CENTER);
		add(buttonPanel, BorderLayout.PAGE_END);
		setSize(400, 300); // setting the size of the window
		setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

	}
	
	public static void main(String[] args) {
		new LocationListing();
 	}
	
	public void actionPerformed(ActionEvent ae) {

		String id = getLastID();
		String address = addressText.getText();
		String city = cityText.getText();
		String state = stateText.getText();
		String zipcode = zipcodeText.getText();
		String houseValue = houseValueText.getText();
		String rentValue = rentValueText.getText();
		String sqft = sqftText.getText();
		String schools = schoolsText.getText();
		
		//make sure that all fields are filled 
		if(address.isEmpty() || city.isEmpty() || state.isEmpty() || zipcode.isEmpty() || houseValue.isEmpty() || rentValue.isEmpty()|| sqft.isEmpty() || schools.isEmpty()) {
			
			//show error message if fields are empty
			errorPanel = new JPanel();
			JOptionPane.showMessageDialog(errorPanel, "Please fill out all the fields!", "Error", JOptionPane.ERROR_MESSAGE);
		}
		else {
			try {
				//send the input from text fields into the file.csv file
				BufferedWriter csvOutput = new BufferedWriter(new FileWriter("src\\realty\\file.csv", true), ',');
				csvOutput.write(id+","+address+","+city+","+state+","+zipcode+","+houseValue+","+rentValue+","+sqft+","+schools);
				csvOutput.close();
				
				//show success message if the listing was added successfully
				successPanel = new JPanel();
				JOptionPane.showMessageDialog(successPanel, "Listing #"+id+ " was added successfully!", "Success", JOptionPane.INFORMATION_MESSAGE);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}

	private String getLastID() { //get an id for the new listing
		
		int lineCount = 0;
	      try (BufferedReader reader = new BufferedReader(new FileReader("src\\realty\\file.csv"))) {
	          //while there are lines to read, update the counter
	    	  while (reader.readLine() != null) {
	        	  lineCount++;
	          }
	      } catch (IOException e) {
	          e.printStackTrace();
	      }
	      
		return String.valueOf(lineCount);
	}	
}
