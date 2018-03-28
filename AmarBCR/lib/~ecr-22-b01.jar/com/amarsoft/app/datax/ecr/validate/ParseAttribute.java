// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ParseAttribute.java

package com.amarsoft.app.datax.ecr.validate;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Calculator;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.StringTokenizer;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate:
//			ValidateRule

public class ParseAttribute
{

	protected static ValidateRule parseValidateRule = null;

	public ParseAttribute()
	{
	}

	public static String[] splitString(String valueString, String separator)
	{
		StringTokenizer strToken = new StringTokenizer(valueString, separator);
		String splitedString[] = new String[strToken.countTokens()];
		for (int i = 0; i < splitedString.length; i++)
			splitedString[i] = strToken.nextToken().trim();

		return splitedString;
	}

	public static String[] valueToValue(String originalValues[])
	{
		String realValue[] = new String[originalValues.length];
		String tempString[] = originalValues;
		for (int i = 0; i < tempString.length; i++)
			realValue[i] = valueToValue(tempString[i]);

		return realValue;
	}

	public static String valueToValue(String originalValue)
	{
		String realValue = "";
		String tempString = originalValue;
		if (isExpression(tempString))
			realValue = getExpressionResult(splitExpression(tempString));
		else
		if (isQuoter(tempString))
		{
			tempString = clearValue(tempString);
			if (quoterLevel(tempString).equalsIgnoreCase("Record"))
				realValue = parseRecord(tempString);
			else
			if (quoterLevel(tempString).equalsIgnoreCase("Segment"))
				realValue = parseSegment(tempString);
			else
				realValue = tempString;
		} else
		{
			realValue = tempString;
		}
		return realValue;
	}

	public static boolean isList(String valueUnit)
	{
		boolean list = true;
		if (valueUnit.indexOf(";") >= 0)
			list = true;
		else
			list = false;
		return list;
	}

	public static boolean isExpression(String valueUnit)
	{
		boolean expression = true;
		if (valueUnit.length() >= 3 && (valueUnit.indexOf("+") >= 0 || valueUnit.indexOf("-") >= 0 || valueUnit.indexOf("*") >= 0 || valueUnit.indexOf("/") >= 0))
			expression = true;
		else
			expression = false;
		return expression;
	}

	public static String[] splitExpression(String valueUnit)
	{
		String splitedexpression[] = null;
		String tempString = valueUnit;
		tempString = replace(tempString, "+", ";+;");
		tempString = replace(tempString, "-", ";-;");
		tempString = replace(tempString, "*", ";*;");
		tempString = replace(tempString, "/", ";/;");
		splitedexpression = splitString(tempString, ";");
		return splitedexpression;
	}

	public static String getExpressionResult(String splitedExpression[])
	{
		String expressionResult = "";
		String arTempResult[] = null;
		String tempResult = "";
		if (splitedExpression != null && splitedExpression.length >= 3)
		{
			arTempResult = valueToValue(splitedExpression);
			tempResult = uniteString(arTempResult, "");
			String realData = transferData(tempResult);
			expressionResult = Calculator.compute(realData);
		} else
		{
			expressionResult = "Can't compute!!!";
		}
		return expressionResult;
	}

	public static boolean isQuoter(String valueUnit)
	{
		boolean quoter = true;
		if (valueUnit.indexOf("{") >= 0)
			quoter = true;
		else
			quoter = false;
		return quoter;
	}

	public static String quoterLevel(String valueUnit)
	{
		String quoterLevel = "";
		if (valueUnit.indexOf(".") >= 0)
			quoterLevel = "Record";
		else
			quoterLevel = "Segment";
		valueUnit.indexOf(".");
		return quoterLevel;
	}

