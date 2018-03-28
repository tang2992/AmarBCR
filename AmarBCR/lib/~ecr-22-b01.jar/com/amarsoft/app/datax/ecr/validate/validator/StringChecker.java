// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   StringChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class StringChecker extends AbstractFieldChecker
{

	public StringChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		if (checkedValue == null)
			return false;
		byte checkedByte[] = checkedValue.getBytes();
		for (int i = 0; i < checkedByte.length; i++)
		{
			byte tByte = checkedByte[i];
			if (tByte >= 128 || tByte <= 0)
				return false;
		}

		return true;
	}
}
