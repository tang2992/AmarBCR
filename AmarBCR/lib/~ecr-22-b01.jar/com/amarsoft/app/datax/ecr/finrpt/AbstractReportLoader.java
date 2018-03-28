// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   AbstractReportLoader.java

package com.amarsoft.app.datax.ecr.finrpt;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.math.BigDecimal;
import java.util.Date;

// Referenced classes of package com.amarsoft.app.datax.ecr.finrpt:
//			ReportLoader, FinanceReport, ReportItem

public abstract class AbstractReportLoader
	implements ReportLoader
{

	protected FinanceReport report;
	protected Log logger;

	public AbstractReportLoader()
	{
		report = null;
		logger = ARE.getLog();
	}

	protected FinanceReport getReport()
	{
		return report;
	}

	protected int getReportYear()
	{
		if (report == null)
			return 0;
		else
			return report.getReportYear();
	}

	protected String getCustomerId()
	{
		if (report == null)
			return null;
		else
			return report.getCustomerId();
	}

	protected int getReportClass()
	{
		if (report == null)
			return 0;
		else
			return report.getReportClass();
	}

	protected int getReportType()
	{
		if (report == null)
			return 0;
		else
			return report.getReportType();
	}

	protected ReportItem getItem(String itemCode)
	{
		if (report == null)
			return null;
		else
			return report.getItem(itemCode);
	}

	public final boolean loadReport(FinanceReport report)
		throws ECRException
	{
		if (report == null)
			throw new ECRException("无效的报表参数!");
		this.report = report;
		if (!reportReady())
			return false;
		report.setReportSubtype(getReportSubtype());
		report.setAuditFirm(getAuditFirm());
		report.setAuditor(getAuditor());
		report.setAuditDate(getAuditDate());
		report.setTerms(getTerms());
		for (int i = 0; i < report.getItemNumber(); i++)
		{
			ReportItem item = report.getItem(i);
			String itemCode = item.getCode();
			item.setBeginningValue(getItemBeginningValue(itemCode));
			item.setEndingValue(getItemEndingValue(itemCode));
			item.setOccurValue(getItemOccurValue(itemCode));
		}

		return true;
	}

	protected abstract boolean reportReady()
		throws ECRException;

	public String getAuditFirm()
	{
		return null;
	}

	public int getTerms()
	{
		return 0;
	}

	protected String getAuditor()
	{
		return null;
	}

	protected Date getAuditDate()
	{
		return null;
	}

	protected abstract int getReportSubtype();

	protected abstract BigDecimal getItemBeginningValue(String s);

	protected abstract BigDecimal getItemEndingValue(String s);

	protected abstract BigDecimal getItemOccurValue(String s);
}
