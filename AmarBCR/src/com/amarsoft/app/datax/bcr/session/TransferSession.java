package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.bizcollect.SimpleBCRProvider;
import com.amarsoft.app.datax.bcr.bizcollect.TransferHandler;
import com.amarsoft.are.log.Log;

public class TransferSession extends MessageProcessSession
{

	private String database;

	public TransferSession()
	{
		database = "bcr";
	}

	public TransferSession(String messageSetType)
	{
		database = "bcr";
		setMessageSetType(messageSetType);
	}

	public boolean init()
	{
		SimpleBCRProvider p = new SimpleBCRProvider();
		String f = " (IncrementFlag='1' or IncrementFlag='2') ";
		p.setDataFilter(f);
		TransferHandler h = new TransferHandler();
		h.setDatabase(database);
		provider = p;
		handler = h;
		return true;
	}

	public void postProcess()
	{
		if (getStatus() == 100)
			logger.info((new StringBuilder("�������¼����")).append(((TransferHandler)handler).getTotalRecordNumber()).append(", ���гɹ�Ǩ�ƣ�").append(((TransferHandler)handler).getPassedRecordNumber()).append(", ���������ܾ���").append(((TransferHandler)handler).getRefusedRecordNumber()).toString());
	}
}
