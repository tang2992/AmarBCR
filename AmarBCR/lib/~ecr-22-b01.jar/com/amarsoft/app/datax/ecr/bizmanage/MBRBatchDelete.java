// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRBatchDelete.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.DataConvert;
import java.sql.*;

public class MBRBatchDelete extends MessageBodyReader
{

	private String database;
	private String recordSql;
	private ResultSet rsRecord;
	private Connection conn;
	private Statement stmt;
	private int iCount;
	private int RecordNumberInMessage;

	public MBRBatchDelete(Message message)
	{
		super(message);
		database = "ecr";
		recordSql = "select * from HIS_BATCHDELETE where (SessionID='0000000000') and (Incrementflag='1' or Incrementflag='2') and (RecordFlag='40')";
		rsRecord = null;
		conn = null;
		stmt = null;
		iCount = 0;
		RecordNumberInMessage = 1000;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		RecordNumberInMessage = DataConvert.toInt(ARE.getProperty("deleteNumber"));
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_181;
		Segment segB = r.createSegment("B");
		segB.getField(8539).setString(rsRecord.getString("BusinessType"));
		segB.getField(6501).setString(rsRecord.getString("FinanceID"));
		segB.getField(7503).setString(rsRecord.getString("LoanCardNo"));
		segB.getField(7695).setString(rsRecord.getString("ContractNo"));
		segB.getField(2501).setDate(rsRecord.getString("OccurDate"));
		iCount++;
		return iCount <= RecordNumberInMessage;
		SQLException e;
		e;
		logger.debug(e);
		throw new ECRException(e);
		return false;
	}

	public void close()
		throws ECRException
	{
		if (rsRecord != null)
		{
			try
			{
				rsRecord.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			rsRecord = null;
		}
		if (stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			stmt = null;
		}
		if (conn != null)
		{
			try
			{
				conn.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			conn = null;
		}
	}

	public void open()
		throws ECRException
	{
		RecordNumberInMessage = ARE.getProperty("deleteNumber", 1000);
		if (conn == null)
			try
			{
				conn = ARE.getDBConnection(database);
			}
			catch (SQLException ex)
			{
				throw new ECRException("打开征信数据库失败", ex);
			}
		if (stmt == null)
			try
			{
				stmt = conn.createStatement();
			}
			catch (SQLException ex)
			{
				throw new ECRException("创建Statement失败", ex);
			}
		if (rsRecord == null)
			try
			{
				rsRecord = stmt.executeQuery(recordSql);
			}
			catch (SQLException ex)
			{
				throw new ECRException("打开记录集合失败", ex);
			}
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}

	public String getRecordSql()
	{
		return recordSql;
	}

	public void setRecordSql(String recordSql)
	{
		this.recordSql = recordSql;
	}
}
