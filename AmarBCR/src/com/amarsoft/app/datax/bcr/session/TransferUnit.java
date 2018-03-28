package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;

public class TransferUnit extends MessageProcessSessionUnit
{

	public TransferUnit()
	{
	}

	protected MessageProcessSession createSession()
		throws BCRException
	{
		TransferSession sess = new TransferSession();
		return sess;
	}
}
