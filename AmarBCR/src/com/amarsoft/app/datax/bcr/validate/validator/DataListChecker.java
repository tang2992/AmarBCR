package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.util.HashSet;
import java.util.StringTokenizer;

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
