// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ReportFactory.java

package com.amarsoft.app.datax.ecr.finrpt;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.xml.*;
import java.io.File;
import java.util.Iterator;
import java.util.List;

// Referenced classes of package com.amarsoft.app.datax.ecr.finrpt:
//			FinanceReport, ReportItem

public class ReportFactory
{

	private String templeteFile;
	private FinanceReport reportTemplete[];

	public ReportFactory()
	{
		templeteFile = null;
		reportTemplete = new FinanceReport[9];
	}

	public FinanceReport createBalanceSheet()
		throws ECRException
	{
		return createReport(1);
	}

	public FinanceReport createProfitStatement()
		throws ECRException
	{
		return createReport(2);
	}

	public FinanceReport createCashflowStatement()
		throws ECRException
	{
		return createReport(3);
	}

	public FinanceReport createBalanceSheet2007()
		throws ECRException
	{
		return createReport(4);
	}

	public FinanceReport createProfitStatement2007()
		throws ECRException
	{
		return createReport(5);
	}

	public FinanceReport createCashflowStatement2007()
		throws ECRException
	{
		return createReport(6);
	}

	public FinanceReport createBalanceSheetIN()
		throws ECRException
	{
		return createReport(7);
	}

	public FinanceReport createCashflowStatementIN()
		throws ECRException
	{
		return createReport(8);
	}

	public FinanceReport createReport(int reportClass, int reportType, int reportSubType)
		throws ECRException
	{
		if (reportClass < 1 || reportClass > 8)
			throw new ECRException((new StringBuilder("无效的报表类别(")).append(reportClass).append(")！").toString());
		if (reportTemplete[reportClass] == null)
			reportTemplete[reportClass] = loadTemplete(reportClass);
		FinanceReport r = (FinanceReport)reportTemplete[reportClass].clone();
		r.setReportType(reportType);
		r.setReportSubtype(reportSubType);
		return r;
	}

	public FinanceReport createReport(int reportClass, int reportType)
		throws ECRException
	{
		return createReport(reportClass, reportType, 1);
	}

	public FinanceReport createReport(int reportClass)
		throws ECRException
	{
		return createReport(reportClass, 10, 1);
	}

	private FinanceReport loadTemplete(int reportClass)
		throws ECRException
	{
		FinanceReport r = null;
		String tempFile = getTempleteFile();
		ARE.getLog().debug((new StringBuilder("Load finance report templete file: ")).append(tempFile).toString());
		if (tempFile == null)
			throw new ECRException("没有定义财务报表模板文件！");
		File f = new File(tempFile);
		if (!f.exists() || !f.isFile())
			throw new ECRException((new StringBuilder("无法找到财务报表模板文件：")).append(tempFile).toString());
		try
		{
			Document doc = new Document(f);
			Element root = doc.getRootElement();
			List xReports = root.getChildren("report");
			Iterator it = xReports.iterator();
			Element xReport = null;
			while (it.hasNext()) 
			{
				Element x = (Element)it.next();
				Attribute a = x.getAttribute("class");
				if (a == null)
					continue;
				int c = a.getValue(-1);
				if (c != reportClass)
					continue;
				xReport = x;
				break;
			}
			if (xReport == null)
				throw new ECRException((new StringBuilder("初始化报表模板(")).append(reportClass).append(")失败，找不到对应的模板定义！").toString());
			r = new FinanceReport(reportClass);
			String modelNo = xReport.getAttributeValue("loanModelNo");
			if (modelNo == null)
				modelNo = getDefaultModelNo(reportClass);
			r.setLoanModelNo(modelNo);
			ReportItem item;
			for (Iterator xItems = xReport.getChildren("item").iterator(); xItems.hasNext(); r.addItem(item))
			{
				Element xItem = (Element)xItems.next();
				item = new ReportItem();
				for (Iterator xAtts = xItem.getAttributeList().iterator(); xAtts.hasNext();)
				{
					Attribute xAtt = (Attribute)xAtts.next();
					String n = xAtt.getName();
					String v = xAtt.getValue().trim();
					if (!v.equals(""))
						ObjectX.setProperty(item, n, v, false);
				}

			}

		}
		catch (Exception ex)
		{
			throw new ECRException("初始化报表模板失败！", ex);
		}
		return r;
	}

	private String getDefaultModelNo(int reortClass)
	{
		String mn = null;
		switch (reortClass)
		{
		case 1: // '\001'
			mn = "0001";
			break;

		case 2: // '\002'
			mn = "0002";
			break;

		case 3: // '\003'
			mn = "0007";
			break;

		case 4: // '\004'
			mn = "0201";
			break;

		case 5: // '\005'
			mn = "0202";
			break;

		case 6: // '\006'
			mn = "0208";
			break;

		case 7: // '\007'
			mn = "0191";
			break;

		case 8: // '\b'
			mn = "0192";
			break;

		default:
			mn = "0000";
			break;
		}
		return mn;
	}

	public void setTempleteFile(String fileName)
	{
		templeteFile = fileName;
	}

	public String getTempleteFile()
	{
		if (templeteFile == null)
			templeteFile = ARE.getProperty("finaceReport.templete");
		if (templeteFile == null)
			templeteFile = (new StringBuilder(String.valueOf(ARE.getProperty("ECR_HOME")))).append("/etc/finance_report_templete.xml").toString();
		return templeteFile;
	}
}
