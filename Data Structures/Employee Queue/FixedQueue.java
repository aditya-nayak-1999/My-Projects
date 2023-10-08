package Employee Queue;
public class FixedQueue<Employee> 
{
	protected int front=-1;
	protected int rear=-1;
	protected int size=0;
	protected int max;
	protected Employee employee[];
	
	public FixedQueue(int max) 
	{
		this.employee = (Employee[]) new Object[max];
		this.max=max;	
	}

	public FixedQueue() 
	{															// TODO Auto-generated constructor stub
	}
	
	public boolean enqueue(Employee e) 							// Enqueue employee objects for fixed front operation.
	{
		if(isFull()) 
		{
			throw new StackOverflowError ("Queue is full");
		}
		rear++;
		employee[rear] = e;
		size++;
		return true;
	}
	
	public void print()											// Print the elements in the queue.
	{
		for(int i=0;i<employee.length;i++) 
		{
			System.out.println(employee[i]);
		}
	}
	
	public Employee dequeue() 									// Dequeue employee objects for fixed front operation.
	{
		if (isEmpty()) 
		{
			throw new StackOverflowError ("Queue is empty");
		}
		size--;
		Employee Value = employee[front+1];
		for (int i=0; i<size; i++) 
		{
			employee[i]=employee[i+1];
		}
		employee[rear] = null;
		rear--;
		return Value;
	}
		
	public boolean isEmpty()
	{ 
		return (size == 0); 
	}

	public boolean isFull()
	{ 
		return (size==max);
	}		
}
