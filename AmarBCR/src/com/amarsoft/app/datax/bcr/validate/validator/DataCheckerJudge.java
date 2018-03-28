package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;

public class DataCheckerJudge extends AbstractFieldChecker
{

	public DataCheckerJudge()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		String dataStartValue = checkRule.getDataStartValue();
		if ((checkedValue == null || checkedValue.trim() == "") && (dataStartValue == null || dataStartValue.trim() == ""))
			return true;
		return checkedValue != null && checkedValue.trim() != "" && dataStartValue != null && dataStartValue.trim() != "";
	}
}
