// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBROrganizationDelete.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.DataConvert;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MBROrganizationDelete extends DBMessageBodyReader
{

	private String recordSql;
	private ResultSet rsRecord;
	private int iCount;

	public String getRecordSql()
	{
		return recordSql;
	}

	public void setRecordSql(String recordSql)
	{
		this.recordSql = recordSql;
	}

	public MBROrganizationDelete(Message message)
	{
		super(message);
		recordSql = null;
		rsRecord = null;
		iCount = 0;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		SQLException e;
		if (recordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(recordSql);
			}
			// Misplaced declaration of an exception variable
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_236;
		iCount++;
		Segment segB = r.createSegment("B");
		segB.getField(2001).setString(rsRecord.getString("CIFCustomerID"));
		segB.getField(2002).setString(rsRecord.getString("SegmentType"));
		segB.getField(2003).setString(rsRecord.getString("ManagerType"));
		segB.getField(2004).setDate(rsRecord.getString("UpdateDate"));
		segB.getField(2005).setString("");
		segB.getField(9993).setDate(rsRecord.getString("OccurDate"));
		return iCount < DataConvert.toInt(ARE.getProperty("deleteNumber"));
		segB;
		logger.debug(segB);
		throw new ECRException(segB);
		return false;
	}
}
