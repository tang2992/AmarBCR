// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncCapiIncrementflag.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncCapiIncrementflag extends ExecuteUnit
{

	protected Connection connection;
	protected Statement stmtQuery;
	private PreparedStatement pstmtUpdateNumber;
	private PreparedStatement pstmtUpdate;
	private PreparedStatement pstmtUpdateKeeper;
	private PreparedStatement pstmtUpdateCapi;
	private PreparedStatement pstmtUpdateInvest;
	private PreparedStatement pstmtUpdateFamily;
	private PreparedStatement pstmtUpdateCustomer;

	public SyncCapiIncrementflag()
	{
		connection = null;
		stmtQuery = null;
		pstmtUpdateNumber = null;
		pstmtUpdate = null;
		pstmtUpdateKeeper = null;
		pstmtUpdateCapi = null;
		pstmtUpdateInvest = null;
		pstmtUpdateFamily = null;
		pstmtUpdateCustomer = null;
	}

	protected void init()
		throws ECRException
	{
		String database = "ecr";
		try
		{
			connection = ARE.getDBConnection(database);
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
			logger.info("开始更新资本构成增量标志...");
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
		String sqlQuery = "select CustomerID from ECR_CUSTCAPIINFO";
		String sqlUpdateCapiInfo = "update ECR_CUSTCAPIINFO set incrementflag=(case when incrementflag='8' then '2' else incrementflag end),occurdate=? where customerid=? ";
		String sqlUpdateKeeper = "update ECR_CUSTOMERKEEPER set incrementflag=(case when incrementflag='8' then '2' else incrementflag end),occurdate=? where customerid=? ";
		String sqlUpdateCapi = " update ECR_CUSTOMERCAPI set incrementflag=(case when incrementflag='8' then '2' else incrementflag end),occurdate=? where incrementflag in('1','2','3') and customerid=? ";
		String sqlUpdateInvest = " update ECR_CUSTOMERINVEST set incrementflag=(case when incrementflag='8' then '2' else incrementflag end),occurdate=? where incrementflag in('1','2','3') and customerid=? ";
		String sqlUpdateFamily = " update ECR_CUSTOMERFAMILY set incrementflag=(case when incrementflag='8' then '2' else incrementflag end),occurdate=? where incrementflag in('1','2','3') and customerid=? ";
		String sqlUpdateCustomer = (new StringBuilder("update ecr_customerinfo set IncrementFlag='2',OccurDate='")).append(ARE.getProperty("occurDate")).append("' where customerid=?").toString();
		String customerid = null;
		String sOccurdate = "";
		logger.debug((new StringBuilder("Get record for update: ")).append(sqlQuery).toString());
		logger.debug((new StringBuilder("Updae sql : ")).append(sqlUpdateCapiInfo).toString());
		stmtQuery = connection.createStatement(1003, 1008);
		pstmtUpdate = connection.prepareStatement(sqlUpdateCapiInfo);
		pstmtUpdateKeeper = connection.prepareStatement(sqlUpdateKeeper);
		pstmtUpdateCapi = connection.prepareStatement(sqlUpdateCapi);
		pstmtUpdateInvest = connection.prepareStatement(sqlUpdateInvest);
		pstmtUpdateFamily = connection.prepareStatement(sqlUpdateFamily);
		pstmtUpdateCustomer = connection.prepareStatement(sqlUpdateCustomer);
		ResultSet rs;
		for (rs = stmtQuery.executeQuery(sqlQuery); rs.next();)
		{
			customerid = rs.getString("CustomerID");
			sOccurdate = ARE.getProperty("occurDate");
			if (getChangeNum(customerid) > 0)
			{
				pstmtUpdate.setString(1, sOccurdate);
				pstmtUpdate.setString(2, customerid);
				pstmtUpdate.executeUpdate();
				pstmtUpdateKeeper.setString(1, sOccurdate);
				pstmtUpdateKeeper.setString(2, customerid);
				pstmtUpdateKeeper.executeUpdate();
				pstmtUpdateCapi.setString(1, sOccurdate);
				pstmtUpdateCapi.setString(2, customerid);
				pstmtUpdateCapi.executeUpdate();
				pstmtUpdateInvest.setString(1, sOccurdate);
				pstmtUpdateInvest.setString(2, customerid);
				pstmtUpdateInvest.executeUpdate();
				pstmtUpdateFamily.setString(1, sOccurdate);
				pstmtUpdateFamily.setString(2, customerid);
				pstmtUpdateFamily.executeUpdate();
				pstmtUpdateCustomer.setString(1, customerid);
				pstmtUpdateCustomer.executeUpdate();
			}
		}

		rs.close();
		stmtQuery.close();
		pstmtUpdate.close();
		pstmtUpdateKeeper.close();
		pstmtUpdateCapi.close();
		pstmtUpdateInvest.close();
		pstmtUpdateFamily.close();
		pstmtUpdateCustomer.close();
		pstmtUpdateCapi = null;
		pstmtUpdateInvest = null;
		pstmtUpdateFamily = null;
		pstmtUpdate = null;
		pstmtUpdateKeeper = null;
		stmtQuery = null;
		pstmtUpdateCustomer = null;
	}

	private int getChangeNum(String customerid)
		throws SQLException
	{
		if (pstmtUpdateNumber == null)
		{
			String sql = "select count(*) as capinum from ECR_CUSTOMERCAPI where incrementflag in('1','2','3') and customerid=?  union select count(*) as capinum from ECR_CUSTCAPIINFO where incrementflag in('1','2','3') and customerid=?  union select count(*) as capinum from ECR_CUSTOMERINVEST where incrementflag in('1','2','3') and customerid=?  union select count(*) as capinum from ECR_CUSTOMERKEEPER where incrementflag in('1','2','3') and customerid=?  union select count(*) as capinum from ECR_CUSTOMERFAMILY where incrementflag in('1','2','3') and customerid=? ";
			logger.debug((new StringBuilder("Get changed number: ")).append(sql).toString());
			pstmtUpdateNumber = connection.prepareStatement(sql);
		}
		pstmtUpdateNumber.setString(1, customerid);
		pstmtUpdateNumber.setString(2, customerid);
		pstmtUpdateNumber.setString(3, customerid);
		pstmtUpdateNumber.setString(4, customerid);
		pstmtUpdateNumber.setString(5, customerid);
		ResultSet rs = pstmtUpdateNumber.executeQuery();
		int changeNum;
		for (changeNum = 0; rs.next(); changeNum += rs.getInt(1));
		rs.close();
		return changeNum;
	}

	private void clearResource()
	{
		if (stmtQuery != null)
		{
			try
			{
				stmtQuery.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			stmtQuery = null;
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
		if (pstmtUpdateKeeper != null)
		{
			try
			{
				pstmtUpdateKeeper.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdateKeeper = null;
		}
		if (pstmtUpdateNumber != null)
		{
			try
			{
				pstmtUpdateNumber.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdateNumber = null;
		}
		if (pstmtUpdateCapi != null)
		{
			try
			{
				pstmtUpdateCapi.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdateCapi = null;
		}
		if (pstmtUpdateInvest != null)
		{
			try
			{
				pstmtUpdateInvest.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdateInvest = null;
		}
		if (pstmtUpdateFamily != null)
		{
			try
			{
				pstmtUpdateFamily.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdateFamily = null;
		}
		if (pstmtUpdateCustomer != null)
		{
			try
			{
				pstmtUpdateCustomer.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdateCustomer = null;
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
