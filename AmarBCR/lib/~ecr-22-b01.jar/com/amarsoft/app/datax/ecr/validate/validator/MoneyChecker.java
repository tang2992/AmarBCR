// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MoneyChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.util.regex.Pattern;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class MoneyChecker extends AbstractFieldChecker
{

	public MoneyChecker()
	{
	}

	public boolean getCheckResult()
	{
		String money = checkRule.getCheckedValue();
		return checkMoney(money);
	}

	public boolean checkMoney(String money)
	{
		boolean checkOk = Pattern.matches("\\x2d?\\d+\\x2e?\\d* *", money);
		return checkOk;
	}
}
