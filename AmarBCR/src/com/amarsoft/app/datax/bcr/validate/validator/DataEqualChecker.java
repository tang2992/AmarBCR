package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.math.BigDecimal;

public class DataEqualChecker extends AbstractFieldChecker
{

	public DataEqualChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		String dataList = checkRule.getDataList();
		String CompareWay = checkRule.getCompareWay();
		if (checkedValue == null || checkedValue.trim() == "")
			return false;
		if (CompareWay == null || !CompareWay.trim().equals("number"))
			return checkedValue.equals(dataList);
		double value1 = (new BigDecimal(checkedValue.trim())).doubleValue();
		double value2 = (new BigDecimal(dataList.trim())).doubleValue();
		return Math.abs(value1 - value2) <= 9.9999999999999995E-007D;
	}
}
