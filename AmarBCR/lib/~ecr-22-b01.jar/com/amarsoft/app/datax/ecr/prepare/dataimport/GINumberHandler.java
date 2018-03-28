// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   GINumberHandler.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.dpx.recordset.Record;
import com.amarsoft.are.log.Log;
import java.sql.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.prepare.dataimport:
//			ECRUpdateHandler

public class GINumberHandler extends ECRUpdateHandler
{

	private PreparedStatement psGetMaxNo;
	private String serialNoField;
	private String gContractNoField;

	public GINumberHandler()
	{
		psGetMaxNo = null;
		serialNoField = null;
		gContractNoField = null;
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
		Field contractField = curRecord.getField("ContractNo");
		Field gContractField = curRecord.getField(gContractNoField);
		Field serialField = curRecord.getField(serialNoField);
		if (contractField == null || gContractField == null || serialField == null)
			return;
		psGetMaxNo.setString(1, contractField.getString());
		psGetMaxNo.setString(2, gContractField.getString());
		ResultSet rs = psGetMaxNo.executeQuery();
		int mn = 0;
		if (rs.next())
		{
			mn = rs.getInt(1);
			if (rs.wasNull())
				mn = 0;
		}
		serialField.setValue(mn + 1);
	}

	private void prepare()
		throws SQLException
	{
		String table = getTable();
		if (table.equalsIgnoreCase("ECR_GUARANTYCONT"))
		{
			serialNoField = "GuarantyNo";
			gContractNoField = "GuarantyContNo";
		} else
		{
			serialNoField = "ImpawNo";
			gContractNoField = "ImpawnContNo";
		}
		StringBuffer sqlb = new StringBuffer((new StringBuilder("select max(")).append(serialNoField).append(") from ").toString());
		sqlb.append(table).append(" where ").append("ContractNo").append("=?");
		sqlb.append(" and ").append(gContractNoField).append("=?");
		if (logger.isDebugEnabled())
			logger.debug((new StringBuilder("GISerialNoHandler get max serialno: ")).append(sqlb).toString());
		psGetMaxNo = connection.prepareStatement(sqlb.toString());
		setCommitNumber(1);
	}
}
