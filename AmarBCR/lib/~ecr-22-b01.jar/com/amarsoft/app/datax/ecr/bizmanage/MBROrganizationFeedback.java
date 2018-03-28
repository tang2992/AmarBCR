// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBROrganizationFeedback.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.io.BufferedReader;

public class MBROrganizationFeedback extends TextMessageBodyReader
{

	public MBROrganizationFeedback(Message message, BufferedReader reader)
	{
		super(message, reader);
	}

	public MBROrganizationFeedback(Message message)
	{
		super(message);
	}

	protected void fillRecord(byte data[], Record record)
		throws ECRException
	{
		String messageFile = message.getHeader().getFirstSegment("A").getField(2305).getString();
		int messageType = 0;
		if (messageFile.substring(28, 30).equals("32"))
			messageType = 37;
		else
			messageType = 36;
		Segment seg = record.createSegment("B");
		String backRecord = new String(data);
		int backRecordLength = backRecord.getBytes().length;
		String errorRecord = "";
		int errorRownum = 0;
		String errorMsg = "";
		int recordType = 0;
		errorRownum = Integer.parseInt(backRecord.substring(0, 10));
		if (messageType == 36)
		{
			int idx = backRecord.indexOf("B");
			errorRecord = backRecord.substring(idx);
			errorMsg = backRecord.substring(10, idx);
			if (errorRecord.getBytes().length == 254)
				recordType = 77;
			else
				recordType = 75;
		} else
		{
			String flag = (new StringBuilder()).append(backRecord.charAt(backRecordLength - 50)).toString();
			if (flag.matches("[B-I]"))
			{
				recordType = 76;
				errorRecord = backRecord.substring(backRecordLength - 91);
				errorMsg = backRecord.substring(10, backRecordLength - 91);
			} else
			{
				recordType = 78;
				errorRecord = backRecord.substring(backRecordLength - 94);
				errorMsg = backRecord.substring(10, backRecordLength - 94);
			}
		}
		seg.getField(2401).setInt(errorRownum);
		seg.getField(2402).setString(errorMsg);
		seg.getField(2403).setString(errorRecord);
		seg.getField(2409).setInt(recordType);
	}
}
