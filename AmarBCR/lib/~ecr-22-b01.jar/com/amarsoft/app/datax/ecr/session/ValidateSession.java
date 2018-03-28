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
			logger.error("校验规则文件配置有误！");
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
			logger.error((new StringBuilder("校验规则文件加载失败,文件: ")).append(messageValidateRuleFile).toString(), e1);
			return false;
		}
		try
		{
			DicUtil.initDicUtil(validateDicFile);
		}
		catch (Exception e)
		{
			logger.error((new StringBuilder("加载数据校验字典失败,文件 :")).append(validateDicFile).toString(), e);
			return false;
		}
		provider = p;
		handler = h;
		return true;
	}

	public void postProcess()
	{
		if (getStatus() == 100)
			logger.info((new StringBuilder("共校验记录数：")).append(((ValidateHandler)handler).getTotalRecordNumber()).append(", 其中正确记录：").append(((ValidateHandler)handler).getCorrectRecordNumber()).append(", 检验到错误数：").append(((ValidateHandler)handler).getErrorRecordNumber()).append(", 错误关联记录：").append(((ValidateHandler)handler).getErrorRelativedRecordNumber()).toString());
	}
}
