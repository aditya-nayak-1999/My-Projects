package Employee Stack;
import java.util.Scanner;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;

public class Employee 
{
	String EmpStack[] = new String[30];
    int TopLoc = -1;
    public static void main(String args[]) 
    {	
		Scanner sc = new Scanner(System.in); 				// Scanner object is created.
		System.out.println("Enter the location of emp.txt file: "); 								
		String location = sc.nextLine();					// Location of emp.txt is scanned.
		String EmpLine = "";
		String EmpElement[];
		String Name;
		String ID;
		String StackElement;
		Employee emp = new Employee();	
		try
		{
			BufferedReader buff = new BufferedReader(new FileReader(location));
			while((EmpLine = buff.readLine())!=null) 
			{
				EmpElement = EmpLine.split(" ");
				Name = EmpElement[0];
				ID = EmpElement[1];
				StackElement = Name + " " + ID;
				try 
				{
					emp.push(StackElement);					// push method is called.
				} 
				catch (Exception e) 
				{
					e.printStackTrace();
				}								
			}
			System.out.println("\nemp.txt file contains: ");
			emp.display();
			try 
			{
				String TopElement = emp.top(); 				// top method is called.
				System.out.println("\nTop element of the stack is " + TopElement);
				emp.pop(); 
				emp.pop(); 									// pop method is called twice.	
				TopElement=emp.top(); 						// top method is called again.
				System.out.println("Top element of the stack after popping twice is " +TopElement);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
		} 
		catch (FileNotFoundException e) 
		{
			e.printStackTrace();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}													// try catch block is used to display the type of exception.
    }
    public  void push(String StackElement)
    {
    	if (IsFull())
    		throw new StackOverflowError("Array is full. Hence can't push any element.");
    	else 
    	{
    		TopLoc++;
    		EmpStack[TopLoc]= StackElement;	
    	}		
    } 														// push method is used to add all employee records into the array.
    public void display()
    {
    	for(int i=0;i<30;i++) 
    	{
    		System.out.println(EmpStack[i]);
    	}
    }														// display method is used to display all the array elements.
    public String top() 
    {
    	String TopStack=null;
    	if (IsEmpty())
    		throw new StackOverflowError("Array is empty. Hence no top element.");
    	else
    		TopStack=EmpStack[TopLoc];
    	return TopStack;	
    }														// top method is used to return top element of the stack.
    public void pop()
    {
    	if (IsEmpty())
    		throw new StackOverflowError("Array is empty. Hence can't pop any element.");
    	else
    	{
    		EmpStack[TopLoc] = null;
    		TopLoc--;
    	}
    }														// pop method is used to remove top element from the stack.
    public boolean IsEmpty()
    { 
    	return (TopLoc == -1); 																		
    }														// IsEmpty method returns true if the stack is empty, else returns false.
    public boolean IsFull()
    { 
    	return (TopLoc == (EmpStack.length - 1));
    }														// IsFull method returns true if the stack is full, else returns false.
}
			