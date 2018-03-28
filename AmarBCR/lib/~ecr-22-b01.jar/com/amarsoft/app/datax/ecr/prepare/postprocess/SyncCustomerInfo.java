// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncCustomerInfo.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

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
			"ECR_CUSTOMERLAW", "LoanCardNo", "CustomerID"
		}, {
			"ECR_CUSTOMERLAW", "CustomerName", "CustomerID"
		}, {
			"ECR_CUSTOMERFACT", "LoanCardNo", "CustomerID"
		}, {
			"ECR_CUSTOMERFACT", "CustomerName", "CustomerID"
		}, {
			"ECR_FINANCEBS", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FINANCEBS", "CustomerName", "CustomerID"
		}, {
			"ECR_FINANCEPS", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FINANCEPS", "CustomerName", "CustomerID"
		}, {
			"ECR_FINANCECF", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FINANCECF", "CustomerName", "CustomerID"
		}, {
			"ECR_FINANCEBS_2007", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FINANCEBS_2007", "CustomerName", "CustomerID"
		}, {
			"ECR_FINANCEPS_2007", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FINANCEPS_2007", "CustomerName", "CustomerID"
		}, {
			"ECR_FINANCECF_2007", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FINANCECF_2007", "CustomerName", "CustomerID"
		}, {
			"ECR_FINANCEBS_IN", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FINANCEBS_IN", "CustomerName", "CustomerID"
		}, {
			"ECR_FINANCECF_IN", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FINANCECF_IN", "CustomerName", "CustomerID"
		}, {
			"ECR_LOANCONTRACT", "LoanCardNo", "CustomerID"
		}, {
			"ECR_LOANCONTRACT", "CustomerName", "CustomerID"
		}, {
			"ECR_GUARANTEEBILL", "LoanCardNo", "CustomerID"
		}, {
			"ECR_GUARANTEEBILL", "CustomerName", "CustomerID"
		}, {
			"ECR_FACTORING", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FACTORING", "CustomerName", "CustomerID"
		}, {
			"ECR_FLOORFUND", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FLOORFUND", "CustomerName", "CustomerID"
		}, {
			"ECR_CUSTOMERCREDIT", "LoanCardNo", "CustomerID"
		}, {
			"ECR_CUSTOMERCREDIT", "CustomerName", "CustomerID"
		}, {
			"ECR_FINAINFO", "LoanCardNo", "CustomerID"
		}, {
			"ECR_FINAINFO", "CustomerName", "CustomerID"
		}, {
			"ECR_DISCOUNT", "LoanCardNo", "CustomerID"
		}, {
			"ECR_DISCOUNT", "CustomerName", "CustomerID"
		}, {
			"ECR_INTERESTDUE", "LoanCardNo", "CustomerID"
		}, {
			"ECR_CREDITLETTER", "LoanCardNo", "CustomerID"
		}, {
			"ECR_CREDITLETTER", "CustomerName", "CustomerID"
		}, {
			"ECR_ACCEPTANCE", "LoanCardNo", "CustomerID"
		}, {
			"ECR_ACCEPTANCE", "CustomerName", "CustomerID"
		}, {
			"ECR_CUSTOMERCREDIT", "LoanCardNo", "CustomerID"
		}, {
			"ECR_CUSTOMERCREDIT", "CustomerName", "CustomerID"
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
		sql.append(updateTable).append(" set ").append(updateColumn).append("=(select ").append(loanCard ? " LoanCardNo" : " CHINESENAME").append(loanCard ? " from ECR_ORGANINFO where ECR_ORGANINFO.LSCustomerID=" : " FROM ECR_ORGANATTRIBUTE where CIFCUSTOMERID=(  SELECT CIFCUSTOMERID FROM ECR_ORGANINFO where LSCUSTOMERID=").append(updateTable).append(".").append(customerIdColumn).append(loanCard ? ")" : "))").append(" where ").append(updateColumn).append(" is null or ").append(updateColumn).append("=''");
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
