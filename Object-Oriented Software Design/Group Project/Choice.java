package realty;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class Choice extends JFrame{

	JPanel panel;
	JLabel location, agent, locationListing, agentListing, text;
	JButton locationButton, agentButton, listLocationButton, listAgentButton;

	public Choice() {
		location = new JLabel();
		location.setText("     Locations:"); // (must be 5 spaces )
		agent = new JLabel();
		agent.setText("     Agents:"); // (must be 5 spaces )
		locationListing = new JLabel();
		locationListing.setText("     Add Property:"); // (must be 5 spaces )
		agentListing = new JLabel();
		agentListing.setText("     Register As Agent:"); // (must be 5 spaces )
		locationButton = new JButton("Choose");
		agentButton = new JButton("Choose");
		listLocationButton = new JButton("Choose");
		listAgentButton = new JButton("Choose");
		panel = new JPanel(new GridLayout(4, 1));
		panel.add(location); // location label
		panel.add(locationButton); // location button
		panel.add(agent); // agent label
		panel.add(agentButton); // agent button
		panel.add(locationListing); // listing label
		panel.add(listLocationButton); // listing button
		panel.add(agentListing); // listing label
		panel.add(listAgentButton); // listing button

		ClickListener click = new ClickListener();
		
		locationButton.addActionListener(click);
		agentButton.addActionListener(click);
		listLocationButton.addActionListener(click);
		listAgentButton.addActionListener(click);
		
		setTitle("What would you like to search for?");
		setSize(375, 200); // setting the size of the window
		setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		add(panel, BorderLayout.CENTER);
	}
	
	private class ClickListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			if(e.getSource() == locationButton) {
				setVisible(false);
				new SearchLocation();
			}
			else if(e.getSource() == agentButton) {
				setVisible(false);
				new SearchAgent();
			}
			else if(e.getSource() == listLocationButton) {
				setVisible(false);
				new LocationListing();
			}
			else {
				setVisible(false);
				new AgentListing();
		}
	}
	}
	public static void main(String[] args) {
		new Choice();
 	}
	}
