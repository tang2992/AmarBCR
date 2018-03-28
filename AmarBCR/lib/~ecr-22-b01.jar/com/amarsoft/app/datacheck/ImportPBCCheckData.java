// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ImportPBCCheckData.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.AREException;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.Target;
import com.amarsoft.task.Task;

// Referenced classes of package com.amarsoft.app.datacheck:
//			ImportDataFile

public class ImportPBCCheckData extends ImportDataFile
{

	public static final String CHECK_DATE = "checkDate";

	public ImportPBCCheckData()
	{
	}

	protected void init()
		throws AREException
	{
		if ("".equals(getTarget().getTask().getProperty("checkDate")) || getTarget().getTask().getProperty("checkDate") == null)
			logger.fatal("请先执行数据源检查任务！");
		Uri = getProperty("dataSource");
		String date = getTarget().getTask().getProperty("checkDate");
		date = date.replaceAll("/", "-");
		Uri = Uri.replaceAll("yyyy-mm-dd", date);
		super.init();
	}
}
