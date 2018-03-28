// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   AmarECR.java

package com.amarsoft.app.datax.ecr;

import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.CommandLineArgument;
import com.amarsoft.task.TaskRunner;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class AmarECR
{

	public static final String PROPERTY_TASK_FILE = "TaskFile";
	public static final String DEFAULT_ARE_CONFIG = "etc/ecr_are.xml";

	public AmarECR()
	{
	}

	public static void main(String args[])
	{
		CommandLineArgument arg = new CommandLineArgument(args);
		String are = arg.getArgument("are", "etc/ecr_are.xml");
		ARE.init(are);
		String occurDate = getArgumentOccurDate(arg);
		if (occurDate == null)
			occurDate = getAREOccurDate(ARE.getProperty("businessOccurDate"));
		ARE.setProperty("businessOccurDate", occurDate);
		ARE.setProperty("occurDate", occurDate);
		String taskFile = ARE.getProperty((new StringBuilder(String.valueOf(arg.getArgument("task", "report")))).append("TaskFile").toString());
		boolean gui = arg.getArgument("gui", false);
		int exitCode = 0;
		if (gui)
		{
			exitCode = TaskRunner.runGui(taskFile);
			ARE.getLog().info((new StringBuilder("自动计算后businessOccurDate：")).append(occurDate).toString());
		} else
		{
			ARE.getLog().info((new StringBuilder("自动计算后businessOccurDate：")).append(occurDate).toString());
			exitCode = TaskRunner.runCli(taskFile);
			System.exit(exitCode);
		}
	}

	private static String getArgumentOccurDate(CommandLineArgument arg)
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String occurDate = arg.getArgument("businessOccurDate");
		if (occurDate != null)
			try
			{
				sdf.parse(occurDate);
			}
			catch (Exception ex)
			{
				System.out.println((new StringBuilder("无效的发生日期参数：")).append(occurDate).toString());
				occurDate = null;
			}
		return occurDate;
	}

	public static String getAREOccurDate(String od)
	{
		String occurDate;
		SimpleDateFormat sdf;
		occurDate = null;
		sdf = new SimpleDateFormat("yyyy/MM/dd");
		if (od == null)
			od = "AUTOSELECT";
		if (od.equalsIgnoreCase("TODAY"))
		{
			occurDate = sdf.format(new Date());
			break MISSING_BLOCK_LABEL_225;
		}
		if (od.equalsIgnoreCase("YESTERDAY"))
		{
			occurDate = Tools.getLastDay("1");
			break MISSING_BLOCK_LABEL_225;
		}
		if (od.equalsIgnoreCase("AUTOSELECT"))
		{
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			occurDate = Tools.getCurrentDay("1");
			if (cal.get(11) < 22)
				occurDate = Tools.getLastDay("1");
			break MISSING_BLOCK_LABEL_225;
		}
		if (!od.equalsIgnoreCase("USERINPUT"))
			break MISSING_BLOCK_LABEL_207;
		occurDate = null;
		  goto _L1
_L3:
		byte buf[];
		System.out.print("Input Business Date(yyyy/mm/dd)：");
		buf = new byte[10];
		int ii = System.in.read(buf);
		if (ii != 10)
		{
			System.out.println("Invalid input!");
			continue; /* Loop/switch isn't completed */
		}
		try
		{
			occurDate = new String(buf);
			try
			{
				sdf.parse(occurDate);
			}
			catch (Exception e)
			{
				occurDate = null;
			}
		}
		catch (IOException e)
		{
			System.out.println(e);
		}
_L1:
		if (occurDate == null) goto _L3; else goto _L2
_L2:
		break MISSING_BLOCK_LABEL_225;
		try
		{
			occurDate = od;
			sdf.parse(od);
		}
		catch (Exception ex)
		{
			occurDate = getAREOccurDate("AUTOSELECT");
		}
		return occurDate;
	}
}
