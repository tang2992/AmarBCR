// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ReportItem.java

package com.amarsoft.app.datax.ecr.finrpt;

import java.math.BigDecimal;

public final class ReportItem
	implements Cloneable
{

	public static final int DIRECTION_DEBIT = 0;
	public static final int DIRECTION_CREDIT = 1;
	public static final int TYPE_ASSETS = 0;
	public static final int TYPE_LIABILITIES = 1;
	public static final int TYPE_SHAREHOLDERSE_QUITY = 2;
	public static final int TYPE_PROFITS = 11;
	public static final int TYPE_CASHFLOW = 12;
	protected String code;
	protected String name;
	protected String label;
	protected String displayStyle;
	protected String level;
	protected String note;
	protected BigDecimal beginningValue;
	protected BigDecimal endingValue;
	protected BigDecimal occurValue;
	protected String beginningExpression;
	protected String endingExpression;
	protected String occurExpression;
	protected String itemType;
	protected int occurDirection;
	protected String loanItem;

	public ReportItem()
	{
		code = null;
		name = null;
		label = null;
		displayStyle = null;
		level = "1";
		note = null;
		beginningValue = new BigDecimal(0.0D);
		endingValue = new BigDecimal(0.0D);
		occurValue = new BigDecimal(0.0D);
		beginningExpression = null;
		endingExpression = null;
		occurExpression = null;
		itemType = "0";
		occurDirection = 0;
		loanItem = null;
	}

	public final String getCode()
	{
		return code;
	}

	public final void setCode(String code)
	{
		this.code = code;
	}

	public final String getName()
	{
		return name;
	}

	public final void setName(String name)
	{
		this.name = name;
	}

	public final String getNote()
	{
		return note;
	}

	public final void setNote(String note)
	{
		this.note = note;
	}

	public final String getBeginningExpression()
	{
		return beginningExpression;
	}

	public final void setBeginningExpression(String beginningExpression)
	{
		this.beginningExpression = beginningExpression;
	}

	public final BigDecimal getBeginningValue()
	{
		return beginningValue;
	}

	public final void setBeginningValue(BigDecimal beginningValue)
	{
		this.beginningValue = beginningValue;
	}

	public final void setBeginningValue(double beginningValue)
	{
		this.beginningValue = new BigDecimal(beginningValue);
	}

	public final String getDisplayStyle()
	{
		return displayStyle;
	}

	public final void setDisplayStyle(String displayStype)
	{
		displayStyle = displayStype;
	}

	public final BigDecimal getEndingValue()
	{
		return endingValue;
	}

	public final void setEndingValue(BigDecimal endingValue)
	{
		this.endingValue = endingValue;
	}

	public final void setEndingValue(double endingValue)
	{
		this.endingValue = new BigDecimal(endingValue);
	}

	public final String getEndingExpression()
	{
		return endingExpression;
	}

	public final void setEndingExpression(String endningExpression)
	{
		endingExpression = endningExpression;
	}

	public final String getType()
	{
		return itemType;
	}

	public final void setType(String itemDirection)
	{
		itemType = itemDirection;
	}

	public final String getLabel()
	{
		return label;
	}

	public final void setLabel(String label)
	{
		this.label = label;
	}

	public final int getOccurDirection()
	{
		return occurDirection;
	}

	public final void setOccurDirection(int occurDirection)
	{
		this.occurDirection = occurDirection;
	}

	public final String getOccurExpression()
	{
		return occurExpression;
	}

	public final void setOccurExpression(String occurExpression)
	{
		this.occurExpression = occurExpression;
	}

	public final BigDecimal getOccurValue()
	{
		return occurValue;
	}

	public final void setOccurValue(BigDecimal occurValue)
	{
		this.occurValue = occurValue;
	}

	public final void setOccurValue(double occurValue)
	{
		this.occurValue = new BigDecimal(occurValue);
	}

	public String getLevel()
	{
		return level;
	}

	public void setLevel(String level)
	{
		this.level = level;
	}

	public String getLoanItem()
	{
		return loanItem;
	}

	public void setLoanItem(String loanItems)
	{
		loanItem = loanItems;
	}

	public String toString()
	{
		StringBuffer sb = new StringBuffer(getCode());
		sb.append("[").append(getName()).append("](").append(getBeginningValue()).append(",").append(getOccurValue()).append(",").append(getEndingValue()).append(")");
		return sb.toString();
	}

	protected Object clone()
	{
		ReportItem o = null;
		try
		{
			o = (ReportItem)super.clone();
		}
		catch (CloneNotSupportedException ex)
		{
			o = new ReportItem();
		}
		return o;
	}
}
