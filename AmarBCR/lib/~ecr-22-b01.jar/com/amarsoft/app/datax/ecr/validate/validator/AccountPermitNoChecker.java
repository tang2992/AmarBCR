// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   AccountPermitNoChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class AccountPermitNoChecker extends AbstractFieldChecker
{

	public AccountPermitNoChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkAP = checkRule.getCheckedValue();
		if (checkAP.trim().length() != 14)
			return false;
		else
			return checkAccountPermitNo(checkAP.trim());
	}

	public static boolean checkAccountPermitNo(String checkAP)
	{
		String orgCode = checkAP.substring(0, 1);
		if (!"J".equals(orgCode))
		{
			return false;
		} else
		{
			Pattern p = Pattern.compile("[0-9]*");
			boolean isNum = p.matcher(checkAP.substring(1, 14)).matches();
			return isNum;
		}
	}
}
