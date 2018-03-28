package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;

public interface RecordFilter
{

	public abstract void init()
		throws BCRException;

	public abstract boolean accept(Message message, Record record);

	public abstract void close();
}
