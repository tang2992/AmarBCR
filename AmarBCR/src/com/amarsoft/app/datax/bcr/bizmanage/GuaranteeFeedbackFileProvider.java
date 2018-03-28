package com.amarsoft.app.datax.bcr.bizmanage;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.*;
import java.io.*;

public class GuaranteeFeedbackFileProvider extends MessageFileProvider
{

	private int recordCount;

	public GuaranteeFeedbackFileProvider(String messageFile)
		throws BCRException
	{
		super(messageFile);
		recordCount = 0;
	}

	public MessageBodyReader getMessageBodyReader(Message message)
		throws BCRException
	{
		MBRGuaranteeFeedback mbr = new MBRGuaranteeFeedback(message);
		mbr.setMessageDataReader(reader);
		return mbr;
	}

	public void readFooter(Message msg, Record footer)
		throws BCRException
	{
		Segment seg = footer.createSegment("Z");
		seg.getField(2501).setString("Z");
		seg.getField(2502).setInt(msg.getRecordCount());
		recordCount += msg.getRecordCount();
		super.setRecordCount(recordCount);
	}

	public void readHeader(Message msg, Record header)
		throws BCRException
	{
		Segment seg = header.createSegment("A");
		byte row[];
		while ((row = readLine(reader)) != null) 
			if (row[0] == 65)
			{
				fillSegment(row, seg);
				return;
			}
		String emptyMessage = "A1.000000000000         000000000000000000000000000000000000000000000000000                                                                                       \nZ0000000000";
		reader = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(emptyMessage.getBytes())));
		readHeader(msg, header);
	}
}
