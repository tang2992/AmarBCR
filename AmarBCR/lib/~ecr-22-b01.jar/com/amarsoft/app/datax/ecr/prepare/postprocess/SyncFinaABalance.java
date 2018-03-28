// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncFinaABalance.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncFinaABalance extends ExecuteUnit
{

	private String database;
	private boolean processRecycle;
	protected Connection connection;
	private Statement stmt;
	private PreparedStatement pstmtUpdateBalance;
	private PreparedStatement pstmtUsedSum;
	private int batchCommitNumber;

	public SyncFinaABalance()
	{
		database = "ecr";
		processRecycle = false;
		connection = null;
		stmt = null;
		pstmtUpdateBalance = null;
		pstmtUsedSum = null;
		batchCommitNumber = 2000;
	}

	public int execute()
	{
		transferUnitProperties();
		try
		{
			connection = ARE.getDBConnection(database);
		}
		catch (SQLException e)
		{
			logger.fatal("初始化数据库失败", e);
			return 2;
		}
		try
		{
			logger.info("开始更新贸易融资合同可用余额...");
			String sqlQuery = "select BusinessSum,FContractNo,AvailabBalance,Recycle,IncrementFlag from ECR_FINAINFO where FContractNo in(select FContractNo from ECR_FINADUEBILL  where IncrementFlag='1' or IncrementFlag='2') ";
			String sqlUpdate = "update ECR_FINAINFO set AvailabBalance=?,IncrementFlag=? where FContractNo=?";
			logger.debug(sqlQuery);
			logger.debug(sqlUpdate);
			pstmtUpdateBalance = connection.prepareStatement(sqlUpdate);
			stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sqlQuery);
			int updateCount = 0;
			while (rs.next()) 
			{
				String contractNo = rs.getString("FContractNo");
				double contractSum = rs.getDouble("BusinessSum");
				double availabBalance = rs.getDouble("AvailabBalance");
				String recycle = rs.getString("Recycle");
				if (rs.wasNull())
					recycle = "2";
				double usedSum = getUsedSum(contractNo, isProcessRecycle() && recycle.equals("1"));
				double newAbalance = contractSum - usedSum;
				String incrementFlag = rs.getString("IncrementFlag");
				if (logger.isTraceEnabled())
				{
					StringBuffer sb = new StringBuffer();
					sb.append("ContactNo=").append(contractNo).append(",BusinessSum=").append(contractSum).append(",OldAbaliableBalance=").append(availabBalance).append(",recycle=").append(recycle).append(",UsedSum=").append(usedSum).append(",NewAbaliableBalance=").append(newAbalance).append(",IncrementFlag=").append(incrementFlag);
					logger.trace(sb.toString());
				}
				if (newAbalance < 0.0D)
					newAbalance = 0.0D;
				if (availabBalance != newAbalance)
				{
					pstmtUpdateBalance.setDouble(1, newAbalance);
					if (incrementFlag.equals("8"))
						incrementFlag = "2";
					pstmtUpdateBalance.setString(2, incrementFlag);
					pstmtUpdateBalance.setString(3, contractNo);
					pstmtUpdateBalance.addBatch();
					if (++updateCount >= batchCommitNumber)
					{
						pstmtUpdateBalance.executeBatch();
						updateCount = 0;
					}
				}
			}
			if (updateCount > 0)
				pstmtUpdateBalance.executeBatch();
		}
		catch (SQLException e)
		{
			logger.fatal("更新可用余额失败！", e);
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private double getUsedSum(String ContractNo, boolean recycle)
		throws SQLException
	{
		double putoutAmount = 0.0D;
		double balance = 0.0D;
		if (pstmtUsedSum == null)
		{
			String sql = "select sum(PutoutAmount) as PutoutAmount,sum(Balance) as Balance from ECR_FINADUEBILL where  FContractNo=?";
			logger.debug((new StringBuilder("Get Used Sum: ")).append(sql).toString());
			pstmtUsedSum = connection.prepareStatement(sql);
		}
		pstmtUsedSum.setString(1, ContractNo);
		ResultSet rs = pstmtUsedSum.executeQuery();
		if (rs.next())
		{
			putoutAmount = rs.getDouble("PutoutAmount");
			balance = rs.getDouble("Balance");
		}
		rs.close();
		if (logger.isTraceEnabled())
			logger.trace((new StringBuilder("DuebillSum=")).append(putoutAmount).append(",DuebillBalance=").append(balance).toString());
		return recycle ? balance : putoutAmount;
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
		if (pstmtUpdateBalance != null)
		{
			try
			{
				pstmtUpdateBalance.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdateBalance = null;
		}
		if (pstmtUsedSum != null)
		{
			try
			{
				pstmtUsedSum.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUsedSum = null;
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

	public boolean isProcessRecycle()
	{
		return processRecycle;
	}

	public void setProcessRecycle(boolean autoCycle)
	{
		processRecycle = autoCycle;
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}

	public int getBatchCommitNumber()
	{
		return batchCommitNumber;
	}

	public void setBatchCommitNumber(int batchCommitNumber)
	{
		this.batchCommitNumber = batchCommitNumber;
	}
}
