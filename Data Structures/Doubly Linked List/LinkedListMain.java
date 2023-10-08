package Doubly Linked List;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class LinkedListMain<L extends Comparable<L>> extends LinkedList<L> 
{
	public LinkedListMain() 
	{
		super();
	}

	public static void main(String[] args) 
	{
		ArrayPart2<Employee> arrayList = new ArrayPart2<Employee>();
		LinkedList<Employee> linkedList = new LinkedList<Employee>();

		try (BufferedReader buff = new BufferedReader(new FileReader("D:\\IIT Chicago\\4. CS401 Lab\\Lab 8\\emp.txt"))) 
		{
			for (String empLine; (empLine = buff.readLine()) != null;) 
			{
				int i = 0;
				String[] empElement = empLine.split("\\s+");
				String empName = empElement[0];
				int empID = Integer.parseInt(empElement[1]);
				Employee empObj = new Employee(empName, empID);				
				arrayList.add(empObj);
				linkedList.add(empObj);
				i++;
			}
		} 
		catch (IOException e) 
		{
			System.out.println(e);
		} 
		catch (Exception e) 
		{
			System.out.println(e);
		}
		System.out.println(linkedList.toString());

		try 
		{
			System.out.println("Does it contain " + arrayList.get(0).toString() + linkedList.contains(arrayList.get(0)));
		} 
		catch (Exception e) 
		{
			System.out.println(e);
		}
	}

	@Override
	public void add(L element) 					// Method to add an element into the Linked List.
	{
		LLNode<L> value = this.head;
		if (value == null) 
		{
			this.head = new LLNode<L>(element);
			return;
		} 
		else if (value.getValue().compareTo(element) > 0) 
		{
			LLNode<L> newNode = new LLNode<L>(element);
			newNode.setNext(value);
			this.head = newNode;
			return;
		}
		while (value.getNext() != null && value.getNext().getValue().compareTo(element) < 0) 
		{
			value = value.getNext();
		}
		LLNode<L> newNext = value.getNext();
		value.setNext(new LLNode<L>(element));
		value.getNext().setNext(newNext);
	}
}
