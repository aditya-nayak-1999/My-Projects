package Binary Tree;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class binarytreeMain 
{
	public static void main(String args[]) 
	{
		List<Integer> arrayList = new ArrayList<Integer>();
		
		Scanner filepath = new Scanner(System.in);											// Scanner object is created.
		System.out.println("Enter the location of file:"); 									
		String location = filepath.nextLine();												// Location of the input file is scanned.	
		File file = new File (location);
	
		Scanner input;
		try 
		{
			input = new Scanner(file);
			Integer data;
			while (input.hasNext()) 
			{
				data = input.nextInt();
				arrayList.add(data);														// Input data is shifted to an array list.
			}
		}
		catch (FileNotFoundException e) 
		{
			e.printStackTrace();															// TODO Auto-generated catch block
		}
					
		Integer intArray[] = arrayList.toArray(new Integer[0]);								// Array list data is shifted to an array.
			      	
		System.out.println("\nThe file contains the following numbers:");					
		for (int i = 0; i < intArray.length; i++)
		System.out.print(intArray[i] + " ");												// Input data present in the array is displayed.
			      
		binaryTree<Integer> binaryTree = new binaryTree<Integer>();
					
		Integer sortedArray[] = binaryTree.sortArray(intArray);								// Method to sort the array in ascending order is called.
			      	
		System.out.println("\n\nThe numbers are sorted in ascending order as follows:"); 	
		for (int i = 0; i < sortedArray.length; i++)
		System.out.print(sortedArray[i]+ " ");												// Sorted data present in the array is displayed.
			      	
		node<Integer> root = binaryTree.binarytreeRoot(sortedArray);
			      	
		int maxDepth = binaryTree.maxDepth(root);											// Method to find maximum depth of the binary tree is called.
		System.out.println("\n\nMaximum depth of the binary tree is " + maxDepth + "." );
			      	
		int recSize = binaryTree.recSize(root);												// Method to find size of the binary tree using recursive approach is called.
		System.out.println("\nSize of the tree using recursive approach is " + recSize + "." );
			      	
		int iterSize = binaryTree.iterSize(root);											// Method to find size of the binary tree using iterative approach is called.
		System.out.println("\nSize of the tree using iterative approach is " + iterSize + "." );
			      	
		System.out.println("\nIn-order traversal of tree is as follows:");							
		binaryTree.inOrder(root);															// Method to display In-order traversal of the tree is called.
			      	
		System.out.println("\n\nPre-order traversal of tree is as follows:");							
		binaryTree.preOrder(root);															// Method to display Pre-order traversal of the tree is called.
				   
		System.out.println("\n\nPost-order traversal of tree is as follows:");								      	
		binaryTree.postOrder(root);															// Method to display Post-order traversal of the tree is called.
	}
}
