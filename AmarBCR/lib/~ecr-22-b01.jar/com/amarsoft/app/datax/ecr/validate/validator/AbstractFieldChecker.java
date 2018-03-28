// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   AbstractFieldChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;

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
