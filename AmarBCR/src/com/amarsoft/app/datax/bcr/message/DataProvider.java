package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;

public interface DataProvider
{

	public abstract String generateFileName(MessageSet messageset)
		throws BCRException;

	public abstract void readHeader(Message message, Record record)
		throws BCRException;

	public abstract void readFooter(Message message, Record record)
		throws BCRException;

	public abstract MessageBodyReader getMessageBodyReader(Message message)
		throws BCRException;
}
