package com.amarsoft.app.datax.bcr.common;

import java.math.BigDecimal;

public class Calculator
{
  public static String infixToPostfix(String infixExpression)
  {
    char currentChar;
    String infix = infixExpression;
    String Postfix = "";
    char[] stack = new char[infix.length()];
    int stackTop = -1;
    for (int i = 0; i < infix.length(); ++i) {
      char stackChar;
      currentChar = infix.charAt(i);
      switch (currentChar)
      {
      case ' ':
        break;
      case '+':
      case '-':
        while (stackTop >= 0) {
          stackChar = stack[(stackTop--)];
          if (stackChar == '(') {
            stack[(++stackTop)] = stackChar;
            break;
          }
          Postfix = Postfix + stackChar;
        }
        stack[(++stackTop)] = currentChar;
        Postfix = Postfix + " ";
        break;
      case '*':
      case '/':
        while (stackTop >= 0) {
          stackChar = stack[(stackTop--)];
          if (stackChar == '(') {
            stack[(++stackTop)] = stackChar;
            break;
          }
          if ((stackChar == '+') || (stackChar == '-')) {
            stack[(++stackTop)] = stackChar;
            break;
          }
          Postfix = Postfix + stackChar;
        }
        stack[(++stackTop)] = currentChar;
        Postfix = Postfix + " ";
        break;
      case '(':
        stack[(++stackTop)] = currentChar;
        Postfix = Postfix + " ";
        break;
      case ')':
        while (stackTop >= 0) {
          stackChar = stack[(stackTop--)];
          if (stackChar == '(')
            break;

          Postfix = Postfix + stackChar;
        }
        Postfix = Postfix + " ";
        break;
      case '!':
      case '"':
      case '#':
      case '$':
      case '%':
      case '&':
      case '\'':
      case ',':
      case '.':
      default:
        Postfix = Postfix + currentChar;
      }
    }

    while (stackTop >= 0)
      Postfix = Postfix + stack[(stackTop--)];

    return Postfix;
  }

  public static String postfixCompute(String postfixExpression)
	{
		BigDecimal stack[] = new BigDecimal[postfixExpression.length()];
		int stackTop = -1;
		String stackString = "";
		BigDecimal result;
		for (int i = 0; i < postfixExpression.length(); i++)
		{
			char currentChar = postfixExpression.charAt(i);
			if (currentChar >= '0' && currentChar <= '9' || currentChar == '.')
				stackString = (new StringBuilder(String.valueOf(stackString))).append(currentChar).toString();
			if (currentChar == ' ' && stackString != "" || i == postfixExpression.length() - 1)
			{
				stack[++stackTop] = new BigDecimal(stackString);
				stackString = "";
			}
			if (currentChar == '+' || currentChar == '-' || currentChar == '*' || currentChar == '/')
			{
				if (stackString != "")
				{
					stack[++stackTop] = new BigDecimal(stackString);
					stackString = "";
				}
				BigDecimal backNumber = stack[stackTop--];
				BigDecimal frontNumber = stack[stackTop--];
				switch (currentChar)
				{
				case 43: // '+'
					result = frontNumber.add(backNumber);
					break;

				case 45: // '-'
					result = frontNumber.subtract(backNumber);
					break;

				case 42: // '*'
					result = frontNumber.multiply(backNumber);
					break;

				case 47: // '/'
					result = frontNumber.divide(backNumber);
					break;

				case 44: // ','
				case 46: // '.'
				default:
					result = BigDecimal.ZERO;
					break;
				}
				stack[++stackTop] = result;
			}
		}

		result = stack[stackTop--];
		return String.valueOf(result);
	}

  public static String compute(String infixExpression) {
    String result = postfixCompute(infixToPostfix(infixExpression));
    return result;
  }

  public static String replace(String originalValue, String oldStr, String newStr)
  {
    String replacedString = originalValue;
    int iCursor = 0;
    iCursor -= newStr.length();
    int iCount = 1;
    for (int i = replacedString.indexOf(oldStr, 0); i != -1; i = replacedString.indexOf
      (oldStr, i + newStr.length()))
    {
      replacedString = replacedString.substring(0, i) + newStr + 
        replacedString.substring(i + oldStr.length());
      iCursor = i;
      ++iCount;
    }
    return replacedString;
  }
}