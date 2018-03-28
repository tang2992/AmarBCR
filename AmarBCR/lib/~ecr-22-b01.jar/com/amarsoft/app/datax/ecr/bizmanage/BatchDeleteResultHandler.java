// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   BatchDeleteResultHandler.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class BatchDeleteResultHandler
	implements Handler
{

	private Log logger;
	private Connection connection;
	private PreparedStatement pstmtUpdate;
	private PreparedStatement pstmtSelect;
	private int feedbackCount;
	private String sqlUpdate;
	private String sqlSelect;

	public BatchDeleteResultHandler()
	{
		logger = null;
		connection = null;
		pstmtUpdate = null;
		pstmtSelect = null;
		feedbackCount = 0;
		sqlUpdate = "update his_batchdelete set sessionid=? where contractno=? and businesstype=?  and sessionid= ? ";
		sqlSelect = "select max(sessionid) from his_batchdelete where contractno=?  and businesstype=? and sessionid not in ('7777777777','8888888888')";
	}

	public void messageStart(Message message1)
	{
	}

	public void handleHeader(Message message, Record header)
		throws ECRException
	{
		String messageFile = header.getFirstSegment("A").getField(8523).getString();
		String msgresult = header.getFirstSegment("A").getField(8535).getString();
		if (messageFile.equals("52"))
		{
			if (!msgresult.equals("90"))
				throw new ECRException("不是-90-正常读取");
			else
				return;
		} else
		{
			throw new ECRException("不是-52－批量信贷业务数据删除结果报文");
		}
	}

	public void handleRecord(Message message, Record record)
		throws ECRException
	{
		String sContract = "";
		String sDelResult = "";
		String sBusinessType = "";
		String sSessionID = "";
		String sSSession = "8888888888";
		String sFSession = "7777777777";
		sContract = record.getFirstSegment("B").getField("ContractNo").getString();
		sDelResult = record.getFirstSegment("B").getField("DeleteResult").getString();
		sBusinessType = record.getFirstSegment("B").getField("BusinessType").getString();
		try
		{
			pstmtSelect.setString(1, sContract);
			pstmtSelect.setString(2, sBusinessType);
			ResultSet rs = pstmtSelect.executeQuery();
			if (rs.next())
				sSessionID = rs.getString(1);
			rs.close();
			pstmtUpdate.setString(1, sDelResult.equals("1") ? sSSession : sFSession);
			pstmtUpdate.setString(2, sContract);
			pstmtUpdate.setString(3, sBusinessType);
			pstmtUpdate.setString(4, sSessionID);
			pstmtUpdate.executeUpdate();
		}
		catch (SQLException e)
		{
			throw new ECRException("Save bitchdelresult failed", e);
		}
	}

	public void handleFooter(Message message1, Record record)
	{
	}

	public void messageEnd(Message message1)
	{
	}

	public void end(MessageSet messageSet)
	{
		if (pstmtSelect != null)
		{
			try
			{
				pstmtSelect.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtSelect = null;
		}
		pstmtSelect = null;
		if (pstmtUpdate != null)
		{
			try
			{
				pstmtUpdate.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdate = null;
		}
		pstmtUpdate = null;
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			connection = null;
		}
	}

	public void start(MessageSet messageSet)
	{
		logger = ARE.getLog();
		try
		{
			connection = ARE.getDBConnection("ecr");
			int isolation = ARE.getProperty("connection.ecr.isolation", -1);
			if (isolation != -1)
			{
				logger.debug((new StringBuilder("JDBC transactionIsolation set to ")).append(isolation).toString());
				connection.setTransactionIsolation(isolation);
			}
			pstmtSelect = connection.prepareStatement(sqlSelect);
			pstmtUpdate = connection.prepareStatement(sqlUpdate);
		}
		catch (SQLException sqlE)
		{
			logger.debug(sqlE);
		}
	}

	public void setFeedbackCount(int feedbackCount)
	{
		this.feedbackCount = feedbackCount;
	}

	public int getFeedbackCount()
	{
		return feedbackCount;
	}
}
