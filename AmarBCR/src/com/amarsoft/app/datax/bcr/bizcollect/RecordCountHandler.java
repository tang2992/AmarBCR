package com.amarsoft.app.datax.bcr.bizcollect;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.*;

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
		throws BCRException
	{
		messageIndex++;
		messageRecordNumber[messageIndex][0] = message.getType();
	}

	public void handleHeader(Message message1, Record record)
		throws BCRException
	{
	}

	public void handleRecord(Message message1, Record record1)
		throws BCRException
	{
	}

	public void handleFooter(Message message, Record footer)
		throws BCRException
	{
		if (message.getType() == 7 || message.getType() == 8 || message.getType() == 32 || message.getType() == 33 || message.getType() == 36 || message.getType() == 81 ){
			messageRecordNumber[messageIndex][1] = footer.getFirstSegment("Z").getField(2202).getInt();
		}else if(message.getType() == 82 || message.getType() == 83){
			messageRecordNumber[messageIndex][1] = footer.getFirstSegment("Z").getField(3002).getInt();
		}else{
			messageRecordNumber[messageIndex][1] = footer.getFirstSegment("Z").getField(4513).getInt();
		}
	}

	public void messageEnd(Message message)
		throws BCRException
	{
		totalRecordNumber += messageRecordNumber[messageIndex][1];
	}

	public void start(MessageSet messageSet)
		throws BCRException
	{
		totalRecordNumber = 0;
		messageRecordNumber = new int[messageSet.getMessages().length][2];
		messageIndex = -1;
	}

	public void end(MessageSet messageset)
		throws BCRException
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
