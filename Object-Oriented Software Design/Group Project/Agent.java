package realty;

import javax.swing.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;
import java.util.stream.Collectors;


public class Agent {
	
	public static void main(String[] args) {
		int i = 1;
		List<AgentData> listOfAgents = AccessibleAgentDataAPI.findAgentDataByLastName("sussy");
		String values = "";
		for(AgentData agent: listOfAgents) {
			values += "Agent " + i + ": " + agent.getFirstName() + " " + agent.getLastName() + "\n";
			i++;
		}
		JOptionPane.showMessageDialog(null, values);
	}

}

// getters and setters
class AgentData {
	private String id;
	private String firstName;
	private String lastName;

	public AgentData(String id, String firstName, String lastName) {
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
	}

	// getters
	public String getID() {
		return id;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;	
	}

	// setters
	public void setID(String id) {
		this.id = id;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public void setSecondName(String lastName) {
		this.lastName = lastName;
	}
}

class AccessibleAgentDataAPI {	
	public static ArrayList <AgentData> AgentData = new ArrayList<>();
	public static String AGENT_DATA_FILE_PATH = "src\\realty\\agent.csv";
	
	public static List <AgentData> findAgentDataByID(String id) {
		return AccessibleAgentDataAPI.getAgentData().stream()	
				.filter(AgentData -> AgentData.getID().equalsIgnoreCase(id))
				.collect(Collectors.toList());
	}

	public static List <AgentData> findAgentDataByFirstName(String firstName) {
			
		return AccessibleAgentDataAPI.getAgentData().stream()					
				.filter(AgentData -> AgentData.getFirstName().equalsIgnoreCase(firstName))					
				.collect(Collectors.toList());		
	}
	
	public static List <AgentData> findAgentDataByLastName(String lastName) {		
		return AccessibleAgentDataAPI.getAgentData().stream()			
				.filter(AgentData -> AgentData.getLastName().equalsIgnoreCase(lastName))				
				.collect(Collectors.toList());	
	}

	private static ArrayList <AgentData> getAgentData() {	
		String id = " ";		
		String firstName = " ";	
		String lastName = " ";
		ArrayList <AgentData> list = new ArrayList<>();
		try {		
			Scanner x = new Scanner(new File(AccessibleAgentDataAPI.AGENT_DATA_FILE_PATH));			
			String nextLine;		
			while (x.hasNextLine()) {	
				nextLine = x.nextLine();		
				if (nextLine == " ") {	
					break;		
				}			
				StringTokenizer tokenNextLine = new StringTokenizer(nextLine, ",");          	
				id = tokenNextLine.nextToken();    			
				firstName = tokenNextLine.nextToken();   							
				lastName = tokenNextLine.nextToken();					
				list.add(new AgentData(id, firstName, lastName));				
			} 				
			AgentData = list;			
		} 			
		catch (Exception e) {			
			System.out.println("Thats an error");				
			e.printStackTrace();		
			
		}
		return AgentData;		
	}
}
