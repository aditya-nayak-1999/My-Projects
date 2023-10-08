package Palindrome;
public class PalindromeCheck 
{
	public static boolean checkPalindrome(String enteredString) 
	{
		String forwardString = enteredString;
		String reverseString = "";
		int length=forwardString.length()-1;
		
		for (int i=length;i>=0;i--) 									// Reversing the string.
		{
			reverseString = reverseString+forwardString.charAt(i);
		}
		
		if (forwardString.equals(reverseString))						// Comparing if the entered string and its reverse is same.
			return true;
		else
			return false;
	}
}
