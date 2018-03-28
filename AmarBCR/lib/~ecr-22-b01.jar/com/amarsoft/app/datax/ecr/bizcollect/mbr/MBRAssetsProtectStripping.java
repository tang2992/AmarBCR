// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRAssetsProtectStripping.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect.mbr:
//			MBRSingleSql

public class MBRAssetsProtectStripping extends MBRSingleSql
{

	private String assetsDisposeRecordSql;
	private ResultSet rsRecord;

	public MBRAssetsProtectStripping(Message paramMessage, String paramString)
	{
		super(paramMessage, paramString);
		assetsDisposeRecordSql = null;
		rsRecord = null;
	}

	public MBRAssetsProtectStripping(Message paramMessage)
	{
		super(paramMessage);
		assetsDisposeRecordSql = null;
		rsRecord = null;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		int rt = r.getType();
		switch (rt)
		{
		case 51: // '3'
			return fillAssetsDispose(r);
		}
		return false;
	}

	private boolean fillAssetsDispose(Record r)
		throws ECRException
	{
		if (assetsDisposeRecordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(assetsDisposeRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_298;
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(5559).setString(rsRecord.getString("CustomerName"));
		segB.getField(7503).setString(rsRecord.getString("LoanCardNo"));
		segB.getField(6511).setString(rsRecord.getString("OrganizationCode"));
		segB.getField(5517).setString(rsRecord.getString("BusinessRegistryNo"));
		segB.getField(7661).setString(rsRecord.getString("BusinessNo"));
		fillIDChangeSegment(r, rsRecord);
		Segment segE = r.createSegment("E");
		segE.getField(1579).setDouble(rsRecord.getDouble("Balance"));
		segE.getField(2595).setDate(rsRecord.getString("DisposeDate"));
		segE.getField(7639).setString(rsRecord.getString("DisposeType"));
		segE.getField(1585).setDouble(rsRecord.getDouble("RecoveryAmount"));
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

	public final String getAssetsDisposeRecordSql()
	{
		return assetsDisposeRecordSql;
	}

	public void setAssetsDisposeRecordSql(String assetsDisposeRecordSql)
	{
		this.assetsDisposeRecordSql = assetsDisposeRecordSql;
	}
}
