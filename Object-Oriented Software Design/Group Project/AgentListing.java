package realty;

import java.awt.*;
import java.awt.event.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import javax.swing.*;

public class AgentListing extends JFrame implements ActionListener {

	/**
	 * 
	 */
	//private static final long serialVersionUID = 1L;
	JPanel panel, buttonPanel, errorPanel, successPanel;
	JLabel firstName, lastName, successMsg;
	JTextField firstText, lastText;
	JButton submitButton;
	
	public AgentListing() { //create UI
		
		firstName = new JLabel();
		firstName.setText("     First Name:");
		firstText = new JTextField();
		
		lastName = new JLabel();
		lastName.setText("     Last Name:"); 
		lastText = new JTextField();
		
		successMsg = new JLabel();
		successMsg.setText("     Listing added successfully!");
		
		submitButton = new JButton("Submit");
		submitButton.addActionListener(this);
		
		panel = new JPanel(new GridLayout(2, 1));
		panel.add(firstName); 
		panel.add(firstText); 
		panel.add(lastName); 
		panel.add(lastText); 
		
		buttonPanel = new JPanel(new GridLayout(1,1));
		buttonPanel.add(submitButton);
		
		
		setTitle("Add a real estate agent");
		add(panel, BorderLayout.CENTER);
		add(buttonPanel, BorderLayout.PAGE_END);
		setSize(400, 160); // setting the size of the window
		setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

	}
	
	public static void main(String[] args) {
		new AgentListing();
 	}
	
	public void actionPerformed(ActionEvent ae) {

		String id = getLastID();
		String firstName = firstText.getText();
		String lastName = lastText.getText();

		
		//make sure that all fields are filled 
		if(firstName.isEmpty() || lastName.isEmpty()) {
			
			//show error message if fields are empty
			errorPanel = new JPanel();
			JOptionPane.showMessageDialog(errorPanel, "Please fill out all the fields!", "Error", JOptionPane.ERROR_MESSAGE);
		}
		else {
			try {
				//send the input from text fields into the file.csv file
				BufferedWriter csvOutput = new BufferedWriter(new FileWriter("src\\realty\\agent.csv", true), ',');
				csvOutput.write(id+","+firstName+","+lastName);
				csvOutput.close();
				
				//show success message if the listing was added successfully
				successPanel = new JPanel();
				JOptionPane.showMessageDialog(successPanel, "Agent #"+id+ " was added successfully!", "Success", JOptionPane.INFORMATION_MESSAGE);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}

	private String getLastID() { //get an id for the new listing
		
		int lineCount = 0;
	      try (BufferedReader reader = new BufferedReader(new FileReader("src\\realty\\agent.csv"))) {
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