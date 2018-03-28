package com.amarsoft.app.datax.bcr.common;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.io.File;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class Tools
{

	private static String loanEncoding = "GBK";
	private static String ecrEncoding = "GBK";
	private static boolean encodingConvert = false;
	private static SimpleDateFormat dateFormat = null;

	public Tools()
	{
	}

	public static int MoneyCompare(double d1, double d2)
	{
		if (Math.abs(d1 - d2) < 0.0050000000000000001D)
			return 0;
		return d1 - d2 <= 0.0050000000000000001D ? -1 : 1;
	}

	public static void setDataBaseEncoding(String loan, String ecr)
	{
		loanEncoding = loan;
		ecrEncoding = ecr;
		if (loanEncoding == null || ecrEncoding == null)
			encodingConvert = false;
		else
			try
			{
				String testchar = "±àÂë²âÊÔ-123-öÎ";
				byte l[] = testchar.getBytes(loanEncoding);
				byte e[] = testchar.getBytes(ecrEncoding);
				encodingConvert = !Arrays.equals(l, e);
			}
			catch (UnsupportedEncodingException e)
			{
				ARE.getLog().warn("×Ö·û±àÂë²»Ö§³Ö", e);
				encodingConvert = false;
			}
	}

	public static String handleDate(String sDate, String flag)
	{
		if (sDate == null || sDate.trim().equals("") || sDate.length() != 8 && sDate.length() != 10)
			return "";
		sDate = sDate.replace('|', ' ').trim();
		if (flag.equals("0") && sDate.length() == 8)
			return (new StringBuilder(String.valueOf(sDate.substring(0, 4)))).append("/").append(sDate.substring(4, 6)).append("/").append(sDate.substring(6, 8)).toString();
		if (flag.equals("0") && sDate.length() == 10)
			return (new StringBuilder(String.valueOf(sDate.substring(0, 4)))).append("/").append(sDate.substring(5, 7)).append("/").append(sDate.substring(8, 10)).toString();
		if (flag.equals("1") && sDate.length() == 10)
			return (new StringBuilder(String.valueOf(sDate.substring(0, 4)))).append(sDate.substring(5, 7)).append(sDate.substring(8, 10)).toString();
		if (flag.equals("2") && sDate.length() == 8)
			return (new StringBuilder(String.valueOf(sDate.substring(0, 4)))).append("/").append(sDate.substring(4, 6)).toString();
		if (flag.equals("2") && sDate.length() == 10)
			return sDate.substring(0, 7);
		if (flag.equals("3") && sDate.length() == 8)
			return sDate.substring(0, 6);
		if (flag.equals("3") && sDate.length() == 10)
			return (new StringBuilder(String.valueOf(sDate.substring(0, 4)))).append(sDate.substring(5, 7)).toString();
		else
			return sDate;
	}

	public static String getCurrentDay(String flag)
	{
		String prev = (new Date(System.currentTimeMillis())).toString().trim();
		if (flag.equals("0"))
			prev = (new StringBuilder(String.valueOf(prev.substring(0, 4)))).append(prev.substring(5, 7)).append(prev.substring(8, 10)).toString();
		else
		if (flag.equals("1"))
			prev = (new StringBuilder(String.valueOf(prev.substring(0, 4)))).append("/").append(prev.substring(5, 7)).append("/").append(prev.substring(8, 10)).toString();
		else
			prev = (new StringBuilder(String.valueOf(prev.substring(5, 7)))).append(prev.substring(8, 10)).toString();
		return prev;
	}

	public static String getAssignedDay(String sCurDate, int assignedDay, String flag)
	{
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		try
		{
			calendar.setTime(formatter.parse(sCurDate));
		}
		catch (Exception exception) { }
		calendar.add(5, assignedDay);
		String sTempDate = "";
		String sMouth = (new StringBuilder()).append(calendar.get(2) + 1).toString();
		String sDay = (new StringBuilder()).append(calendar.get(5)).toString();
		if (sMouth.length() == 1)
			sMouth = (new StringBuilder("0")).append(sMouth).toString();
		if (sDay.length() == 1)
			sDay = (new StringBuilder("0")).append(sDay).toString();
		if (flag.equals("0"))
			sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append(sMouth).append(sDay).toString();
		else
		if (flag.equals("1"))
			sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append("/").append(sMouth).append("/").append(sDay).toString();
		return sTempDate;
	}

	public static String getNextDay(String sCurDate, String flag)
	{
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		try
		{
			calendar.setTime(formatter.parse(sCurDate));
		}
		catch (Exception exception) { }
		calendar.add(5, 1);
		String sTempDate = "";
		String sMouth = (new StringBuilder()).append(calendar.get(2) + 1).toString();
		String sDay = (new StringBuilder()).append(calendar.get(5)).toString();
		if (sMouth.length() == 1)
			sMouth = (new StringBuilder("0")).append(sMouth).toString();
		if (sDay.length() == 1)
			sDay = (new StringBuilder("0")).append(sDay).toString();
		if (flag.equals("0"))
			sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append(sMouth).append(sDay).toString();
		else
		if (flag.equals("1"))
			sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append("/").append(sMouth).append("/").append(sDay).toString();
		return sTempDate;
	}

	public static String getLastDay(String flag)
	{
		Calendar calendar = Calendar.getInstance();
		calendar.add(5, -1);
		String sTempDate = "";
		String sMouth = (new StringBuilder()).append(calendar.get(2) + 1).toString();
		String sDay = (new StringBuilder()).append(calendar.get(5)).toString();
		if (sMouth.length() == 1)
			sMouth = (new StringBuilder("0")).append(sMouth).toString();
		if (sDay.length() == 1)
			sDay = (new StringBuilder("0")).append(sDay).toString();
		if (flag.equals("0"))
			sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append(sMouth).append(sDay).toString();
		else
		if (flag.equals("1"))
			sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append("/").append(sMouth).append("/").append(sDay).toString();
		return sTempDate;
	}

	public static String getLastLastDay(String flag)
	{
		Calendar calendar = Calendar.getInstance();
		calendar.add(5, -2);
		String sTempDate = "";
		String sMouth = (new StringBuilder()).append(calendar.get(2) + 1).toString();
		String sDay = (new StringBuilder()).append(calendar.get(5)).toString();
		if (sMouth.length() == 1)
			sMouth = (new StringBuilder("0")).append(sMouth).toString();
		if (sDay.length() == 1)
			sDay = (new StringBuilder("0")).append(sDay).toString();
		if (flag.equals("0"))
			sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append(sMouth).append(sDay).toString();
		else
		if (flag.equals("1"))
			sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append("/").append(sMouth).append("/").append(sDay).toString();
		return sTempDate;
	}

	public static String getCurrentMonth()
	{
		Calendar calendar = Calendar.getInstance();
		String sTempDate = "";
		String sMouth = (new StringBuilder()).append(calendar.get(2) + 1).toString();
		if (sMouth.length() == 1)
			sMouth = (new StringBuilder("0")).append(sMouth).toString();
		sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append("/").append(sMouth).toString();
		return sTempDate;
	}

	public static String getLastMonth(int i)
	{
		Calendar calendar = Calendar.getInstance();
		if (i == 1)
			calendar.add(2, -1);
		else
			calendar.add(5, -1);
		String sTempDate = "";
		String sMouth = (new StringBuilder()).append(calendar.get(2) + 1).toString();
		if (sMouth.length() == 1)
			sMouth = (new StringBuilder("0")).append(sMouth).toString();
		sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append("/").append(sMouth).toString();
		return sTempDate;
	}

	public static String getLastLastMonth()
	{
		Calendar calendar = Calendar.getInstance();
		calendar.add(2, -2);
		String sTempDate = "";
		String sMouth = (new StringBuilder()).append(calendar.get(2) + 1).toString();
		if (sMouth.length() == 1)
			sMouth = (new StringBuilder("0")).append(sMouth).toString();
		sTempDate = (new StringBuilder(String.valueOf(calendar.get(1)))).append("/").append(sMouth).toString();
		return sTempDate;
	}

	public static String diffMonth(String sDate, int Months)
	{
		if (Months == 0)
			return sDate;
		String sReturnDate = "";
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		try
		{
			cal.setTime(formatter.parse(sDate));
		}
		catch (Exception exception) { }
		cal.add(2, Months);
		sReturnDate = formatter.format(cal.getTime());
		return sReturnDate;
	}

	public static String diffDay(String sDate, int Days)
	{
		if (Days == 0)
			return sDate;
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		try
		{
			cal.setTime(formatter.parse(sDate));
		}
		catch (Exception exception) { }
		cal.add(5, Days);
		return formatter.format(cal.getTime());
	}

	public static String getCurrentYear()
	{
		return getLastMonth(1).substring(0, 4);
	}

	public static String diffYear(String sDate, int Years)
	{
		if (Years == 0)
			return sDate;
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		try
		{
			calendar.setTime(formatter.parse(sDate));
		}
		catch (Exception exception) { }
		calendar.add(1, Years);
		return formatter.format(calendar.getTime());
	}

	public static boolean isFirstDayOfMonth()
	{
		Calendar calendar = Calendar.getInstance();
		String sDay = (new StringBuilder()).append(calendar.get(5)).toString();
		if (sDay.length() == 1)
			sDay = (new StringBuilder("0")).append(sDay).toString();
		return sDay.equals("01");
	}

	public static boolean isFirstDayOfYear()
	{
		if (getLastMonth(1).equals(getLastMonth(2)))
			return getLastMonth(1).substring(5, 7).equals("12");
		else
			return false;
	}

	public static int betweenMonths(String sStartDate, String sEndDate)
	{
		int iMonths = (Integer.parseInt(sEndDate.substring(0, 4)) * 12 + Integer.parseInt(sEndDate.substring(5, 7))) - (Integer.parseInt(sStartDate.substring(0, 4)) * 12 + Integer.parseInt(sStartDate.substring(5, 7)));
		double iDay = (double)(Integer.parseInt(sEndDate.substring(8, 10)) - Integer.parseInt(sStartDate.substring(8, 10))) / 30.420000000000002D;
		if (iDay > 0.0D)
			return iMonths + 1;
		else
			return iMonths;
	}

	public static int betweenMonths2(String sStartDate, String sEndDate)
	{
		int iMonths = (Integer.parseInt(sEndDate.substring(0, 4)) * 12 + Integer.parseInt(sEndDate.substring(5, 7))) - (Integer.parseInt(sStartDate.substring(0, 4)) * 12 + Integer.parseInt(sStartDate.substring(5, 7)));
		return iMonths;
	}

	public static String getDateTime()
	{
		String prev = (new Date(System.currentTimeMillis())).toString().trim();
		String prev1 = (new Time(System.currentTimeMillis())).toString().trim();
		prev = (new StringBuilder(String.valueOf(prev.substring(5, 7)))).append(prev.substring(8, 10)).append(prev1.substring(0, 2)).append(prev1.substring(3, 5)).append(prev1.substring(6, 8)).toString();
		return prev;
	}

	public static int betweenDays(String sStartDate, String sEndDate)
	{
		java.util.Date startDate = Date.valueOf(sStartDate.replace('/', '-'));
		java.util.Date endDate = Date.valueOf(sEndDate.replace('/', '-'));
		int iDays = (int)((endDate.getTime() - startDate.getTime()) / 0x5265c00L);
		return iDays;
	}

	public static String handleTime(String sTime)
	{
		String stmp = "";
		if (sTime == null)
			sTime = "";
		if (sTime.length() == 6)
			stmp = (new StringBuilder(String.valueOf(sTime.substring(0, 2)))).append(":").append(sTime.substring(2, 4)).append(":").append(sTime.substring(4, 6)).toString();
		stmp = stmp.replace('.', ':').trim();
		return stmp;
	}

	public static String getEndDateOfMonth(String sCurDate)
	{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		try
		{
			cal.setTime(formatter.parse(sCurDate));
		}
		catch (Exception exception) { }
		int maxDays = cal.getActualMaximum(5);
		cal.set(5, maxDays);
		return formatter.format(cal.getTime());
	}

	public static String getFristDateOfMonth(String sCurDate)
	{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		try
		{
			cal.setTime(formatter.parse(sCurDate));
		}
		catch (Exception exception) { }
		cal.set(5, 1);
		return formatter.format(cal.getTime());
	}

	public static double getDouble(double d, int num)
	{
		int inum = 1;
		for (int i = 0; i < num; i++)
			inum *= 10;

		double dTmpNum1 = Math.round(d * (double)inum);
		double dTmpNum = dTmpNum1 / (double)inum;
		return dTmpNum;
	}

	public static double getDouble(double d)
	{
		int inum = 10000;
		d /= inum;
		double dTmpNum = Math.round(d);
		return dTmpNum;
	}

	public static String getString(double d)
	{
		int dTmpNum = (int)Math.round(d);
		String sTmpNum = String.valueOf(dTmpNum);
		return sTmpNum;
	}

	public static int handleInt(String sdata)
	{
		sdata = sdata.replace('|', ' ').trim();
		if (sdata == null || sdata.equals(""))
			sdata = "0";
		return Integer.parseInt(sdata);
	}

	public static double handleDouble(String sdata, int i)
	{
		sdata = sdata.replace('|', ' ').trim();
		if (sdata == null || sdata.equals(""))
			sdata = "0.00";
		if (sdata.indexOf(".") == -1)
			sdata = (new StringBuilder(String.valueOf(sdata))).append(".00").toString();
		if (sdata.indexOf(".") == 0)
			sdata = (new StringBuilder("0")).append(sdata).toString();
		sdata = (new StringBuilder(String.valueOf(sdata))).append("000000000000").toString();
		if (i == 0)
			sdata = sdata.substring(0, sdata.indexOf("."));
		else
		if (i < 0)
			sdata = sdata.substring(0, sdata.indexOf("."));
		else
			sdata = sdata.substring(0, sdata.indexOf(".") + 1 + i);
		return Double.parseDouble(sdata);
	}

	public static String leftFill(String sdata, int len, String sFillchar)
	{
		for (int j = 1; j <= len; j++)
			sdata = (new StringBuilder(String.valueOf(sFillchar))).append(sdata).toString();

		return sdata;
	}

	public static String rightFill(String sdata, int len, String sFillchar)
	{
		for (int j = 1; j <= len; j++)
			sdata = (new StringBuilder(String.valueOf(sdata))).append(sFillchar).toString();

		return sdata;
	}

	public static String specifyLengthLeftFill(String sdata, int len, String sFillchar)
	{
		int j = len - sdata.getBytes().length;
		for (int k = 1; k <= j; k++)
			sdata = (new StringBuilder(String.valueOf(sFillchar))).append(sdata).toString();

		if (j < 0)
			sdata = new String(sdata.getBytes(), 0, len);
		return sdata;
	}

	public static String specifyLengthRightFill(String sdata, int len, String sFillchar)
	{
		int j = len - sdata.getBytes().length;
		for (int k = 1; k <= j; k++)
			sdata = (new StringBuilder(String.valueOf(sdata))).append(sFillchar).toString();

		if (j < 0)
			sdata = new String(sdata.getBytes(), 0, len);
		return sdata;
	}

	public static boolean fileExists(String pathFile)
	{
		File file = new File(pathFile);
		boolean flag = file.exists();
		return flag;
	}

	public static String CrtSerialNo(String fixString, int len, String maxNO)
	{
		String tmp = maxNO;
		for (int k = 0; k < len - maxNO.length(); k++)
			tmp = (new StringBuilder("0")).append(tmp).toString();

		return (new StringBuilder(String.valueOf(fixString))).append(tmp).toString();
	}

	public static String handleString(String sString)
	{
		String stmp;
		if (sString == null)
			stmp = "";
		else
			stmp = sString.trim();
		stmp = chiniessConvert(stmp, 2);
		stmp = stmp.replace('\'', ' ').trim();
		stmp = stmp.replace('|', ' ').trim();
		return stmp;
	}

	public static String chiniessConvert(String sString, int iChage)
	{
		try
		{
			if (sString == null)
				sString = "";
			if (iChage == 0)
				sString = new String(sString.getBytes("8859_1"), "gb2312");
			if (iChage == 1)
				sString = new String(sString.getBytes("gb2312"), "8859_1");
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
		return sString;
	}

	public static String formatDate(java.util.Date d, String format)
	{
		if (d == null)
			return "";
		if (dateFormat == null)
			dateFormat = new SimpleDateFormat();
		dateFormat.applyPattern(format);
		return dateFormat.format(d);
	}

	public static String formatDate(java.util.Date d)
	{
		if (d == null)
			return "";
		else
			return formatDate(d, "yyyy/MM/dd");
	}

	public static String subByte(String s, int i2)
		throws UnsupportedEncodingException
	{
		int i1 = 0;
		return subByte(s, i1, i2);
	}

	public static String subByte(String s, int i1, int i2)
		throws UnsupportedEncodingException
	{
		if (s == null || i1 >= i2 || s.getBytes().length < i2 - i1)
			return "";
		byte buffer[] = new byte[i2 - i1];
		for (int i = 0; i < i2 - i1; i++)
			buffer[i] = s.getBytes()[i + i1];

		return new String(buffer, "GB2312");
	}

	public static java.util.Date charToDate(String strDate)
	{
		java.util.Date d = null;
		if (strDate == null || strDate == "")
			return d;
		if (dateFormat == null)
			dateFormat = new SimpleDateFormat();
		dateFormat.applyPattern("yyyy/MM/dd");
		try
		{
			d = dateFormat.parse(strDate);
		}
		catch (ParseException e)
		{
			dateFormat.applyPattern("yyyyMMdd");
			try
			{
				d = dateFormat.parse(strDate);
			}
			catch (ParseException e1)
			{
				dateFormat.applyPattern("yy/MM/dd");
				try
				{
					d = dateFormat.parse(strDate);
				}
				catch (ParseException parseexception) { }
			}
		}
		return d;
	}

	public static String subString(String sourceString, int lengthLimit)
	{
		byte strByte[] = null;
		if (sourceString == null)
			return null;
		if (encodingConvert)
			try
			{
				sourceString = new String(sourceString.getBytes(loanEncoding), ecrEncoding);
			}
			catch (UnsupportedEncodingException unsupportedencodingexception) { }
		sourceString = DBC2SBC(sourceString.replaceAll("[\n\r\t]", ""));
		strByte = sourceString.getBytes();
		if (strByte.length <= lengthLimit)
			return sourceString;
		if (strByte[lengthLimit - 1] < 0)
			return new String(strByte, 0, lengthLimit - 1);
		else
			return new String(strByte, 0, lengthLimit);
	}

	public static String changeID(String s)
    {
        String s1;
        try
        {
            s1 = "";
            if(s == null)
                return "";
        }
        catch(Exception exception)
        {
            return s;
        }
        if(s.length() != 15 && s.length() != 18)
            return s;
        if(s.length() == 18)
            s1 = s.toUpperCase();
        if(s.length() == 15)
        {
            int ai[] = {
                7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 
                7, 9, 10, 5, 8, 4, 2, 1
            };
            char ac[] = {
                '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', 
                '2'
            };
            String s2 = (new StringBuilder()).append(s.substring(0, 6)).append("19").append(s.substring(6, 15)).toString();
            int ai1[] = new int[17];
            for(int i = 0; i < 17; i++)
                ai1[i] = Integer.parseInt(s2.substring(i, i + 1));

            int j = 0;
            for(int k = 0; k < 17; k++)
                j += ai1[k] * ai[k];

            j %= 11;
            s1 = (new StringBuilder()).append(s2).append(ac[j]).toString();
        }
        return s1;
    }

	public static String DBC2SBC(String str)
	{
		String result = "";
		String strTemp = "";
		byte b[] = null;
		String codeList[] = {
			"¡®,'", "¡¯,'", "¡¡, "
		};
		String codeValues = "";
		for (int i = 0; i < str.length(); i++)
		{
			try
			{
				strTemp = str.substring(i, i + 1);
				b = strTemp.getBytes("unicode");
			}
			catch (UnsupportedEncodingException e)
			{
				e.printStackTrace();
			}
			if (b[3] == -1)
			{
				b[2] = (byte)(b[2] + 32);
				b[3] = 0;
				try
				{
					result = (new StringBuilder(String.valueOf(result))).append(new String(b, "unicode")).toString();
				}
				catch (UnsupportedEncodingException e)
				{
					e.printStackTrace();
				}
			} else
			{
				for (int j = 0; j < codeList.length; j++)
				{
					codeValues = codeList[j];
					strTemp = strTemp.replaceAll(codeValues.substring(0, 1), codeValues.substring(2, 3));
				}

				result = (new StringBuilder(String.valueOf(result))).append(strTemp).toString();
			}
		}

		return result;
	}

	public static String getRelativeDate(java.util.Date date, int iYear, int iMonth, int iDate, String sFormat)
	{
		SimpleDateFormat sdf = new SimpleDateFormat(sFormat);
		GregorianCalendar gc = new GregorianCalendar();
		gc.setTime(date);
		gc.add(1, iYear);
		gc.add(2, iMonth);
		gc.add(5, iDate);
		return sdf.format(gc.getTime());
	}

	public static String getRelativeDate(String sDate, int iYear, int iMonth, int iDate, String sFormat)
		throws Exception
	{
		java.util.Date date = parseString2Date(sDate, "yyyy/MM/dd");
		return getRelativeDate(date, iYear, iMonth, iDate, sFormat);
	}

	public static String getRelativeDate(java.util.Date date, int iYear, int iMonth, int iDate)
	{
		return getRelativeDate(date, iYear, iMonth, iDate, "yyyy/MM/dd");
	}

	public static String getRelativeDate(String sDate, int iYear, int iMonth, int iDate)
		throws Exception
	{
		return getRelativeDate(sDate, iYear, iMonth, iDate, "yyyy/MM/dd");
	}
	
	protected static java.util.Date parseString2Date(String s, String s1)
	        throws Exception
	    {
	        try
	        {
	            String s2 = "";
	            if(s.length() == 7)
	                s2 = (new StringBuilder()).append(s).append("/01").toString();
	            else
	                s2 = s;
	            java.util.Date date = (new SimpleDateFormat(s1)).parse(s2);
	            return date;
	        }
	        catch(Exception exception)
	        {
	            throw new Exception((new StringBuilder()).append("×Ö·û'").append(s).append("'×ª»»Òì³£").append(exception).toString());
	        }
	    }

	public static java.util.Date parseString2Date(String datestring)
		throws Exception
	{
		return parseString2Date(datestring, "yyyy/MM/dd");
	}

	public static String parseDateFormat(java.util.Date date, String sFormat)
	{
		SimpleDateFormat sdf = new SimpleDateFormat(sFormat);
		GregorianCalendar gc = new GregorianCalendar();
		gc.setTime(date);
		return sdf.format(gc.getTime());
	}

	public static String a10to62_db2(long number)
	{
		String num = "";
		int i = (int)(number % 62L);
		int y = (int)(number / 62L);
		if (i >= 0 && i <= 9)
			num = String.valueOf(i);
		else
			num = getData_db2(i);
		if (y > 0)
			num = (new StringBuilder(String.valueOf(a10to62_db2(y)))).append(num).toString();
		return num;
	}

	public static String getData_db2(int num)
	{
		switch (num)
		{
		case 10: // '\n'
			return "a";

		case 11: // '\013'
			return "b";

		case 12: // '\f'
			return "c";

		case 13: // '\r'
			return "d";

		case 14: // '\016'
			return "e";

		case 15: // '\017'
			return "f";

		case 16: // '\020'
			return "g";

		case 17: // '\021'
			return "h";

		case 18: // '\022'
			return "i";

		case 19: // '\023'
			return "j";

		case 20: // '\024'
			return "k";

		case 21: // '\025'
			return "l";

		case 22: // '\026'
			return "m";

		case 23: // '\027'
			return "n";

		case 24: // '\030'
			return "o";

		case 25: // '\031'
			return "p";

		case 26: // '\032'
			return "q";

		case 27: // '\033'
			return "r";

		case 28: // '\034'
			return "s";

		case 29: // '\035'
			return "t";

		case 30: // '\036'
			return "u";

		case 31: // '\037'
			return "v";

		case 32: // ' '
			return "w";

		case 33: // '!'
			return "x";

		case 34: // '"'
			return "y";

		case 35: // '#'
			return "z";

		case 36: // '$'
			return "A";

		case 37: // '%'
			return "B";

		case 38: // '&'
			return "C";

		case 39: // '\''
			return "D";

		case 40: // '('
			return "E";

		case 41: // ')'
			return "F";

		case 42: // '*'
			return "G";

		case 43: // '+'
			return "H";

		case 44: // ','
			return "I";

		case 45: // '-'
			return "J";

		case 46: // '.'
			return "K";

		case 47: // '/'
			return "L";

		case 48: // '0'
			return "M";

		case 49: // '1'
			return "N";

		case 50: // '2'
			return "O";

		case 51: // '3'
			return "P";

		case 52: // '4'
			return "Q";

		case 53: // '5'
			return "R";

		case 54: // '6'
			return "S";

		case 55: // '7'
			return "T";

		case 56: // '8'
			return "U";

		case 57: // '9'
			return "V";

		case 58: // ':'
			return "W";

		case 59: // ';'
			return "X";

		case 60: // '<'
			return "Y";

		case 61: // '='
			return "Z";
		}
		return Integer.toString(num);
	}

	public static long a62to10_db2(String number)
	{
		long num = 0L;
		int count = 0;
		for (int i = number.length() - 1; i >= 0; i--)
			num += getData_db2(number.charAt(i)) * (long)Math.pow(62D, count++);

		return num;
	}

	public static long getData_db2(char number)
	{
		switch (number)
		{
		case 48: // '0'
			return 0L;

		case 49: // '1'
			return 1L;

		case 50: // '2'
			return 2L;

		case 51: // '3'
			return 3L;

		case 52: // '4'
			return 4L;

		case 53: // '5'
			return 5L;

		case 54: // '6'
			return 6L;

		case 55: // '7'
			return 7L;

		case 56: // '8'
			return 8L;

		case 57: // '9'
			return 9L;

		case 97: // 'a'
			return 10L;

		case 98: // 'b'
			return 11L;

		case 99: // 'c'
			return 12L;

		case 100: // 'd'
			return 13L;

		case 101: // 'e'
			return 14L;

		case 102: // 'f'
			return 15L;

		case 103: // 'g'
			return 16L;

		case 104: // 'h'
			return 17L;

		case 105: // 'i'
			return 18L;

		case 106: // 'j'
			return 19L;

		case 107: // 'k'
			return 20L;

		case 108: // 'l'
			return 21L;

		case 109: // 'm'
			return 22L;

		case 110: // 'n'
			return 23L;

		case 111: // 'o'
			return 24L;

		case 112: // 'p'
			return 25L;

		case 113: // 'q'
			return 26L;

		case 114: // 'r'
			return 27L;

		case 115: // 's'
			return 28L;

		case 116: // 't'
			return 29L;

		case 117: // 'u'
			return 30L;

		case 118: // 'v'
			return 31L;

		case 119: // 'w'
			return 32L;

		case 120: // 'x'
			return 33L;

		case 121: // 'y'
			return 34L;

		case 122: // 'z'
			return 35L;

		case 65: // 'A'
			return 36L;

		case 66: // 'B'
			return 37L;

		case 67: // 'C'
			return 38L;

		case 68: // 'D'
			return 39L;

		case 69: // 'E'
			return 40L;

		case 70: // 'F'
			return 41L;

		case 71: // 'G'
			return 42L;

		case 72: // 'H'
			return 43L;

		case 73: // 'I'
			return 44L;

		case 74: // 'J'
			return 45L;

		case 75: // 'K'
			return 46L;

		case 76: // 'L'
			return 47L;

		case 77: // 'M'
			return 48L;

		case 78: // 'N'
			return 49L;

		case 79: // 'O'
			return 50L;

		case 80: // 'P'
			return 51L;

		case 81: // 'Q'
			return 52L;

		case 82: // 'R'
			return 53L;

		case 83: // 'S'
			return 54L;

		case 84: // 'T'
			return 55L;

		case 85: // 'U'
			return 56L;

		case 86: // 'V'
			return 57L;

		case 87: // 'W'
			return 58L;

		case 88: // 'X'
			return 59L;

		case 89: // 'Y'
			return 60L;

		case 90: // 'Z'
			return 61L;

		case 58: // ':'
		case 59: // ';'
		case 60: // '<'
		case 61: // '='
		case 62: // '>'
		case 63: // '?'
		case 64: // '@'
		case 91: // '['
		case 92: // '\\'
		case 93: // ']'
		case 94: // '^'
		case 95: // '_'
		case 96: // '`'
		default:
			return 0L;
		}
	}

	public static String a10to62_ora(long number)
	{
		String num = "";
		int i = (int)(number % 62L);
		int y = (int)(number / 62L);
		if (i >= 0 && i <= 9)
			num = String.valueOf(i);
		else
			num = getData_ora(i);
		if (y > 0)
			num = (new StringBuilder(String.valueOf(a10to62_ora(y)))).append(num).toString();
		return num;
	}

	public static String getData_ora(int num)
	{
		switch (num)
		{
		case 10: // '\n'
			return "A";

		case 11: // '\013'
			return "B";

		case 12: // '\f'
			return "C";

		case 13: // '\r'
			return "D";

		case 14: // '\016'
			return "E";

		case 15: // '\017'
			return "F";

		case 16: // '\020'
			return "G";

		case 17: // '\021'
			return "H";

		case 18: // '\022'
			return "I";

		case 19: // '\023'
			return "J";

		case 20: // '\024'
			return "K";

		case 21: // '\025'
			return "L";

		case 22: // '\026'
			return "M";

		case 23: // '\027'
			return "N";

		case 24: // '\030'
			return "O";

		case 25: // '\031'
			return "P";

		case 26: // '\032'
			return "Q";

		case 27: // '\033'
			return "R";

		case 28: // '\034'
			return "S";

		case 29: // '\035'
			return "T";

		case 30: // '\036'
			return "U";

		case 31: // '\037'
			return "V";

		case 32: // ' '
			return "W";

		case 33: // '!'
			return "X";

		case 34: // '"'
			return "Y";

		case 35: // '#'
			return "Z";

		case 36: // '$'
			return "a";

		case 37: // '%'
			return "b";

		case 38: // '&'
			return "c";

		case 39: // '\''
			return "d";

		case 40: // '('
			return "e";

		case 41: // ')'
			return "f";

		case 42: // '*'
			return "g";

		case 43: // '+'
			return "h";

		case 44: // ','
			return "i";

		case 45: // '-'
			return "j";

		case 46: // '.'
			return "k";

		case 47: // '/'
			return "l";

		case 48: // '0'
			return "m";

		case 49: // '1'
			return "n";

		case 50: // '2'
			return "o";

		case 51: // '3'
			return "p";

		case 52: // '4'
			return "q";

		case 53: // '5'
			return "r";

		case 54: // '6'
			return "s";

		case 55: // '7'
			return "t";

		case 56: // '8'
			return "u";

		case 57: // '9'
			return "v";

		case 58: // ':'
			return "w";

		case 59: // ';'
			return "x";

		case 60: // '<'
			return "y";

		case 61: // '='
			return "z";
		}
		return Integer.toString(num);
	}

	public static long a62to10_mssql(String number)
	{
		long num = 0L;
		int count = 0;
		for (int i = number.length() - 1; i >= 0; i--)
			num += getData_mssql(number.charAt(i)) * (long)Math.pow(62D, count++);

		return num;
	}

	public static long getData_mssql(char number)
	{
		switch (number)
		{
		case 48: // '0'
			return 0L;

		case 49: // '1'
			return 1L;

		case 50: // '2'
			return 2L;

		case 51: // '3'
			return 3L;

		case 52: // '4'
			return 4L;

		case 53: // '5'
			return 5L;

		case 54: // '6'
			return 6L;

		case 55: // '7'
			return 7L;

		case 56: // '8'
			return 8L;

		case 57: // '9'
			return 9L;

		case 97: // 'a'
			return 10L;

		case 65: // 'A'
			return 11L;

		case 98: // 'b'
			return 12L;

		case 66: // 'B'
			return 13L;

		case 99: // 'c'
			return 14L;

		case 67: // 'C'
			return 15L;

		case 100: // 'd'
			return 16L;

		case 68: // 'D'
			return 17L;

		case 101: // 'e'
			return 18L;

		case 69: // 'E'
			return 19L;

		case 102: // 'f'
			return 20L;

		case 70: // 'F'
			return 21L;

		case 103: // 'g'
			return 22L;

		case 71: // 'G'
			return 23L;

		case 104: // 'h'
			return 24L;

		case 72: // 'H'
			return 25L;

		case 105: // 'i'
			return 26L;

		case 73: // 'I'
			return 27L;

		case 106: // 'j'
			return 28L;

		case 74: // 'J'
			return 29L;

		case 107: // 'k'
			return 30L;

		case 75: // 'K'
			return 31L;

		case 108: // 'l'
			return 32L;

		case 76: // 'L'
			return 33L;

		case 109: // 'm'
			return 34L;

		case 77: // 'M'
			return 35L;

		case 110: // 'n'
			return 36L;

		case 78: // 'N'
			return 37L;

		case 111: // 'o'
			return 38L;

		case 79: // 'O'
			return 39L;

		case 112: // 'p'
			return 40L;

		case 80: // 'P'
			return 41L;

		case 113: // 'q'
			return 42L;

		case 81: // 'Q'
			return 43L;

		case 114: // 'r'
			return 44L;

		case 82: // 'R'
			return 45L;

		case 115: // 's'
			return 46L;

		case 83: // 'S'
			return 47L;

		case 116: // 't'
			return 48L;

		case 84: // 'T'
			return 49L;

		case 117: // 'u'
			return 50L;

		case 85: // 'U'
			return 51L;

		case 118: // 'v'
			return 52L;

		case 86: // 'V'
			return 53L;

		case 119: // 'w'
			return 54L;

		case 87: // 'W'
			return 55L;

		case 120: // 'x'
			return 56L;

		case 88: // 'X'
			return 57L;

		case 121: // 'y'
			return 58L;

		case 89: // 'Y'
			return 59L;

		case 122: // 'z'
			return 60L;

		case 90: // 'Z'
			return 61L;

		case 58: // ':'
		case 59: // ';'
		case 60: // '<'
		case 61: // '='
		case 62: // '>'
		case 63: // '?'
		case 64: // '@'
		case 91: // '['
		case 92: // '\\'
		case 93: // ']'
		case 94: // '^'
		case 95: // '_'
		case 96: // '`'
		default:
			return 0L;
		}
	}

	public static String a10to62_mssql(long number)
	{
		String num = "";
		int i = (int)(number % 62L);
		int y = (int)(number / 62L);
		if (i >= 0 && i <= 9)
			num = String.valueOf(i);
		else
			num = getData_mssql(i);
		if (y > 0)
			num = (new StringBuilder(String.valueOf(a10to62_mssql(y)))).append(num).toString();
		return num;
	}

	public static String getData_mssql(int num)
	{
		switch (num)
		{
		case 10: // '\n'
			return "a";

		case 11: // '\013'
			return "A";

		case 12: // '\f'
			return "b";

		case 13: // '\r'
			return "B";

		case 14: // '\016'
			return "c";

		case 15: // '\017'
			return "C";

		case 16: // '\020'
			return "d";

		case 17: // '\021'
			return "D";

		case 18: // '\022'
			return "e";

		case 19: // '\023'
			return "E";

		case 20: // '\024'
			return "f";

		case 21: // '\025'
			return "F";

		case 22: // '\026'
			return "g";

		case 23: // '\027'
			return "G";

		case 24: // '\030'
			return "h";

		case 25: // '\031'
			return "H";

		case 26: // '\032'
			return "i";

		case 27: // '\033'
			return "I";

		case 28: // '\034'
			return "j";

		case 29: // '\035'
			return "J";

		case 30: // '\036'
			return "k";

		case 31: // '\037'
			return "K";

		case 32: // ' '
			return "l";

		case 33: // '!'
			return "L";

		case 34: // '"'
			return "m";

		case 35: // '#'
			return "M";

		case 36: // '$'
			return "n";

		case 37: // '%'
			return "N";

		case 38: // '&'
			return "o";

		case 39: // '\''
			return "O";

		case 40: // '('
			return "p";

		case 41: // ')'
			return "P";

		case 42: // '*'
			return "q";

		case 43: // '+'
			return "Q";

		case 44: // ','
			return "r";

		case 45: // '-'
			return "R";

		case 46: // '.'
			return "s";

		case 47: // '/'
			return "S";

		case 48: // '0'
			return "t";

		case 49: // '1'
			return "T";

		case 50: // '2'
			return "u";

		case 51: // '3'
			return "U";

		case 52: // '4'
			return "v";

		case 53: // '5'
			return "V";

		case 54: // '6'
			return "w";

		case 55: // '7'
			return "W";

		case 56: // '8'
			return "x";

		case 57: // '9'
			return "X";

		case 58: // ':'
			return "y";

		case 59: // ';'
			return "Y";

		case 60: // '<'
			return "z";

		case 61: // '='
			return "Z";
		}
		return Integer.toString(num);
	}

	public static long a62to10_ora(String number)
	{
		long num = 0L;
		int count = 0;
		for (int i = number.length() - 1; i >= 0; i--)
			num += getData_ora(number.charAt(i)) * (long)Math.pow(62D, count++);

		return num;
	}

	public static long getData_ora(char number)
	{
		switch (number)
		{
		case 48: // '0'
			return 0L;

		case 49: // '1'
			return 1L;

		case 50: // '2'
			return 2L;

		case 51: // '3'
			return 3L;

		case 52: // '4'
			return 4L;

		case 53: // '5'
			return 5L;

		case 54: // '6'
			return 6L;

		case 55: // '7'
			return 7L;

		case 56: // '8'
			return 8L;

		case 57: // '9'
			return 9L;

		case 65: // 'A'
			return 10L;

		case 66: // 'B'
			return 11L;

		case 67: // 'C'
			return 12L;

		case 68: // 'D'
			return 13L;

		case 69: // 'E'
			return 14L;

		case 70: // 'F'
			return 15L;

		case 71: // 'G'
			return 16L;

		case 72: // 'H'
			return 17L;

		case 73: // 'I'
			return 18L;

		case 74: // 'J'
			return 19L;

		case 75: // 'K'
			return 20L;

		case 76: // 'L'
			return 21L;

		case 77: // 'M'
			return 22L;

		case 78: // 'N'
			return 23L;

		case 79: // 'O'
			return 24L;

		case 80: // 'P'
			return 25L;

		case 81: // 'Q'
			return 26L;

		case 82: // 'R'
			return 27L;

		case 83: // 'S'
			return 28L;

		case 84: // 'T'
			return 29L;

		case 85: // 'U'
			return 30L;

		case 86: // 'V'
			return 31L;

		case 87: // 'W'
			return 32L;

		case 88: // 'X'
			return 33L;

		case 89: // 'Y'
			return 34L;

		case 90: // 'Z'
			return 35L;

		case 97: // 'a'
			return 36L;

		case 98: // 'b'
			return 37L;

		case 99: // 'c'
			return 38L;

		case 100: // 'd'
			return 39L;

		case 101: // 'e'
			return 40L;

		case 102: // 'f'
			return 41L;

		case 103: // 'g'
			return 42L;

		case 104: // 'h'
			return 43L;

		case 105: // 'i'
			return 44L;

		case 106: // 'j'
			return 45L;

		case 107: // 'k'
			return 46L;

		case 108: // 'l'
			return 47L;

		case 109: // 'm'
			return 48L;

		case 110: // 'n'
			return 49L;

		case 111: // 'o'
			return 50L;

		case 112: // 'p'
			return 51L;

		case 113: // 'q'
			return 52L;

		case 114: // 'r'
			return 53L;

		case 115: // 's'
			return 54L;

		case 116: // 't'
			return 55L;

		case 117: // 'u'
			return 56L;

		case 118: // 'v'
			return 57L;

		case 119: // 'w'
			return 58L;

		case 120: // 'x'
			return 59L;

		case 121: // 'y'
			return 60L;

		case 122: // 'z'
			return 61L;

		case 58: // ':'
		case 59: // ';'
		case 60: // '<'
		case 61: // '='
		case 62: // '>'
		case 63: // '?'
		case 64: // '@'
		case 91: // '['
		case 92: // '\\'
		case 93: // ']'
		case 94: // '^'
		case 95: // '_'
		case 96: // '`'
		default:
			return 0L;
		}
	}

}
