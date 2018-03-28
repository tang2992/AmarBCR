// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRCustomerInfo.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class MBRCustomerInfo extends DBMessageBodyReader
{

	private String recordSql;
	private String stockSql;
	private PreparedStatement psStock;
	private ResultSet rsRecord;

	public MBRCustomerInfo(Message message, String database)
	{
		super(message, database);
		recordSql = null;
		stockSql = null;
		psStock = null;
		rsRecord = null;
	}

	public MBRCustomerInfo(Message message)
	{
		super(message);
		recordSql = null;
		stockSql = null;
		psStock = null;
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
				String customerId = rsRecord.getString("CustomerID");
				String occurDate = rsRecord.getString("OccurDate");
				Segment segB = fillBaseSegment(r, rsRecord);
				segB.getField(7503).setString(rsRecord.getString("LoanCardNo"));
				segB.getField(9991).setString(rsRecord.getString("CustomerID"));
				fillIDChangeSegment(r, rsRecord);
				Segment segD = r.createSegment("D");
				segD.getField(5509).setString(rsRecord.getString("CountryCode"));
				segD.getField(5505).setString(rsRecord.getString("ChinaName"));
				segD.getField(5507).setString(rsRecord.getString("ForeignName"));
				segD.getField(6511).setString(rsRecord.getString("OrganizationCode"));
				segD.getField(2503).setString(rsRecord.getString("SetupDate"));
				segD.getField(5515).setString(rsRecord.getString("RegistType"));
				segD.getField(5517).setString(rsRecord.getString("RegistNo"));
				segD.getField(2505).setDate(rsRecord.getString("RegistDate"));
				segD.getField(2507).setDate(rsRecord.getString("RegistEndDate"));
				segD.getField(5519).setString(rsRecord.getString("CountryTaxNo"));
				segD.getField(5521).setString(rsRecord.getString("LocationTaxNo"));
				segD.getField(5523).setString(rsRecord.getString("Attribute"));
				segD.getField(5525).setString(rsRecord.getString("IndustryType"));
				segD.getField(4503).setInt(rsRecord.getInt("EmployeeNumber"));
				segD.getField(5527).setString(rsRecord.getString("RegionCode"));
				segD.getField(5529).setString(rsRecord.getString("CustomerCharacter"));
				segD.getField(3501).setString(rsRecord.getString("Tel"));
				segD.getField(3503).setString(rsRecord.getString("Addr"));
				segD.getField(3505).setString(rsRecord.getString("Fax"));
				segD.getField(3507).setString(rsRecord.getString("Email"));
				segD.getField(3509).setString(rsRecord.getString("WebSite"));
				segD.getField(3511).setString(rsRecord.getString("Address"));
				segD.getField(3513).setString(rsRecord.getString("PostNo"));
				segD.getField(8501).setString(rsRecord.getString("MainProduct"));
				segD.getField(4505).setInt(rsRecord.getInt("LocalEarea"));
				segD.getField(8503).setString(rsRecord.getString("LocaleDroit"));
				segD.getField(8505).setString(rsRecord.getString("GroupFlag"));
				segD.getField(8507).setString(rsRecord.getString("InOutFlag"));
				segD.getField(8509).setString(rsRecord.getString("MarketFlag"));
				String fdContact = rsRecord.getString("FinanceContact");
				if (fdContact != null && fdContact != "")
				{
					Segment segE = r.createSegment("E");
					segE.getField(5531).setString(fdContact);
				}
				if (stockSql != null)
					fillSegmentF(r, customerId, occurDate);
				int length = r.getLength();
				segB.getField(4501).setInt(length);
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

	private void fillSegmentF(Record r, String customerId, String occurDate)
		throws ECRException, SQLException
	{
		if (psStock == null)
			psStock = prepareStatement(stockSql);
		psStock.setString(1, customerId);
		psStock.setString(2, occurDate);
		ResultSet rs;
		Segment seg;
		for (rs = psStock.executeQuery(); rs.next(); seg.getField(6515).setString(rs.getString("MarketPlace")))
		{
			seg = r.createSegment("F");
			seg.getField(6513).setString(rs.getString("StockNo"));
		}

		rs.close();
	}

	public final String getRecordSql()
	{
		return recordSql;
	}

	public final void setRecordSql(String recordSql)
	{
		this.recordSql = recordSql;
		if (recordSql == null)
		{
			stockSql = null;
			return;
		}
		String s = recordSql.toUpperCase();
		String stockTable = null;
		if (s.indexOf("ECR_CUSTOMERINFO") > 0)
			stockTable = "ECR_CUSTOMERSTOCK";
		else
			stockTable = "HIS_CUSTOMERSTOCK";
		stockSql = (new StringBuilder("select * from ")).append(stockTable).append(" where CustomerID=? and OccurDate=?").toString();
	}
}
