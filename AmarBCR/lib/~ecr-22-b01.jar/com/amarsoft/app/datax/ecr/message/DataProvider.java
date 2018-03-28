// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DataProvider.java

package com.amarsoft.app.datax.ecr.message;

import com.amarsoft.app.datax.ecr.ECRException;

// Referenced classes of package com.amarsoft.app.datax.ecr.message:
//			MessageSet, Message, Record, MessageBodyReader

public interface DataProvider
{

	public abstract String generateFileName(MessageSet messageset)
		throws ECRException;

	public abstract void readHeader(Message message, Record record)
		throws ECRException;

	public abstract void readFooter(Message message, Record record)
		throws ECRException;

	public abstract MessageBodyReader getMessageBodyReader(Message message)
		throws ECRException;
}
