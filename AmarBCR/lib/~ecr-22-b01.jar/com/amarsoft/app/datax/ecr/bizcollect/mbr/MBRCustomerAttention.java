// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRCustomerAttention.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MBRCustomerAttention extends DBMessageBodyReader
{

	private String lawRecordSql;
	private String factRecordSql;
	private ResultSet rsRecord;

	public MBRCustomerAttention(Message message, String database)
	{
		super(message, database);
		lawRecordSql = null;
		factRecordSql = null;
		rsRecord = null;
	}

	public MBRCustomerAttention(Message message)
	{
		super(message);
		lawRecordSql = null;
		factRecordSql = null;
		rsRecord = null;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		int rt = r.getType();
		switch (rt)
		{
		case 6: // '\006'
			return fillLaw(r);

		case 7: // '\007'
			return fillFact(r);
		}
		return false;
	}

	private boolean fillLaw(Record r)
		throws ECRException
	{
		if (lawRecordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(lawRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_319;
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(7503).setString(rsRecord.getString("LoanCardNo"));
		segB.getField(5559).setString(rsRecord.getString("CustomerName"));
		segB.getField(9991).setString(rsRecord.getString("CustomerID"));
		fillIDChangeSegment(r, rsRecord);
		Segment segD = r.createSegment("D");
		segD.getField(7647).setString(rsRecord.getString("LawNo"));
		segD.getField(5585).setString(rsRecord.getString("PlaintiffName"));
		segD.getField(1501).setString(rsRecord.getString("Currency"));
		segD.getField(1577).setDouble(rsRecord.getDouble("ExecuteSum"));
		segD.getField(2587).setDate(rsRecord.getString("ExecuteDate"));
		segD.getField(8529).setString(rsRecord.getString("ExecuteResult"));
		segD.getField(8531).setString(rsRecord.getString("AppellCause"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			rsRecord.close();
			rsRecord = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	private boolean fillFact(Record r)
		throws ECRException
	{
		if (factRecordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(factRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_214;
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(7503).setString(rsRecord.getString("LoanCardNo"));
		segB.getField(5559).setString(rsRecord.getString("CustomerName"));
		segB.getField(9991).setString(rsRecord.getString("CustomerID"));
		fillIDChangeSegment(r, rsRecord);
		Segment segE = r.createSegment("E");
		segE.getField(7649).setString(rsRecord.getString("FactNo"));
		segE.getField(8533).setString(rsRecord.getString("Describe"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			rsRecord.close();
			rsRecord = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	public final String getLawRecordSql()
	{
		return lawRecordSql;
	}

	public final void setLawRecordSql(String lawRecordSql)
	{
		this.lawRecordSql = lawRecordSql;
	}

	public final String getFactRecordSql()
	{
		return factRecordSql;
	}

	public final void setFactRecordSql(String factRecordSql)
	{
		this.factRecordSql = factRecordSql;
	}
}
