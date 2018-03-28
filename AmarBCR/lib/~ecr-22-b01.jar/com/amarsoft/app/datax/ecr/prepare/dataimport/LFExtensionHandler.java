// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   LFExtensionHandler.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.dpx.recordset.Record;
import com.amarsoft.are.log.Log;
import java.sql.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.prepare.dataimport:
//			ECRUpdateHandler

public class LFExtensionHandler extends ECRUpdateHandler
{

	private PreparedStatement psGetMaxNo;
	private String duebillNoField;

	public LFExtensionHandler()
	{
		psGetMaxNo = null;
		duebillNoField = null;
	}

	protected void insertRecord(Record arg0)
		throws SQLException
	{
		setSerialNo(arg0);
		super.insertRecord(arg0);
	}

	protected void setSerialNo(Record curRecord)
		throws SQLException
	{
		if (psGetMaxNo == null)
			prepare();
		Field dueField = curRecord.getField(duebillNoField);
		Field extField = curRecord.getField("ExtenTimes");
		if (dueField == null || extField == null)
			return;
		psGetMaxNo.setString(1, dueField.getString());
		ResultSet rs = psGetMaxNo.executeQuery();
		int mn = 0;
		String extentTimes = null;
		if (rs.next())
		{
			extentTimes = rs.getString(1);
			if (rs.wasNull())
				mn = 0;
			else
				mn = Integer.parseInt(extentTimes);
		}
		rs.close();
		if (mn + 1 < 10)
			extentTimes = (new StringBuilder("0")).append(String.valueOf(mn + 1)).toString();
		else
			extentTimes = String.valueOf(mn + 1);
		extField.setValue(extentTimes);
	}

	private void prepare()
		throws SQLException
	{
		StringBuffer sqlb = new StringBuffer("select max(ExtenTimes) from ");
		String table = getTable();
		if (table.equalsIgnoreCase("ECR_LOANEXTENSION"))
			duebillNoField = "LDuebillNo";
		else
			duebillNoField = "FDuebillNo";
		sqlb.append(table).append(" where ").append(duebillNoField).append("=?");
		if (logger.isDebugEnabled())
			logger.debug((new StringBuilder("ExtensionHandler get max extendtimes:")).append(sqlb).toString());
		psGetMaxNo = connection.prepareStatement(sqlb.toString());
		setCommitNumber(1);
	}
}
