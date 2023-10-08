package Palindrome;
import java.util.Scanner;

public class PalindromeMain 
{
	public static void main(String args[]) 
	{
		Scanner sc = new Scanner(System.in);     							// Scanner object is created.
		System.out.println("Enter the string:");							// String is entered by the user.
		String enteredString = sc.nextLine();
		
		if (PalindromeCheck.checkPalindrome(enteredString))					// Palindrome validation method is called.
			System.out.println("\nEntered string is a palindrome.");
		else
			System.out.println("\nEntered string is not a palindrome.");
	}	
}

