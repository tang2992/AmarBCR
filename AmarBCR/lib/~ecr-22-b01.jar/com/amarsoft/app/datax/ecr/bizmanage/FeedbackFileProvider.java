// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FeedbackFileProvider.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizmanage:
//			MBRFeedback

public class FeedbackFileProvider extends MessageFileProvider
{

	public FeedbackFileProvider(String messageFile)
		throws ECRException
	{
		super(messageFile);
	}

	public MessageBodyReader getMessageBodyReader(Message message)
		throws ECRException
	{
		MBRFeedback mbr = new MBRFeedback(message);
		mbr.setMessageDataReader(reader);
		return mbr;
	}
}
