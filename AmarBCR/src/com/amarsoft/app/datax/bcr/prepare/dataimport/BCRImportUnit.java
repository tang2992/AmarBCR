package com.amarsoft.app.datax.bcr.prepare.dataimport;

import com.amarsoft.are.dpx.recordset.RecordSetException;
import com.amarsoft.task.units.dpx.PRHUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BCRImportUnit extends PRHUnit
{

	public BCRImportUnit()
	{
	}

	protected void preprocess()
		throws RecordSetException
	{
		if (getProperty("unit.provider") == null)
			setProperty("unit.provider", "com.amarsoft.app.datax.bcr.prepare.dataimport.BCRDataSourceProvider");
		if (getProperty("unit.handlers") == null)
			setProperty("unit.handlers", "com.amarsoft.app.datax.bcr.prepare.dataimport.BCRUpdateHandler");
		if (getProperty("unit.handlers").indexOf("com.amarsoft.app.datax.bcr.prepare.dataimport.BCRUpdateHandler") >= 0)
		{
			String col[] = {
				"INCREMENTFLAG", "OCCURDATE"
			};
			for (int i = 0; i < col.length; i++)
				if (!hasUpdateColumn("com.amarsoft.app.datax.bcr.prepare.dataimport.BCRUpdateHandler", col[i]))
					throw new RecordSetException((new StringBuilder(String.valueOf(col[i]))).append("字段必须在更新列表中!").toString());

		}
		if (getProperty("unit.handlers").indexOf("com.amarsoft.app.datax.bcr.prepare.dataimport.FIDChangeHandler") >= 0)
		{
			String col[] = {
				"INCREMENTFLAG", "OCCURDATE", "FINANCEID", "OLDFINANCEID"
			};
			for (int i = 0; i < col.length; i++)
				if (!hasUpdateColumn("com.amarsoft.app.datax.bcr.prepare.dataimport.FIDChangeHandler", col[i]))
					throw new RecordSetException((new StringBuilder(String.valueOf(col[i]))).append("字段必须在更新列表中!").toString());

		}
	}

	private boolean hasUpdateColumn(String handlerClass, String col)
	{
		String updateCols = getProperty((new StringBuilder(String.valueOf(handlerClass))).append(".updateColumns").toString(), "");
		Pattern p = Pattern.compile(col, 2);
		Matcher m = p.matcher(updateCols);
		return m.find();
	}
}
