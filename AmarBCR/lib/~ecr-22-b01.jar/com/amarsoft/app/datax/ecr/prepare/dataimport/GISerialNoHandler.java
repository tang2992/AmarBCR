// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   GISerialNoHandler.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.dpx.recordset.Record;
import com.amarsoft.are.log.Log;
import java.sql.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.prepare.dataimport:
//			ECRUpdateHandler

public class GISerialNoHandler extends ECRUpdateHandler
{

	private PreparedStatement psGetMaxNo;
	private String serialNoField;
	private String gContractNoField;
	private String dbType;

	public GISerialNoHandler()
	{
		psGetMaxNo = null;
		serialNoField = null;
		gContractNoField = null;
		dbType = null;
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
		if (dbRecord.getField(serialNoField).isNull())
		{
			Field contractField = curRecord.getField("ContractNo");
			Field gContractField = curRecord.getField(gContractNoField);
			Field serialField = curRecord.getField(serialNoField);
			if (contractField == null || gContractField == null || serialField == null)
				return;
			psGetMaxNo.setString(1, contractField.getString());
			psGetMaxNo.setString(2, gContractField.getString());
			ResultSet rs = psGetMaxNo.executeQuery();
			String temp = "";
			if (rs.next())
			{
				temp = rs.getString(1);
				if (rs.wasNull())
					temp = "0";
			}
			String temp2 = null;
			if ("3".equals(getDbType()))
				temp2 = Tools.a10to62_mssql(Tools.a62to10_mssql(temp) + 1L);
			else
			if ("2".equals(getDbType()))
				temp2 = Tools.a10to62_db2(Tools.a62to10_db2(temp) + 1L);
			else
				temp2 = Tools.a10to62_ora(Tools.a62to10_ora(temp) + 1L);
			if (temp2.length() == 1)
				temp2 = (new StringBuilder("0")).append(temp2).toString();
			serialField.setValue(temp2);
			rs.close();
		}
	}

	private void prepare()
		throws SQLException
	{
		setDbType(ARE.getProperty("dbType"));
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

	protected String getDbType()
	{
		return dbType;
	}

	protected void setDbType(String dbType)
	{
		this.dbType = dbType;
	}
}
