package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;

public class NullChecker extends AbstractFieldChecker
{

	public NullChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		System.out.print(checkedValue.trim().length());
		return checkedValue != null && checkedValue.trim().length() != 0;
		
	}
}
