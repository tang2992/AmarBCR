// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ValidateUnit.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			MessageProcessSessionUnit, ValidateSession, MessageProcessSession

public class ValidateUnit extends MessageProcessSessionUnit
{

	public ValidateUnit()
	{
	}

	protected MessageProcessSession createSession()
		throws ECRException
	{
		ValidateSession sess = new ValidateSession();
		return sess;
	}
}
