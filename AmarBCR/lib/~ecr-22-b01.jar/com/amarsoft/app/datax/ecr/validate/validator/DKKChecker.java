// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DKKChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.io.PrintStream;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class DKKChecker extends AbstractFieldChecker
{

	public DKKChecker()
	{
	}

	public static void main(String args[])
	{
		String checkedDKK = "1201040000297286";
		System.out.println((new StringBuilder("1")).append(checkDKK(checkedDKK.getBytes())).toString());
	}

	public boolean getCheckResult()
	{
		String checkedDKK = checkRule.getCheckedValue();
		if (checkedDKK.trim().length() < 16)
			return false;
		else
			return checkDKK(checkedDKK.getBytes());
	}

	public static boolean checkDKK(byte financecode[])
	{
		int weightValue[] = new int[14];
		int checkValue[] = new int[14];
		int totalValue = 0;
		int c = 0;
		weightValue[0] = 1;
		weightValue[1] = 3;
		weightValue[2] = 5;
		weightValue[3] = 7;
		weightValue[4] = 11;
		weightValue[5] = 2;
		weightValue[6] = 13;
		weightValue[7] = 1;
		weightValue[8] = 1;
		weightValue[9] = 17;
		weightValue[10] = 19;
		weightValue[11] = 97;
		weightValue[12] = 23;
		weightValue[13] = 29;
		for (int j = 0; j < 14; j++)
		{
			if (financecode[j] >= 65 && financecode[j] <= 90)
				checkValue[j] = (financecode[j] - 65) + 10;
			else
			if (financecode[j] >= 48 && financecode[j] <= 57)
				checkValue[j] = financecode[j] - 48;
			else
				return false;
			totalValue += weightValue[j] * checkValue[j];
		}

		c = 1 + totalValue % 97;
		int val = (financecode[14] - 48) * 10 + (financecode[15] - 48);
		return val == c;
	}
}
