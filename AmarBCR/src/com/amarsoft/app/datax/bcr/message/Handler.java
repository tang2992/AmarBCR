package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;

public interface Handler
{

	public abstract void messageStart(Message message)
		throws BCRException;

	public abstract void handleHeader(Message message, Record record)
		throws BCRException;

	public abstract void handleRecord(Message message, Record record)
		throws BCRException;

	public abstract void handleFooter(Message message, Record record)
		throws BCRException;

	public abstract void messageEnd(Message message)
		throws BCRException;

	public abstract void start(MessageSet messageset)
		throws BCRException;

	public abstract void end(MessageSet messageset)
		throws BCRException;
}
