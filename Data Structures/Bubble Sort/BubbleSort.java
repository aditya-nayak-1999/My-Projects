package Bubble Sort;
import java.util.Scanner;								// Scanner file is imported.

public class BubbleSort 								// BubbleSort class is created.
{
	public static void main (String args[]) 			// Main method is defined inside the class.
	{
		double time1, time2, totaltime;					// Variables are declared inside main method.
		
		time1 = System.nanoTime();						// time1 stores the value of start time in nano seconds.
		BubbleSortMethod();								// Bubble sort method is called.
		time2 = System.nanoTime();						// time2 stores the value of end time in nano seconds.
		totaltime = time2 - time1;						// totaltime represents execution time of bubble sort method in nano seconds.

		System.out.println("Execution time for bubble sort method is " +totaltime+ " nano seconds."); // Execution time for bubble sort method is displayed.
	}
	
	public static void BubbleSortMethod() 				// Bubble sort method is defined.
	{	
		int size, temp;									
		double t1, t2, t;								// Variables are declared inside Bubble sort method.
		
		Scanner sc = new Scanner(System.in);			// Object of class Scanner is created.
		
		System.out.println("Enter the size of array:");
		size = sc.nextInt();							// Scanned value is assigned to the variable "size".
		
		int a[] = new int[size];						// Size of the array is declared.
		
		System.out.println("Enter the array elements:");
		for (int i=0;i<a.length;i++) 
		{
			a[i]=sc.nextInt();                          // Scanned values are assigned to the array "a[size]".
		}
		
		t1 = System.nanoTime();							// t1 stores the value of start time in nano seconds.
		for (int i=1;i<a.length;i++) 					// i represents number of iterations.
		{
			for (int j=0;j<a.length-i;j++) 				// j represents position of array elements.
			{
				if (a[j] > a[j + 1])                    // If an element is greater than the next element, then swap the value.
				{
			         temp = a[j];
			         a[j] = a[j + 1];
			         a[j + 1] = temp;
			    }
			}	
		}
		t2 = System.nanoTime();							// t2 stores the value of end time in nano seconds.
		
		System.out.println("Array after sorting in ascending order:");
		for (int i=0;i<a.length;i++) 
		{
			System.out.println(a[i]);					// Sorted array in ascending order is displayed.
		}
		
		t = t2 - t1;									// t represents execution time of bubble sort operation in nano seconds.
		System.out.println("Execution time for bubble sort operation is " +t+ " nano seconds."); // Execution time for bubble sort operation is displayed.			
	}
}
