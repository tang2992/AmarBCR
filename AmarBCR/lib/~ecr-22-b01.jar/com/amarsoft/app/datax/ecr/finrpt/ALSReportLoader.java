// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ALSReportLoader.java

package com.amarsoft.app.datax.ecr.finrpt;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.log.Log;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.finrpt:
//			DBReportLoader, ReportItem, FinanceReport

public class ALSReportLoader extends DBReportLoader
{

	protected PreparedStatement psHead;
	protected PreparedStatement psData;
	public int terms;
	private int subtype;
	private Map endingValue;
	private Map beginningValue;
	private String headSql;
	private String dataSql;

	public ALSReportLoader()
	{
		psHead = null;
		psData = null;
		terms = 0;
		subtype = 1;
		endingValue = new HashMap();
		beginningValue = new HashMap();
		headSql = "";
		dataSql = "";
	}

	public String getDatabase()
	{
		String db = super.getDatabase();
		if (db == null)
			db = "loan";
		return db;
	}

	public int getTerms()
	{
		return terms;
	}

	protected BigDecimal getItemBeginningValue(String itemCode)
	{
		ReportItem item = getItem(itemCode);
		if (item == null)
			return null;
		else
			return getLoanItemValue(item.getLoanItem(), beginningValue);
	}

	protected BigDecimal getItemEndingValue(String itemCode)
	{
		ReportItem item = getItem(itemCode);
		if (item == null)
			return null;
		else
			return getLoanItemValue(item.getLoanItem(), endingValue);
	}

	protected BigDecimal getItemOccurValue(String itemCode)
	{
		return null;
	}

	protected int getReportSubtype()
	{
		return subtype;
	}

	private BigDecimal getLoanItemValue(String loanItemExp, Map loanItemValue)
	{
		if (logger.isTraceEnabled())
			logger.trace((new StringBuilder("Compute Item: ")).append(loanItemExp).toString());
		if (loanItemExp == null)
			return new BigDecimal(0);
		String item[] = loanItemExp.split("[\\+\\-]", 0);
		String oper[] = loanItemExp.split("[^\\+\\-]+", 0);
		BigDecimal value = null;
		if (item.length == 0)
			return new BigDecimal(0);
		if (item.length == 1)
		{
			value = (BigDecimal)loanItemValue.get(item[0].trim());
			if (value == null)
				value = new BigDecimal(0);
			return value;
		}
		Stack var = new Stack();
		Stack ope = new Stack();
		for (int i = item.length - 1; i >= 0; i--)
		{
			BigDecimal v = (BigDecimal)loanItemValue.get(item[i].trim());
			if (v == null)
				v = new BigDecimal(0);
			var.push(v);
		}

		for (int i = oper.length - 1; i >= 0; i--)
			if (!oper[i].trim().equals(""))
				ope.push(oper[i].trim());

		for (; !ope.empty(); var.push(value))
		{
			String op = (String)ope.pop();
			BigDecimal v1 = null;
			BigDecimal v2 = null;
			try
			{
				v1 = (BigDecimal)var.pop();
			}
			catch (EmptyStackException ex)
			{
				v1 = new BigDecimal(0);
			}
			try
			{
				v2 = (BigDecimal)var.pop();
			}
			catch (EmptyStackException ex)
			{
				v2 = new BigDecimal(0);
			}
			if (op.equals("+"))
				value = v1.add(v2);
			else
				value = v1.subtract(v2);
			if (logger.isTraceEnabled())
				logger.trace((new StringBuilder()).append(v1).append(op).append(v2).append("=").append(value).toString());
		}

		return value;
	}

