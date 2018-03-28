// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   TransferSession.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.bizcollect.SimpleECRProvider;
import com.amarsoft.app.datax.ecr.bizcollect.TransferHandler;
import com.amarsoft.are.log.Log;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			MessageProcessSession

public class TransferSession extends MessageProcessSession
{

	private String database;

	public TransferSession()
	{
		database = "ecr";
	}

	public TransferSession(String messageSetType)
	{
		database = "ecr";
		setMessageSetType(messageSetType);
	}

	public boolean init()
	{
		SimpleECRProvider p = new SimpleECRProvider();
		String f = " (IncrementFlag='1' or IncrementFlag='2') ";
		p.setDataFilter(f);
		TransferHandler h = new TransferHandler();
		h.setDatabase(database);
		provider = p;
		handler = h;
		return true;
	}

	public void postProcess()
	{
		if (getStatus() == 100)
			logger.info((new StringBuilder("共处理记录数：")).append(((TransferHandler)handler).getTotalRecordNumber()).append(", 其中成功迁移：").append(((TransferHandler)handler).getPassedRecordNumber()).append(", 被过滤器拒绝：").append(((TransferHandler)handler).getRefusedRecordNumber()).toString());
	}
}
