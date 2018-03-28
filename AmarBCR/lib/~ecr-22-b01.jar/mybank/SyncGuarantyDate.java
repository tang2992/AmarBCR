// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncGuarantyDate.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;
import java.util.*;

public class SyncGuarantyDate extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmt;
	private HashMap bizStatements;
	private PreparedStatement pstmtUpdate;

	public SyncGuarantyDate()
	{
		connection = null;
		stmt = null;
		bizStatements = null;
		pstmtUpdate = null;
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
		bizStatements = new HashMap();
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
			logger.info("开始更新担保合同...");
			updateContract("ECR_ASSURECONT");
			logger.info("开始更新抵押合同...");
			updateContract("ECR_GUARANTYCONT");
			logger.info("开始更新保证合同...");
			updateContract("ECR_IMPAWNCONT");
		}
		catch (SQLException e)
		{
			logger.fatal("更新担保日期失败！", e);
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void updateContract(String table)
		throws SQLException
	{
		String sqlQuery = (new StringBuilder("select ContractNo,BusinessType from ")).append(table).append(" where  incrementflag='2'").toString();
		String sqlUpdate = (new StringBuilder("update ")).append(table).append(" set OccurDate=? where ContractNo=?").toString();
		String bizType = null;
		String bizNo = null;
		String occurDate = null;
		logger.debug(sqlQuery);
		logger.debug(sqlUpdate);
		pstmtUpdate = connection.prepareStatement(sqlUpdate);
		ResultSet rs;
		for (rs = stmt.executeQuery(sqlQuery); rs.next(); pstmtUpdate.executeUpdate())
		{
			bizType = rs.getString(2);
			bizNo = rs.getString(1);
			occurDate = getOccurDate(bizType, bizNo);
			pstmtUpdate.setString(1, occurDate);
			pstmtUpdate.setString(2, bizNo);
		}

		rs.close();
		pstmtUpdate.close();
		pstmtUpdate = null;
	}

	private String getOccurDate(String bizType, String bizNo)
		throws SQLException
	{
		PreparedStatement pstmt = (PreparedStatement)bizStatements.get(bizType);
		String occurDate = null;
		if (pstmt == null)
		{
			String sql = null;
			if (bizType.equals("1"))
				sql = "select EC.OccurDate as OccurDate,EC.IncrementFlag as IncrementFlag from ECR_LOANCONTRACT EC where incrementflag='2' and EC.Lcontractno=?  order by EC.OccurDate";
			else
			if (bizType.equals("2"))
				sql = "select OccurDate,IncrementFlag from ECR_FACTORING where incrementflag='2' and FactoringNo=?";
			else
			if (bizType.equals("4"))
				sql = "select EC.OccurDate as OccurDate,EC.IncrementFlag as IncrementFlag from ECR_FINAINFO EC where incrementflag='2' and EC.FContractNo=?  order by EC.OccurDate";
			else
			if (bizType.equals("5"))
				sql = "select OccurDate,IncrementFlag from ECR_CREDITLETTER where incrementflag='2' and CreditLetterNo=?";
			else
			if (bizType.equals("6"))
				sql = "select OccurDate,IncrementFlag from ECR_GUARANTEEBILL where incrementflag='2' and GuaranteeBillNo=?";
			else
				sql = "select OccurDate,IncrementFlag from ECR_ACCEPTANCE where incrementflag='2' and AcceptNo=?";
			pstmt = connection.prepareStatement(sql);
			bizStatements.put(bizType, pstmt);
		}
		pstmt.setString(1, bizNo);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next())
			occurDate = rs.getString("OccurDate");
		rs.close();
		return occurDate;
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
		if (bizStatements != null)
		{
			for (Iterator it = bizStatements.values().iterator(); it.hasNext();)
				try
				{
					((PreparedStatement)it.next()).close();
				}
				catch (SQLException e)
				{
					logger.debug(e);
				}

			bizStatements.clear();
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
