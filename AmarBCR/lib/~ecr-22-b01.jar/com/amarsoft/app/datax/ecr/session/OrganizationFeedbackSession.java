// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   OrganizationFeedbackSession.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizmanage.*;
import com.amarsoft.app.datax.ecr.message.MessageSet;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			MessageProcessSession

public class OrganizationFeedbackSession extends MessageProcessSession
{

	private String feedbackFile;
	private String cryptConfigFile;
	private String cryptKeyFile;
	private String originalMessageList;
	private Map messageSetMap;
	private String database;

	public OrganizationFeedbackSession()
	{
		feedbackFile = null;
		cryptConfigFile = null;
		cryptKeyFile = null;
		originalMessageList = "{etc/ecr_message_organizationinfo.xml}{etc/ecr_message_organizationdelete.xml}";
		messageSetMap = new HashMap();
		database = "ecr";
		feedbackFile = null;
		setMessageConfigFile("etc/ecr_message_organizationfeedback.xml");
	}

	public OrganizationFeedbackSession(String backMesageDataFile)
	{
		feedbackFile = null;
		cryptConfigFile = null;
		cryptKeyFile = null;
		originalMessageList = "{etc/ecr_message_organizationinfo.xml}{etc/ecr_message_organizationdelete.xml}";
		messageSetMap = new HashMap();
		database = "ecr";
		feedbackFile = backMesageDataFile;
		setMessageConfigFile("etc/ecr_message_organizationfeedback.xml");
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
			logger.error("������Ϣ�������ļ�������(messageSetType)δ���ã�");
			return false;
		}
		try
		{
			provider = new OrganizationFeedbackFileProvider(feedbackFile);
		}
		catch (ECRException e1)
		{
			logger.error("��ʼ��������Ϣ���������ṩ��ʧ�ܣ�", e1);
			return false;
		}
		String ol[] = StringX.parseArray(originalMessageList);
		if (ol == null || ol.length < 1)
		{
			logger.error("ԭʼ�����б�(originalMessageList)δ���ã�");
			return false;
		}
		for (int i = 0; i < ol.length; i++)
			try
			{
				addOriginalMessageConfig(ol[i]);
			}
			catch (ECRException ex)
			{
				logger.error("����ԭʼ��������ʧ�ܣ�");
				return false;
			}

		String mess[] = new String[2];
		mess[0] = (String)messageSetMap.get("51");
		mess[1] = (String)messageSetMap.get("32");
		try
		{
			OrganizationFeedbackRecord.init(mess);
		}
		catch (ECRException e)
		{
			logger.error("��ʼ��������Ϣ��������ԭʼ���ļ���ʧ��!", e);
			return false;
		}
		handler = new OrganizationFeedbackHandler();
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
			logger.fatal((new StringBuilder("���б��Ĵ������")).append(getSessionId()).append("ʧ��!").toString());
			return;
		}
		logger.info((new StringBuilder("�����ر����ļ�")).append(feedbackFile).append("�ɹ���").toString());
		File fs = new File(feedbackFile);
		if (fs.renameTo(new File((new StringBuilder(String.valueOf(fs.getPath()))).append(".bak").toString())))
			logger.info((new StringBuilder("����")).append(fs.getPath()).append("Ϊ").append(fs.getPath()).append(".bak�ɹ���").toString());
		else
			logger.warn((new StringBuilder("����")).append(fs.getPath()).append("Ϊ").append(fs.getPath()).append(".bakʧ�ܣ�").toString());
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
