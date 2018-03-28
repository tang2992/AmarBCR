// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   PostCodeChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class PostCodeChecker extends AbstractFieldChecker
{

	public PostCodeChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		String StrictLevel = checkRule.getStrictLevel();
		if (checkedValue == null || checkedValue.trim() == "" || checkedValue.trim().length() != 6)
			return false;
		checkedValue = checkedValue.trim();
		if (StrictLevel != null && StrictLevel.equals("0") && checkedValue.equals("000000"))
			return true;
		int checkValue = 0;
		try
		{
			checkValue = Integer.parseInt(checkedValue);
		}
		catch (NumberFormatException ex)
		{
			return false;
		}
		return checkValue >= 1 && checkValue <= 0xf423f;
	}
}
