package Comparison;

public class Student implements Comparable<Student>
{
		int ID;
		String Name;
		String Result;							// Variables are declared.
		
		public int getID() {					
			return ID;							// Integer value of ID is returned to class Main using getter.
		}
		public void setID(int iD) {
			ID = iD;							// Integer value from class Main is assigned to ID using setter.
		}
		public String getName() {
			return Name;						// String value of Name is returned to class Main using getter.
		}
		public void setName(String name) {
			Name = name;						// String value from class Main is assigned to Name using setter.
		}
		
		@Override
		public int compareTo(Student s2) 		// compareTo is used to compare local data with data of specified object.
		{
			if(((this.Name).toLowerCase()).compareTo((s2.Name).toLowerCase())==0)
				return 0;						
			else
				return 1;						// If both names are same, then return 0, else return 1.
		}

		@Override
		public String toString() {
			return "Result: " + Result;			// String message is returned to class Main using toString.
		}			
}