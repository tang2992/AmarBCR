// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FinanceReport.java

package com.amarsoft.app.datax.ecr.finrpt;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.math.BigDecimal;
import java.util.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.finrpt:
//			ReportItem

public class FinanceReport
	implements Cloneable
{

	public static final int CLASS_BALANCESHEET = 1;
	public static final int CLASS_PROFITSTATEMENT = 2;
	public static final int CLASS_CASHFLOWSTATEMENT = 3;
	public static final int CLASS_BALANCESHEET_2007 = 4;
	public static final int CLASS_PROFITSTATEMENT_2007 = 5;
	public static final int CLASS_CASHFLOWSTATEMENT_2007 = 6;
	public static final int CLASS_BALANCESHEET_IN = 7;
	public static final int CLASS_CASHFLOWSTATEMENT_IN = 8;
	public static final int TYPE_YEAR = 10;
	public static final int TYPE_FIRSTHALF = 20;
	public static final int TYPE_SECONDHALF = 30;
	public static final int TYPE_QUARTER1 = 40;
	public static final int TYPE_QUARTER2 = 50;
	public static final int TYPE_QUARTER3 = 60;
	public static final int TYPE_QUARTER4 = 70;
	public static final int TYPE_BEGINTERM = 1;
	public static final int TYPE_ENDTERM = 2;
	public static final int SUBTYPE_NATURAL = 1;
	public static final int SUBTYPE_MERGER = 2;
	public static final int SUBTYPE_UNKNOW = 9;
	private int reportClass;
	private String loanModelNo;
	private String customerId;
	private int reportYear;
	private int reportType;
	private int reportSubtype;
	private String auditFirm;
	private String auditor;
	private Date auditDate;
	private int terms;
	private ArrayList items;

	protected FinanceReport(int rptClass)
	{
		reportClass = 1;
		loanModelNo = null;
		customerId = null;
		reportYear = 0;
		reportType = 10;
		reportSubtype = 1;
		auditFirm = null;
		auditor = null;
		auditDate = null;
		terms = 0;
		items = null;
		reportClass = rptClass;
		items = new ArrayList();
	}

	public final Date getAuditDate()
	{
		return auditDate;
	}

	public final void setAuditDate(Date auditDate)
	{
		this.auditDate = auditDate;
	}

	public final String getAuditFirm()
	{
		return auditFirm;
	}

	public final void setAuditFirm(String auditFirm)
	{
		this.auditFirm = auditFirm;
	}

	public final String getAuditor()
	{
		return auditor;
	}

	public final void setAuditor(String auditor)
	{
		this.auditor = auditor;
	}

	public final String getCustomerId()
	{
		return customerId;
	}

	public final void setCustomerId(String customerId)
	{
		this.customerId = customerId;
	}

	public final int getReportSubtype()
	{
		return reportSubtype;
	}

	public final void setReportSubtype(int reportSubType)
	{
		reportSubtype = reportSubType;
	}

	public final int getReportType()
	{
		return reportType;
	}

	public final void setReportType(int reportType)
	{
		this.reportType = reportType;
	}

	public final int getReportYear()
	{
		return reportYear;
	}

	public void setTerms(int terms)
	{
		this.terms = terms;
	}

	public int getTerms()
	{
		return terms;
	}

	public final void setReportYear(int reportYear)
	{
		this.reportYear = reportYear;
	}

	public final List getItems()
	{
		return items;
	}

	public final ReportItem getItem(int index)
	{
		return (ReportItem)items.get(index);
		RuntimeException e;
		e;
		return null;
	}

	public final ReportItem getItem(String code)
	{
		int index = indexOf(code);
		if (index < 0)
			return null;
		else
			return getItem(index);
	}

	public final int indexOf(String code)
	{
		int index;
		for (index = items.size(); --index >= 0;)
			if (((ReportItem)items.get(index)).getCode().equals(code))
				break;

		return index;
	}

	public int getItemNumber()
	{
		return items.size();
	}

	protected void addItem(ReportItem newItem)
	{
		items.add(newItem);
	}

	public void clear()
	{
		for (int i = 0; i < items.size(); i++)
		{
			ReportItem item = (ReportItem)items.get(i);
			item.setBeginningValue(null);
			item.setEndingValue(null);
			item.setOccurValue(null);
		}

	}

	public void clearComputeItems()
	{
		for (int i = 0; i < items.size(); i++)
		{
			ReportItem ri = (ReportItem)items.get(i);
			if (ri.beginningExpression != null)
				ri.setBeginningValue(null);
			if (ri.endingExpression != null)
				ri.setEndingValue(null);
			if (ri.occurExpression != null)
				ri.setOccurValue(null);
		}

	}

	public final int getReportClass()
	{
		return reportClass;
	}

	public final BigDecimal getBeginningValue(String itemCode)
	{
		ReportItem item = getItem(itemCode);
		if (item == null)
			return null;
		BigDecimal v = item.getBeginningValue();
		if (v == null || v.equals(new BigDecimal(0.0D)))
		{
			String exp = item.getBeginningExpression();
			if (exp != null)
			{
				v = computeExpression(exp, 0);
				item.setBeginningValue(v);
			}
		}
		return v;
	}

	public final void setBeginningValue(String itemCode, BigDecimal value)
	{
		ReportItem item = getItem(itemCode);
		if (item == null)
		{
			return;
		} else
		{
			item.setBeginningValue(value);
			return;
		}
	}

	public final void setBeginningValue(String itemCode, double value)
	{
		ReportItem item = getItem(itemCode);
		if (item == null)
		{
			return;
		} else
		{
			item.setBeginningValue(value);
			return;
		}
	}

	public final BigDecimal getEndingValue(String itemCode)
	{
		ReportItem item = getItem(itemCode);
		if (item == null)
			return null;
		BigDecimal v = item.getEndingValue();
		if (v == null || v.equals(new BigDecimal(0.0D)))
		{
			String exp = item.getEndingExpression();
			if (exp != null)
			{
				v = computeExpression(exp, 1);
				item.setEndingValue(v);
			}
		}
		return v;
	}

	public final void setEndingValue(String itemCode, BigDecimal value)
	{
		ReportItem item = getItem(itemCode);
		if (item == null)
		{
			return;
		} else
		{
			item.setEndingValue(value);
			return;
		}
	}

	public final void setEndingValue(String itemCode, double value)
	{
		ReportItem item = getItem(itemCode);
		if (item == null)
		{
			return;
		} else
		{
			item.setEndingValue(value);
			return;
		}
	}

	private BigDecimal computeExpression(String exp, int expType)
	{
		String opers[] = exp.split("[^\\+\\-]+", 0);
		String item[] = exp.split("[\\+\\-]", 0);
		Stack var = new Stack();
		Stack ope = new Stack();
		for (int i = item.length - 1; i >= 0; i--)
		{
			BigDecimal v = null;
			if (expType == 0)
				v = getBeginningValue(item[i].trim());
			else
				v = getEndingValue(item[i].trim());
			if (v == null)
				v = new BigDecimal(0);
			var.push(v);
		}

		for (int i = opers.length - 1; i >= 0; i--)
			if (!opers[i].trim().equals(""))
				ope.push(opers[i].trim());

		BigDecimal value = null;
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
			if (ARE.getLog().isTraceEnabled())
				ARE.getLog().trace((new StringBuilder()).append(v1).append(op).append(v2).append("=").append(value).toString());
		}

		return value;
	}

	public String getLoanModelNo()
	{
		return loanModelNo;
	}

	public void setLoanModelNo(String loanModelNo)
	{
		this.loanModelNo = loanModelNo;
	}

	protected Object clone()
	{
		FinanceReport r;
		try
		{
			r = (FinanceReport)super.clone();
		}
		catch (CloneNotSupportedException ex)
		{
			r = new FinanceReport(reportClass);
		}
		r.items = new ArrayList();
		for (int i = 0; i < items.size(); i++)
			r.items.add(((ReportItem)items.get(i)).clone());

		return r;
	}
}
