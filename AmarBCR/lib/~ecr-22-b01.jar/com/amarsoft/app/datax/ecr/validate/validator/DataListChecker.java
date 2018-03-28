// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DataListChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.util.HashSet;
import java.util.StringTokenizer;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class DataListChecker extends AbstractFieldChecker
{

	public DataListChecker()
	{
	}

	public boolean getCheckResult()
	{
		HashSet dataSet = new HashSet();
		String checkedValue = checkRule.getCheckedValue();
		String dataList = checkRule.getDataList();
		if (checkedValue == null || checkedValue.trim() == "")
			return false;
		if (dataList == null)
			return false;
		StringTokenizer token = new StringTokenizer(dataList, ";");
		dataSet.clear();
		String strToken = "";
		for (; token.hasMoreTokens(); dataSet.add(strToken))
			strToken = token.nextToken().trim();

		checkedValue = checkedValue.trim();
		int p = 0;
		int checkedValueSize = checkedValue.length();
		int iterateLength = checkRule.getIterateLength();
		if (iterateLength < 1 || iterateLength > checkedValueSize)
			iterateLength = checkedValueSize;
		for (; p < checkedValueSize; p += iterateLength)
		{
			String c = checkedValue.substring(p, p + iterateLength);
			if (!dataSet.contains(c))
				return false;
		}

		return true;
	}
}
