package Palindrome;
public class Employee implements Comparable<Employee>
{
	String Name;
	int ID;
	 
	public Employee(String Name, int ID) 
	{
		setName(Name);
		setID(ID);
	}
	
	public String getEmpName() 
	{
		return Name;
	}
	
	public void setName(String Name) 
	{
		this.Name = Name;
	}
	
	public int getEmpID() 
	{
		return ID;
	}
	
	public void setID(int ID) 
	{
		this.ID = ID;
	}
	
	public String toString()
	{
		return Name+" "+ ID;  
	} 
	
	public int compareTo(Employee minIDEmp) 
	{
		if (this.ID > minIDEmp.ID)
			return 1;
		else if (this.ID < minIDEmp.ID)
			return -1;
		else
			return 0;
	} 	
}
