// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRLoanCardInquire.java

package com.amarsoft.app.datax.ecr.infoservice;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class MBRLoanCardInquire extends MessageBodyReader
{

	private String database;
	private String recordSql;
	private ResultSet rsRecord;
	private Connection conn;
	private Statement stmt;

	public MBRLoanCardInquire(Message message)
	{
		super(message);
		database = "ecr";
		recordSql = "select LoanCardNo,Password from ECR_LOANCARD where (SessionID='0000000000') and (Incrementflag='1' or Incrementflag='2')";
		rsRecord = null;
		conn = null;
		stmt = null;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
label0:
		{
			try
			{
				if (!rsRecord.next())
					break label0;
				Segment segB = r.createSegment("B");
				segB.getField(7503).setString(rsRecord.getString("LoanCardNo"));
				segB.getField(7655).setString(rsRecord.getString("LoanCardPassword"));
				segB.getField(2501).setDate(rsRecord.getString("OccurDate"));
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
			return true;
		}
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
