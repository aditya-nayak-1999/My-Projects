package Jacobsthal;
public class Minimum 
{
	public static int minimum(int A[], int size) 
	{
		if(size==0) 						// Filled code
		{
			return A[0];
		}
		return A[size-1] < minimum(A, size-1) ? A[size-1] : minimum(A, size-1);		// ternary operator
	}										
	public static void main(String args[]) 
	{
		int A[] = {10, -20, 1, 2, 0, 5, 100};
		int s = minimum(A, A.length);
		
		System.out.println("$ java Minimum");
		System.out.println(s);
	}
}