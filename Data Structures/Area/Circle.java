package Area;
public class Circle 
{
		float radius;								
		float area;									// Variables are declared.
		
		public float getRadius() 					
		{
			return radius; 							// Getter is used to return value of radius to class Main.
		}
		public void setRadius(float radius) 
		{
			this.radius = radius; 					// Setter is used to assign value of radius from class Main.
		}
		
		@Override
		public String toString() 
		{					
			return "Area of a circle is: " + area; 	// toString method is used to return string message to class Main.
		}
}
