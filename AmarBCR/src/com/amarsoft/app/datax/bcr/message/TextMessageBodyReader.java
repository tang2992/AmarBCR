package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;
import java.io.BufferedReader;


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
		throws BCRException
	{
	}

	public void close()
		throws BCRException
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
		throws BCRException
	{
		byte row[] = MessageFileProvider.readLine(messageDataReader);
		if (row == null)
			throw new BCRException("错误报文结构，没有报文尾");
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
		throws BCRException;
}
