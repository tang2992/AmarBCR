package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.message.Record;
import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import java.math.BigInteger;

public class SegmentNumberChecker extends AbstractFieldChecker
{

	public SegmentNumberChecker()
	{
	}

	public boolean getCheckResult()
	{
		com.amarsoft.app.datax.bcr.message.Segment sgCheckedValue[] = checkRule.getRecord().getSegments(checkRule.getCheckedFieldName());
		String checkedValue = String.valueOf(sgCheckedValue != null ? sgCheckedValue.length : 0);
		String dataStartValue = checkRule.getDataStartValue();
		String dataEndValue = checkRule.getDataEndValue();
		long checkValue2;
		if (dataStartValue == null)
			checkValue2 = 0x8000000000000000L;
		else
			checkValue2 = (new BigInteger(dataStartValue.trim())).longValue();
		long checkValue3;
		if (dataEndValue == null)
			checkValue3 = 0x7fffffffffffffffL;
		else
			checkValue3 = (new BigInteger(dataEndValue.trim())).longValue();
		long checkValue1 = (new BigInteger(checkedValue.trim())).longValue();
		return checkValue1 >= checkValue2 && checkValue1 <= checkValue3;
	}
}
