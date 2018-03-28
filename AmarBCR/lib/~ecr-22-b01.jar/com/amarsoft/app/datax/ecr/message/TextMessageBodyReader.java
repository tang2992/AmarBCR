// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   TextMessageBodyReader.java

package com.amarsoft.app.datax.ecr.message;

import com.amarsoft.app.datax.ecr.ECRException;
import java.io.BufferedReader;

// Referenced classes of package com.amarsoft.app.datax.ecr.message:
//			MessageBodyReader, MessageFileProvider, Message, Record

public abstract class TextMessageBodyReader extends MessageBodyReader
{

	protected BufferedReader messageDataReader;

	public TextMessageBodyReader(Message message, BufferedReader reader)
	{
		super(message);
		messageDataReader = null;
		messageDataReader = reader;
	}

	public TextMessageBodyReader(Message message)
	{
		super(message);
		messageDataReader = null;
	}

	public void open()
		throws ECRException
	{
	}

	public void close()
		throws ECRException
	{
	}

	public final BufferedReader getMessageDataReader()
	{
		return messageDataReader;
	}

	public final void setMessageDataReader(BufferedReader messageDataReader)
	{
		this.messageDataReader = messageDataReader;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		byte row[] = MessageFileProvider.readLine(messageDataReader);
		if (row == null)
			throw new ECRException("错误报文结构，没有报文尾");
		if (row[0] == 90)
		{
			return false;
		} else
		{
			fillRecord(row, r);
			return true;
		}
	}

	protected abstract void fillRecord(byte abyte0[], Record record)
		throws ECRException;
}
