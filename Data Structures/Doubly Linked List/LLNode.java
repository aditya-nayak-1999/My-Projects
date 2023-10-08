package Doubly Linked List;
public class LLNode <L extends Comparable <L>> 
{
	private L value;
	private LLNode<L> nextNode;
	
	public L getValue() 
	{
		return value;
	}

	public void setValue(L value) 
	{
		this.value = value;
	}

	public LLNode<L> getNext() 
	{
		return nextNode;
	}
	
	public void setNext(LLNode<L> nextNode) 
	{
		this.nextNode = nextNode;
	}

	public LLNode(L element) 
	{
		super();
		this.value = element;
		this.nextNode = null;
	}

	public int compareTo(L element) 
	{
		return this.value.compareTo(element);
	}
}
