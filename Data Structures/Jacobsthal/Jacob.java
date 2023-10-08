package Jacobsthal;
public class Jacob 
{
	int x=0, y=1, Jacobsthal=0;
	public static void main(String args[]) 
	{
		int n = 10;
		long t1, t2, Rt, t3, t4, It; 
		Jacob obj = new Jacob();
		System.out.println("$ java Jacobsthal "+n);
													
		System.out.print("Recursive version: ");  			// Start of recursive section
		t1 = System.currentTimeMillis();
		int x=0, y=1, Jacobsthal=0 ;
		if (x==n) 
		{
			System.out.print(x);
		}
		else 
			if(y==n) 
			{
				System.out.print(x+ ", " +y);
			}
			else 
				if (Jacobsthal<n)
				{
					System.out.print(x+ ", " +y);
					obj.Jacobsthal_recursive(n);		 	// Calling recursive method
				}
		t2 = System.currentTimeMillis();
		Rt = t2 - t1;
		System.out.print("\nTime taken to execute recursive version: " +Rt+ " millisecond");  	
															// End of recursive section
		System.out.print("\n");
		System.out.print("Iterative version: ");			// Start of iterative section
		t3 = System.currentTimeMillis();
		obj.Jacobsthal_iterative(n);						// Calling iterative method
		t4 = System.currentTimeMillis();
		It = t4 - t3;
		System.out.println("\nTime taken to execute iterative version: " +It+ " millisecond");	
	}														// End of iterative section
	
	long Jacobsthal_recursive(int n) 						// Recursive method
	{
		if((n-2)==0) 
		{
			return n;
		}
		Jacobsthal = y+(x*2);
		x = y;
		y = Jacobsthal;
		System.out.print(", " + Jacobsthal);
	
		return Jacobsthal_recursive(n-1);
	}
	
	long Jacobsthal_iterative(int n) 						// Iterative method
	{	
		int x=0, y=1, Jacobsthal=0 ;
		if (x==n) 
		{
			System.out.print(x);
		}
		else 
			if(y==n) 
			{
				System.out.print(x+ ", " +y);
			}
			else 
				if (Jacobsthal<n)
				{
					System.out.print(x+ ", " +y);
					for(int i=2;i<n;i++) 
					{
						Jacobsthal = y+(x*2);
						x = y;
						y = Jacobsthal;
						System.out.print(", " +Jacobsthal);
					}
				}
		return n;
	}
}
