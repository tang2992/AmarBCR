// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   AbstractReportProvider.java

package com.amarsoft.app.datax.ecr.finrpt;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.*;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.DataSourceURI;
import com.amarsoft.are.sql.TabularReader;
import java.math.BigDecimal;
import java.net.URISyntaxException;
import java.sql.*;
import java.util.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.finrpt:
//			ReportLoader, ReportFactory, FinanceReport, ReportItem

public abstract class AbstractReportProvider
	implements DataProvider
{
	public class ReportTerm
	{

		private int reportYear;
		private int reportType;
		final AbstractReportProvider this$0;

		public String toString()
		{
			return (new StringBuilder("Year=")).append(reportYear).append(",Type=").append(reportType).toString();
		}

		public int getReportType()
		{
			return reportType;
		}

		public void setReportType(int reportType)
		{
			this.reportType = reportType;
		}

		public int getReportYear()
		{
			return reportYear;
		}

		public void setReportYear(int reportYear)
		{
			this.reportYear = reportYear;
		}

		public ReportTerm()
		{
			this(2007, 10);
		}

		public ReportTerm(int reportYear, int reportType)
		{
			this$0 = AbstractReportProvider.this;
			super();
			this.reportYear = reportYear;
			this.reportType = reportType;
		}
	}


	private String customerSelector;
	private int reportClass;
	private String templeteFile;
	private boolean includeYearReport;
	private boolean includeHalfYearReport;
	private boolean includeQuarterReport;
	private ReportLoader loader;
	private ReportFactory factory;
	protected Log logger;
	private TabularReader customers;
	private Date businessOccurDate;
	private ReportTerm reportTerms[];
	private Vector recordBuffer;
	private String database;
	protected Connection connection;
	private PreparedStatement pstmtFinanceId;
	String financeId[];

	public AbstractReportProvider()
	{
		customerSelector = null;
		reportClass = 1;
		templeteFile = null;
		includeYearReport = true;
		includeHalfYearReport = false;
		includeQuarterReport = false;
		loader = null;
		factory = null;
		logger = ARE.getLog();
		customers = null;
		businessOccurDate = null;
		reportTerms = null;
		recordBuffer = null;
		database = "ecr";
		connection = null;
		pstmtFinanceId = null;
		financeId = null;
	}

	public void close()
		throws RecordSetException
	{
		if (loader != null)
			loader.close();
		clearResource();
	}

	public void open(RecordSet recordSet)
		throws RecordSetException
	{
		try
		{
			connection = ARE.getDBConnection(database);
			String sql = "select FinanceId,OldFinanceId from ECR_ORGANINFO where LSCustomerID=?";
			pstmtFinanceId = connection.prepareStatement(sql);
		}
		catch (SQLException e)
		{
			logger.fatal("初始化数据库失败", e);
			clearResource();
		}
		loader = createReportLoader();
		if (loader == null)
			throw new RecordSetException("无法确定正确的ReportLoader");
		try
		{
			loader.open();
		}
		catch (ECRException ex)
		{
			logger.debug(ex.getMessage(), ex);
			throw new RecordSetException("Open Loader Error.", ex);
		}
		factory = new ReportFactory();
		factory.setTempleteFile(getTempleteFile());
		DataSourceURI u = null;
		try
		{
			u = new DataSourceURI(getCustomerSelector());
			customers = new TabularReader(u);
		}
		catch (URISyntaxException ex)
		{
			customers.close();
			loader.close();
			logger.debug(ex.getMessage(), ex);
			throw new RecordSetException("Open Customer Selector Error.", ex);
		}
		businessOccurDate = getBusinessOccurDate();
		prepareReportTerms();
		recordBuffer = new Vector();
	}

	private Date getBusinessOccurDate()
	{
		String od = ARE.getProperty("businessOccurDate");
		Date d = null;
		if (od == null)
			d = new Date();
		else
			d = StringX.parseDate(od);
		return d;
	}

	protected abstract ReportLoader createReportLoader();

	public boolean readRecord(Record record)
		throws RecordSetException
	{
		if (recordBuffer.isEmpty() && !readBuffer())
		{
			return false;
		} else
		{
			FinanceReport r = (FinanceReport)recordBuffer.get(0);
			recordBuffer.remove(0);
			fillRecord(r, record, financeId);
			return true;
		}
	}

	private boolean readBuffer()
		throws RecordSetException
	{
		try
		{
			while (customers.next()) 
			{
				String customerId = customers.getString(1);
				financeId = getFinanceId(customerId);
				if (financeId == null)
					continue;
				for (int i = 0; i < reportTerms.length; i++)
				{
					FinanceReport r = factory.createReport(getReportClass());
					r.setReportType(reportTerms[i].getReportType());
					r.setCustomerId(customerId);
					r.setReportYear(reportTerms[i].getReportYear());
					if (loader.loadReport(r))
						if (r.getReportClass() == 3 || r.getReportClass() == 6 || r.getReportClass() == 8)
						{
							recordBuffer.add(r);
						} else
						{
							r.setReportType(r.getReportType() + r.getTerms());
							recordBuffer.add(r);
						}
				}

				if (!recordBuffer.isEmpty())
					break;
			}
		}
		catch (SQLException ex)
		{
			logger.debug(ex);
			throw new RecordSetException("Get customerid error!", ex);
		}
		catch (ECRException ex)
		{
			logger.debug(ex);
			throw new RecordSetException("Create reporterror!", ex);
		}
		return !recordBuffer.isEmpty();
	}

	private void fillRecord(FinanceReport report, Record record, String financeId[])
	{
		Field f = null;
		f = record.getField("CustomerID");
		if (f != null)
			f.setValue(report.getCustomerId());
		f = record.getField("ReportYear");
		if (f != null)
			f.setValue(report.getReportYear());
		f = record.getField("ReportType");
		if (f != null)
			f.setValue(report.getReportType());
		f = record.getField("ReportSubType");
		if (f != null)
			f.setValue(report.getReportSubtype());
		f = record.getField("Auditor");
		if (f != null)
			f.setValue(report.getAuditor());
		f = record.getField("AuditFirm");
		if (f != null)
			f.setValue(report.getAuditFirm());
		f = record.getField("AuditDate");
		if (f != null)
			f.setValue(report.getAuditDate());
		f = record.getField("FinanceId");
		if (f != null)
			f.setValue(financeId[0]);
		f = record.getField("OldFinanceId");
		if (f != null)
			f.setValue(financeId[1]);
		boolean isBeginning = report.getReportType() % 10 == 1;
		for (int i = 0; i < report.getItemNumber(); i++)
		{
			ReportItem item = report.getItem(i);
			String itemCode = item.getCode();
			f = record.getField((new StringBuilder("M")).append(itemCode).toString());
			if (f != null)
				f.setValue(isBeginning ? report.getBeginningValue(itemCode).doubleValue() : report.getEndingValue(itemCode).doubleValue());
		}

	}

	private String[] getFinanceId(String customerId)
	{
		String fid[] = null;
		try
		{
			pstmtFinanceId.setString(1, customerId);
			ResultSet rs = pstmtFinanceId.executeQuery();
			if (rs.next())
			{
				fid = new String[2];
				fid[0] = rs.getString("FinanceID");
				fid[1] = rs.getString("OldFinanceID");
			}
			rs.close();
		}
		catch (SQLException e)
		{
			logger.debug("获取金融机构代码出错！", e);
		}
		return fid;
	}

	private void prepareReportTerms()
	{
		if (reportTerms == null)
		{
			Vector v = new Vector();
			Calendar c = Calendar.getInstance();
			c.setTime(businessOccurDate);
			int year = c.get(1);
			int month = c.get(2) + 1;
			if (isIncludeYearReport())
			{
				int y = year - 1;
				int t = 10;
				v.add(new ReportTerm(y, t));
			}
			if (isIncludeHalfYearReport())
			{
				int y = month >= 7 ? year : year - 1;
				int t = month >= 7 ? 20 : 30;
				v.add(new ReportTerm(y, t));
			}
			if (isIncludeQuarterReport())
			{
				int y = 0;
				int t = 0;
				if (month < 4)
				{
					y = year - 1;
					t = 70;
				} else
				if (month < 7)
				{
					y = year;
					t = 40;
				} else
				if (month < 10)
				{
					y = year;
					t = 50;
				} else
				{
					y = year;
					t = 60;
				}
				v.add(new ReportTerm(y, t));
			}
			reportTerms = (ReportTerm[])v.toArray(new ReportTerm[0]);
			if (logger.isTraceEnabled())
			{
				StringBuffer sb = new StringBuffer("Extract data in follow terms:\n");
				for (int i = 0; i < reportTerms.length; i++)
					sb.append(reportTerms[i]).append("\n");

				logger.trace(sb);
			}
		}
	}

	public String getCustomerSelector()
	{
		return customerSelector;
	}

	public void setCustomerSelector(String customerRange)
	{
		customerSelector = customerRange;
	}

	public boolean isIncludeHalfYearReport()
	{
		return includeHalfYearReport;
	}

	public void setIncludeHalfYearReport(boolean includeHalfYearReport)
	{
		this.includeHalfYearReport = includeHalfYearReport;
	}

	public boolean isIncludeQuarterReport()
	{
		return includeQuarterReport;
	}

	public void setIncludeQuarterReport(boolean includeQuarterReport)
	{
		this.includeQuarterReport = includeQuarterReport;
	}

	public boolean isIncludeYearReport()
	{
		return includeYearReport;
	}

	public void setIncludeYearReport(boolean includeYearReport)
	{
		this.includeYearReport = includeYearReport;
	}

	public String getTempleteFile()
	{
		return templeteFile;
	}

	public void setTempleteFile(String reportTemplete)
	{
		templeteFile = reportTemplete;
	}

	public int getReportClass()
	{
		return reportClass;
	}

	public void setReportClass(int reportClass)
	{
		this.reportClass = reportClass;
	}

	private void clearResource()
	{
		if (pstmtFinanceId != null)
		{
			try
			{
				pstmtFinanceId.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
			pstmtFinanceId = null;
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
		if (customers != null)
		{
			customers.close();
			customers = null;
		}
	}

	public int getFetchSize()
	{
		return 0;
	}

	public int getMaxRows()
	{
		return 0;
	}

	public void setFetchSize(int i)
	{
	}

	public void setMaxRows(int i)
	{
	}
}
