package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.util.regex.Pattern;

public class ANChecker extends AbstractFieldChecker
{

	public ANChecker()
	{
	}

	public boolean getCheckResult()
	{
		String string = checkRule.getCheckedValue();
		return checkAN(string);
	}

	public boolean checkAN(String string)
	{
		boolean checkOk = Pattern.matches("[ -~]+", string);
		return checkOk;
	}
}
