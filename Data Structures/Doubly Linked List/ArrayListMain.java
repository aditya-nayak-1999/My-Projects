package Doubly Linked List;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

public class ArrayListMain 
{
	public static void main(String[] args)  
	{
		CS401ArrayImpl <Employee> employeeList = new CS401ArrayImpl <Employee>();
		
		Scanner sc = new Scanner(System.in);								// Scanner object is created.
		System.out.println("Enter the location of emp.txt file:"); 			// User enters the location of emp.txt file.
		String location = sc.nextLine();									
		String empLine = "";
		String empElement[];
		
		try 
		{
			BufferedReader br = new BufferedReader(new FileReader(location));
			while((empLine = br.readLine())!=null) 
			{
				empElement = empLine.split(" ");
				String empName = empElement[0];
				int empID = Integer.parseInt(empElement[1]);  
				employeeList.add(new Employee(empName, empID));
			}
		} 
		catch (IOException e) 
		{
			e.printStackTrace();											// TODO Auto-generated catch block.
		}
		
		System.out.println(employeeList);
		System.out.println("ArrayListSize is " + employeeList.getSize() + ".");		
	}
}
