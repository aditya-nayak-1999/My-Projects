package Doubly Linked List;
public class CS401ArrayImpl<T> 
{
	private T empList[];
	private int size;
	private int DEFCAP = 10; 												// Default capacity is 10.
	
	public CS401ArrayImpl() 
	{
		this.empList = (T[]) new Object[DEFCAP]; 							// Setting the capacity of array list as 10.
		this.size = 0;	
	}
	
	public void add(T element) 												// Method for adding an element.
	{
		if(this.size == this.DEFCAP) 
		{
			this.DEFCAP = this.DEFCAP * 2; 									// The size of array list is doubled.
			T newList [] = (T[]) new Object[this.DEFCAP];
			for(int i = 0; i < size; i++) 
			{
				newList[i] = this.empList[i];
			}
			this.empList = newList;
		}
		this.empList[this.size] = element;
		this.size++;
	}
	
	public T get (int index) throws Exception								// Element at the given index is fetched from the array.
	{
		if ( index < 0 || index >= size) {
			throw new IndexOutOfBoundsException("Index is Out of bounds, Index value : " + index +" , Size : "+size);
		}
		return this.empList[index];
	}
	
	public T remove (int index) throws Exception 							// Method to remove element at the given index from the array.
	{
		if ( index < 0 || index >= size) 
		{
			throw new IndexOutOfBoundsException("Index is Out of bounds, Index value : " + index +" , Size : "+size);
		}
		T retValue = this.empList[index];
		for(int i = index; i < this.size; i++) 
		{
			this.empList[i] = this.empList[i+1];
		}
		this.empList[this.size] = null;
		this.size--;
		return retValue;
	}
	
	public int getSize() 
	{
		return this.size;
	}
	
	@Override
	public String toString() 
	{
		String retValue = "";
		for(int i = 0; i < this.size; i++) 
		{
			retValue += (this.empList[i]); 
		}
		return "\nCS401ArrayImpl contains the following employee details:\n" + retValue;
	}
}
