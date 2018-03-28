// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ErrorRecord.java

package com.amarsoft.app.datax.ecr.validate;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.Segment;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate:
//			ValidateRule

public interface ErrorRecord
{

	public abstract void writeError(ValidateRule validaterule, Segment segment)
		throws ECRException;

	public abstract void clearAllError()
		throws ECRException;

	public abstract void clearMessageError(int i)
		throws ECRException;

	public abstract void open()
		throws ECRException;

	public abstract void close();
}
