// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   LengthRangeChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.io.PrintStream;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class LengthRangeChecker extends AbstractFieldChecker
{

	public LengthRangeChecker()
	{
	}

	public static void main(String args[])
	{
		LengthRangeChecker lr = new LengthRangeChecker();
		System.out.println(lr.getCheckResult());
	}

	public boolean getCheckResult()
	{
		String sCheckValue = checkRule.getCheckedValue();
		int minLength = Integer.parseInt(checkRule.getDataStartValue());
		int maxLength = Integer.parseInt(checkRule.getDataEndValue());
		return checkLengthRange(sCheckValue, minLength, maxLength);
	}

	public static boolean checkLengthRange(String sCheckValue, int minLength, int maxLength)
	{
		return sCheckValue.trim().getBytes().length >= minLength && sCheckValue.trim().getBytes().length <= maxLength;
	}
}
