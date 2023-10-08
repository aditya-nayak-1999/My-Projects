package Quadratic Log Linear;
import java.util.LinkedHashMap;

public class Operations 
{
	static void selectionSort(int intArray[])								// Selection sort method definition.
	{
		int lastIndex = intArray.length-1; 
		int numComp1=0;
				
		for(int currIndex=0; currIndex<lastIndex; currIndex++)				// Least element is moved to the top on every iteration.
		{
			int minIndex = currIndex;
			for (int index=currIndex+1; index<=lastIndex; index++)
			{
				numComp1++;	
				if (intArray[index] < intArray[minIndex])
					swapValue(intArray, index, minIndex);					// Minimum value is moved to the front of the array.
			}
		}
		System.out.println("\nCompare count of Selection sort technique is " +numComp1+ ".");
	}
			
	static void swapValue(int[] intArray, int index1, int index2) 			// Swap method is used to swap values in the array.
	{
		int temp = intArray[index1];
		intArray[index1] = intArray[index2];
		intArray[index2] = temp;
	}
			
	static void insertionSort(int intArray[])								// Insertion sort method definition.
	{
		int arrSize = intArray.length;
		int numComp2 = 0;
		for (int count=1; count<arrSize; count++)
			numComp2 = numComp2 + sortArray(intArray, 0, count);
		System.out.println("\nCompare count of Insertion sort technique is " +numComp2+ ".");
	}
			
	static int sortArray(int intArray[], int firstIndex, int lastIndex) 		// sortArray method is called within insertionSort method.
	{																			// sortArray method maintains the sorted array on one side
		boolean sortComplete = false;											// by pushing the least value to the top of the array. 
		int currIndex = lastIndex;
		boolean sortIncomplete = true;
		int previous;
		int numComp2=0;
				
		while (sortIncomplete && !sortComplete)
		{
			previous = currIndex-1;
			numComp2++;
			if (intArray[currIndex] < intArray[previous])
			{
				swapValue(intArray, currIndex, previous);
				currIndex--;
				sortIncomplete = (currIndex != firstIndex);
			}
			else
				sortComplete = true;
		}
		return numComp2;
	}
			
	static void bubbleSort(int intArray[])            							// Bubble sort method definition.
	{
		int currIndex = 0;
		int numComp3 = 0;
		int size = intArray.length-1;
				
		while (currIndex < intArray.length-1)
		{
			numComp3 = numComp3 + pushElement(intArray, currIndex, size);
			currIndex++;
		}
		System.out.println("\nCompare count of Bubble sort technique is "+numComp3+".");
	}
			
	static int pushElement(int intArray[], int firstIndex, int lastIndex)		// pushElement method is used within bubbleSort method.
	{																			// pushElement method compares current value with the adjacent value 
		int numComp3=0;															// and pushes the least element to the top of the array.
		for (int index=lastIndex; index>firstIndex; index--) 
		{
			int prevIndex = index-1;
			numComp3++;
			if (intArray[index] < intArray[prevIndex])
				swapValue(intArray, index, prevIndex);
		}
		return numComp3;
	}
			
	static int mergeSort(int intArray[], int arrayLength)							// Merge sort method definition.
	{
		if(arrayLength <= 1)														// Proceed with the sorting only if array length is greater than 1.
			return -1;																
		int numComp4=0;
		int midIndex = arrayLength/2;
				
		int arrayLeft[] = new int[midIndex]; 										// New array is created for left section of the main array.
		int arrayRight[] = new int[arrayLength-midIndex]; 							// New array is created for right section of the main array.
				
		for (int currIndex=0; currIndex<midIndex; currIndex++)
		{
			arrayLeft[currIndex] = intArray[currIndex];								// Values in left section of the main array is assigned to the new array.
		}
				
		for(int currIndex=midIndex; currIndex<arrayLength; currIndex++)
		{
			arrayRight[currIndex-midIndex] = intArray[currIndex];					// Values in right section of the main array is assigned to the new array.
		}
				
		numComp4 = numComp4 + mergeSort(arrayLeft, midIndex);						// Performing mergeSort operation on left section of the array.
		numComp4 = numComp4 + mergeSort(arrayRight, arrayLength-midIndex);			// Performing mergeSort operation on right section of the array.
		numComp4 = numComp4 + combineArray(intArray, arrayLeft, arrayRight);		// Sort and combine the sorted left and sorted right section of the array.
		return numComp4;
	}
			
	static int combineArray(int intArray[], int arrayLeft[], int arrayRight[])
	{
	    int lengthLeftArray = arrayLeft.length;
	    int lengthRightArray = arrayRight.length;
	    int i=0, j=0, k=0;
	    int numComp4=0;
	       
	    while(i<lengthLeftArray && j<lengthRightArray)
	    {
			if(arrayLeft[i] <= arrayRight[j])						// Left array value is shifted to main array if it is less than right array value.
			{
				numComp4++;
	            intArray[k] = arrayLeft[i];
	            i++;
	            k++;
	        }
	        else
	        {
				intArray[k] = arrayRight[j];						// Right array value is shifted to main array if it is less than left array value.
	            numComp4++;
	            j++;
	            k++;
	        }
	    }
			
		while(i < lengthLeftArray) 									// Once all right array values are shifted to main array,								
		{															// the left over values in left array are shifted to main array.
			intArray[k] = arrayLeft[i];
	        numComp4++;
	        i++;
	        k++;
	    }

		while(j < lengthRightArray)									// Once all left array values are shifted to main array, 
		{															// the left over values in right array are shifted to main array. 
			intArray[k] = arrayRight[j];
	        numComp4++;
	        j++;
	        k++;
	    }
	    return numComp4;
	}
			
