package com.amarsoft.app.datax.bcr.validate.validator;

import com.amarsoft.app.datax.bcr.validate.ValidateRule;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PersonIDChecker extends AbstractFieldChecker
{

	private static final int maxDay[] = {
		0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 
		31, 30, 31
	};

	public PersonIDChecker()
	{
	}

	public static boolean personIDChecker(String ID)
	{
		String checkedValue = ID;
		if (checkedValue == null)
			return false;
		checkedValue = checkedValue.trim();
		if (checkedValue.length() != 15 && checkedValue.length() != 18)
			return false;
		String sCheckNum;
		if (checkedValue.length() == 15)
			sCheckNum = checkedValue;
		else
			sCheckNum = checkedValue.substring(0, checkedValue.length() - 1);
		Pattern p = Pattern.compile("[^0-9]");
		Matcher m = p.matcher(sCheckNum);
		if (m.find())
			return false;
		String dateValue;
		if (checkedValue.length() == 15)
			dateValue = (new StringBuilder("19")).append(checkedValue.substring(6, 12)).toString();
		else
			dateValue = checkedValue.substring(6, 14);
		if (!checkDate(dateValue))
			return false;
		if (checkedValue.length() == 18)
			return checkPersonId(checkedValue);
		else
			return true;
	}

	public static boolean checkDate(String sDate)
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
			ARE.getLog().error(checkedDate, e);
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
				ARE.getLog().error(checkedDate, e);
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

	private static boolean checkPersonId(String personId)
	{
		personId = personId.trim();
		String strJiaoYan[] = {
			"1", "0", "X", "9", "8", "7", "6", "5", "4", "3", 
			"2"
		};
		int intQuan[] = {
			7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 
			7, 9, 10, 5, 8, 4, 2, 1
		};
		int intTemp = 0;
		String dateValue = personId.substring(6, 14);
		SimpleDateFormat Simplefmt = new SimpleDateFormat("yyyyMMdd");
		ParsePosition pos = new ParsePosition(0);
		Date dtime = Simplefmt.parse(dateValue, pos);
		if (dtime == null)
			return false;
		for (int i = 0; i < personId.length() - 1; i++)
			try
			{
				intTemp += Integer.parseInt(personId.substring(i, i + 1)) * intQuan[i];
			}
			catch (NumberFormatException ex)
			{
				return false;
			}

		intTemp %= 11;
		return personId.substring(personId.length() - 1).equals(strJiaoYan[intTemp]);
	}

	public boolean getCheckResult()
	{
		String checkedValue = checkRule.getCheckedValue();
		return personIDChecker(checkedValue);
	}

}
