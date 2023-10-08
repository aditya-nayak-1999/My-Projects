package Doubly Linked List;
public class DoublyLinkedList 
{
	private Node head;									// First node of doubly linked list.
	private Node tail; 									// Last node of doubly linked list.
	private int size; 									// Number of nodes in doubly linked list.
	
	public DoublyLinkedList() 							// Constructor for initializing.
	{
		this.head = null;
		this.tail = null;
		this.size = 0;
	}
	
	private class Node 
	{
	    private int data;
	    private Node nextNode;
	    private Node previousNode;

	    public Node(int data) 
	    {
	        this.data = data;
	    }
	}
	
	public void add(int data)							// Method to add an element into the linked list.
	{
	    Node nodeRef = new Node(data);
	    
	    if (head == null) 								// Checking whether the linked list is empty.
	    {
	    	head=nodeRef;
	        tail=nodeRef; 
	        head.previousNode = null;
	        tail.nextNode=null;
	    }
	    else 
	    {
		    tail.nextNode = nodeRef;    
		    nodeRef.previousNode = tail;       
			tail = nodeRef;       
			tail.nextNode = null;    
	    }
	    size++;
	}
	
	public void removeFirst()							// Method to remove first node of the linked list. 
	{  
	    head = head.nextNode;  
	    size--;
	}  
		
	public void removeLast()							// Method to remove last node of the linked list.
	{  
		tail = tail.previousNode;  
		tail.nextNode=null;
	} 
		
	public void remove(int data) 
	{
		Node node = head;
		if (node == null) 
		{
			return;
		}

		if (node.data == data) 
		{
		    head = head.nextNode;
		    head.previousNode = head;
		    return;
		}

		do 
		{
		    Node n = node.nextNode;
		    if (n.data == data) 
		    {
		        node.nextNode = n.nextNode;
		        break;
		    }
		    node = node.nextNode;
		} 
		while (node != head);
	}
			 
	public void contains(int data) 
	{  
		int i = 1;  
		boolean flag = false;  
		        
		Node current = head;  
		  
		if(head == null) 								// To check whether the linked list is empty.
		{  
		    System.out.println("Doubly linked list is empty");  
		    return;  
		}  
		while(current != null) 
		{  
			if(current.data == data) 
			{  
				flag = true;  
		        break;  
		    }  
		    current = current.nextNode;  
		    i++;  
		}  
		if(flag)  
		    System.out.println("The value "+data+" is present in the list at location "+i+".");  
		else  
		    System.out.println("The value "+data+" is not present in the list.");  
	}  
	  
	public void displayValues() 						// Method to display values in the linked list.
	{
		Node first = head;
        
		if(head == null) 
		{  
			System.out.println("List is empty");    
			return;    
		} 
        while (first != null) 
        {
            System.out.print(first.data + " ");
            first = first.nextNode;
        }
	} 
}
