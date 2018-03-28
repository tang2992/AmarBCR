// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   Handler.java

package com.amarsoft.app.datax.ecr.message;

import com.amarsoft.app.datax.ecr.ECRException;

// Referenced classes of package com.amarsoft.app.datax.ecr.message:
//			Message, Record, MessageSet

public interface Handler
{

	public abstract void messageStart(Message message)
		throws ECRException;

	public abstract void handleHeader(Message message, Record record)
		throws ECRException;

	public abstract void handleRecord(Message message, Record record)
		throws ECRException;

	public abstract void handleFooter(Message message, Record record)
		throws ECRException;

	public abstract void messageEnd(Message message)
		throws ECRException;

	public abstract void start(MessageSet messageset)
		throws ECRException;

	public abstract void end(MessageSet messageset)
		throws ECRException;
}
