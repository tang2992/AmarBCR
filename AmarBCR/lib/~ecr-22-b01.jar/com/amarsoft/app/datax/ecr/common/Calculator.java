// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   Calculator.java

package com.amarsoft.app.datax.ecr.common;

import java.math.BigDecimal;

public class Calculator
{

	public Calculator()
	{
	}

	public static String infixToPostfix(String infixExpression)
	{
		String infix = infixExpression;
		String Postfix = "";
		char stack[] = new char[infix.length()];
		int stackTop = -1;
		for (int i = 0; i < infix.length(); i++)
		{
			char currentChar = infix.charAt(i);
			switch (currentChar)
			{
			case 32: // ' '
				break;

			case 43: // '+'
			case 45: // '-'
				char stackChar;
				for (; stackTop >= 0; Postfix = (new StringBuilder(String.valueOf(Postfix))).append(stackChar).toString())
				{
					stackChar = stack[stackTop--];
					if (stackChar != '(')
						continue;
					stack[++stackTop] = stackChar;
					break;
				}

				stack[++stackTop] = currentChar;
				Postfix = (new StringBuilder(String.valueOf(Postfix))).append(" ").toString();
				break;

			case 42: // '*'
			case 47: // '/'
				char stackChar;
				for (; stackTop >= 0; Postfix = (new StringBuilder(String.valueOf(Postfix))).append(stackChar).toString())
				{
					stackChar = stack[stackTop--];
					if (stackChar == '(')
					{
						stack[++stackTop] = stackChar;
						break;
					}
					if (stackChar != '+' && stackChar != '-')
						continue;
					stack[++stackTop] = stackChar;
					break;
				}

				stack[++stackTop] = currentChar;
				Postfix = (new StringBuilder(String.valueOf(Postfix))).append(" ").toString();
				break;

			case 40: // '('
				stack[++stackTop] = currentChar;
				Postfix = (new StringBuilder(String.valueOf(Postfix))).append(" ").toString();
				break;

			case 41: // ')'
				while (stackTop >= 0) 
				{
					char stackChar = stack[stackTop--];
					if (stackChar == '(')
						break;
					Postfix = (new StringBuilder(String.valueOf(Postfix))).append(stackChar).toString();
				}
				Postfix = (new StringBuilder(String.valueOf(Postfix))).append(" ").toString();
				break;

			case 33: // '!'
			case 34: // '"'
			case 35: // '#'
			case 36: // '$'
			case 37: // '%'
			case 38: // '&'
			case 39: // '\''
			case 44: // ','
			case 46: // '.'
			default:
				Postfix = (new StringBuilder(String.valueOf(Postfix))).append(currentChar).toString();
				break;
			}
		}

		while (stackTop >= 0) 
			Postfix = (new StringBuilder(String.valueOf(Postfix))).append(stack[stackTop--]).toString();
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

	public static String compute(String infixExpression)
	{
		String result = postfixCompute(infixToPostfix(infixExpression));
		return result;
	}

	public static String replace(String originalValue, String oldStr, String newStr)
	{
		String replacedString = originalValue;
		int iCursor = 0;
		iCursor -= newStr.length();
		int iCount = 1;
		for (int i = replacedString.indexOf(oldStr, 0); i != -1; i = replacedString.indexOf(oldStr, i + newStr.length()))
		{
			replacedString = (new StringBuilder(String.valueOf(replacedString.substring(0, i)))).append(newStr).append(replacedString.substring(i + oldStr.length())).toString();
			iCursor = i;
			iCount++;
		}

		return replacedString;
	}
}
