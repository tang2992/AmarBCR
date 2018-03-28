// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   CheckLoanCardNo.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class CheckLoanCardNo extends ExecuteUnit
{

	protected Connection connection;
	private PreparedStatement pstmtUpdateALSDataCheck;
	private PreparedStatement psSelectALSDataCheck;
	private String sqlSelectALSDataCheck;
	private String sqlUpdateALSDataCheck;
	private String loanCardNo;
	private String updateTable;

	public CheckLoanCardNo()
	{
		connection = null;
		pstmtUpdateALSDataCheck = null;
		psSelectALSDataCheck = null;
		sqlSelectALSDataCheck = "";
		sqlUpdateALSDataCheck = "";
		loanCardNo = "";
		updateTable = "";
	}

	protected void init()
		throws Exception
	{
		transferUnitProperties();
		String database = getProperty("unit.database", "ecr");
		updateTable = getUpdateTable();
		sqlSelectALSDataCheck = (new StringBuilder(" SELECT LoanCardNo from ")).append(updateTable).append(" ").toString();
		sqlUpdateALSDataCheck = (new StringBuilder(" Update ")).append(updateTable).append(" set Status=? where LoanCardNo=?").toString();
		try
		{
			connection = ARE.getDBConnection(database);
			logger.debug(sqlSelectALSDataCheck);
			logger.debug(sqlUpdateALSDataCheck);
			psSelectALSDataCheck = connection.prepareStatement(sqlSelectALSDataCheck);
			pstmtUpdateALSDataCheck = connection.prepareStatement(sqlUpdateALSDataCheck);
		}
		catch (SQLException e)
		{
			throw new Exception(e);
		}
	}

	public int execute()
	{
		try
		{
			init();
		}
		catch (Exception e)
		{
			logger.fatal("初始化失败", e);
			clearResource();
			return 2;
		}
		try
		{
			logger.info("开始校验贷款卡编码是否正确");
			int iCount = 0;
			ResultSet rs;
			for (rs = psSelectALSDataCheck.executeQuery(); rs.next();)
			{
				loanCardNo = rs.getString("LoanCardNo");
				if (!checkLoanCardNo(loanCardNo))
				{
					iCount++;
					pstmtUpdateALSDataCheck.setString(1, "01");
					pstmtUpdateALSDataCheck.setString(2, loanCardNo);
					pstmtUpdateALSDataCheck.execute();
				}
			}

			rs.close();
			if (iCount > 0)
				logger.warn((new StringBuilder("一共有")).append(iCount).append("笔贷款卡编码错误,请查看").append(updateTable).append("表里面status='01'的数据!").toString());
		}
		catch (SQLException e)
		{
			logger.fatal("更新贷款卡编码信息出错！", e);
			clearResource();
			return 2;
		}
		return 1;
	}

	public boolean checkLoanCardNo(String loanCardNo)
	{
		if (loanCardNo.trim().length() != 16)
			return false;
		else
			return checkDKK(loanCardNo.getBytes());
	}

	public static boolean checkDKK(byte financecode[])
	{
		int weightValue[] = new int[14];
		int checkValue[] = new int[14];
		int totalValue = 0;
		int c = 0;
		weightValue[0] = 1;
		weightValue[1] = 3;
		weightValue[2] = 5;
		weightValue[3] = 7;
		weightValue[4] = 11;
		weightValue[5] = 2;
		weightValue[6] = 13;
		weightValue[7] = 1;
		weightValue[8] = 1;
		weightValue[9] = 17;
		weightValue[10] = 19;
		weightValue[11] = 97;
		weightValue[12] = 23;
		weightValue[13] = 29;
		for (int j = 0; j < 14; j++)
		{
			if (financecode[j] >= 65 && financecode[j] <= 90)
				checkValue[j] = (financecode[j] - 65) + 10;
			else
			if (financecode[j] >= 48 && financecode[j] <= 57)
				checkValue[j] = financecode[j] - 48;
			else
				return false;
			totalValue += weightValue[j] * checkValue[j];
		}

		c = 1 + totalValue % 97;
		int val = (financecode[14] - 48) * 10 + (financecode[15] - 48);
		return val == c;
	}

	private void clearResource()
	{
		if (psSelectALSDataCheck != null)
		{
			try
			{
				psSelectALSDataCheck.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectALSDataCheck = null;
		}
		if (pstmtUpdateALSDataCheck != null)
		{
			try
			{
				pstmtUpdateALSDataCheck.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdateALSDataCheck = null;
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

	public void setUpdateTable(String updateTable)
	{
		this.updateTable = updateTable;
	}

	private String getUpdateTable()
	{
		return updateTable;
	}
}
