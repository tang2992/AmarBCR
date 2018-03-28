// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DICChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.cfcc.ecus.eft.util.ConfigurationException;
import com.cfcc.ecus.eft.util.DicUtil;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class DICChecker extends AbstractFieldChecker
{

	public DICChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue().trim();
		String dataList = checkRule.getDataList();
		if (checkedValue == null || checkedValue.equals(""))
			return false;
		else
			return DicUtil.checkDic(dataList, checkedValue);
	}

	static 
	{
		try
		{
			String conf = (new StringBuilder(String.valueOf(ARE.getProperty("ECR_HOME")))).append("/etc/dic.xml").toString();
			ARE.getLog().debug((new StringBuilder("Initiallize DicUtil use: ")).append(conf).toString());
			DicUtil.initDicUtil(conf);
		}
		catch (ConfigurationException e)
		{
			ARE.getLog().debug(e);
		}
	}
}
