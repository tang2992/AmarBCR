// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   EmailChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.util.regex.Pattern;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class EmailChecker extends AbstractFieldChecker
{

	public EmailChecker()
	{
	}

	public boolean getCheckResult()
	{
		String email = checkRule.getCheckedValue();
		return checkEmail(email);
	}

	public boolean checkEmail(String email)
	{
		boolean checkOk = Pattern.matches("\\w+@((\\w+[.]?)+)", email);
		return checkOk;
	}
}
