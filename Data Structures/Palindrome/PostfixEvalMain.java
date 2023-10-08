package Palindrome;
import java.util.Scanner;
import java.util.Stack;

public class PostfixEvalMain 
{
	public static void main(String args[]) 
	{
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter the expression:");
		String equation = sc.nextLine();
		
		String Postfix = PostfixEval.Postfix(equation);   			// Postfix method of PostfixEval class is called.
		System.out.println("\nPostfix:"+Postfix);
		
		int Evaluation = PostfixEval.Evaluation(PostfixEval.Postfix(equation));		// Evaluation method of PostfixEval class is called.
		System.out.println("Evaluation:"+Evaluation);	
	}
}
