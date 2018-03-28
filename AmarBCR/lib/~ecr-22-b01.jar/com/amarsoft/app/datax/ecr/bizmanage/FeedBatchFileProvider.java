// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FeedBatchFileProvider.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizmanage:
//			MBRFeedbatchDelete

public class FeedBatchFileProvider extends MessageFileProvider
{

	public FeedBatchFileProvider(String messageFile)
		throws ECRException
	{
		super(messageFile);
	}

	public MessageBodyReader getMessageBodyReader(Message message)
		throws ECRException
	{
		MBRFeedbatchDelete mbr = new MBRFeedbatchDelete(message);
		mbr.setMessageDataReader(reader);
		return mbr;
	}
}
