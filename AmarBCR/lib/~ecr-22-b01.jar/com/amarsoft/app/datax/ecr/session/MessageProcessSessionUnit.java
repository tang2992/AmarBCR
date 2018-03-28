// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MessageProcessSessionUnit.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.util.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			MessageProcessSession

public abstract class MessageProcessSessionUnit extends ExecuteUnit
{

	private MessageProcessSession session;

	public MessageProcessSessionUnit()
	{
		session = null;
	}

	protected abstract MessageProcessSession createSession()
		throws ECRException;

	public final int execute()
	{
		transferUnitProperties();
		try
		{
			session = createSession();
		}
		catch (ECRException e1)
		{
			ARE.getLog().fatal("创建报文处理过程失败", e1);
			return 2;
		}
		if (session == null)
		{
			ARE.getLog().fatal("创建报文处理过程失败！");
			return 2;
		}
		String p;
		for (Iterator it = extendProperties.keySet().iterator(); it.hasNext(); ObjectX.setPropertyX(session, p, getProperty(p), true))
			p = (String)it.next();

		try
		{
			session.start();
		}
		catch (ECRException e)
		{
			session.logger.fatal((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("失败").toString(), e);
			sessionFailed(session);
			return 2;
		}
		int st = session.getStatus();
		if (st == 100)
		{
			session.logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("成功！").toString());
			sessionSuccessful(session);
			return 1;
		}
		if (st == 10)
		{
			session.logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("条件不具备！").toString());
			sessionWarning(session);
			return 3;
		} else
		{
			sessionFailed(session);
			return 2;
		}
	}

	protected void sessionSuccessful(MessageProcessSession messageprocesssession)
	{
	}

	protected void sessionFailed(MessageProcessSession messageprocesssession)
	{
	}

	protected void sessionWarning(MessageProcessSession messageprocesssession)
	{
	}
}
