// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   CBRCShanghaiReport.java

package com.amarsoft.app.datax.ecr.ext;

import com.amarsoft.app.datax.ecr.common.MessageFileSplit;
import com.amarsoft.are.io.FileFilterByName;
import com.amarsoft.are.lang.StringX;
import java.io.*;
import java.util.Date;
import java.util.Properties;

public class CBRCShanghaiReport
{

	private String exportFolder;
	private String messageFileFolder;
	private String messageFilePattern;
	private String memberOrgs;

	public CBRCShanghaiReport()
	{
		exportFolder = "data";
		messageFileFolder = "data";
		messageFilePattern = "11\\w{17}[1-3]{2}[12][0-9]{4}[01]0\\.[Tt][Xx][Tt]$";
		memberOrgs = null;
	}

	public int execute()
	{
		String orgId = getMemberOrgs();
		if (orgId == null)
		{
			log_error("memberOrgs property not set!");
			return 2;
		}
		String messageFolder = getMessageFileFolder();
		File messFolder = null;
		if (messageFolder == null)
		{
			log_error("memberOrgs property not set!");
			return 2;
		}
		messFolder = new File(messageFolder);
		if (!messFolder.exists() || !messFolder.isDirectory())
		{
			log_error("原始报文文件目录无效!");
			return 2;
		}
		String orgs[] = StringX.parseArray(orgId);
		MessageFileSplit split = new MessageFileSplit();
		split.addGroup("shanghai", orgs);
		split.setExportFolder(getExportFolder());
		FileFilterByName ff = new FileFilterByName();
		ff.setDirectoryInclude(false);
		ff.setNamePattern(getMessageFilePattern());
		File fs[] = messFolder.listFiles(ff);
		if (fs.length < 1)
		{
			log_info("报文目录下面没有符合要求的文件！");
			return 1;
		}
		int okCount = 0;
		int errorCount = 0;
		for (int i = 0; i < fs.length; i++)
			try
			{
				log_info((new StringBuilder("开始处理报文：")).append(fs[i].getPath()).toString());
				split.splitMessage(fs[i].getPath());
				okCount++;
			}
			catch (FileNotFoundException ex)
			{
				log_warn("报文处理失败，继续下一个！", ex);
				errorCount++;
			}
			catch (IOException ex)
			{
				log_warn("报文处理失败，继续下一个！", ex);
				errorCount++;
			}

		log_info((new StringBuilder("所有报文处理完成，共计处理")).append(fs.length).append("个！成功").append(okCount).append("个，失败").append(errorCount).append("个").toString());
		return 1;
	}

	private void log_error(String message)
	{
		System.err.println(new Date());
		System.err.println((new StringBuilder("错误：")).append(message).toString());
	}

	private void log_warn(String message, Exception ex)
	{
		System.err.println(new Date());
		System.err.println((new StringBuilder("警告：")).append(message).toString());
		ex.printStackTrace();
	}

	private void log_info(String message)
	{
		System.err.println(new Date());
		System.err.println((new StringBuilder("信息：")).append(message).toString());
	}

	public final String getExportFolder()
	{
		return exportFolder;
	}

	public final void setExportFolder(String exportFolder)
	{
		this.exportFolder = exportFolder;
	}

	public final String getMessageFilePattern()
	{
		return messageFilePattern;
	}

	public final void setMessageFilePattern(String fileFilter)
	{
		messageFilePattern = fileFilter;
	}

	public final String getMemberOrgs()
	{
		return memberOrgs;
	}

	public final void setMemberOrgs(String memberOrgs)
	{
		this.memberOrgs = memberOrgs;
	}

	public final String getMessageFileFolder()
	{
		return messageFileFolder;
	}

	public final void setMessageFileFolder(String messageFolder)
	{
		messageFileFolder = messageFolder;
	}

	public static void main(String args[])
	{
		System.out.println("Amarsoft Credit Report Tools V1.0 (for CBRC Shanghai)");
		System.out.println("Copyright 2007, Amarsoft Technology, Co., Ltd.");
		System.out.println();
		String prop = null;
		if (args.length > 0)
			prop = args[0];
		if (prop == null)
		{
			System.out.println("命令行没有传递配置文件，使用缺省的文件：cbrcshanghai.properties");
			prop = "cbrcshanghai.properties";
		}
		File pf = new File(prop);
		Properties props = new Properties();
		FileInputStream fs = null;
		try
		{
			fs = new FileInputStream(pf);
		}
		catch (FileNotFoundException ex)
		{
			System.err.println((new StringBuilder("配置文件")).append(prop).append("不存在！").toString());
			ex.printStackTrace();
			System.exit(-1);
		}
		try
		{
			props.load(fs);
		}
		catch (IOException ex)
		{
			System.err.println((new StringBuilder("加载配置文件")).append(prop).append("出错！").toString());
			ex.printStackTrace();
			System.exit(-1);
		}
		try
		{
			fs.close();
		}
		catch (IOException ioexception) { }
		String exportFolder = props.getProperty("exportFolder", ".");
		String messageFileFolder = props.getProperty("messageFileFolder", ".");
		String messageFilePattern = props.getProperty("messageFilePattern");
		String memberOrgs = props.getProperty("memberOrgs");
		CBRCShanghaiReport cr = new CBRCShanghaiReport();
		cr.setExportFolder(exportFolder);
		cr.setMessageFileFolder(messageFileFolder);
		if (messageFilePattern != null)
			cr.setMessageFilePattern(messageFilePattern);
		cr.setMemberOrgs(memberOrgs);
		int exitcode = cr.execute();
		System.exit(exitcode);
	}
}
