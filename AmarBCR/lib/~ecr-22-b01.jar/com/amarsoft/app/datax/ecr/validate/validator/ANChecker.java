// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ANChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.util.regex.Pattern;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class ANChecker extends AbstractFieldChecker
{

	public ANChecker()
	{
	}

	public boolean getCheckResult()
	{
		String string = checkRule.getCheckedValue();
		return checkAN(string);
	}

	public boolean checkAN(String string)
	{
		boolean checkOk = Pattern.matches("[ -~]+", string);
		return checkOk;
	}
}
