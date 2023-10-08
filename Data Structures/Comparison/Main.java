package Comparison;
import java.util.Comparator;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) 
	{
		int ID1, ID2, r1, r2;
		String Name1, Name2;													// Variables are declared.
		
		Student s1 = new Student();												// First object of class Student is created.
		Student s2 = new Student();												// Second object of class Student is created.
		Student r = new Student();												// Third object of class Student is created.
		Scanner sc = new Scanner(System.in);									// Object of class Scanner is created.
		
		System.out.println("Enter the first student name: ");			
		s1.setName(sc.next());													// First student name is assigned to Name of class Student using setter.
		Name1 = s1.getName();													// First student name is assigned to Name1 of class Main using getter.
		
		System.out.println("Enter the first student ID: ");				
		s1.setID(sc.nextInt());													// First student ID is assigned to ID of class Student using setter.
		ID1 = s1.getID();														// First student ID is assigned to ID1 of class Main using getter.
		
		System.out.println("Enter the second student name: ");			
		s2.setName(sc.next());													// Second student name is assigned to Name of class Student using setter.
		Name2 = s2.getName();													// Second student name is assigned to Name2 of class Main using getter.
		
		System.out.println("Enter the second student ID: ");			
		s2.setID(sc.nextInt());													// Second student ID is assigned to ID of class Student using setter.	
		ID2 = s2.getID();														// Second student ID is assigned to ID2 of class Main using getter.
				
		Comparator<Student> c = new Comparator<Student>()						// Object of comparator is created and defined.
		{
			public int compare(Student s1, Student s2)							// compare is used to compare data in two objects.
			{
				if(Integer.compare(ID1,ID2)==0)									// If both IDs are same, then return 0, else return 1.
					return 0;
				else
					return 1;
			}
		};
		
		r1 = s1.compareTo(s2);													// r1 stores the returned value of compareTo.
		r2 = c.compare(s1, s2);													// r2 stores the returned value of compare.
		
		if(r1 == 0 && r2 == 0)													// r1 represents comparison of names.
			r.Result = "Students' name is same, ID is same.";					// r2 represents comparison of IDs.
		else if(r1 == 0 && r2 == 1)												// If r1 is 0, that means the names are same.
			r.Result = "Students' name is same, ID is different.";				// If r1 is 1, that means the names are different.
		else if(r1 == 1 && r2 == 0)												// If r2 is 0, that means the IDs are same.
			r.Result = "Students' name is different, ID is same.";				// If r2 is 1, that means the IDs are different.
		else if(r1 == 1 && r2 == 1)
			r.Result = "Students' name is different, ID is different.";			// The corresponding message is assigned to Result of class Student based on the value of r1 and r2.
		
		System.out.println(r.toString());										// String from class Student is fetched using toString and displayed.
	}
}
