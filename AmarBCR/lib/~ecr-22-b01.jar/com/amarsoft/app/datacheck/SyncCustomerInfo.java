// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncCustomerInfo.java

package com.amarsoft.app.datacheck;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncCustomerInfo extends ExecuteUnit
{

	protected Connection connection;
	protected Statement stmt;
	private String database;
	protected String tables[][] = {
		{
			"BANK_LOANCONTRACT", "LoanCardNo", "CustomerID"
		}, {
			"BANK_LOANCONTRACT", "CustomerName", "CustomerID"
		}, {
			"BANK_GUARANTEEBILL", "LoanCardNo", "CustomerID"
		}, {
			"BANK_GUARANTEEBILL", "CustomerName", "CustomerID"
		}, {
			"BANK_FACTORING", "LoanCardNo", "CustomerID"
		}, {
			"BANK_FACTORING", "CustomerName", "CustomerID"
		}, {
			"BANK_FLOORFUND", "LoanCardNo", "CustomerID"
		}, {
			"BANK_FLOORFUND", "CustomerName", "CustomerID"
		}, {
			"BANK_CUSTOMERCREDIT", "LoanCardNo", "CustomerID"
		}, {
			"BANK_CUSTOMERCREDIT", "CustomerName", "CustomerID"
		}, {
			"BANK_FINAINFO", "LoanCardNo", "CustomerID"
		}, {
			"BANK_FINAINFO", "CustomerName", "CustomerID"
		}, {
			"BANK_DISCOUNT", "LoanCardNo", "CustomerID"
		}, {
			"BANK_DISCOUNT", "CustomerName", "CustomerID"
		}, {
			"BANK_INTERESTDUE", "LoanCardNo", "CustomerID"
		}, {
			"BANK_CREDITLETTER", "LoanCardNo", "CustomerID"
		}, {
			"BANK_CREDITLETTER", "CustomerName", "CustomerID"
		}, {
			"BANK_ACCEPTANCE", "LoanCardNo", "CustomerID"
		}, {
			"BANK_ACCEPTANCE", "CustomerName", "CustomerID"
		}
	};

	public SyncCustomerInfo()
	{
		connection = null;
		stmt = null;
		database = "ecr";
	}

	protected void init()
		throws ECRException
	{
		try
		{
			connection = ARE.getDBConnection(database);
			stmt = connection.createStatement();
		}
		catch (SQLException e)
		{
			throw new ECRException(e);
		}
	}

	public int execute()
	{
		transferUnitProperties();
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
		for (int i = 0; i < tables.length; i++)
			try
			{
				updateTable(tables[i][0], tables[i][1], tables[i][2]);
			}
			catch (SQLException e)
			{
				logger.fatal("更新贷款卡和企业名称失败！", e);
				clearResource();
				return 2;
			}

		clearResource();
		return 1;
	}

	private void updateTable(String updateTable, String updateColumn, String customerIdColumn)
		throws SQLException
	{
		boolean loanCard = updateColumn.equalsIgnoreCase("LoanCardNo");
		StringBuffer sql = new StringBuffer("update ");
		sql.append(updateTable).append(" set ").append(updateColumn).append("=(select ").append(loanCard ? " LoanCardNo" : " ChinaName").append(" from TEMP_CUSTOMERINFO where TEMP_CUSTOMERINFO.CustomerID=").append(updateTable).append(".").append(customerIdColumn).append(")").append(" where ").append(updateColumn).append(" is null or ").append(updateColumn).append("=''");
		logger.trace(sql.toString());
		stmt.executeUpdate(sql.toString());
	}

	private void clearResource()
	{
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
			connection = null;
		}
	}
}
