package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.io.PrintStream;
import java.util.regex.Pattern;

public class CreditCodeChecker extends AbstractFieldChecker
{

	public CreditCodeChecker()
	{
	}

	public boolean getCheckResult()
	{
		String creditCode = checkRule.getCheckedValue();
		return checkCreditCode(creditCode.getBytes());
	}

	public static void main(String args[])
	{
		System.out.println(checkCreditCode("G10530102010759900".getBytes()));
	}

	public static boolean checkCreditCode(byte creditCode[])
	{
		if (creditCode.length != 18)
			return false;
		if (!Pattern.matches("[A-Z]{1}[0-9]{16}[0-9A-Z\\*]{1}", new String(creditCode)))
			return false;
		int m = 36;
		int s = m;
		for (int i = 0; i <= creditCode.length - 2; i++)
		{
			s = (s + char2num(creditCode[i])) % m;
			if (s == 0)
				s = m;
			s = (s * 2) % (m + 1);
		}

		return (s + char2num(creditCode[creditCode.length - 1])) % m == 1;
	}

	private static int char2num(byte a)
	{
		if (a == 42)
			return 36;
		if (a >= 48 && a <= 57)
			return a - 48;
		else
			return a - 55;
	}
}
