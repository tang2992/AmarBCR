// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   NumberChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.math.BigInteger;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class NumberChecker extends AbstractFieldChecker
{

	public NumberChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		String StrictLevel = checkRule.getStrictLevel();
		if (checkedValue == null || checkedValue.trim() == "")
			return false;
		checkedValue = checkedValue.trim();
		try
		{
			if (StrictLevel != null && StrictLevel.equals("1"))
			{
				if (checkedValue.startsWith("+") || checkedValue.startsWith("-"))
					new Integer(checkedValue.substring(1));
				else
					new Integer(checkedValue);
			} else
			{
				new BigInteger(checkedValue);
			}
		}
		catch (Exception e)
		{
			return false;
		}
		return true;
	}
}
