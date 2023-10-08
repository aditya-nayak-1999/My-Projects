package Employee Queue;
public class Employee 
{
	String Name;
	String ID;
	public Employee(String Name, String ID) 
	{
		this.Name=Name;
		this.ID=ID;
	}
	public String getEmpName() 
	{
		return Name;
	}
	public void setEmpName(String Name) 
	{
		this.Name = Name;
	}
	public String getEmpID() 
	{
		return ID;
	}
	public void setEmpID(String ID) 
	{
		this.ID = ID;
	}
	public String toString()
	{
		return "Name: "+Name+", ID: "+ID ;  				// Overriding the toString() method. 
	} 	
}
