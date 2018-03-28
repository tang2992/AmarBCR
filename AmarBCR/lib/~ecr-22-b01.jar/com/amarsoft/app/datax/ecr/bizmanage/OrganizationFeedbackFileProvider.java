// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   OrganizationFeedbackFileProvider.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.io.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizmanage:
//			MBROrganizationFeedback

public class OrganizationFeedbackFileProvider extends MessageFileProvider
{

	private int recordCount;

	public OrganizationFeedbackFileProvider(String messageFile)
		throws ECRException
	{
		super(messageFile);
		recordCount = 0;
	}

	public MessageBodyReader getMessageBodyReader(Message message)
		throws ECRException
	{
		MBROrganizationFeedback mbr = new MBROrganizationFeedback(message);
		mbr.setMessageDataReader(reader);
		return mbr;
	}

	public void readFooter(Message msg, Record footer)
		throws ECRException
	{
		Segment seg = footer.createSegment("Z");
		seg.getField(2501).setString("Z");
		seg.getField(2502).setInt(msg.getRecordCount());
		recordCount += msg.getRecordCount();
		super.setRecordCount(recordCount);
	}

	public void readHeader(Message msg, Record header)
		throws ECRException
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
