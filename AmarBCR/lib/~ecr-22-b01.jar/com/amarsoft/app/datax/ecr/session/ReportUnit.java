// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ReportUnit.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			MessageProcessSessionUnit, ReportSession, MessageProcessSession

public class ReportUnit extends MessageProcessSessionUnit
{

	public ReportUnit()
	{
	}

	protected MessageProcessSession createSession()
		throws ECRException
	{
		String msgs = getProperty("com.amarsoft.app.datax.ecr.session.ReportSession.messageSetType", "11");
		boolean retry = getProperty("com.amarsoft.app.datax.ecr.session.ReportSession.retryMessage", false);
		ReportSession sess = ReportSession.getSession(msgs, retry);
		return sess;
	}
}
