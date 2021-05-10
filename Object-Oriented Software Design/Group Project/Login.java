package realty;

import java.awt.*;
import java.io.File;
import java.awt.event.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Scanner;

import javax.swing.*;
import javax.xml.crypto.Data;

public class Login extends JFrame implements ActionListener {
	JPanel panel;
	JLabel username, password, text;
	JTextField usernameText;
	JPasswordField passwordText;
	JButton submit, cancel;
	boolean isLoggedIn = false;

	Login() {
		username = new JLabel();
		username.setText("     Username:"); // (must be 5 spaces )
		usernameText = new JTextField();
		password = new JLabel();
		password.setText("     Password:"); // (must be 5 spaces )
		passwordText = new JPasswordField();
		submit = new JButton("Submit"); // text for submit button
		
		submit.addActionListener(this);

		panel = new JPanel(new GridLayout(3, 1));
		panel.add(username); // user label
		panel.add(usernameText); // user input
		panel.add(password); // pass label
		panel.add(passwordText); // user input
		text = new JLabel();
		panel.add(text); // blank box to put submit button under user input
		panel.add(submit); // submit button
		
		add(panel, BorderLayout.CENTER);
		setTitle("Please Login:");
		setSize(375, 150); // setting the size of the window
		setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
	int newInstance = 1;

	public static void main(String[] args) {
		new Login();
	}

	@Override // this is the login / register ( basically they can either login with admin
				// credentials or make a new account and login instantly lol )
	public void actionPerformed(ActionEvent ae) {
			File db = new File("db.csv");
			try {
				if(!db.exists()) {
					db.createNewFile();
					BufferedWriter csvW1;
					csvW1 = new BufferedWriter(new FileWriter("db.csv", true));
					csvW1.write("admin");
					csvW1.write("password,");
					csvW1.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}

		
		String username = usernameText.getText();
		String password = passwordText.getText();
		BufferedReader csvR;
		
		try {		
			csvR = new BufferedReader(new FileReader("db.csv"));
			String row = "";
			String[] data = {};
			
			while(true){
				//System.out.println(data.length);
				while ((row = csvR.readLine()) != null) {
					//System.out.println(row);
					//System.out.println(Arrays.toString(data));
					data = row.split(",");
				}
				//csvR.close();
				
				//System.out.println(Arrays.toString(data));
				//System.out.println(Arrays.toString(data).contains(password));
				
				if (Arrays.toString(data).contains(username) && Arrays.toString(data).contains(password)) {
				setVisible(false);
				System.out.println("Welcome back " + username + "!");
				new Choice();
				break;
			}
			else {
				setVisible(false);
				System.out.println("Would you like to register? (Y/N) then enter.");
				Scanner sc = new Scanner(System.in);
				String yn = sc.nextLine(); //get yes/no from user
				if(yn.contains("Y")|| yn.contains("y"))
				{
					BufferedWriter csvW = new BufferedWriter(new FileWriter("db.csv",true));

					csvW.write(username);
					csvW.write(password);
					csvW.write(",");
					csvW.flush();
					sc.close();
					csvW.close();
					
				}
				else
				{
					System.out.println("Okay bye then.");
					sc.close();
					return;
				}
				//System.out.println("Welcome back " + usernameText.getText() + "!");
				//System.out.println("WE GOT PAST CHOICE");
			}	
			}

		} catch (FileNotFoundException e) {
			System.out.println("File not found.");
			System.out.println("Would you like to register and create a new file? Y/N");
			String yn = ""; //get yes/no from user
			if(yn == "Y" || yn == "y")
			{
				db = new File("db.csv");
				try {
					db.createNewFile();
				} catch (IOException e2) {
					e.printStackTrace();
				}
				
				FileWriter csvW;
				try {
					csvW = new FileWriter("db.csv");
					Scanner sc = new Scanner(System.in);

					username+=",";
					password+="\n";
					csvW.append(username);
					csvW.append(password);
					csvW.flush();
					sc.close();
					csvW.close();
				} catch (IOException e1) {
					System.out.println("big yike :/");
					e1.printStackTrace();
				}
			}
			
		} catch (Throwable e) {
			System.out.println("File read failed.");
			e.printStackTrace();
		}

	}
}
