package Doubly Linked List;
public class ArrayPart2<A> 
{
	private A arrayList[];
	private int size;
	private int max = 10;
	
	public ArrayPart2() 
	{ 
		this.arrayList = (A[]) new Object[max];
		this.size = 0;
	}

	public void add(A element) 							// Method to add an element into the array.
	{														
		if (this.size == this.max) 
		{
			this.max = this.max * 2;
			A newArray[] = (A[]) new Object[this.max];
			for (int i = 0; i < size; i++) 
			{
				newArray[i] = this.arrayList[i];
			}
			this.arrayList = newArray;
		}
		this.arrayList[this.size] = element;
		this.size++;
	}
	
	public A get(int index) throws Exception 				// Method to get element at the given index from the array.
	{
		if (index < 0 || index >= size) 
		{
			throw new Exception("");
		}
		return this.arrayList[index];
	}

	public A remove(int index) throws Exception 			// Method to remove element at the given index from the array.
	{
		if (index < 0 || index >= size) 
		{
			throw new Exception("not in range");
		}
		A retVal = this.arrayList[index];
		for (int i = index; i < this.size; i++) 
		{
			this.arrayList[i] = this.arrayList[i + 1];
		}
		this.arrayList[this.size] = null;
		this.size--;
		return retVal;
	}

	public int getSize() 
	{
		return this.size;
	}

	@Override
	public String toString() 
	{
		String retVal = "";
		for (int i = 0; i < this.size; i++) {
			retVal += (this.arrayList[i] + " ");
		}
		return "CS401arrayImpl [ary=" + retVal + "]";
	}	
}
