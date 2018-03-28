// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DataChangeChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class DataChangeChecker extends AbstractFieldChecker
{

	public DataChangeChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		String dataStartValue = checkRule.getDataStartValue();
		String dataEndValue = checkRule.getDataEndValue();
		String dataList = checkRule.getDataList();
		if (dataList.equals("2") && (dataStartValue == null || dataStartValue.trim().equals("")) && (checkedValue == null || checkedValue.trim().equals("")))
			return false;
		return !dataList.equals("3") || checkedValue != null && !checkedValue.trim().equals("") || dataStartValue != null && !dataStartValue.trim().equals("") || dataEndValue != null && !dataEndValue.trim().equals("");
	}
}