	public static String parseSegment(String originalValue)
	{
		String realValue = "";
		String tempString = "";
		tempString = replace(originalValue, "$", "").trim();
		String segmentField = tempString;
		Field f = null;
		Segment s = parseValidateRule.getSegment();
		f = s != null ? s.getField(segmentField) : null;
		if (f != null)
			try
			{
				realValue = f.getTextValue();
			}
			catch (ECRException e)
			{
				ARE.getLog().debug(e);
				realValue = "";
			}
		else
		if (segmentField.equalsIgnoreCase("SystemDate"))
			try
			{
				realValue = (new SimpleDateFormat("yyyyMMddHHmmss")).format(new Date());
			}
			catch (Exception e)
			{
				ARE.getLog().fatal("", e);
			}
		else
		if (!segmentField.equalsIgnoreCase("FileName"))
			segmentField.equalsIgnoreCase("DataYearMonth");
		return realValue;
	}

	public static String parseRecord(String originalValue)
	{
		String realValue = "";
		String tempString = "";
		tempString = replace(originalValue, "$", "").trim();
		String recordField[] = splitString(tempString, ".");
		try
		{
			realValue = parseValidateRule.getRecord().getFirstSegment(recordField[0]).getField(recordField[1]).getTextValue();
		}
		catch (ECRException e)
		{
			ARE.getLog().debug((new StringBuilder("½âÎöRecord³ö´í£º")).append(recordField[0]).append("|").append(recordField[1]).toString(), e);
			realValue = "";
		}
		return realValue;
	}

	public static String replace(String originalValue, String oldStr, String newStr)
	{
		String replacedString = originalValue;
		int iCount = 1;
		for (int i = replacedString.indexOf(oldStr, 0); i != -1; i = replacedString.indexOf(oldStr, i + newStr.length()))
		{
			replacedString = (new StringBuilder(String.valueOf(replacedString.substring(0, i)))).append(newStr).append(replacedString.substring(i + oldStr.length())).toString();
			iCount++;
		}

		return replacedString;
	}

	public static String clearValue(String originalValue)
	{
		String clearedValue = originalValue;
		clearedValue = replace(clearedValue, "{", "");
		clearedValue = replace(clearedValue, "}", "");
		clearedValue = replace(clearedValue, "$", "");
		clearedValue = clearedValue.trim();
		return clearedValue;
	}

	public static String uniteString(String splitedString[], String separator)
	{
		String unitedString = "";
		int tokenCount = splitedString.length;
		for (int i = 0; i < tokenCount; i++)
			if (tokenCount - i == 1)
				unitedString = (new StringBuilder(String.valueOf(unitedString))).append(splitedString[i]).toString();
			else
				unitedString = (new StringBuilder(String.valueOf(unitedString))).append(splitedString[i]).append(separator).toString();

		return unitedString;
	}

	public static String transferData(String tempResult)
	{
		String realData = tempResult;
		if (realData.indexOf("-") == 0)
			realData = (new StringBuilder("0")).append(realData).toString();
		if (realData.indexOf("--") >= 0)
			realData = realData.replaceAll("--", "+");
		if (realData.indexOf("+-") >= 0)
			realData = realData.replaceAll("\\+-", "-");
		return realData;
	}

	public static String getRealValue(ValidateRule validateRule, String originalValue)
	{
		if (originalValue == null)
			return null;
		parseValidateRule = validateRule;
		String realValue = "";
		String tempValue[] = null;
		if (isList(originalValue))
		{
			tempValue = splitString(originalValue, ";");
			tempValue = valueToValue(tempValue);
			realValue = uniteString(tempValue, ";");
		} else
		{
			realValue = valueToValue(originalValue);
		}
		return realValue;
	}

	public static String getCheckedValue(ValidateRule validateRule, String originalValue)
	{
		if (originalValue == null)
			return "";
		parseValidateRule = validateRule;
		String realValue = "";
		String tempString = originalValue;
		if (isExpression(tempString))
			realValue = getExpressionResult(splitExpression(tempString));
		else
		if (isQuoter(tempString))
		{
			tempString = clearValue(tempString);
			if (quoterLevel(tempString).equalsIgnoreCase("Record"))
				realValue = parseRecord(tempString);
			else
			if (quoterLevel(tempString).equalsIgnoreCase("Segment"))
				realValue = parseSegment(tempString);
			else
				realValue = parseSegment(tempString);
		} else
		{
			realValue = parseSegment(tempString);
		}
		return realValue;
	}

}
