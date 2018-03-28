package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;

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
		throws BCRException;

	public final Record read()
		throws BCRException
	{
		Record record = null;
		try
		{
			record = (Record)recordArrayOfMessage[recordIndexOfMessage].clone();
		}
		catch (CloneNotSupportedException e)
		{
			throw new BCRException("Create record failed", e);
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
		throws BCRException;

	public abstract void close()
		throws BCRException;

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
