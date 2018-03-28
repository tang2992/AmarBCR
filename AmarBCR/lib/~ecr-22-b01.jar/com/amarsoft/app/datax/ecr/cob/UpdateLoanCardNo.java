// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   UpdateLoanCardNo.java

package com.amarsoft.app.datax.ecr.cob;

import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class UpdateLoanCardNo extends ExecuteUnit
{

	private String database;
	private Connection connection;
	private Statement statement;
	private String oldLoanCardNo;
	private String newLoanCardNo;
	private String customerID;
	public final String allTables[] = {
		"CUSTOMERINFO", "CUSTOMERSTOCK", "CUSTCAPIINFO", "CUSTOMERCAPI", "CUSTOMERINVEST", "CUSTOMERKEEPER", "CUSTOMERFAMILY", "CUSTOMERlAW", "CUSTOMERFACT", "FINANCEBS", 
		"FINANCEPS", "FINANCECF"
	};

	public UpdateLoanCardNo(String customerID, String oldLoanCardNo, String newLoanCardNo)
	{
		database = "ecr";
		connection = null;
		statement = null;
		this.oldLoanCardNo = null;
		this.newLoanCardNo = null;
		this.customerID = null;
		this.oldLoanCardNo = oldLoanCardNo;
		this.newLoanCardNo = newLoanCardNo;
		this.customerID = customerID;
		init();
	}

	private void init()
	{
		try
		{
			connection = ARE.getDBConnection(database);
			statement = connection.createStatement(1003, 1008);
		}
		catch (SQLException e)
		{
			logger.fatal("初始化数据库失败", e);
			clearResource();
		}
	}

	public int execute()
	{
		if (oldLoanCardNo != null && oldLoanCardNo.equals(newLoanCardNo))
		{
			logger.debug("新旧贷款卡一致没有更新的必要！");
			return -1;
		}
		boolean succeed = updateCustomer();
		return !succeed ? -1 : 1;
	}

	private boolean updateCustomer()
	{
		try
		{
			String occurdate = Tools.getCurrentDay("1");
			for (int i = 0; i < allTables.length; i++)
			{
				String updateSql = null;
				if (i == 1 || i == 3 || i == 4 || i == 5 || i == 6)
					updateSql = (new StringBuilder("update ECR_")).append(allTables[i]).append(" set IncrementFlag='").append("1").append("',Occurdate='").append(occurdate).append("' where CustomerID='").append(customerID).append("'").toString();
				else
					updateSql = (new StringBuilder("update ECR_")).append(allTables[i]).append(" set IncrementFlag='").append("1").append("',LoanCardNo='").append(newLoanCardNo).append("',Occurdate='").append(occurdate).append("' where CustomerID='").append(customerID).append("'").toString();
				statement.addBatch(updateSql);
				logger.debug(updateSql);
				String deleteSql = (new StringBuilder("delete from HIS_")).append(allTables[i]).append(" where CustomerID='").append(customerID).append("'").toString();
				statement.addBatch(deleteSql);
				logger.debug(deleteSql);
			}

			statement.executeBatch();
		}
		catch (SQLException e)
		{
			logger.debug((new StringBuilder("SQL执行失败:")).append(e.toString()).toString());
			return false;
		}
		return true;
	}

	public String checkBusiness()
	{
		ResultSet rs;
		String contractSql = (new StringBuilder("select count(*) from ECR_LOANCONTRACT where CustomerID='")).append(customerID).append("' and availabstatus<>'2'").toString();
		rs = statement.executeQuery(contractSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未结清的贷款业务!!";
		rs.close();
		String finaSql = (new StringBuilder("select count(*) from ECR_FINAINFO where CustomerID='")).append(customerID).append("' and availabstatus<>'2'").toString();
		rs = statement.executeQuery(finaSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未结清的贸易融资业务!!";
		rs.close();
		String factoringSql = (new StringBuilder("select count(*) from ECR_FACTORING where CustomerID='")).append(customerID).append("' and Balance>0").toString();
		rs = statement.executeQuery(factoringSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未结清的保理业务!!";
		rs.close();
		String discountSql = (new StringBuilder("select count(*) from ECR_DISCOUNT where CustomerID='")).append(customerID).append("' and BillStatus ='1'").toString();
		rs = statement.executeQuery(discountSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未结清的票据贴现业务!!";
		rs.close();
		String letterSql = (new StringBuilder("select count(*) from ECR_CREDITLETTER where CustomerID='")).append(customerID).append("' and CreditStatus <>'2'").toString();
		rs = statement.executeQuery(letterSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未结清的信用证业务!!";
		rs.close();
		String guaranteebillSql = (new StringBuilder("select count(*) from ECR_GUARANTEEBILL where CustomerID='")).append(customerID).append("' and GUARANTEESTATUS <>'2'").toString();
		rs = statement.executeQuery(guaranteebillSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未结清的保函业务!!";
		rs.close();
		String acceptanceSql = (new StringBuilder("select count(*) from ECR_ACCEPTANCE where CustomerID='")).append(customerID).append("' and DRAFTSTATUS <>'2'").toString();
		rs = statement.executeQuery(acceptanceSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未结清的承兑汇票业务!!";
		rs.close();
		String creditSql = (new StringBuilder("select count(*) from ECR_CUSTOMERCREDIT where CustomerID='")).append(customerID).append("' and CREDITLOGOUTDATE is not null").toString();
		rs = statement.executeQuery(creditSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未到期的公开授信业务!!";
		rs.close();
		String advanceSql = (new StringBuilder("select count(*) from ECR_FLOORFUND where CustomerID='")).append(customerID).append("'").toString();
		rs = statement.executeQuery(advanceSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未删除的垫款业务!!";
		rs.close();
		String interestdueSql = (new StringBuilder("select count(*) from ECR_INTERESTDUE where CustomerID='")).append(customerID).append("' and InterestBalance>0").toString();
		rs = statement.executeQuery(interestdueSql);
		if (rs.next() && rs.getInt(1) > 0)
			return "该客户还存在未删除的欠息业务!!";
		try
		{
			rs.close();
		}
		catch (SQLException e)
		{
			logger.debug((new StringBuilder("SQL执行失败:")).append(e.toString()).toString());
			clearResource();
			return "Failure";
		}
		return "NOTEXISTS";
	}

	private void clearResource()
	{
		if (statement != null)
			try
			{
				statement.close();
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
