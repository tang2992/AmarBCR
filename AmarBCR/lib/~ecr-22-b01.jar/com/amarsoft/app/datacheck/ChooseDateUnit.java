// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ChooseDateUnit.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.util.DateRange;
import com.amarsoft.task.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

// Referenced classes of package com.amarsoft.app.datacheck:
//			DateChooser

public class ChooseDateUnit extends ExecuteUnit
{

	private String varFormat;
	private String varName;
	private String varScope;

	public ChooseDateUnit()
	{
		varFormat = "yyyy/MM/dd";
		varName = "myVar";
		varScope = "task";
	}

	public int execute()
	{
		transferUnitProperties();
		Calendar cal = Calendar.getInstance();
		cal.set(5, 1);
		cal.add(5, -1);
		Date initDate = cal.getTime();
		DateChooser ds = new DateChooser(initDate);
		ds.setAcceptRange(new DateRange(StringX.parseDate("2008/01/01"), new Date()));
		Date d = ds.chooseDate(getTarget().getTask().getTaskWindow());
		if (d == null)
			return 2;
		String v = (new SimpleDateFormat(getVarFormat())).format(d);
		if (v == null)
			return 2;
		String scope = getVarScope();
		if (scope == null)
			scope = "task";
		if (scope.equalsIgnoreCase("task"))
			getTarget().getTask().setProperty(getVarName(), v);
		else
		if (scope.equalsIgnoreCase("target"))
			getTarget().setProperty(getVarName(), v);
		else
		if (scope.equalsIgnoreCase("are"))
			ARE.setProperty(getVarName(), v);
		else
		if (scope.equalsIgnoreCase("system"))
			System.setProperty(getVarName(), v);
		else
			return 2;
		return 1;
	}

	public String getVarFormat()
	{
		return varFormat;
	}

	public void setVarFormat(String varFormat)
	{
		this.varFormat = varFormat;
	}

	public String getVarName()
	{
		return varName;
	}

	public void setVarName(String varName)
	{
		this.varName = varName;
	}

	public String getVarScope()
	{
		return varScope;
	}

	public void setVarScope(String varScope)
	{
		this.varScope = varScope;
	}
}
