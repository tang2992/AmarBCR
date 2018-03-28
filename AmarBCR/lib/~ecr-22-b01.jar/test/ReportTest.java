// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ReportTest.java

package test;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.finrpt.*;
import com.amarsoft.app.datax.ecr.prepare.dataimport.ALSReportProvider;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.*;
import com.amarsoft.are.metadata.DataSourceMetaData;
import java.io.PrintStream;
import java.sql.SQLException;

public class ReportTest
{

	public ReportTest()
	{
	}

	public static void main(String args[])
	{
		ARE.init("etc/ecr_are.xml");
		testProvider();
	}

	public static void testTemplete()
	{
		ReportFactory f = new ReportFactory();
		f.setTempleteFile((new StringBuilder(String.valueOf(ARE.getProperty("ECR_HOME")))).append("/etc/finance_report_templete_publiccompany.xml").toString());
		try
		{
			FinanceReport r = f.createBalanceSheet();
			printReport(r);
		}
		catch (ECRException ex)
		{
			ex.printStackTrace();
		}
	}

	public static void testALSLoader()
	{
		ReportFactory f = new ReportFactory();
		f.setTempleteFile("etc/finance_report_templete_als6general.xml");
		try
		{
			FinanceReport r = f.createReport(1);
			r.setReportType(20);
			r.setCustomerId("20061030000001");
			r.setReportYear(2006);
			ALSReportLoader l = new ALSReportLoader();
			l.open();
			l.loadReport(r);
			l.close();
			printReport(r);
		}
		catch (ECRException ex)
		{
			ex.printStackTrace();
		}
	}

	public static void testProvider()
	{
		try
		{
			RecordSet rs = new RecordSet(ARE.getMetaData("ecr_data").getTable("ECR_FINANCEBS"));
			ALSReportProvider p = new ALSReportProvider();
			p.setTempleteFile("etc/finance_report_templete_als6general.xml");
			p.setDatabase("loan");
			p.setReportClass(1);
			p.setCustomerSelector("datasource:db:loan:select customerid from ent_info where CustomerID='20070625000042'");
			p.setIncludeYearReport(true);
			p.setIncludeHalfYearReport(true);
			p.setIncludeQuarterReport(false);
			ExportFileHandler h = new ExportFileHandler();
			h.setFileName("d:\\temp\\reporttest.txt");
			h.setIncludeHeader(true);
			h.setSplitToken(",");
			h.setAppendMode(false);
			rs.addHandler(h);
			rs.parse(p);
		}
		catch (SQLException ex)
		{
			ex.printStackTrace();
		}
		catch (RecordSetException ex)
		{
			ex.printStackTrace();
		}
	}

	private static void printReport(FinanceReport report)
	{
		System.out.println(report.getLoanModelNo());
		System.out.println(report.getCustomerId());
		System.out.println(report.getReportType());
		System.out.println(report.getReportYear());
		System.out.println(report.getItemNumber());
		for (int i = 0; i < report.getItemNumber(); i++)
			System.out.println(report.getItem(i));

	}
}
