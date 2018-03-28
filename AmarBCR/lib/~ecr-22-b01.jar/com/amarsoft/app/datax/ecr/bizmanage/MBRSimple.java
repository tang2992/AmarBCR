// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRSimple.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.io.BufferedReader;

public class MBRSimple extends TextMessageBodyReader
{

	public MBRSimple(Message message, BufferedReader reader)
	{
		super(message, reader);
	}

	public MBRSimple(Message message)
	{
		super(message);
	}

	protected void fillRecord(byte data[], Record record)
		throws ECRException
	{
		com.amarsoft.app.datax.ecr.message.Segment seg = record.createSegment("B");
		MessageFileProvider.fillSegment(data, seg);
	}
}
