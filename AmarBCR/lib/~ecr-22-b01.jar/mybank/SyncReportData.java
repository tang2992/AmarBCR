// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncReportData.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncReportData extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected PreparedStatement stmt;
	protected PreparedStatement ptmtdel;
	private PreparedStatement pstmAmountno;
	private PreparedStatement pstmAmountsum;
	private PreparedStatement pstmNAmountno;
	private PreparedStatement pstmNAmountsum;
	private PreparedStatement pstmCAmountno;
	private PreparedStatement pstmCAmountsum;
	private PreparedStatement pstmInsert;
	protected String allTables[][] = {
		{
			"CUSTOMERINFO", "1", "01"
		}, {
			"CUSTCAPIINFO", "1", "02"
		}, {
			"CUSTOMERLAW", "1", "06"
		}, {
			"CUSTOMERFACT", "1", "07"
		}, {
			"LOANCONTRACT", "businesssum", "08"
		}, {
			"LOANDUEBILL", "balance", "09"
		}, {
			"LOANRETURN", "returnsum", "10"
		}, {
			"LOANEXTENSION", "extensum", "11"
		}, {
			"FACTORING", "Balance", "12"
		}, {
			"DISCOUNT", "discountsum", "13"
		}, {
			"FINAINFO", "businesssum", "14"
		}, {
			"FINADUEBILL", "balance", "15"
		}, {
			"FINARETURN", "returnsum", "16"
		}, {
			"FINAEXTENSION", "extensum", "17"
		}, {
			"CREDITLETTER", "balance", "18"
		}, {
			"GUARANTEEBILL", "GuaranteeSum", "19"
		}, {
			"ACCEPTANCE", "AccepSum", "20"
		}, {
			"CUSTOMERCREDIT", "CreditLimit", "21"
		}, {
			"ASSURECONT", "AssureSum", "22"
		}, {
			"GUARANTYCONT", "GuarantySum", "23"
		}, {
			"IMPAWNCONT", "ImpawnSum", "24"
		}, {
			"FLOORFUND", "FloorBalance", "25"
		}, {
			"INTERESTDUE", "InterestBalance", "26"
		}
	};

	public SyncReportData()
	{
		connection = null;
		stmt = null;
		ptmtdel = null;
		pstmAmountno = null;
		pstmAmountsum = null;
		pstmNAmountno = null;
		pstmNAmountsum = null;
		pstmCAmountno = null;
		pstmCAmountsum = null;
		pstmInsert = null;
		try
		{
			init();
		}
		catch (ECRException e)
		{
			logger.fatal("初始化失败", e);
			clearResource();
		}
	}

	protected void init()
		throws ECRException
	{
		if (logger == null)
			logger = ARE.getLog();
		try
		{
			if (connection == null)
				connection = ARE.getDBConnection("ecr");
		}
		catch (SQLException e)
		{
			logger.debug("得到数据库连接时发生错误:", e);
			throw new ECRException("得到数据库连接时发生错误!", e);
		}
	}

	public void InsertReport()
		throws ECRException
	{
		String sqlQuery = "select max(sessionid) as sessionid from ecr_session";
		String sqlDelete = "delete from ecr_amoutreport where sessionid=?";
		String sSessionid = "";
		String sBusinessType = "";
		String sAmountNo = "";
		double AmountSum = 0.0D;
		String sNAmountNo = "";
		double NAmountSum = 0.0D;
		String sCAmountNo = "";
		double CAmountSum = 0.0D;
		String sqlInsert = "insert into ecr_amoutreport(sessionid,businesstype,amoutno,amoutsum,newamoutno,newamoutsum,changeamoutno,changeamoutsum) values(?,?,?,?,?,?,?,?)";
		try
		{
			stmt = connection.prepareStatement(sqlQuery);
			pstmInsert = connection.prepareStatement(sqlInsert);
		}
		catch (SQLException e1)
		{
			e1.printStackTrace();
		}
		for (int i = 0; i < allTables.length; i++)
		{
			String sqlAmountNo = (new StringBuilder("select count(loancardno) from ecr_")).append(allTables[i][0]).toString();
			String sqlAmountSum = (new StringBuilder("select sum(")).append(allTables[i][1]).append(") from ecr_").append(allTables[i][0]).toString();
			String sqlNAmountno = (new StringBuilder("select count(loancardno) from his_")).append(allTables[i][0]).append(" where incrementflag='1' and sessionid=?").toString();
			String sqlNAmountSum = (new StringBuilder("select sum(")).append(allTables[i][1]).append(") from his_").append(allTables[i][0]).append(" where incrementflag='1' and sessionid=?").toString();
			String sqlCAmountNo = (new StringBuilder("select count(loancardno) from his_")).append(allTables[i][0]).append(" where incrementflag='2' and sessionid=?").toString();
			String sqlCAmountSum = (new StringBuilder("select sum(")).append(allTables[i][1]).append(") from his_").append(allTables[i][0]).append(" where incrementflag='2' and sessionid=?").toString();
			try
			{
				pstmAmountno = connection.prepareStatement(sqlAmountNo);
				pstmAmountsum = connection.prepareStatement(sqlAmountSum);
				pstmNAmountno = connection.prepareStatement(sqlNAmountno);
				pstmNAmountsum = connection.prepareStatement(sqlNAmountSum);
				pstmCAmountno = connection.prepareStatement(sqlCAmountNo);
				pstmCAmountsum = connection.prepareStatement(sqlCAmountSum);
				ptmtdel = connection.prepareStatement(sqlDelete);
				ResultSet rs = stmt.executeQuery(sqlQuery);
				logger.debug(sqlQuery);
				if (rs.next())
				{
					sSessionid = rs.getString(1);
					sBusinessType = allTables[i][2];
					logger.debug(sSessionid);
					ptmtdel.setString(1, sSessionid);
					ptmtdel.executeUpdate();
					ResultSet rs1 = pstmAmountno.executeQuery();
					if (rs1.next())
						sAmountNo = rs1.getString(1);
					ResultSet rs2 = pstmAmountsum.executeQuery();
					if (rs2.next())
						AmountSum = rs2.getDouble(1);
					pstmNAmountno.setString(1, sSessionid);
					ResultSet rs3 = pstmNAmountno.executeQuery();
					if (rs3.next())
						sNAmountNo = rs3.getString(1);
					pstmNAmountsum.setString(1, sSessionid);
					ResultSet rs4 = pstmNAmountsum.executeQuery();
					if (rs4.next())
						NAmountSum = rs4.getDouble(1);
					pstmCAmountno.setString(1, sSessionid);
					ResultSet rs5 = pstmCAmountno.executeQuery();
					if (rs5.next())
						sCAmountNo = rs5.getString(1);
					pstmCAmountsum.setString(1, sSessionid);
					ResultSet rs6 = pstmCAmountsum.executeQuery();
					if (rs6.next())
						CAmountSum = rs6.getDouble(1);
					if (sBusinessType.equals("1") || sBusinessType.equals("2") || sBusinessType.equals("6") || sBusinessType.equals("7"))
					{
						AmountSum = 0.0D;
						NAmountSum = 0.0D;
						CAmountSum = 0.0D;
					}
					pstmInsert.setString(1, sSessionid);
					pstmInsert.setString(2, sBusinessType);
					pstmInsert.setString(3, sAmountNo);
					pstmInsert.setDouble(4, AmountSum);
					pstmInsert.setString(5, sNAmountNo);
					pstmInsert.setDouble(6, NAmountSum);
					pstmInsert.setString(7, sCAmountNo);
					pstmInsert.setDouble(8, CAmountSum);
					pstmInsert.addBatch();
					pstmInsert.executeBatch();
				}
			}
			catch (SQLException e)
			{
				logger.debug("插入数据表ecr_amoutreport出错！", e);
			}
		}

	}

	public int execute()
	{
		try
		{
			init();
			InsertReport();
		}
		catch (ECRException e)
		{
			logger.fatal((new StringBuilder("插入报表数据出错！")).append(e.getMessage()).toString());
			return 2;
		}
		clearResource();
		logger.info("插入报表数据完成！");
		return 1;
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
				logger.warn(e);
			}
			stmt = null;
		}
		if (pstmInsert != null)
		{
			try
			{
				pstmInsert.close();
			}
			catch (SQLException e)
			{
				logger.warn("pstmInsert.close()", e);
			}
			pstmInsert = null;
		}
		if (pstmAmountno != null)
		{
			try
			{
				pstmAmountno.close();
			}
			catch (SQLException e)
			{
				logger.warn("pstmAmountno.close()", e);
			}
			pstmAmountno = null;
		}
		if (pstmAmountsum != null)
		{
			try
			{
				pstmAmountsum.close();
			}
			catch (SQLException e)
			{
				logger.warn("pstmAmountsum.close()", e);
			}
			pstmAmountsum = null;
		}
		if (pstmNAmountno != null)
		{
			try
			{
				pstmNAmountno.close();
			}
			catch (SQLException e)
			{
				logger.warn("pstmNAmountno.close()", e);
			}
			pstmNAmountno = null;
		}
		if (pstmNAmountsum != null)
		{
			try
			{
				pstmNAmountsum.close();
			}
			catch (SQLException e)
			{
				logger.warn("pstmNAmountsum.close()", e);
			}
			pstmNAmountsum = null;
		}
		if (pstmCAmountno != null)
		{
			try
			{
				pstmCAmountno.close();
			}
			catch (SQLException e)
			{
				logger.warn("pstmCAmountno.close()", e);
			}
			pstmCAmountno = null;
		}
		if (pstmCAmountsum != null)
		{
			try
			{
				pstmCAmountsum.close();
			}
			catch (SQLException e)
			{
				logger.warn("pstmCAmountsum.close()", e);
			}
			pstmCAmountsum = null;
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
