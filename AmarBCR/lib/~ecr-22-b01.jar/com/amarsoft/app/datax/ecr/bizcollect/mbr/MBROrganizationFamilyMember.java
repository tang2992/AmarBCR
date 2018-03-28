// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBROrganizationFamilyMember.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MBROrganizationFamilyMember extends DBMessageBodyReader
{

	private String recordSql;
	private ResultSet rsRecord;

	public String getRecordSql()
	{
		return recordSql;
	}

	public void setRecordSql(String recordSql)
	{
		this.recordSql = recordSql;
	}

	public MBROrganizationFamilyMember(Message message)
	{
		super(message);
		recordSql = null;
		rsRecord = null;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
label0:
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
				if (!rsRecord.next())
					break label0;
				Segment segB = r.createSegment("B");
				segB.getField(9992).setString(rsRecord.getString("CIFCustomerId"));
				segB.getField(1902).setString(rsRecord.getString("ManagerName"));
				segB.getField(1903).setString(rsRecord.getString("ManagerCertType"));
				segB.getField(1904).setString(rsRecord.getString("ManagerCertId"));
				segB.getField(1905).setString(rsRecord.getString("MemberRelaType"));
				segB.getField(1906).setString(rsRecord.getString("MemberName"));
				segB.getField(1907).setString(rsRecord.getString("MemberCertType"));
				segB.getField(1908).setString(rsRecord.getString("MemberCertId"));
				segB.getField(1909).setDate(rsRecord.getString("updateDate"));
				segB.getField(1910).setString("");
				segB.getField(9993).setDate(rsRecord.getString("OccurDate"));
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
			return true;
		}
		return false;
	}
}
