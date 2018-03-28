// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ProcessLoanCardNoChangeUnit.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.app.datax.ecr.validate.validator.DKKChecker;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class ProcessLoanCardNoChangeUnit extends ExecuteUnit
{

	private Connection connection;
	private Statement stmt;
	private PreparedStatement ps[];
	private PreparedStatement psInsertHisBatchDelete;
	private PreparedStatement psDelHisBatchDelete;
	private PreparedStatement psUpdateCustomerInfo;
	private PreparedStatement psSelectCustomerInfo;
	private PreparedStatement psUpdateLoanCardNoChange;

	public ProcessLoanCardNoChangeUnit()
	{
		connection = null;
		stmt = null;
		ps = new PreparedStatement[10];
		psInsertHisBatchDelete = null;
		psDelHisBatchDelete = null;
		psUpdateCustomerInfo = null;
		psSelectCustomerInfo = null;
		psUpdateLoanCardNoChange = null;
	}

	public int execute()
	{
		try
		{
			init();
		}
		catch (ECRException e)
		{
			logger.fatal("初始化数据库连接失败", e);
			clearResource();
			return 2;
		}
		String sql = "select * from ECR_LoanCardNoChange where isProcessed='N' and isReady='Y'";
		logger.debug(sql);
		ResultSet rs;
		for (rs = stmt.executeQuery(sql); rs.next();)
		{
			String customerID = rs.getString("CustomerID");
			String oldLoanCardNo = rs.getString("OldLoanCardNo");
			String newLoanCardNo = rs.getString("NewLoanCardNo");
			String financeID = rs.getString("financeID");
			if (!validate(oldLoanCardNo, newLoanCardNo))
				logger.debug((new StringBuilder("新贷款卡编码为")).append(newLoanCardNo).append(",旧贷款卡编码为").append(oldLoanCardNo).append(",不满足更新贷款卡编码条件").toString());
			else
				processLoanCardNoChange(customerID, oldLoanCardNo, newLoanCardNo, financeID);
		}

		rs.close();
		clearResource();
		return 1;
		SQLException ex;
		ex;
		logger.fatal("更新贷款卡编码失败", ex);
		clearResource();
		return 2;
		Exception exception;
		exception;
		clearResource();
		throw exception;
	}

	private void processLoanCardNoChange(String customerID, String oldLoanCardNo, String newLoanCardNo, String financeID)
		throws SQLException
	{
		connection.setAutoCommit(false);
		psDelHisBatchDelete.setString(1, Tools.getCurrentDay("1"));
		psDelHisBatchDelete.setString(2, oldLoanCardNo);
		psDelHisBatchDelete.setString(3, financeID);
		psDelHisBatchDelete.execute();
		for (int i = 0; i < 10; i++)
			if (ps[i] != null)
			{
				ps[i].setString(1, customerID);
				ps[i].setString(2, oldLoanCardNo);
				ResultSet rs;
				for (rs = ps[i].executeQuery(); rs.next(); psInsertHisBatchDelete.addBatch())
				{
					psInsertHisBatchDelete.setString(1, Tools.getCurrentDay("1"));
					psInsertHisBatchDelete.setString(2, rs.getString("ContractNo"));
					psInsertHisBatchDelete.setString(3, rs.getString("businesstype"));
					psInsertHisBatchDelete.setString(4, oldLoanCardNo);
					psInsertHisBatchDelete.setString(5, rs.getString("financeid"));
				}

				rs.close();
				if (psInsertHisBatchDelete != null)
					psInsertHisBatchDelete.executeBatch();
			}

		psSelectCustomerInfo.setString(1, newLoanCardNo);
		ResultSet rs = psSelectCustomerInfo.executeQuery();
		int iCount = 0;
		if (rs.next())
			iCount = rs.getInt(1);
		rs.close();
		if (iCount > 0)
			psUpdateCustomerInfo.setString(1, "2");
		else
			psUpdateCustomerInfo.setString(1, "1");
		psUpdateCustomerInfo.setString(2, newLoanCardNo);
		psUpdateCustomerInfo.setString(3, customerID);
		psUpdateCustomerInfo.execute();
		psUpdateLoanCardNoChange.setString(1, "Y");
		psUpdateLoanCardNoChange.setString(2, customerID);
		psUpdateLoanCardNoChange.setString(3, oldLoanCardNo);
		psUpdateLoanCardNoChange.setString(4, newLoanCardNo);
		psUpdateLoanCardNoChange.execute();
		connection.commit();
	}

	private boolean validate(String oldLoanCardNo, String newLoanCardNo)
	{
		if (oldLoanCardNo == null || newLoanCardNo == null || oldLoanCardNo.length() != 16 || newLoanCardNo.length() != 16 || oldLoanCardNo.equals(newLoanCardNo))
			return false;
		if (!checkLoanCardNo(oldLoanCardNo))
		{
			logger.debug((new StringBuilder("oldLoanCardNo=")).append(oldLoanCardNo).append(",invalid!").toString());
			return false;
		}
		if (!checkLoanCardNo(newLoanCardNo))
		{
			logger.debug((new StringBuilder("newLoanCardNo=")).append(newLoanCardNo).append(",invalid!").toString());
			return false;
		} else
		{
			return true;
		}
	}

	private boolean checkLoanCardNo(String newLoanCardNo)
	{
		return DKKChecker.checkDKK(newLoanCardNo.getBytes());
	}

	public void init()
		throws ECRException
	{
		String deleteTable[][] = {
			{
				"ECR_LOANCONTRACT", "HIS_LOANCONTRACT", "LCONTRACTNO", "01"
			}, {
				"ECR_FACTORING", "HIS_FACTORING", "FACTORINGNO", "02"
			}, {
				"ECR_DISCOUNT", "HIS_DISCOUNT", "BILLNO", "03"
			}, {
				"ECR_FINAINFO", "HIS_FINAINFO", "FCONTRACTNO", "04"
			}, {
				"ECR_CREDITLETTER", "HIS_CREDITLETTER", "CREDITLETTERNO", "05"
			}, {
				"ECR_GUARANTEEBILL", "HIS_GUARANTEEBILL", "GUARANTEEBILLNO", "06"
			}, {
				"ECR_ACCEPTANCE", "HIS_ACCEPTANCE", "ACCEPTNO", "07"
			}, {
				"ECR_CUSTOMERCREDIT", "HIS_CUSTOMERCREDIT", "CCONTRACTNO", "08"
			}, {
				"ECR_FLOORFUND", "HIS_FLOORFUND", "FLOORFUNDNO", "09"
			}, {
				"ECR_INTERESTDUE", "HIS_INTERESTDUE", "LOANCARDNO", "10"
			}
		};
		String sqlInsertHisBatchDelete = " insert into his_batchdelete(occurdate,contractno,businesstype,loancardno,financeid,incrementflag,sessionid,recordflag) values(?,?,?,?,?,'1','0000000000','40')";
		String sqlDelHisBatchDelete = " Delete From His_BatchDelete where OccurDate=? and LoanCardNo=? and financeID=? ";
		String sqlUpdateCustomerInfo = " Update ECR_CustomerInfo set IncrementFlag=?,LoanCardNo=? where CustomerID=?";
		String sqlSelectCustomerInfo = " Select Count(*) from ECR_CustomerInfo where LoanCardNo=? and (IncrementFlag='6' or IncrementFlag='8')";
		String sqlUpdateLoanCardNoChange = " Update ECR_LoanCardNoChange  set isProcessed=? where CustomerID=? and OldLoanCardNo=? and NewLoanCardNo=?";
		try
		{
			if (connection == null)
				connection = ARE.getDBConnection("ecr");
			stmt = connection.createStatement();
			for (int i = 0; i < 10; i++)
			{
				String sql = (new StringBuilder("select distinct ")).append(deleteTable[i][2]).append(" as contractno,'").append(deleteTable[i][3]).append("' as businesstype,financeid").append(" from ").append(deleteTable[i][0]).append(" where CustomerID=? and LoanCardNo=? and IncrementFlag<>'1'").toString();
				logger.debug(sql);
				ps[i] = connection.prepareStatement(sql);
			}

			logger.debug(sqlDelHisBatchDelete);
			psDelHisBatchDelete = connection.prepareStatement(sqlDelHisBatchDelete);
			logger.debug(sqlInsertHisBatchDelete);
			psInsertHisBatchDelete = connection.prepareStatement(sqlInsertHisBatchDelete);
			logger.debug(sqlUpdateCustomerInfo);
			psUpdateCustomerInfo = connection.prepareStatement(sqlUpdateCustomerInfo);
			logger.debug(sqlSelectCustomerInfo);
			psSelectCustomerInfo = connection.prepareStatement(sqlSelectCustomerInfo);
			logger.debug(sqlUpdateLoanCardNoChange);
			psUpdateLoanCardNoChange = connection.prepareStatement(sqlUpdateLoanCardNoChange);
		}
		catch (SQLException e)
		{
			throw new ECRException("得到数据库连接时发生错误!", e);
		}
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
		for (int i = 0; i < 10; i++)
			if (ps[i] != null)
			{
				try
				{
					ps[i].close();
				}
				catch (SQLException e)
				{
					logger.debug(e);
				}
				ps[i] = null;
			}

		if (psDelHisBatchDelete != null)
		{
			try
			{
				psDelHisBatchDelete.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psDelHisBatchDelete = null;
		}
		if (psInsertHisBatchDelete != null)
		{
			try
			{
				psInsertHisBatchDelete.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psInsertHisBatchDelete = null;
		}
		if (psUpdateCustomerInfo != null)
		{
			try
			{
				psUpdateCustomerInfo.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psUpdateCustomerInfo = null;
		}
		if (psSelectCustomerInfo != null)
		{
			try
			{
				psSelectCustomerInfo.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectCustomerInfo = null;
		}
		if (psUpdateLoanCardNoChange != null)
		{
			try
			{
				psUpdateLoanCardNoChange.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psUpdateLoanCardNoChange = null;
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
