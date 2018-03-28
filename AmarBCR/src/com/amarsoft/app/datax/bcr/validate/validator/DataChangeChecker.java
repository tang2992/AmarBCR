package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;

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
