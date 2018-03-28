// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   CBRCShanghaiReportUnit.java

package com.amarsoft.app.datax.ecr.ext;

import com.amarsoft.app.datax.ecr.common.MessageFileSplit;
import com.amarsoft.are.io.FileFilterByName;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.io.*;

public class CBRCShanghaiReportUnit extends ExecuteUnit
{

	private String exportFolder;
	private String messageFileFolder;
	private String messageFilePattern;
	private String memberOrgs;

	public CBRCShanghaiReportUnit()
	{
		exportFolder = "export";
		messageFileFolder = "export";
		messageFilePattern = "11\\w{17}[1-3]{2}[12][0-9]{4}00\\.[Tt][Xx][Tt]$";
		memberOrgs = null;
	}

	public int execute()
	{
		transferProperties();
		String orgId = getMemberOrgs();
		if (orgId == null)
		{
			logger.error("memberOrgs property not set!");
			return 2;
		}
		String messageFolder = getMessageFileFolder();
		File messFolder = null;
		if (messageFolder == null)
		{
			logger.error("memberOrgs property not set!");
			return 2;
		}
		messFolder = new File(messageFolder);
		if (!messFolder.exists() || !messFolder.isDirectory())
		{
			logger.error("原始报文文件目录无效!");
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
			logger.info("报文目录下面没有符合要求的文件！");
			return 1;
		}
		int okCount = 0;
		int errorCount = 0;
		for (int i = 0; i < fs.length; i++)
			try
			{
				logger.info((new StringBuilder("开始处理报文：")).append(fs[i].getPath()).toString());
				split.splitMessage(fs[i].getPath());
				okCount++;
			}
			catch (FileNotFoundException ex)
			{
				logger.warn("报文处理失败，继续下一个！", ex);
				errorCount++;
			}
			catch (IOException ex)
			{
				logger.warn("报文处理失败，继续下一个！", ex);
				errorCount++;
			}

		logger.info((new StringBuilder("所有报文处理完成，共计处理")).append(fs.length).append("个！成功").append(okCount).append("个，失败").append(errorCount).append("个").toString());
		return 1;
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
}
