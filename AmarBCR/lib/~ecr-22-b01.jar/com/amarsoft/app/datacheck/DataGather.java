// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DataGather.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.dpx.recordset.RecordSetException;
import com.amarsoft.task.units.dpx.PRHUnit;
import java.io.PrintStream;

public class DataGather extends PRHUnit
{

	public DataGather()
	{
	}

	protected void preprocess()
		throws RecordSetException
	{
		System.out.println(getProperty("com.amarsoft.app.datax.ecr.prepare.dataimport.ECRDataSourceProvider.dataSource"));
		if (getProperty("unit.provider") == null)
			setProperty("unit.provider", "com.amarsoft.app.datax.ecr.prepare.dataimport.ECRDataSourceProvider");
		if (getProperty("unit.handlers") == null)
			setProperty("unit.handlers", "com.amarsoft.are.dpx.recordset.UpdateDBHandler");
	}
}
