package Palindrome;
import java.util.Stack;

public class PostfixEval 
{
	static int value(char c)
	{
        switch (c)
        {
            case '+':
            case '-':
                return 1;
            case '*':
            case '/':
                return 2;
            case '^':
                return 3;
        }
        return -1;
    }

	static String Postfix(String equation)
	{
        String res = "";
        Stack<Character> stack = new Stack<>();
        for (int i = 0; i <equation.length() ; i++) 
        {
            char c = equation.charAt(i);

            if(value(c)>0)			// c is an operator then
            {
                while(stack.isEmpty()==false && value(stack.peek())>=value(c))
                {
                    res+= stack.pop();
                }
                stack.push(c);
            }
			
			else if(c==')')			// c is ')' then
			{
                char a = stack.pop();
                while(a!='(')
                {
                    res+=a;
                    a= stack.pop();
                }
            }
			
			else if(c=='(')			// c is '(' then push it to stack
			{
                stack.push(c);
            }
			
			else					// c is not operator nor '(' or ')' then add to the resulted expression
			{
                res += c;			// character is neither operator nor ( 
            }
        }
        
        for (int i = 0; i <=stack.size() ; i++) 
        {
            res += stack.pop();
        }
        return res;
    }

	public static int Evaluation(String equation)
	{
		Stack<Integer> stack = new Stack<>();
		
		if (equation == null || equation.length() == 0) 
		{
			System.exit(-1);
		}

		for (char ch: equation.toCharArray())
		{
			if (Character.isDigit(ch)) 						// character is an operand, push it into the stack
			{
				stack.push(ch - '0');
			}
			else 											// character is an operator
			{
				int pop1 = stack.pop();						// remove the top two elements from the stack
				int pop2 = stack.pop();

				if (ch == '+') 								// push the value back to stack
				{
					stack.push(pop1+ pop2);
				}
				else if (ch == '-') 
				{
					stack.push(pop2-pop1);
				}
				else if (ch == '*') 
				{
					stack.push(pop1*pop2);
				}
				else if (ch == '/') 
				{
					stack.push(pop2/pop1);
				}
			}
		}
		return stack.pop();
	}   
}
