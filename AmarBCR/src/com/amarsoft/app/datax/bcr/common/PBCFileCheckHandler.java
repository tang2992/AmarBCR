package com.amarsoft.app.datax.bcr.common;

import com.cfcc.ecus.eft.CheckResult;
import com.cfcc.ecus.eft.cudata.CUCheckResult;

public interface PBCFileCheckHandler
{

	public abstract void handleResult(CheckResult checkresult);

	public abstract void handleResult(CUCheckResult cucheckresult);
}
