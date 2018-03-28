package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.util.regex.Pattern;

public class MoneyChecker extends AbstractFieldChecker
{

	public MoneyChecker()
	{
	}

	public boolean getCheckResult()
	{
		String money = checkRule.getCheckedValue();
		return checkMoney(money);
	}

	public boolean checkMoney(String money)
	{
		boolean checkOk = Pattern.matches("\\x2d?\\d+\\x2e?\\d* *", money);
		return checkOk;
	}
}
