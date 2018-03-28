package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
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
			String conf = (new StringBuilder(String.valueOf(ARE.getProperty("BCR_HOME")))).append("/etc/dic.xml").toString();
			ARE.getLog().debug((new StringBuilder("Initiallize DicUtil use: ")).append(conf).toString());
			DicUtil.initDicUtil(conf);
		}
		catch (ConfigurationException e)
		{
			ARE.getLog().debug(e);
		}
	}
}
