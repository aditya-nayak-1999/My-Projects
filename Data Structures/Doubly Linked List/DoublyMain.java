package Doubly Linked List;
public class DoublyMain 
{
	public static void main(String args[]) 
	{
		DoublyLinkedList list = new DoublyLinkedList();
		list.add(2);
        list.add(3);
        list.add(4);
        list.add(5);
        list.add(6);
        list.add(7);
        list.add(8);
        list.add(9);
        list.add(10);
        System.out.println("Doubly linked list contains the following values:");
        list.displayValues();
    
        list.removeFirst();
        System.out.println("\n\nAfter removing first value from the list:");
        list.displayValues();
        
        list.removeLast();
        System.out.println("\n\nAfter removing last value from the list:");
        list.displayValues();

        System.out.println("\n\nAfter removing value 7 from the list:");
        list.remove(7);
        list.displayValues();

        System.out.println("\n\nDoes the list contain value 3?");
        list.contains(3);
        System.out.println("\nDoes the list contain value 14?");
        list.contains(14);
	}
}
