// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FeedBatchDeleteSession.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizmanage.BatchDeleteResultHandler;
import com.amarsoft.app.datax.ecr.bizmanage.FeedBatchFileProvider;
import com.amarsoft.app.datax.ecr.message.MessageSet;
import com.amarsoft.are.log.Log;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			MessageProcessSession

public class FeedBatchDeleteSession extends MessageProcessSession
{

	private String feedbackFile;
	private String cryptConfigFile;
	private String cryptKeyFile;
	private String originalMessageList;
	private Map messageSetMap;
	private String database;

	public FeedBatchDeleteSession()
	{
		feedbackFile = null;
		cryptConfigFile = null;
		cryptKeyFile = null;
		originalMessageList = "{etc/ecr_message_customerinfo.xml}{etc/ecr_message_businessinfo.xml}{etc/ecr_message_assetssaving.xml}";
		messageSetMap = new HashMap();
		database = "ecr";
		feedbackFile = null;
		setMessageConfigFile("etc/ecr_message_batchdelete_result.xml");
	}

	public FeedBatchDeleteSession(String backMesageDataFile)
	{
		feedbackFile = null;
		cryptConfigFile = null;
		cryptKeyFile = null;
		originalMessageList = "{etc/ecr_message_customerinfo.xml}{etc/ecr_message_businessinfo.xml}{etc/ecr_message_assetssaving.xml}";
		messageSetMap = new HashMap();
		database = "ecr";
		feedbackFile = backMesageDataFile;
		setMessageConfigFile("etc/ecr_message_batchdelete_result.xml");
	}

	public void setFeedbackFile(String backFile)
	{
		feedbackFile = backFile;
	}

	public String getFeedbackFile()
	{
		return feedbackFile;
	}

	public boolean init()
	{
		String s = getMessageSetType();
		if (s == null)
		{
			logger.error("反馈报文集合类型(messageSetType)未配置！");
			return false;
		}
		try
		{
			provider = new FeedBatchFileProvider(feedbackFile);
		}
		catch (ECRException e1)
		{
			logger.error("初始化反馈报文提供器失败！", e1);
			return false;
		}
		if (s.equals("35"))
			handler = new BatchDeleteResultHandler();
		return true;
	}

	public void addOriginalMessageConfig(String xmlMessageConfigFile)
		throws ECRException
	{
		MessageSet ms = MessageSet.createMessageSetFromXml(xmlMessageConfigFile);
		messageSetMap.put(ms.getType(), xmlMessageConfigFile);
	}

	public void postProcess()
	{
		if (getStatus() != 100)
		{
			logger.fatal((new StringBuilder("运行报文处理过程")).append(getSessionId()).append("失败!").toString());
			return;
		}
		logger.info((new StringBuilder("处理返回报文文件")).append(feedbackFile).append("成功！").toString());
		File fs = new File(feedbackFile);
		if (fs.renameTo(new File((new StringBuilder(String.valueOf(fs.getPath()))).append(".bak").toString())))
			logger.info((new StringBuilder("更名")).append(fs.getPath()).append("为").append(fs.getPath()).append(".bak成功！").toString());
		else
			logger.warn((new StringBuilder("更名")).append(fs.getPath()).append("为").append(fs.getPath()).append(".bak失败！").toString());
	}

	public String getOriginalMessageList()
	{
		return originalMessageList;
	}

	public void setOriginalMessageList(String messageConfigFiles)
	{
		originalMessageList = messageConfigFiles;
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}

	public final String getCryptConfigFile()
	{
		return cryptConfigFile;
	}

	public final void setCryptConfigFile(String cryptConfigFile)
	{
		this.cryptConfigFile = cryptConfigFile;
	}

	public final String getCryptKeyFile()
	{
		return cryptKeyFile;
	}

	public final void setCryptKeyFile(String cryptKeyFile)
	{
		this.cryptKeyFile = cryptKeyFile;
	}
}
