package Doubly Linked List;
public class LinkedList <L extends Comparable <L>> 
{
	protected LLNode<L> head;

	public LinkedList() 
	{
		this.head = null;
	}
	
	public void add(L element)							// Method to add an element into the Linked List. 
	{
		LLNode<L> value = this.head;
		if(value == null) 
		{
			this.head = new LLNode<L>(element);
			return;
		}
		while(value.getNext() != null) 
		{
			value = value.getNext();
		}
		value.setNext(new LLNode<L>(element));
	}
	
	public boolean contains(L element) 
	{
		LLNode<L> value = this.head;
		while(value != null) 
		{
			if(value.getValue().equals(element)) 
			{
				return true;
			}
			value = value.getNext();
		}
		return false;
	}
	
	public void remove(L element) 						// Method to remove an element from the Linked List.
	{
		LLNode<L> value = this.head;
		if(value == null) return;
		else 
			if(value.getValue().equals(element)) 
			{
				this.head = value.getNext();
			}
		while(value.getNext() != null) 
		{
			if(value.getNext().getValue().equals(element)) 
			{
				value.setNext(value.getNext().getNext());
				return;
			}
			value = value.getNext();
		}
	}

	@Override
	public String toString() 
	{
		String retValue = "";
		LLNode<L> value = this.head;
		while(value != null) 
		{
			retValue += (value.getValue());
			value = value.getNext();
		}
		return "Linked List contains the following employee details:\n" + retValue;
	}
}
