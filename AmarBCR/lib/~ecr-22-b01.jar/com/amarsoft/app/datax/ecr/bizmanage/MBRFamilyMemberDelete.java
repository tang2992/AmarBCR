// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRFamilyMemberDelete.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.DataConvert;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MBRFamilyMemberDelete extends DBMessageBodyReader
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

	public MBRFamilyMemberDelete(Message message)
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
			break MISSING_BLOCK_LABEL_299;
		iCount++;
		Segment segB = r.createSegment("B");
		segB.getField(9992).setString(rsRecord.getString("CIFCustomerID"));
		segB.getField(2101).setString(rsRecord.getString("ManagerCertType"));
		segB.getField(2102).setString(rsRecord.getString("ManagerCertId"));
		segB.getField(2103).setString(rsRecord.getString("MemberRelaType"));
		segB.getField(2104).setString(rsRecord.getString("MemberCertType"));
		segB.getField(2105).setString(rsRecord.getString("MemberCertId"));
		segB.getField(2106).setDate(rsRecord.getString("UpdateDate"));
		segB.getField(2107).setString("");
		segB.getField(9993).setDate(rsRecord.getString("OccurDate"));
		return iCount < DataConvert.toInt(ARE.getProperty("deleteNumber"));
		segB;
		logger.debug(segB);
		throw new ECRException(segB);
		return false;
	}
}
