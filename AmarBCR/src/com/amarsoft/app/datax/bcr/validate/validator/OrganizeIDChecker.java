package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.common.OrganizeCodeChecker;
import com.amarsoft.app.datax.bcr.validate.ValidateRule;

public class OrganizeIDChecker extends AbstractFieldChecker
{

	public OrganizeIDChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		return OrganizeCodeChecker.organizeCodeCheck(checkedValue);
	}
}
