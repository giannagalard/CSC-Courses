package realty;

import java.awt.*;
import java.awt.event.*;
import java.util.List;

import javax.swing.*;

public class SearchAgent extends JFrame{

	JPanel panel;
	JLabel firstName, lastName, text;
	JButton firstNameButton, lastNameButton;
	JTextField firstNameText, lastNameText;
	
	public SearchAgent() {	
		firstName = new JLabel();
		firstName.setText("     First Name:"); // (must be 5 spaces )
		firstNameText = new JTextField();
		lastName = new JLabel();
		lastName.setText("     Last Name:"); // (must be 5 spaces )
		lastNameText = new JTextField();

		firstNameButton = new JButton("Search");
		lastNameButton = new JButton("Search");

		panel = new JPanel(new GridLayout(2, 1));
		panel.add(firstName);
		panel.add(firstNameText);
		panel.add(firstNameButton);
		panel.add(lastName);
		panel.add(lastNameText);
		panel.add(lastNameButton);
		text = new JLabel();
		
		ClickListener click = new ClickListener();	
		firstNameButton.addActionListener(click);
		lastNameButton.addActionListener(click);

		setTitle("Search for agents:");
		setSize(300, 100); // setting the size of the window
		setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		add(panel, BorderLayout.CENTER);
	}
	
	public class ClickListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			String firstName = firstNameText.getText();
			String lastName = lastNameText.getText();
			
			if(e.getSource() == firstNameButton) {
				List<AgentData> listOfAgents = AccessibleAgentDataAPI.findAgentDataByFirstName(firstName);
				int i = 1;
				String values = "";
				for(AgentData agent: listOfAgents) {
					values += "Agent " + i + ": " + agent.getFirstName() + " " + agent.getLastName() + "\n";
					i++;
				}
				if (values == "") {
					JOptionPane.showMessageDialog(null, "Not Found!");
				}
				else {
					JOptionPane.showMessageDialog(null, values);
				}
			}
			else if(e.getSource() == lastNameButton) {
				List<AgentData> listOfAgents = AccessibleAgentDataAPI.findAgentDataByLastName(lastName);
				int i = 1;
				String values = "";
				for(AgentData agent: listOfAgents) {
					values += "Agent " + i + ": " + agent.getFirstName() + " " + agent.getLastName() + "\n";
					i++;
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
		new SearchAgent();
 	}
	
}

