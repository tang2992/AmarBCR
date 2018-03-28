package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AccountPermitNoChecker extends AbstractFieldChecker
{

	public AccountPermitNoChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkAP = checkRule.getCheckedValue();
		if (checkAP.trim().length() != 14)
			return false;
		else
			return checkAccountPermitNo(checkAP.trim());
	}

	public static boolean checkAccountPermitNo(String checkAP)
	{
		String orgCode = checkAP.substring(0, 1);
		if (!"J".equals(orgCode))
		{
			return false;
		} else
		{
			Pattern p = Pattern.compile("[0-9]*");
			boolean isNum = p.matcher(checkAP.substring(1, 14)).matches();
			return isNum;
		}
	}
}
