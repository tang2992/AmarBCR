// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   RecordFilter.java

package com.amarsoft.app.datax.ecr.message;

import com.amarsoft.app.datax.ecr.ECRException;

// Referenced classes of package com.amarsoft.app.datax.ecr.message:
//			Message, Record

public interface RecordFilter
{

	public abstract void init()
		throws ECRException;

	public abstract boolean accept(Message message, Record record);

	public abstract void close();
}
