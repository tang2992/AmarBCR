package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class DateTimeChecker extends AbstractFieldChecker
{

	private static final int maxDay[] = {
		0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 
		31, 30, 31
	};

	public DateTimeChecker()
	{
	}

	public boolean getCheckResult()
	{
		String checkedDate = checkRule.getCheckedValue();
		return checkDate(checkedDate, checkRule);
	}

	public static boolean checkDate(String sDate, ValidateRule checkRule)
	{
		String checkedDate = sDate;
		if (checkedDate == null)
			return false;
		checkedDate = checkedDate.trim();
		if (checkedDate.length() != 8 && checkedDate.length() != 14)
			return false;
		int year;
		int month;
		int day;
		try
		{
			year = Integer.parseInt(checkedDate.substring(0, 4).trim());
			month = Integer.parseInt(checkedDate.substring(4, 6).trim());
			day = Integer.parseInt(checkedDate.substring(6, 8).trim());
		}
		catch (Exception e)
		{
			ARE.getLog().error((new StringBuilder("checkValue=")).append(checkedDate).append("[").append(checkRule.getName()).append("]").toString(), e);
			return false;
		}
		if (year < 1900)
			return false;
		if (month < 1 || month > 12)
			return false;
		if (day > maxDay[month] || day == 0)
			return false;
		if (day == 29 && month == 2 && (year % 4 != 0 || year % 100 == 0) && (year % 4 != 0 || year % 400 != 0))
			return false;
		if (checkedDate.length() == 14)
		{
			int hour;
			int miniute;
			int second;
			try
			{
				hour = Integer.parseInt(checkedDate.substring(8, 10));
				miniute = Integer.parseInt(checkedDate.substring(10, 12));
				second = Integer.parseInt(checkedDate.substring(12, 14));
			}
			catch (Exception e)
			{
				ARE.getLog().error((new StringBuilder("checkValue=")).append(checkedDate).append("[").append(checkRule.getName()).append("]").toString(), e);
				return false;
			}
			if (hour > 23 || hour < 0)
				return false;
			if (miniute > 59 || miniute < 0)
				return false;
			if (second > 59 || second < 0)
				return false;
		}
		return true;
	}

}
