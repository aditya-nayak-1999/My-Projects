package Quadratic Log Linear;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.LinkedHashMap;
import java.util.Scanner;

public class CS401prj 
{
	static int numComp5 = 0;
	static int numComp6 = 0;
	
	public static void main(String args[]) throws Exception  
	{
		Scanner filepath = new Scanner(System.in);								// Scanner object is created.
		
		System.out.println("Enter location of the input file:"); 				// User enters the location of input file.
		String location = filepath.nextLine();
		
		System.out.println("\nEnter number of inputs in the input file:"); 		// User enters the number of inputs in the file.
		int numInput = filepath.nextInt();
		
		int intArray[] = new int[numInput];										// Array is created to store input data.
		int origArray[] = new int[numInput];
		
		int numInsert=0;														// Counter to count the number of data insertions.
		
		File inputFile = new File (location);									// Datatype of the input file is set to type "File".
		
		Scanner scanObj;
		try 
		{
			scanObj = new Scanner(inputFile);
			int inputData;
			while (scanObj.hasNext()) 
			{
				inputData = scanObj.nextInt();
				intArray[numInsert] = inputData; 								// Input data is inserted into array.
				origArray[numInsert] = inputData;
				numInsert++;
			}
		}
		catch (FileNotFoundException e) 
		{
			System.out.println("Enter valid location of the input file:");		// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		System.out.println("\nThe input file contains the following numbers:");		
		for (int i=0; i<intArray.length; i++) 
		{
			if (i!=0 && i%20 == 0)
			{
				System.out.println();		
			}
			System.out.print(intArray[i]);										// Printing the input data with 20 numbers in each line.
			if (i == intArray.length-1) 
			{
		        System.out.print(".");
		    } 
			else 
			{
		        System.out.print(", ");
		    }
		}
		
		String quadSortName = "Quadratic sorting techniques";
		System.out.println("\n\nWhich quadratic sorting technique would you like to use?");
		System.out.println("1. Selection sort\n2. Insertion sort\n3. Bubble sort");
		int quadraticSort = filepath.nextInt();
		
		switch(quadraticSort) 
		{
			case 1:
					quadSortName="Selection sort technique";						
					Operations.selectionSort(intArray);							// Selection sort method is called.
					break;
			case 2:
					quadSortName="Insertion sort technique";							
					Operations.insertionSort(intArray);							// Insertion Sort method is called.
					break;
			case 3:
					quadSortName="Bubble sort technique";							
					Operations.bubbleSort(intArray);							// Bubble sort method is called.
					break;
			default:
					throw new Exception("Enter a valid number:\n");
		}
		
		System.out.println("\nThe numbers are sorted using "+quadSortName+" as follows:");
		for (int i=0; i<intArray.length; i++) 
		{
			if (i != 0 && i%20 == 0)
			{
				System.out.println();		
			}
			System.out.print(intArray[i]);										// Printing the input data with 20 numbers in each line
			if (i == intArray.length-1) 										// sorted using one of the user selected quadratic sorting techniques.
			{
		        System.out.print(".");
		    } 
			else 
			{
		        System.out.print(", ");
		    }
		}																		

		System.out.println("\n\nWhich log-linear sorting technique would you like to use?");
		System.out.println("1. Merge sort\n2. Quick sort\n3. Heap sort");
		int loglinearSort = filepath.nextInt();
		String loglinSortName = "Log-linear sorting techniques";
		switch(loglinearSort) 
		{
			case 1:
					loglinSortName = "Merge sort technique";
					int numComp4 = Operations.mergeSort(intArray, numInput);		// Merge sort method is called.
					System.out.println("\nCompare count of Merge sort technique is " +numComp4+ ".");
					break;
			case 2:
					loglinSortName = "Quick sort technique";
					Operations.quickSort(intArray, 0, intArray.length-1);			// Quick sort method is called.
					System.out.println("\nCompare count of Quick sort technique is " +numComp5+ ".");
					break;
			case 3:
					loglinSortName = "Heap sort technique";							// Heap sort method is called.
					Operations.heapSort(intArray);
					System.out.println("\nCompare count of Heap sort technique is " +numComp6+ ".");
					break;
			default:
					throw new Exception("Enter a valid number:\n");
		}		
			
		System.out.println("\nThe numbers are sorted using "+loglinSortName+" as follows:");		
		for (int i=0; i<intArray.length; i++) 
		{
			if (i!= 0 && i%20 == 0)
			{
				System.out.println();		
			}
			System.out.print(intArray[i]);											// Printing the input data with 20 numbers in each line
			if (i == intArray.length-1) 											// sorted using one of the user selected log-linear sorting techniques.
			{
		        System.out.print(".");
		    } 
			else 
			{
		        System.out.print(", ");
		    }
		}																			
					
		System.out.println("\n\nWhich number are you looking for?");
		int numSearch = filepath.nextInt();
		
		int linearValue = Operations.linearSearch(origArray, numSearch);			// Linear search method is called.
		
		if(linearValue==-1) 
		{
			System.out.println("\nLinear search: The array is empty.");
		}	
		else 
			if(linearValue==-2) 
			{
				System.out.println("\nLinear search: The number "+numSearch+" is not present.");
			}
			else 
			{
				System.out.println("\nLinear search: The number "+numSearch+" is present at index "+linearValue+" of the unsorted array.");
			}
		
		Node rootNode = null;															
		for (int targetValue: intArray) 
		{
            rootNode = Operations.createBinTree(rootNode, targetValue);						// Binary search tree is created. 
        }
		Operations.binarySearch(rootNode, numSearch);										// Binary search method is called.
		
		int hashValue = Operations.hashFunctSearch(intArray, numSearch);					// Hash function search method is called.
		if (hashValue == -1)
		{	
			System.out.println("Hashfunction search: The number "+numSearch+" is not present.");
		}
		else
		{	
			System.out.println("Hashfunction search: The number "+numSearch+" is present at index "+hashValue+" of the sorted array.");
		}	
	}
}

class Node
{
	int inputData;
    Node leftNode = null;
	Node rightNode = null;
 
    Node(int inputData) 
    {
    	this.inputData = inputData;
    }
}