// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRFeedbatchDelete.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.io.BufferedReader;

public class MBRFeedbatchDelete extends TextMessageBodyReader
{

	public MBRFeedbatchDelete(Message message, BufferedReader reader)
	{
		super(message, reader);
	}

	public MBRFeedbatchDelete(Message message)
	{
		super(message);
	}

	protected void fillRecord(byte data[], Record record)
		throws ECRException
	{
		com.amarsoft.app.datax.ecr.message.Segment seg = record.createSegment("B");
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
