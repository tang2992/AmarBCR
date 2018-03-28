// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DummyMessageBodyReader.java

package com.amarsoft.app.datax.ecr.message;

import com.amarsoft.app.datax.ecr.ECRException;

// Referenced classes of package com.amarsoft.app.datax.ecr.message:
//			MessageBodyReader, Message, Record

public class DummyMessageBodyReader extends MessageBodyReader
{

	public DummyMessageBodyReader(Message message)
	{
		super(message);
	}

	public void open()
		throws ECRException
	{
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		return false;
	}

	public void close()
		throws ECRException
	{
	}
}
