// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRFeedback.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.io.BufferedReader;

public class MBRFeedback extends TextMessageBodyReader
{

	public MBRFeedback(Message message, BufferedReader reader)
	{
		super(message, reader);
	}

	public MBRFeedback(Message message)
	{
		super(message);
	}

	protected void fillRecord(byte data[], Record record)
		throws ECRException
	{
		Segment seg = record.createSegment("B");
		MessageFileProvider.fillSegment(data, seg);
		Field fldErrLen = seg.getField(4515);
		int errLength = fldErrLen.getInt();
		Field fldErrMsg = seg.getField(9915);
		fldErrMsg.setEndPosition((fldErrMsg.getStartPosition() + errLength) - 1);
		Field fldRecordData = seg.getField(9916);
		fldRecordData.setStartPosition(fldErrMsg.getEndPosition() + 1);
		fldRecordData.setEndPosition(data.length - 1);
		MessageFileProvider.fillSegment(data, seg);
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		boolean ret = super.fillRecord(r);
		if (!ret)
		{
			byte d[] = MessageFileProvider.readLine(messageDataReader);
			if (d != null)
			{
				for (; d[0] != 65; d = MessageFileProvider.readLine(messageDataReader));
				return fillRecord(r);
			}
		}
		return ret;
	}
}
