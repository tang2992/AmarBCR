// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ECRReportLoader.java

package com.amarsoft.app.datax.ecr.finrpt;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import java.math.BigDecimal;
import java.sql.*;
import java.util.Vector;

// Referenced classes of package com.amarsoft.app.datax.ecr.finrpt:
//			ReportLoader, FinanceReport

public class ECRReportLoader
	implements ReportLoader
{

	private String database;
	private Connection connection;
	private PreparedStatement psFinanceBS_2002;
	private PreparedStatement psFinancePS_2002;
	private PreparedStatement psFinanceCF_2002;
	private PreparedStatement psFinanceBS_2007;
	private PreparedStatement psFinancePS_2007;
	private PreparedStatement psFinanceCF_2007;
	private PreparedStatement psFinanceBS_IN;
	private PreparedStatement psFinanceCF_IN;
	private Log logger;

	public ECRReportLoader()
	{
		database = "ecr";
		connection = null;
		psFinanceBS_2002 = null;
		psFinancePS_2002 = null;
		psFinanceCF_2002 = null;
		psFinanceBS_2007 = null;
		psFinancePS_2007 = null;
		psFinanceCF_2007 = null;
		psFinanceBS_IN = null;
		psFinanceCF_IN = null;
		logger = ARE.getLog();
	}

	public void close()
	{
		if (psFinanceBS_2002 != null)
		{
			try
			{
				psFinanceBS_2002.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psFinanceBS_2002 = null;
		}
		if (psFinancePS_2002 != null)
		{
			try
			{
				psFinancePS_2002.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psFinancePS_2002 = null;
		}
		if (psFinanceCF_2002 != null)
		{
			try
			{
				psFinanceCF_2002.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psFinanceCF_2002 = null;
		}
		if (psFinanceBS_2007 != null)
		{
			try
			{
				psFinanceBS_2007.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psFinanceBS_2007 = null;
		}
		if (psFinancePS_2007 != null)
		{
			try
			{
				psFinancePS_2007.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psFinancePS_2007 = null;
		}
		if (psFinanceCF_2007 != null)
		{
			try
			{
				psFinanceCF_2007.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psFinanceCF_2007 = null;
		}
		if (psFinanceBS_IN != null)
		{
			try
			{
				psFinanceBS_IN.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psFinanceBS_IN = null;
		}
		if (psFinanceCF_IN != null)
		{
			try
			{
				psFinanceCF_IN.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psFinanceCF_IN = null;
		}
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			connection = null;
		}
	}

	public boolean loadReport(FinanceReport report)
		throws ECRException
	{
		ResultSet rsReport = null;
		String rt = null;
		switch (report.getReportClass())
		{
		case 1: // '\001'
			rt = (new StringBuilder(String.valueOf(report.getReportType() / 10))).append("_").toString();
			try
			{
				psFinanceBS_2002.setString(1, report.getCustomerId());
				psFinanceBS_2002.setInt(2, report.getReportYear());
				psFinanceBS_2002.setString(3, rt);
				rsReport = psFinanceBS_2002.executeQuery();
			}
			catch (SQLException ex)
			{
				throw new ECRException("读取2002版资产负债表错误！", ex);
			}
			break;

		case 2: // '\002'
			rt = (new StringBuilder(String.valueOf(report.getReportType() / 10))).append("_").toString();
			try
			{
				psFinancePS_2002.setString(1, report.getCustomerId());
				psFinancePS_2002.setInt(2, report.getReportYear());
				psFinancePS_2002.setString(3, rt);
				rsReport = psFinancePS_2002.executeQuery();
			}
			catch (SQLException ex)
			{
				throw new ECRException("读取2002版损益表错误！", ex);
			}
			break;

		case 3: // '\003'
			rt = (new StringBuilder(String.valueOf(report.getReportType() / 10))).append("_").toString();
			try
			{
				psFinanceCF_2002.setString(1, report.getCustomerId());
				psFinanceCF_2002.setInt(2, report.getReportYear());
				psFinanceCF_2002.setString(3, rt);
				rsReport = psFinanceCF_2002.executeQuery();
			}
			catch (SQLException ex)
			{
				throw new ECRException("读取2002版现金流量表错误！", ex);
			}
			break;

		case 4: // '\004'
			rt = (new StringBuilder(String.valueOf(report.getReportType() / 10))).append("_").toString();
			try
			{
				psFinanceBS_2007.setString(1, report.getCustomerId());
				psFinanceBS_2007.setInt(2, report.getReportYear());
				psFinanceBS_2007.setString(3, rt);
				rsReport = psFinanceBS_2007.executeQuery();
			}
			catch (SQLException ex)
			{
				throw new ECRException("读取2007版资产负债表错误！", ex);
			}
			break;

		case 5: // '\005'
			rt = (new StringBuilder(String.valueOf(report.getReportType() / 10))).append("_").toString();
			try
			{
				psFinancePS_2007.setString(1, report.getCustomerId());
				psFinancePS_2007.setInt(2, report.getReportYear());
				psFinancePS_2007.setString(3, rt);
				rsReport = psFinancePS_2007.executeQuery();
			}
			catch (SQLException ex)
			{
				throw new ECRException("读取2007版损益表错误！", ex);
			}
			break;

		case 6: // '\006'
			rt = (new StringBuilder(String.valueOf(report.getReportType() / 10))).append("_").toString();
			try
			{
				psFinanceCF_2007.setString(1, report.getCustomerId());
				psFinanceCF_2007.setInt(2, report.getReportYear());
				psFinanceCF_2007.setString(3, rt);
				rsReport = psFinanceCF_2007.executeQuery();
			}
			catch (SQLException ex)
			{
				throw new ECRException("读取2007版现金流量表错误！", ex);
			}
			break;

		case 7: // '\007'
			rt = (new StringBuilder(String.valueOf(report.getReportType() / 10))).append("_").toString();
			try
			{
				psFinanceBS_IN.setString(1, report.getCustomerId());
				psFinanceBS_IN.setInt(2, report.getReportYear());
				psFinanceBS_IN.setString(3, rt);
				rsReport = psFinanceBS_IN.executeQuery();
			}
			catch (SQLException ex)
			{
				throw new ECRException("读取事业单位资产负债表错误！", ex);
			}
			break;

		case 8: // '\b'
			rt = (new StringBuilder(String.valueOf(report.getReportType() / 10))).append("_").toString();
			try
			{
				psFinanceCF_IN.setString(1, report.getCustomerId());
				psFinanceCF_IN.setInt(2, report.getReportYear());
				psFinanceCF_IN.setString(3, rt);
				rsReport = psFinanceCF_IN.executeQuery();
			}
			catch (SQLException ex)
			{
				throw new ECRException("读取现事业单位收入支出表错误！", ex);
			}
			break;

		default:
			return false;
		}
		int count = 0;
		try
		{
			ResultSetMetaData md = rsReport.getMetaData();
			Vector items = new Vector();
			for (int i = 0; i < md.getColumnCount(); i++)
			{
				String col = md.getColumnName(i + 1).toUpperCase();
				if (col.charAt(0) == 'M')
					items.add(col.substring(1));
			}

			while (rsReport.next()) 
			{
				count++;
				report.setAuditor(rsReport.getString("Auditor"));
				report.setAuditFirm(rsReport.getString("AuditFirm"));
				report.setAuditDate(StringX.parseDate(rsReport.getString("AuditDate")));
				String reportType = rsReport.getString("ReportType");
				char x;
				if (reportType == null || reportType.length() < 2)
					x = '2';
				else
					x = reportType.charAt(1);
				for (int i = 0; i < items.size(); i++)
				{
					String item = (String)items.get(i);
					BigDecimal value = rsReport.getBigDecimal((new StringBuilder(String.valueOf('M'))).append(item).toString());
					if (x == '1')
						report.setBeginningValue(item, value);
					else
						report.setEndingValue(item, value);
				}

			}
			rsReport.close();
		}
		catch (SQLException ex)
		{
			throw new ECRException("读取报数据表错误！", ex);
		}
		return false;
	}

	public void open()
		throws ECRException
	{
		String bsSql_2002 = "select * from ECR_FINANCEBS where CustomerID=? and ReportYear=? and ReportType like ? ";
		String psSql_2002 = "select * from ECR_FINANCEPS where CustomerID=? and ReportYear=? and ReportType like ? ";
		String cfSql_2002 = "select * from ECR_FINANCECF where CustomerID=? and ReportYear=? and ReportType = ? ";
		String bsSql_2007 = "select * from ECR_FINANCEBS_2007 where CustomerID=? and ReportYear=? and ReportType like ? ";
		String psSql_2007 = "select * from ECR_FINANCEPS_2007 where CustomerID=? and ReportYear=? and ReportType like ? ";
		String cfSql_2007 = "select * from ECR_FINANCECF_2007 where CustomerID=? and ReportYear=? and ReportType = ? ";
		String bsSql_in = "select * from ECR_FINANCEBS_IN where CustomerID=? and ReportYear=? and ReportType like ? ";
		String cfSql_in = "select * from ECR_FINANCECF_IN where CustomerID=? and ReportYear=? and ReportType = ? ";
		try
		{
			connection = ARE.getDBConnection(getDatabase());
			psFinanceBS_2002 = connection.prepareStatement(bsSql_2002);
			psFinancePS_2002 = connection.prepareStatement(psSql_2002);
			psFinanceCF_2002 = connection.prepareStatement(cfSql_2002);
			psFinanceBS_2007 = connection.prepareStatement(bsSql_2007);
			psFinancePS_2007 = connection.prepareStatement(psSql_2007);
			psFinanceCF_2007 = connection.prepareStatement(cfSql_2007);
			psFinanceBS_IN = connection.prepareStatement(bsSql_in);
			psFinanceCF_IN = connection.prepareStatement(cfSql_in);
		}
		catch (SQLException ex)
		{
			throw new ECRException("准备抽取数据错误", ex);
		}
	}

	public String getDatabase()
	{
		if (database == null)
			database = "ecr";
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}
}