	public void close()
	{
		if (psHead != null)
		{
			try
			{
				psHead.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psHead = null;
		}
		if (psData != null)
		{
			try
			{
				psData.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			psData = null;
		}
		super.close();
	}

	public void open()
		throws ECRException
	{
		super.open();
		try
		{
			logger.debug((new StringBuilder("headSql：")).append(headSql).toString());
			psHead = connection.prepareStatement(headSql);
			logger.debug((new StringBuilder("dataSql：")).append(dataSql).toString());
			psData = connection.prepareStatement(dataSql);
		}
		catch (SQLException ex)
		{
			logger.debug("初始化ALS报表取数逻辑失败!", ex);
			throw new ECRException();
		}
	}

	public boolean reportReady()
		throws ECRException
	{
		String CustomerId = null;
		String beginDate = null;
		String endDate = null;
		endingValue.clear();
		beginningValue.clear();
		String beginReportNo = null;
		String endReportNo = null;
		boolean ready = false;
		String reportDate[] = getReportDate();
		ResultSet rs = null;
		CustomerId = getCustomerId();
		beginDate = reportDate[0];
		endDate = reportDate[1];
		beginReportNo = report.getLoanModelNo();
		endReportNo = report.getLoanModelNo();
		try
		{
			psHead.setString(1, getCustomerId());
			psHead.setString(2, endReportNo);
			psHead.setString(3, endDate);
			rs = psHead.executeQuery();
			if (rs.next())
			{
				endReportNo = rs.getString("ReportNo");
				String scope = rs.getString("Scope");
				if (scope == null)
					scope = "02";
				else
					scope = scope.trim();
				if (scope.equals("02"))
					subtype = 1;
				else
				if (scope.equals("01"))
					subtype = 2;
				else
					subtype = 9;
				ready = true;
				beginReportNo = endReportNo;
				beginDate = endDate;
				terms = 2;
			} else
			{
				logger.info((new StringBuilder("期末记录[")).append(reportDate[1]).append("]不存在！").toString());
				psHead.setString(1, getCustomerId());
				psHead.setString(2, beginReportNo);
				psHead.setString(3, beginDate);
				rs = psHead.executeQuery();
				if (rs.next())
				{
					beginReportNo = rs.getString("ReportNo");
					ready = true;
					endReportNo = beginReportNo;
					endDate = beginDate;
					terms = 1;
				} else
				{
					logger.debug((new StringBuilder("期初记录[")).append(reportDate[0]).append("]不存在！").toString());
					ready = false;
				}
			}
			rs.close();
			loadData(endReportNo, CustomerId, endDate);
		}
		catch (SQLException ex)
		{
			logger.error("获取信贷报表数据失败!", ex);
			ready = false;
		}
		return ready;
	}

	private void loadData(String ReportNo, String CustomerId, String Date)
		throws SQLException
	{
		logger.trace((new StringBuilder("Load data from follow report: ")).append(ReportNo).toString());
		psData.setString(1, CustomerId);
		psData.setString(2, ReportNo);
		psData.setString(3, Date);
		ResultSet rs;
		for (rs = psData.executeQuery(); rs.next();)
		{
			String itemCode = rs.getString("ItemCode");
			BigDecimal value = rs.getBigDecimal("Value");
			if (itemCode == null || value == null)
			{
				if (logger.isTraceEnabled())
					logger.trace("Ignore a record because subjectno or value is null!");
			} else
			if (terms == 1)
				beginningValue.put(itemCode.trim(), value);
			else
				endingValue.put(itemCode.trim(), value);
		}

		rs.close();
	}

	private void loadData(String beginReportNo, String endReportNo, String CustomerId, String beginDate, String endDate)
		throws SQLException
	{
		logger.trace((new StringBuilder("Load data from follow report: ")).append(beginReportNo).append(",").append(endReportNo).toString());
		psData.setString(1, CustomerId);
		psData.setString(2, beginReportNo);
		psData.setString(3, endReportNo);
		psData.setString(4, beginDate);
		psData.setString(5, endDate);
		ResultSet rs;
		for (rs = psData.executeQuery(); rs.next();)
		{
			String ReportDate = rs.getString("ReportDate");
			String itemCode = rs.getString("ItemCode");
			BigDecimal value = rs.getBigDecimal("Value");
			if (itemCode == null || value == null)
			{
				if (logger.isTraceEnabled())
					logger.trace("Ignore a record because subjectno or value is null!");
			} else
			if (ReportDate.equals(beginDate))
				beginningValue.put(itemCode.trim(), value);
			else
				endingValue.put(itemCode.trim(), value);
		}

		rs.close();
	}

	private String[] getReportDate()
	{
		String rd[] = new String[2];
		int year = getReportYear();
		switch (getReportType())
		{
		case 10: // '\n'
			rd[0] = (new StringBuilder(String.valueOf(year - 1))).append("/12").toString();
			rd[1] = (new StringBuilder(String.valueOf(year))).append("/12").toString();
			break;

		case 20: // '\024'
			rd[0] = (new StringBuilder(String.valueOf(year - 1))).append("/12").toString();
			rd[1] = (new StringBuilder(String.valueOf(year))).append("/06").toString();
			break;

		case 30: // '\036'
			rd[0] = (new StringBuilder(String.valueOf(year))).append("/06").toString();
			rd[1] = (new StringBuilder(String.valueOf(year))).append("/12").toString();
			break;

		case 40: // '('
			rd[0] = (new StringBuilder(String.valueOf(year - 1))).append("/12").toString();
			rd[1] = (new StringBuilder(String.valueOf(year))).append("/03").toString();
			break;

		case 50: // '2'
			rd[0] = (new StringBuilder(String.valueOf(year))).append("/03").toString();
			rd[1] = (new StringBuilder(String.valueOf(year))).append("/06").toString();
			break;

		case 60: // '<'
			rd[0] = (new StringBuilder(String.valueOf(year))).append("/06").toString();
			rd[1] = (new StringBuilder(String.valueOf(year))).append("/09").toString();
			break;

		case 70: // 'F'
			rd[0] = (new StringBuilder(String.valueOf(year))).append("/09").toString();
			rd[1] = (new StringBuilder(String.valueOf(year))).append("/12").toString();
			break;
		}
		return rd;
	}

	public void setHeadSql(String headSql)
	{
		this.headSql = headSql;
	}

	public String getHeadSql()
	{
		return headSql;
	}

	public void setDataSql(String dataSql)
	{
		this.dataSql = dataSql;
	}

	public String getDataSql()
	{
		return dataSql;
	}
}
