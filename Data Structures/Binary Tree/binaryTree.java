package Binary Tree;
import java.util.LinkedList;

public class binaryTree<T extends Comparable<T>> 
{
	public T[] sortArray(T[] array)									// Method to sort the array in ascending order.
	{
		int size = array.length;
        for (int index = 0; index < size-1; index++)
        {
            int minIndex = index;
            
            for (int i = index + 1; i < size; i++)
            {
            	if (array[i].compareTo(array[minIndex]) < 0)
            	{ 
            		minIndex = i;									// Index of minimum value is figured out.
                }
            }
            
            if (minIndex != index)									// Swap the value if minimum index is not equal to current index.
            {
                T temp = array[index];
                array[index] = array[minIndex];
                array[minIndex] = temp;
            }
        }
        return array;
    }

	public node<T> binarytreeRoot(T[] sortedArray)
	{
		node<T> root = searchNode(sortedArray,0,sortedArray.length-1);
		return root;
	}
	
	private node<T> searchNode(T[] sortedArray, int first, int last)
	{
		if (first > last)
			return null;
		
		int midpoint = (first+last)/2;
		node<T> node =  new node<T>(sortedArray[midpoint]);
		
		node.left = searchNode(sortedArray, first, midpoint - 1);
		node.right = searchNode(sortedArray, midpoint + 1, last);		
		return node;
	}
	
	public int maxDepth(node<T> node) 								// Method to find maximum depth of the binary tree.
	{
		if(node == null)
			return 0;		
		
		if(node.left == null && node.right == null)
			return 1; 												// Leaf Node.
		
		int leftSide = maxDepth(node.left);
		int rightSide = maxDepth(node.right);
		
		return Math.max(leftSide, rightSide) + 1;
	}
	
	public int recSize(node<T> node) 								// Method to find size of the tree using recursive approach.
	{
		if(node==null)
			return 0;
		
		return (1 + recSize(node.left) + recSize(node.right));
	}
	
	public int iterSize(node<T> node)  								// Method to find size of the tree using iterative approach.
	{
		int size = 1;
		  
		if(node == null)
			return 0;
		  
		LinkedList <node<T>> list = new LinkedList <node<T>>();
		  
		node<T> currNode;
		list.push(node);
		  
		while(!list.isEmpty()) 
		{
			currNode = list.poll();
			  
			if(currNode.left!= null) 
			{
				list.push(currNode.left);
				size++;
			}
			  
			if(currNode.right!= null) 
			{
				list.push(currNode.right);
				size++;
			}
		}
		return size;
	 }
	
	public void inOrder(node<T> node) 								// Method to display In-order traversal of the tree.
	{
		if(node == null)
			return;
			
		inOrder(node.left);
		System.out.print(node.info + " ");
		inOrder(node.right);
	}
	
	public void preOrder(node<T> node) 								// Method to display Pre-order traversal of the tree.
	{
		if(node == null)
			return;
		
		System.out.print(node.info + " ");
		preOrder(node.left);
		preOrder(node.right);
	}
	
	public void postOrder(node<T> node) 							// Method to display Post-order traversal of the tree.
	{
		if(node == null)
			return ;
		
		postOrder(node.left);
		postOrder(node.right);
		System.out.print(node.info + " ");
	}
}
