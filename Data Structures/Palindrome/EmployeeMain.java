package Palindrome;
import java.awt.im.InputContext;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.security.DigestInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class EmployeeMain 
{
	public static void main(String args[]) 
	{
		Scanner sc = new Scanner(System.in);							// Scanner object created.
		System.out.println("Enter the location of emp.txt file:"); 		// Location of emp.txt file is provided. 
		String filepath = sc.nextLine();
		String empLine = "";
		String empElement[];
				
		List<Employee> employeeList =  new ArrayList<Employee>();
				
		try
		{
			BufferedReader buff = new BufferedReader(new FileReader(filepath));
			while((empLine = buff.readLine())!=null) 
			{
				empElement=empLine.split(" ");
				String empName = empElement[0];
				int empID = Integer.parseInt(empElement[1]);  
				employeeList.add(new Employee(empName,empID));
			}
		} 
		catch (IOException e) 
		{
			e.printStackTrace();										// TODO Auto-generated catch block
		}
				
		SelectionSort(employeeList);
		String listString = employeeList.toString();
		listString = listString.replace("[","").replace("]","").replace(", ","\n");
		System.out.println("\nEmployee Details sorted in ascending order of their ID:\n" +listString);
			
		System.out.println("\nEnter Employee ID to search:");
		int EmpID = sc.nextInt();
			
		int Exist = BinarySearch(employeeList, EmpID);
			 
		if (Exist==-1)
			System.out.println("\nEmployee with that ID does not exist.");
		else
			System.out.println("\nEmployee ID: "+EmpID+"\nEmployee Name: "+employeeList.get(Exist).getEmpName());
	}

	private static void SelectionSort(List<Employee> listEmployee) 
	{
		int minIndex = 0; 
		Employee minIDEmp = null;
		                     
		for(int i=1;i<listEmployee.size();i++)
		{
		    minIDEmp = listEmployee.get(i-1);
		    minIndex = i-1;
		            
		    for(int j=i;j<listEmployee.size();j++)
		    {
		    	if (listEmployee.get(j).compareTo(minIDEmp) < 0)
		    	{
		    		minIDEmp = listEmployee.get(j);
		            minIndex = j;
		        }
		    }
		        
		    Employee temp = listEmployee.get(minIndex);						// First element of the unsorted subarray is swapped with the smallest element.
		    listEmployee.set(minIndex, listEmployee.get(i-1));
		    listEmployee.set(i-1, temp);          
		}
	}
		
	private static int  BinarySearch(List<Employee> listEmployee, int  empID) 
	{
		int first = 0;
		int last= listEmployee.size() - 1;
		int check;
			    
		while (first <= last)
		{ 
			int midpoint = (first + last) / 2; 
			check = listEmployee.get(midpoint).getEmpID();
			            
			if (check == empID)
			    return midpoint;           	             
			else 
				if (check < empID)
					first = midpoint + 1; 
			    else
			    	last = midpoint - 1; 
		}
		return -1; 
	}
}
