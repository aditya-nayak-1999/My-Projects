package Area;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) 
	{
		final float pi = 3.142f; 								// Constant is defined.
		float radius;											// Variable is declared.
		
		Circle obj = new Circle();                          	// Object of class Circle is created.
		Scanner sc = new Scanner(System.in);               		// Object of class Scanner is created.
		
		System.out.println("Enter the radius of a circle:");	
		obj.setRadius(sc.nextFloat());                          // Setter is called to assign scanned value to radius of class Circle.
		radius = obj.getRadius();								// Getter is called to obtain value of radius from class Circle.
		
		obj.area = pi*radius*radius;							// Calculated value of area is assigned to area of class Circle.
				
		System.out.println(obj.toString());     				// toString method is called to fetch string message from class Circle.
	}
}
