// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   OrganizeIDChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.common.OrganizeCodeChecker;
import com.amarsoft.app.datax.ecr.validate.ValidateRule;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class OrganizeIDChecker extends AbstractFieldChecker
{

	public OrganizeIDChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		return OrganizeCodeChecker.organizeCodeCheck(checkedValue);
	}
}
