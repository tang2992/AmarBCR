// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ECRStockHolderImportUnit.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.RecordSetException;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.task.units.dpx.PRHUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

// Referenced classes of package com.amarsoft.app.datax.ecr.prepare.dataimport:
//			ECRStockHolderUpdateHandler

public class ECRStockHolderImportUnit extends PRHUnit
{

	public ECRStockHolderImportUnit()
	{
	}

	protected void preprocess()
		throws RecordSetException
	{
		if (getProperty("unit.provider") == null)
			setProperty("unit.provider", "com.amarsoft.app.datax.ecr.prepare.dataimport.ECRDataSourceProvider");
		if (getProperty("unit.handlers") == null)
			setProperty("unit.handlers", "com.amarsoft.app.datax.ecr.prepare.dataimport.ECRUpdateHandler");
		if (getProperty("unit.handlers").indexOf("com.amarsoft.app.datax.ecr.prepare.dataimport.ECRUpdateHandler") >= 0)
		{
			String col[] = {
				"INCREMENTFLAG", "OCCURDATE"
			};
			for (int i = 0; i < col.length; i++)
				if (!hasUpdateColumn("com.amarsoft.app.datax.ecr.prepare.dataimport.ECRUpdateHandler", col[i]))
					throw new RecordSetException((new StringBuilder(String.valueOf(col[i]))).append("字段必须在更新列表中!").toString());

		}
		if (getProperty("unit.handlers").indexOf("com.amarsoft.app.datax.ecr.prepare.dataimport.FIDChangeHandler") >= 0)
		{
			String col[] = {
				"INCREMENTFLAG", "OCCURDATE", "FINANCEID", "OLDFINANCEID"
			};
			for (int i = 0; i < col.length; i++)
				if (!hasUpdateColumn("com.amarsoft.app.datax.ecr.prepare.dataimport.FIDChangeHandler", col[i]))
					throw new RecordSetException((new StringBuilder(String.valueOf(col[i]))).append("字段必须在更新列表中!").toString());

		}
		if (StringX.isEmpty(ARE.getProperty("ORGANDIGEST")))
			ARE.setProperty("ORGANDIGEST", ECRStockHolderUpdateHandler.ORGANDIGEST);
	}

	private boolean hasUpdateColumn(String handlerClass, String col)
	{
		String updateCols = getProperty((new StringBuilder(String.valueOf(handlerClass))).append(".updateColumns").toString(), "");
		Pattern p = Pattern.compile(col, 2);
		Matcher m = p.matcher(updateCols);
		return m.find();
	}
}
