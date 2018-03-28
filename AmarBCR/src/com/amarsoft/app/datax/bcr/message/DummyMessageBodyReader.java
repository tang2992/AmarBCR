package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;

public class DummyMessageBodyReader extends MessageBodyReader
{

	public DummyMessageBodyReader(Message message)
	{
		super(message);
	}

	public void open()
		throws BCRException
	{
	}

	protected boolean fillRecord(Record r)
		throws BCRException
	{
		return false;
	}

	public void close()
		throws BCRException
	{
	}
}
