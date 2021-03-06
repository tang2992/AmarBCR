package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.math.BigDecimal;

public class DataRangeChecker extends AbstractFieldChecker
{

	public DataRangeChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		String dataStartValue = checkRule.getDataStartValue();
		String dataEndValue = checkRule.getDataEndValue();
		if (checkedValue == null || checkedValue.trim().equals(""))
			return false;
		long checkValue2;
		try
		{
			if (dataStartValue == null || dataStartValue.trim().equals(""))
				checkValue2 = 0x8000000000000000L;
			else
				checkValue2 = (new BigDecimal(dataStartValue.trim())).longValue();
		}
		catch (Exception e)
		{
			ARE.getLog().debug((new StringBuilder("startValue=")).append(dataStartValue).append("[").append(checkRule.getName()).append("]").toString(), e);
			return false;
		}
		long checkValue3;
		try
		{
			if (dataEndValue == null || dataEndValue.trim().equals(""))
				checkValue3 = 0x7fffffffffffffffL;
			else
				checkValue3 = (new BigDecimal(dataEndValue.trim())).longValue();
		}
		catch (Exception e)
		{
			ARE.getLog().debug((new StringBuilder("endValue=")).append(dataEndValue).append("[").append(checkRule.getName()).append("]").toString(), e);
			return false;
		}
		long checkValue1;
		try
		{
			checkValue1 = (new BigDecimal(checkedValue.trim())).longValue();
		}
		catch (Exception e)
		{
			ARE.getLog().debug((new StringBuilder("checkValue=")).append(checkedValue).append("[").append(checkRule.getName()).append("]").toString(), e);
			return false;
		}
		return checkValue1 >= checkValue2 && checkValue1 <= checkValue3;
	}
}
