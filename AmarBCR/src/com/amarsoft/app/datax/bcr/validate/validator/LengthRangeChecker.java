package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.io.PrintStream;

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
