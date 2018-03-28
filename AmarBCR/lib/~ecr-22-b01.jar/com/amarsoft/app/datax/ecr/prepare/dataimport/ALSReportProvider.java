// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ALSReportProvider.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.app.datax.ecr.finrpt.*;

public class ALSReportProvider extends AbstractReportProvider
{

	private String database;
	private String headSql;
	private String dataSql;

	public ALSReportProvider()
	{
		database = "loan";
		headSql = "select ReportNo as ReportNo,ReportScope as Scope from REPORT_RECORD where ObjectType='CustomerFS' and (updatetime is not null or updatetime<>'') and ObjectNo=? and ModelNo=? and ReportDate=? ";
		dataSql = "select RR.reportdate as ReportDate,RD.RowSubject as ItemCode,RD.Col2Value as Value from REPORT_RECORD RR,REPORT_DATA RD where RR.reportno=RD.reportno and RR.ObjectNo=? and RD.ReportNo=? and RR.reportdate=?";
	}

	protected ReportLoader createReportLoader()
	{
		ALSReportLoader loader = new ALSReportLoader();
		loader.setDatabase(getDatabase());
		loader.setHeadSql(getHeadSql());
		loader.setDataSql(getDataSql());
		return loader;
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
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
