// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DataEqualChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.math.BigDecimal;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class DataEqualChecker extends AbstractFieldChecker
{

	public DataEqualChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		String dataList = checkRule.getDataList();
		String CompareWay = checkRule.getCompareWay();
		if (checkedValue == null || checkedValue.trim() == "")
			return false;
		if (CompareWay == null || !CompareWay.trim().equals("number"))
			return checkedValue.equals(dataList);
		double value1 = (new BigDecimal(checkedValue.trim())).doubleValue();
		double value2 = (new BigDecimal(dataList.trim())).doubleValue();
		return Math.abs(value1 - value2) <= 9.9999999999999995E-007D;
	}
}
