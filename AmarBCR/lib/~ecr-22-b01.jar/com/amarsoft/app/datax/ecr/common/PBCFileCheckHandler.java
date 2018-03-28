// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   PBCFileCheckHandler.java

package com.amarsoft.app.datax.ecr.common;

import com.cfcc.ecus.eft.CheckResult;
import com.cfcc.ecus.eft.cudata.CUCheckResult;

public interface PBCFileCheckHandler
{

	public abstract void handleResult(CheckResult checkresult);

	public abstract void handleResult(CUCheckResult cucheckresult);
}
