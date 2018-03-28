// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ValidateSession.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizcollect.SimpleECRProvider;
import com.amarsoft.app.datax.ecr.bizcollect.ValidateHandler;
import com.amarsoft.are.log.Log;
import com.cfcc.ecus.eft.util.DicUtil;
import java.io.File;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			MessageProcessSession

public class ValidateSession extends MessageProcessSession
{

	private String messageValidateRuleFile;
	private String validateDicFile;
	private String database;

	public ValidateSession()
	{
		messageValidateRuleFile = null;
		validateDicFile = "etc/dic.xml";
		database = "ecr";
	}

	public final String getDatabase()
	{
		return database;
	}

	public final void setDatabase(String database)
	{
		this.database = database;
	}

	public final String getMessageValidateRuleFile()
	{
		return messageValidateRuleFile;
	}

	public final void setMessageValidateRuleFile(String messageValidateRuleFile)
	{
		this.messageValidateRuleFile = messageValidateRuleFile;
	}

	public final String getValidateDicFile()
	{
		return validateDicFile;
	}

	public final void setValidateDicFile(String validateDicFile)
	{
		this.validateDicFile = validateDicFile;
	}

	public boolean init()
	{
		SimpleECRProvider p = new SimpleECRProvider();
		String f = " (IncrementFlag='1' or IncrementFlag='2') ";
		p.setDataFilter(f);
		if (messageValidateRuleFile == null || !(new File(messageValidateRuleFile)).exists())
		{
			logger.error("У������ļ���������");
			return false;
		}
		ValidateHandler h = new ValidateHandler();
		h.setDatabase(database);
		h.setRulesFile(messageValidateRuleFile);
		try
		{
			h.loadRulesFromXMLFile(messageValidateRuleFile);
		}
		catch (ECRException e1)
		{
			logger.error((new StringBuilder("У������ļ�����ʧ��,�ļ�: ")).append(messageValidateRuleFile).toString(), e1);
			return false;
		}
		try
		{
			DicUtil.initDicUtil(validateDicFile);
		}
		catch (Exception e)
		{
			logger.error((new StringBuilder("��������У���ֵ�ʧ��,�ļ� :")).append(validateDicFile).toString(), e);
			return false;
		}
		provider = p;
		handler = h;
		return true;
	}

	public void postProcess()
	{
		if (getStatus() == 100)
			logger.info((new StringBuilder("��У���¼����")).append(((ValidateHandler)handler).getTotalRecordNumber()).append(", ������ȷ��¼��").append(((ValidateHandler)handler).getCorrectRecordNumber()).append(", ���鵽��������").append(((ValidateHandler)handler).getErrorRecordNumber()).append(", ���������¼��").append(((ValidateHandler)handler).getErrorRelativedRecordNumber()).toString());
	}
}
