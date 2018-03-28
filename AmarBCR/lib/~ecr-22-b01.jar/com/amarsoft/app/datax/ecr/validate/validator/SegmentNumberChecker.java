// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SegmentNumberChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.message.Record;
import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import java.math.BigInteger;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class SegmentNumberChecker extends AbstractFieldChecker
{

	public SegmentNumberChecker()
	{
	}

	public boolean getCheckResult()
	{
		com.amarsoft.app.datax.ecr.message.Segment sgCheckedValue[] = checkRule.getRecord().getSegments(checkRule.getCheckedFieldName());
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
