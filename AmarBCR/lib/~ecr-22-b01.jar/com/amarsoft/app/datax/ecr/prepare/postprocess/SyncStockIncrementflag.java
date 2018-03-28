// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncStockIncrementflag.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncStockIncrementflag extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmt;
	private PreparedStatement pstmtUpdate;
	private PreparedStatement pstmtStock;

	public SyncStockIncrementflag()
	{
		connection = null;
		stmt = null;
		pstmtUpdate = null;
		pstmtStock = null;
	}

	protected void init()
		throws ECRException
	{
		logger = ARE.getLog();
		String database = "ecr";
		try
		{
			connection = ARE.getDBConnection(database);
			stmt = connection.createStatement(1003, 1008);
		}
		catch (SQLException e)
		{
			throw new ECRException(e);
		}
	}

	public int execute()
	{
		try
		{
			init();
		}
		catch (ECRException e)
		{
			logger.fatal("初始化失败", e);
			clearResource();
			return 2;
		}
		try
		{
			logger.info("开始更新主客户增量标志...");
			updateIncrementflag();
		}
		catch (SQLException e)
		{
			logger.fatal("更新增量标志失败！", e);
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void updateIncrementflag()
		throws SQLException
	{
		String sqlStock = "select distinct Customerid from ECR_CUSTOMERSTOCK where (IncrementFlag='1' or IncrementFlag='2')";
		String sqlUpdateCustomer = (new StringBuilder("update ecr_customerinfo set IncrementFlag='2',OccurDate='")).append(ARE.getProperty("occurDate")).append("' where customerid=?").toString();
		String sqlUpdateStock = (new StringBuilder("update ECR_CUSTOMERSTOCK set OccurDate='")).append(ARE.getProperty("occurDate")).append("' where (IncrementFlag='1' or IncrementFlag='2') and customerid=?").toString();
		String Customerid = null;
		logger.debug(sqlStock);
		logger.debug(sqlUpdateCustomer);
		logger.debug(sqlUpdateStock);
		pstmtUpdate = connection.prepareStatement(sqlUpdateCustomer);
		pstmtStock = connection.prepareStatement(sqlUpdateStock);
		ResultSet rsquery;
		for (rsquery = stmt.executeQuery(sqlStock); rsquery.next(); pstmtStock.executeUpdate())
		{
			Customerid = rsquery.getString("Customerid");
			pstmtUpdate.setString(1, Customerid);
			pstmtUpdate.executeUpdate();
			pstmtStock.setString(1, Customerid);
		}

		rsquery.close();
		pstmtUpdate.close();
		pstmtStock.close();
	}

	private void clearResource()
	{
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
		if (pstmtStock != null)
		{
			try
			{
				pstmtStock.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtStock = null;
		}
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
}
