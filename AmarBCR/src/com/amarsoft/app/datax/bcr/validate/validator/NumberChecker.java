package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.math.BigInteger;

public class NumberChecker extends AbstractFieldChecker
{

	public NumberChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		String StrictLevel = checkRule.getStrictLevel();
		if (checkedValue == null || checkedValue.trim() == "")
			return false;
		checkedValue = checkedValue.trim();
		try
		{
			if (StrictLevel != null && StrictLevel.equals("1"))
			{
				if (checkedValue.startsWith("+") || checkedValue.startsWith("-"))
					new Integer(checkedValue.substring(1));
				else
					new Integer(checkedValue);
			} else
			{
				new BigInteger(checkedValue);
			}
		}
		catch (Exception e)
		{
			return false;
		}
		return true;
	}
}
