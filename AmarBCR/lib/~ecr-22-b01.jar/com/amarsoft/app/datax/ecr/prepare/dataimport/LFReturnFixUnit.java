// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   LFReturnFixUnit.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class LFReturnFixUnit extends ExecuteUnit
{

	private String database;
	private String table;
	private String dueTable;
	private String dueNoField;
	private String contractNoField;
	private Connection conn;
	private PreparedStatement psReturnedAmount;
	private PreparedStatement psUpdateBack;
	private PreparedStatement psInsertReturn;
	private PreparedStatement psLastBackNo;
	private PreparedStatement psDelete;
	private Statement stmtMain;
	private PreparedStatement psMaxReturnTimes;
	private int insertCount;
	private int fixInsert;
	private int fixUpdate;

	public LFReturnFixUnit()
	{
		database = "ecr";
		table = "ECR_LOANRETURN";
		conn = null;
		psReturnedAmount = null;
		psUpdateBack = null;
		psInsertReturn = null;
		psLastBackNo = null;
		psDelete = null;
		stmtMain = null;
		psMaxReturnTimes = null;
		insertCount = 0;
		fixInsert = 0;
		fixUpdate = 0;
	}

	public int execute()
	{
		transferUnitProperties();
		if (table.equalsIgnoreCase("ECR_LOANRETURN"))
		{
			dueTable = "ECR_LOANDUEBILL";
			dueNoField = "LDuebillNo";
			contractNoField = "LContractNo";
		} else
		{
			table = "ECR_FINARETURN";
			dueTable = "ECR_FINADUEBILL";
			dueNoField = "FDuebillNo";
			contractNoField = "FContractNo";
		}
		try
		{
			conn = ARE.getDBConnection(database);
			stmtMain = conn.createStatement();
			String sql = (new StringBuilder("select ")).append(dueNoField).append(",PutoutAmount - Balance as ReturnSum,").append(contractNoField).append(",ReturnMode from ").append(dueTable).toString();
			if (logger.isDebugEnabled())
				logger.debug((new StringBuilder("Get duebill back amount :")).append(sql).toString());
			ResultSet rs = stmtMain.executeQuery(sql);
			String duebillNo = null;
			double duebillBackAmount = 0.0D;
			double returnBackAmount = 0.0D;
			double errorAmount = 0.0D;
			String returnMode = null;
			String LContractno = null;
			while (rs.next()) 
			{
				duebillNo = rs.getString(1);
				duebillBackAmount = rs.getDouble(2);
				returnMode = rs.getString(4);
				if (rs.wasNull())
					returnMode = "01";
				LContractno = rs.getString(3);
				returnBackAmount = getReturnedAmount(duebillNo);
				errorAmount = duebillBackAmount - returnBackAmount;
				if (Math.abs(errorAmount) >= 0.01D)
				{
					fixInsert++;
					insertBackRecord(duebillNo, errorAmount, returnMode, LContractno);
					if (logger.isTraceEnabled())
						logger.trace((new StringBuilder("Insert new return record: DuebillNo=")).append(duebillNo).append(",ReturnSum=").append(errorAmount).toString());
				}
			}
			psDelete = conn.prepareStatement((new StringBuilder("delete from ")).append(table).append(" where ReturnSum=0").toString());
			psDelete.executeUpdate();
		}
		catch (SQLException e)
		{
			logger.fatal("修正还款记录出错!", e);
			clearResource();
		}
		clearResource();
		logger.info((new StringBuilder("共修正还款记录：")).append(fixInsert + fixUpdate).append("条。其中更新：").append(fixUpdate).append("条，新增：").append(fixInsert).append("条。").toString());
		return 1;
	}

	private void insertBackRecord(String duebillNo, double returnSum, String returnMode, String LContractno)
		throws SQLException
	{
		if (psInsertReturn == null)
		{
			String sql = "insert into " + table + "(" + dueNoField + "," + "ReturnDate," + "ReturnTimes," + "ReturnMode," + "ReturnSum," + "RecordFlag, " + contractNoField + "," + "occurdate, " + "sessionid, " + "incrementflag) " + "VALUES (" + "?,'" + ARE.getProperty("businessOccurDate") + "',?,?,?,'ECR_FIX',?,?,?,?)";
			psInsertReturn = conn.prepareStatement(sql);
		}
		insertCount++;
		psInsertReturn.setString(1, duebillNo);
		psInsertReturn.setInt(2, getNextReturnTimes(duebillNo));
		psInsertReturn.setString(3, returnMode);
		psInsertReturn.setDouble(4, returnSum);
		psInsertReturn.setString(5, LContractno);
		psInsertReturn.setString(6, ARE.getProperty("businessOccurDate"));
		psInsertReturn.setString(7, "0000000000");
		psInsertReturn.setString(8, "1");
		psInsertReturn.executeUpdate();
	}

	private int getNextReturnTimes(String duebillNo)
		throws SQLException
	{
		if (psMaxReturnTimes == null)
		{
			String s = (new StringBuilder("select max(ReturnTimes) from ")).append(table).append(" where ").append(dueNoField).append("=?").toString();
			psMaxReturnTimes = conn.prepareStatement(s);
		}
		psMaxReturnTimes.setString(1, duebillNo);
		ResultSet rs = psMaxReturnTimes.executeQuery();
		int lastNo = 0;
		if (rs.next())
		{
			lastNo = rs.getInt(1);
			if (rs.wasNull())
				lastNo = 0;
		}
		rs.close();
		return lastNo + 1;
	}

	private double getReturnedAmount(String duebillNo)
		throws SQLException
	{
		if (psReturnedAmount == null)
		{
			String sql = (new StringBuilder("select sum(ReturnSum) as Amount from ")).append(table).append(" where ").append(dueNoField).append("=?").toString();
			if (logger.isDebugEnabled())
				logger.debug((new StringBuilder("Get returned amount:")).append(sql).toString());
			psReturnedAmount = conn.prepareStatement(sql);
		}
		double amount = 0.0D;
		psReturnedAmount.setString(1, duebillNo);
		ResultSet rs = psReturnedAmount.executeQuery();
		if (rs.next())
		{
			amount = rs.getDouble(1);
			if (rs.wasNull())
				amount = 0.0D;
		}
		rs.close();
		return amount;
	}

	private void clearResource()
	{
		if (stmtMain != null)
		{
			try
			{
				stmtMain.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			stmtMain = null;
		}
		if (psUpdateBack != null)
		{
			try
			{
				psUpdateBack.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psUpdateBack = null;
		}
		if (psInsertReturn != null)
		{
			try
			{
				psInsertReturn.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psInsertReturn = null;
		}
		if (psLastBackNo != null)
		{
			try
			{
				psLastBackNo.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psLastBackNo = null;
		}
		if (psReturnedAmount != null)
		{
			try
			{
				psReturnedAmount.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psReturnedAmount = null;
		}
		if (psMaxReturnTimes != null)
		{
			try
			{
				psMaxReturnTimes.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psMaxReturnTimes = null;
		}
		if (conn != null)
		{
			try
			{
				conn.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			conn = null;
		}
	}

	public final String getDatabase()
	{
		return database;
	}

	public final void setDatabase(String database)
	{
		this.database = database;
	}

	public final String getTable()
	{
		return table;
	}

	public final void setTable(String val)
	{
		table = val;
	}
}
