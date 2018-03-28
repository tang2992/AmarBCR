// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MessageBodyReader.java

package com.amarsoft.app.datax.ecr.message;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;

// Referenced classes of package com.amarsoft.app.datax.ecr.message:
//			Message, Record

public abstract class MessageBodyReader
{

	protected Message message;
	private Record recordArrayOfMessage[];
	private int recordIndexOfMessage;
	protected Log logger;

	public MessageBodyReader(Message message)
	{
		this.message = null;
		recordArrayOfMessage = null;
		recordIndexOfMessage = 0;
		logger = null;
		this.message = message;
		recordArrayOfMessage = message.getDataRecordArray();
		recordIndexOfMessage = 0;
		logger = ARE.getLog();
	}

	public abstract void open()
		throws ECRException;

	public final Record read()
		throws ECRException
	{
		Record record = null;
		try
		{
			record = (Record)recordArrayOfMessage[recordIndexOfMessage].clone();
		}
		catch (CloneNotSupportedException e)
		{
			throw new ECRException("Create record failed", e);
		}
		if (!fillRecord(record))
		{
			recordIndexOfMessage++;
			if (recordIndexOfMessage < recordArrayOfMessage.length)
				record = read();
			else
				record = null;
		}
		return record;
	}

	protected abstract boolean fillRecord(Record record)
		throws ECRException;

	public abstract void close()
		throws ECRException;

	public final Message getMessage()
	{
		return message;
	}

	public final void setMessage(Message message)
	{
		this.message = message;
		recordArrayOfMessage = message.getDataRecordArray();
		recordIndexOfMessage = 0;
	}
}
