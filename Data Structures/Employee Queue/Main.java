package Employee Queue;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

public class Main 
{
	public static void main(String args[]) 
	{
		Scanner sc = new Scanner(System.in);										// Scanner object is created.
		System.out.println("Enter the location of emp.txt file: ");  
		String filepath = sc.nextLine();											// Location of emp.txt file is scanned.
		String EmpLine = "";
		String EmpElement[];
			
		FixedQueue<Employee> emp1 = new FixedQueue<Employee>(5);
		FloatingQueue<Employee> emp2 = new FloatingQueue<Employee>(5);
		int index = 0;
		
		try 
		{
			BufferedReader buff = new BufferedReader(new FileReader(filepath));
			while((EmpLine = buff.readLine())!=null && index < 5) 
			{
				EmpElement = EmpLine.split(" ");	
				emp1.enqueue(new Employee(EmpElement[0],EmpElement[1]));			// Calling Enqueue method for Fixed front operation.
				emp2.enqueue(new Employee(EmpElement[0],EmpElement[1]));			// Calling Enqueue method for Floating front operation.
				index++;
			}
		} 
		catch (IOException e) 
		{
			e.printStackTrace();													// TODO Auto-generated catch block
		}
			
		System.out.println("Fixed Front Operation");								// Start of Fixed front operation output.
		System.out.println("Elements stored in queue:");							// Printing the elements stored in queue.
		emp1.print();
		emp1.dequeue();															
		emp1.dequeue();																// Calling Dequeue method twice.
		System.out.println("\nElements in queue after dequeuing twice:");
		emp1.print();																// End of Fixed front operation output.
		
		System.out.println("\nFloating Front Operation");							// Start of Floating front operation output
		System.out.println("Elements stored in queue:");							// Printing the elements stored in queue.
		emp2.print();
		emp2.dequeue();														
		emp2.dequeue();																// Calling Dequeue method twice.
		System.out.println("\nElements in queue after dequeuing twice:");
		emp2.print();																// End of Floating front operation output
	}
}
