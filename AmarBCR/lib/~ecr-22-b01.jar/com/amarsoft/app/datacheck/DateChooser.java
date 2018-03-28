// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DateChooser.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.io.SystemConsole;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.util.DateRange;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

public class DateChooser
{

	private Date initDate;
	private DateRange acceptRange;

	public DateChooser()
	{
		initDate = null;
		acceptRange = null;
	}

	public DateChooser(Date initDate)
	{
		this.initDate = null;
		acceptRange = null;
		this.initDate = initDate;
	}

	public DateChooser(Date initDate, DateRange acceptRange)
	{
		this.initDate = null;
		this.acceptRange = null;
		this.initDate = initDate;
	}

	public Date chooseDate(JFrame parent)
	{
		return parent != null ? chooseDateGui(parent) : chooseDateCmd();
	}

	public Date getInitDate()
	{
		return initDate;
	}

	public void setInitDate(Date initDate)
	{
		this.initDate = initDate;
	}

	public DateRange getAcceptRange()
	{
		return acceptRange;
	}

	public void setAcceptRange(DateRange acceptRange)
	{
		this.acceptRange = acceptRange;
	}

	private boolean accept(Date d)
	{
		if (getAcceptRange() == null)
			return true;
		if (d == null)
			return false;
		else
			return getAcceptRange().contains(d);
	}

	private Date chooseDateCmd()
	{
		String sdate = null;
		Date retDate = null;
		Date iDate = getInitDate();
		DateRange dr = getAcceptRange();
		String prompt = null;
		String fmt = "yyyyMMdd";
		SimpleDateFormat df = new SimpleDateFormat(fmt);
		String errorMessage = null;
		if (iDate != null)
			prompt = (new StringBuilder("输入日期(")).append(fmt).append("，缺省").append(df.format(iDate)).append(")：").toString();
		else
			prompt = (new StringBuilder("输入日期(")).append(fmt).append(")：").toString();
		if (dr == null)
			errorMessage = "输入日期无效";
		else
			errorMessage = (new StringBuilder("输入日期无效，必须在")).append(dr.getStartDateString(fmt)).append("到").append(dr.getEndDateString(fmt)).append("之间！").toString();
		while (retDate == null) 
		{
			sdate = SystemConsole.readLine(prompt);
			if (sdate == null)
			{
				if (iDate == null)
					break;
				retDate = getInitDate();
			} else
			{
				retDate = StringX.parseDate(sdate);
			}
			if (!accept(retDate))
			{
				System.out.println(errorMessage);
				retDate = null;
			}
		}
		return retDate;
	}

	private Date chooseDateGui(JFrame parent)
	{
		String sdate = null;
		Date retDate = null;
		Date iDate = getInitDate();
		String fmt = "yyyyMMdd";
		SimpleDateFormat df = new SimpleDateFormat(fmt);
		DateRange dr = getAcceptRange();
		String errorMessage = null;
		if (dr == null)
			errorMessage = "输入日期无效";
		else
			errorMessage = (new StringBuilder("输入日期无效，必须在")).append(dr.getStartDateString(fmt)).append("到").append(dr.getEndDateString(fmt)).append("之间！").toString();
		while (retDate == null) 
		{
			sdate = JOptionPane.showInputDialog(parent, (new StringBuilder("输入日期(")).append(fmt).append(")：").toString(), iDate != null ? ((Object) (df.format(iDate))) : null);
			if (sdate == null)
				break;
			retDate = StringX.parseDate(sdate);
			if (!accept(retDate))
			{
				JOptionPane.showMessageDialog(parent, errorMessage, "输入日期错误", 0);
				retDate = null;
			}
		}
		return retDate;
	}
}
