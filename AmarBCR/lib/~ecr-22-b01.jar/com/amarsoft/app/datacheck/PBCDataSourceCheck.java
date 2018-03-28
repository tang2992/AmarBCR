// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   PBCDataSourceCheck.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.log.Log;
import com.amarsoft.task.*;
import java.io.File;

public class PBCDataSourceCheck extends ExecuteUnit
{

	private static final String DATASOURCE_FOLDER = "dataSourceFolder";
	private static final String CHECK_DATE = "checkDate";

	public PBCDataSourceCheck()
	{
	}

	public String checkDataSource()
	{
		String path = getProperty("dataSourceFolder");
		File file = new File(path);
		String f[] = file.list();
		if (f.length != 21)
		{
			logger.fatal("数据文件个数有误，请检查数据文件！");
			return null;
		}
		String date = f[0].substring(13, 23);
		for (int i = 0; i < f.length; i++)
			if (!f[0].substring(13, 23).equals(f[i].substring(13, 23)))
			{
				logger.fatal("数据文件日期不一致，请检查数据文件！");
				return null;
			}

		date = date.replaceAll("-", "/");
		getTarget().getTask().setProperty("checkDate", date);
		return date;
	}

	public int execute()
	{
		return checkDataSource() != null ? 1 : 2;
	}
}
