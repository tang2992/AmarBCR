// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MessageProcessSession.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class MessageProcessSession
{

	public static final int STATUS_INIT = 0;
	public static final int STATUS_READY = 10;
	public static final int STATUS_PROCESS = 20;
	public static final int STATUS_COMPLETE = 100;
	public static final String DEFAULT_ECR_DATABASE = "ecr";
	public static final String VIRTUAL_FINANCEID = "99999999999";
	public static final String VIRTUAL_CONTACTPERSON = "***";
	public static final String VIRTUAL_CONTACTPHONE = "*******";
	public static final String VIRTUAL_SESSION_WAIT_REPORT = "0000000000";
	public static final String VIRTUAL_SESSION_WAIT_RETRY = "1111111111";
	public static final String VIRTUAL_SESSION_NEEDNT_RETRY = "6666666666";
	public static final String VIRTUAL_SESSION_FEEDBACK_POOL = "9999999999";
	public static final String VIRTUAL_SESSION_FEEDBACK_ERROR = "7777777777";
	public static final String VIRTUAL_SESSION_FEEDBACK_SUCCESS = "8888888888";
	private String sessionId;
	private String financeId;
	private String contactPerson;
	private String contactPhone;
	private int status;
	private String messageSetType;
	private Date createTime;
	private String note;
	private String messageConfigFile;
	protected SimpleDateFormat dateFormater;
	protected Log logger;
	protected MessageSet messageSet;
	protected DataProvider provider;
	protected Handler handler;

	public MessageProcessSession()
	{
		sessionId = "1111111111";
		financeId = "99999999999";
		contactPerson = "***";
		contactPhone = "*******";
		status = 0;
		messageSetType = null;
		createTime = null;
		note = null;
		messageConfigFile = null;
		dateFormater = new SimpleDateFormat();
		logger = ARE.getLog();
		messageSet = null;
		provider = null;
		handler = null;
	}

	public void save()
		throws ECRException
	{
	}

	public abstract boolean init();

	public boolean ready()
	{
		return true;
	}

	public boolean process()
	{
		if (provider == null)
		{
			logger.error("���������ṩ��δ���ã�����init������ʵ�����ã�");
			return false;
		}
		if (handler == null)
		{
			logger.error("�������ݴ��������δ���ã�����init������ʵ�����ã�");
			return false;
		}
		messageSet.setHandler(handler);
		try
		{
			messageSet.parse(provider);
		}
		catch (ECRException e)
		{
			logger.debug(e);
			return false;
		}
		return true;
	}

	public void postProcess()
	{
	}

	public final void start()
		throws ECRException
	{
		if (messageSet == null)
		{
			messageSet = MessageSet.createMessageSetFromXml(messageConfigFile);
			if (messageSetType == null)
				messageSetType = messageSet.getType();
			if (!messageSetType.equals(messageSet.getType()))
				throw new ECRException((new StringBuilder("������̱��ļ�������(")).append(messageSetType).append(")�������ļ��ı��ļ�������(").append(messageSet.getType()).append(")��һ�£�").toString());
		}
		logger.info((new StringBuilder("��ʼ�����Ĵ������[")).append(getSessionId()).append("]......").toString());
		if (init())
		{
			logger.info("��ʼ�����Ĵ��������ɣ�");
			setStatus(10);
		} else
		{
			logger.error("��ʼ�����Ĵ������ʧ�ܣ�");
			postProcess();
			return;
		}
		logger.info((new StringBuilder("��鱨�Ĵ����������[")).append(getSessionId()).append("]......").toString());
		if (ready())
		{
			logger.info("��������������");
			setStatus(20);
		} else
		{
			logger.warn("�������������죡");
			postProcess();
			return;
		}
		logger.info((new StringBuilder("ִ�д����Ĵ������[")).append(getSessionId()).append("]......").toString());
		if (process())
		{
			logger.info("ִ�б��Ĵ��������ɣ�");
			setStatus(100);
		} else
		{
			logger.error("ִ�б��Ĵ������ʧ�ܣ�");
			throw new ECRException("ִ�б��Ĵ������ʧ�ܣ�");
		}
		save();
		postProcess();
	}

	public final String getFinanceId()
	{
		return financeId;
	}

	public String getContactPerson()
	{
		return contactPerson;
	}

	public String getContactPhone()
	{
		return contactPhone;
	}

	public final String getSessionId()
	{
		return sessionId;
	}

	public final Date getCreateTime()
	{
		return createTime;
	}

	public final String getNote()
	{
		return note;
	}

	public final String getCreateTime(String format)
	{
		if (format == null)
			format = "yyyyMMdd";
		dateFormater.applyPattern(format);
		return dateFormater.format(createTime);
	}

	public final String getMessageSetType()
	{
		return messageSetType;
	}

	public final int getStatus()
	{
		return status;
	}

	public final void setStatus(int sessionStatus)
	{
		status = sessionStatus;
	}

	public final void setCreateTime(Date createTime)
	{
		this.createTime = createTime;
	}

	public final void setFinanceId(String financeCode)
	{
		financeId = financeCode;
	}

	public void setContactPerson(String contactPerson)
	{
		this.contactPerson = contactPerson;
	}

	public void setContactPhone(String contactPhone)
	{
		this.contactPhone = contactPhone;
	}

	public final void setMessageSetType(String messageSetType)
	{
		this.messageSetType = messageSetType;
	}

	public final void setNote(String note)
	{
		this.note = note;
	}

	public final void setSessionId(String sessionId)
	{
		this.sessionId = sessionId;
	}

	public final String getMessageConfigFile()
	{
		return messageConfigFile;
	}

	public final void setMessageConfigFile(String messageConfigFile)
	{
		this.messageConfigFile = messageConfigFile;
	}
}
