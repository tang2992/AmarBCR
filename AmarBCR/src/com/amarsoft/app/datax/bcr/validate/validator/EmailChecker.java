package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.util.regex.Pattern;

public class EmailChecker extends AbstractFieldChecker
{

	public EmailChecker()
	{
	}

	public boolean getCheckResult()
	{
		String email = checkRule.getCheckedValue();
		return checkEmail(email);
	}

	public boolean checkEmail(String email)
	{
		boolean checkOk = Pattern.matches("\\w+@((\\w+[.]?)+)", email);
		return checkOk;
	}
}
