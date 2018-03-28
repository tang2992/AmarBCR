// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ReportLoader.java

package com.amarsoft.app.datax.ecr.finrpt;

import com.amarsoft.app.datax.ecr.ECRException;

// Referenced classes of package com.amarsoft.app.datax.ecr.finrpt:
//			FinanceReport

public interface ReportLoader
{

	public abstract void open()
		throws ECRException;

	public abstract void close();

	public abstract boolean loadReport(FinanceReport financereport)
		throws ECRException;
}
