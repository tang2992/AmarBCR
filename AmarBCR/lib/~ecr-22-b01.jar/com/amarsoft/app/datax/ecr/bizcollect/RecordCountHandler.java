// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   RecordCountHandler.java

package com.amarsoft.app.datax.ecr.bizcollect;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;

public class RecordCountHandler
	implements Handler
{

	private int totalRecordNumber;
	private int messageRecordNumber[][];
	private int messageIndex;

	public RecordCountHandler()
	{
		totalRecordNumber = 0;
		messageRecordNumber = null;
		messageIndex = -1;
	}

	public void messageStart(Message message)
		throws ECRException
	{
		messageIndex++;
		messageRecordNumber[messageIndex][0] = message.getType();
	}

	public void handleHeader(Message message1, Record record)
		throws ECRException
	{
	}

	public void handleRecord(Message message1, Record record1)
		throws ECRException
	{
	}

	public void handleFooter(Message message, Record footer)
		throws ECRException
	{
		if (message.getType() == 7 || message.getType() == 8 || message.getType() == 32 || message.getType() == 33 || message.getType() == 36)
			messageRecordNumber[messageIndex][1] = footer.getFirstSegment("Z").getField(2202).getInt();
		else
			messageRecordNumber[messageIndex][1] = footer.getFirstSegment("Z").getField(4513).getInt();
	}

	public void messageEnd(Message message)
		throws ECRException
	{
		totalRecordNumber += messageRecordNumber[messageIndex][1];
	}

	public void start(MessageSet messageSet)
		throws ECRException
	{
		totalRecordNumber = 0;
		messageRecordNumber = new int[messageSet.getMessages().length][2];
		messageIndex = -1;
	}

	public void end(MessageSet messageset)
		throws ECRException
	{
	}

	public int getTotalRecordNumber()
	{
		return totalRecordNumber;
	}

	public int getMessageRecordNumber(int messageType)
	{
		int num = -1;
		for (int i = 0; i < messageRecordNumber.length; i++)
		{
			if (messageRecordNumber[i][0] != messageType)
				continue;
			num = messageRecordNumber[i][1];
			break;
		}

		return num;
	}
}
