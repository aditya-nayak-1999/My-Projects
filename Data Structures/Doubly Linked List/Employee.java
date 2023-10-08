package Doubly Linked List;
public class Employee implements Comparable<Employee>
{
	private String Name;
	private int ID;
 
	public Employee(String Name, int ID) 
	{
		setName(Name);
		setID(ID);
	}

	public String getName() 
	{
		return Name;
	}
	public void setName(String empName) 
	{
		Name = empName;
	}
	public int getID() 
	{
		return ID;
	}
	public void setID(int empID) 
	{
		ID = empID;
	}
	
	public String toString()										// Overriding the toString() method.
	{
		return "Employee Name = " + Name + ", ID = " + ID + "\n";  			
	} 

	public int compareTo(Employee leastIDEmp) 
	{
		if (this.ID > leastIDEmp.ID)
			return 1;
		else 
			if (this.ID < leastIDEmp.ID)
				return -1;
			else
				return 0;
	} 
}
