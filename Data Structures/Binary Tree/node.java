package Binary Tree;
public class node<T> 
{
	T info;
	node<T> right; 
	node<T> left;  
	
	public node(T data) 
	{
		this.info = data;
		left = null;
		right = null;
	}
}
