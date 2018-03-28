// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRCustomerBase.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MBRCustomerBase extends DBMessageBodyReader
{

	private String recordSql;
	private ResultSet rsRecord;

	public MBRCustomerBase(Message message, String database)
	{
		super(message, database);
		recordSql = null;
		rsRecord = null;
	}

	public MBRCustomerBase(Message message)
	{
		super(message);
		recordSql = null;
		rsRecord = null;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		if (recordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(recordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		try
		{
			if (rsRecord.next())
			{
				Segment segB = fillBaseSegment(r, rsRecord);
				Field f = segB.getField(7519);
				if (f != null)
					f.setString(rsRecord.getString("CreditNo"));
				fillSegmentB(segB, rsRecord);
				fillIDChangeSegment(r, rsRecord);
				Segment segD = r.createSegment("D");
				segD.getField(7543).setString("D");
				fillSegmentD(segD, rsRecord);
				int length = r.getLength();
				segB.getField(4501).setInt(length);
			}
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	protected void fillSegmentB(Segment segment, ResultSet resultset)
		throws ECRException, SQLException
	{
	}

	protected void fillSegmentD(Segment segment, ResultSet resultset)
		throws ECRException, SQLException
	{
	}

	public final String getRecordSql()
	{
		return recordSql;
	}

	public final void setRecordSql(String recordSql)
	{
		this.recordSql = recordSql;
	}
}
