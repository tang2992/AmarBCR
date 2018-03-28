package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;

public abstract class AbstractFieldChecker
{

	protected ValidateRule checkRule;

	public AbstractFieldChecker()
	{
		checkRule = null;
	}

	public void init(ValidateRule theRule)
	{
		checkRule = theRule;
	}

	public abstract boolean getCheckResult();
}