	static void quickSort(int intArray[], int first, int last)		// Quick sort method definition.
	{ 
		if (first < last)
		{  
			int dividePoint = divideArray(intArray, first, last);
			quickSort(intArray, first, dividePoint-1);  
			quickSort(intArray, dividePoint+1, last);  
		}  
	}
			
	static int divideArray(int intArray[], int first, int last)		// divideArray method is called within quickSort method.
	{  																// This method divides the array into two sections such that
		int divideValue = intArray[last];   						// right side values are greater than the divide value and 
		int i = (first - 1); 										// left side values are lesser than the divide value.
				  
		for (int j=first; j<=last-1; j++)
		{  
			if (intArray[j] < divideValue)					
			{  
				CS401prj.numComp5++;
				i++;   												// If current element is less than the divide value, then the smaller index is incremented.
				swapValue(intArray,i,j);
			}  
		}  
		swapValue(intArray,i+1,last);
		return (i + 1);  
	}
			
	static void heapSort(int intArray[])							// Heap sort method definition.
	{
		unsortedMaxHeap(intArray);									
		for(int i=intArray.length-1; i>0; i--)
		{
			swapValue(intArray, i, 0);
	        sortedMaxHeap(intArray, 0, i); 
		}
	}
			
	static void unsortedMaxHeap(int intArray[])						// Maximum heap is built for the unsorted array.
	{
		int arrLength = intArray.length;
		for(int i=arrLength/2-1; i>=0; i--)
		{
			sortedMaxHeap(intArray, i, arrLength);
		}
	}
			
	static void sortedMaxHeap(int[] intArray, int currIndex, int arrLength)			// Maximum heap is built for the sorted array.
	{
		if(currIndex<0 || currIndex>=arrLength)
	    return;

		int leftIndex = 2*currIndex+1;
		int rightIndex = 2*currIndex+2;
		int maxIndex = currIndex;

		if(leftIndex<arrLength && intArray[leftIndex] > intArray[maxIndex])
		{
			CS401prj.numComp6++;	
	        maxIndex = leftIndex;
		}

		if(rightIndex <arrLength && intArray[rightIndex] > intArray[maxIndex])
		{
			maxIndex = rightIndex;
	        CS401prj.numComp6++;
		}

		if( maxIndex != currIndex)
		{
			swapValue(intArray, maxIndex, currIndex);
			sortedMaxHeap(intArray, maxIndex, arrLength);
		}
	}
			
	static int linearSearch(int intArray[], int inputData)							// Linear search method definition.
	{
		int arrLength = intArray.length;
		int indexValue;
				
		if (arrLength == 0) 														// Check if array is empty.
		{
			return -1;
		}
				
		for(int i=0; i<arrLength; i++)
		{
			indexValue = intArray[i];
			if(indexValue == inputData)
				return i;
		}
		
		return -2;
	}
			
	static Node createBinTree(Node rootNode, int targetValue)						// Method to create a binary tree.
	{
		if (rootNode == null) 														// Create a new node if root node is null.
		{
			return new Node(targetValue);
		}
			 
		if (targetValue < rootNode.inputData) 										// If target value is less than the data in root node,
		{
			rootNode.leftNode = createBinTree(rootNode.leftNode, targetValue);		// assign the recursive output to the left node.
		}
		else 																		// If target value is more than the data in root node,
		{
			rootNode.rightNode = createBinTree(rootNode.rightNode, targetValue);	// assign the recursive output to the right node.
		}
			 
		return rootNode;
	}
	
	public static void binarySearch(Node rootNode, int targetValue)
	{
		Node currNode = rootNode;													// Initially current node points to the root node.
		Node parentNode = null;														// Parent of the current node is set to null.
		 
		while (currNode != null && currNode.inputData != targetValue)				// Target value is searched.
		{
			parentNode = currNode;													// Current node data is assigned to the parent node.
		 
		    if (targetValue < currNode.inputData) 									// If target value is less than the data in current node, 
		    {																		
		    	currNode = currNode.leftNode;										// then move current node towards the left,
		    }
		    else 
		    {
		    	currNode = currNode.rightNode;										// else move current node towards the right.
		    }
		}
		 
		if (currNode == null)														// If current node is null, then target value is not present.
		{
			System.out.println("Binary search: The number "+targetValue+" is not present.");
		    return;
		}
		 
		if (parentNode == null) 
		{
			System.out.println(targetValue+" is the root node.");
		}
		else 
			if (targetValue < parentNode.inputData)
			{
				System.out.println("Binary search: The number "+targetValue+" is present at index "+parentNode.inputData+" of the sorted array.");
			}
		    else 
		    {
		    	System.out.println("Binary search: The number "+targetValue+" is present at index "+parentNode.inputData+" of the sorted array.");
		    }
	}
			
	public static int hashFunctSearch(int intArray[], int inputData) 
	{
		LinkedHashMap<Integer, Integer> hashRef = new LinkedHashMap<Integer, Integer>();
				
		for(int i=0; i<intArray.length; i++) 
		{
			hashRef.put(intArray[i], i);
		}
		
		if(hashRef.get(inputData) != null) 
		{
			return hashRef.get(inputData); 
		}
		
		return -1;
	}
}
