package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.io.PrintStream;

public class FinanceChecker extends AbstractFieldChecker
{

	public FinanceChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkJRJG = checkRule.getCheckedValue();
		if (checkJRJG.trim().length() < 11)
			return false;
		else
			return checkJRJG(checkJRJG.getBytes());
	}

	public static void main(String args[])
	{
		System.out.println((new StringBuilder("1")).append(checkJRJG("39303140102".getBytes())).toString());
	}

	public static boolean checkJRJG(byte financecode[])
	{
		int M = 10;
		int s = M;
		int k = 9;
		for (int i = k; i >= 0; i--)
		{
			int temp = financecode[k - i];
			if (temp >= 48 && temp <= 57)
				temp -= 48;
			else
			if (temp >= 65 && temp <= 90 || temp >= 97 && temp <= 122)
				temp = 0;
			else
				return false;
			if ((s + temp) % M == 0)
				s = 9;
			else
				s = (((s + temp) % M) * 2) % (M + 1);
		}

		s = (M + 1) - s;
		if (s == 10)
			s = 0;
		return s == 11 && financecode[10] == 88 || s == financecode[10] - 48;
	}
}
