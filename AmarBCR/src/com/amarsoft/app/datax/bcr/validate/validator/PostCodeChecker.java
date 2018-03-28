package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;

public class PostCodeChecker extends AbstractFieldChecker
{

	public PostCodeChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		String StrictLevel = checkRule.getStrictLevel();
		if (checkedValue == null || checkedValue.trim() == "" || checkedValue.trim().length() != 6)
			return false;
		checkedValue = checkedValue.trim();
		if (StrictLevel != null && StrictLevel.equals("0") && checkedValue.equals("000000"))
			return true;
		int checkValue = 0;
		try
		{
			checkValue = Integer.parseInt(checkedValue);
		}
		catch (NumberFormatException ex)
		{
			return false;
		}
		return checkValue >= 1 && checkValue <= 0xf423f;
	}
}
