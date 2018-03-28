package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;

public class StringChecker extends AbstractFieldChecker
{

	public StringChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		if (checkedValue == null)
			return false;
		byte checkedByte[] = checkedValue.getBytes();
		for (int i = 0; i < checkedByte.length; i++)
		{
			byte tByte = checkedByte[i];
			if (tByte >= 128 || tByte <= 0)
				return false;
		}

		return true;
	}
}
