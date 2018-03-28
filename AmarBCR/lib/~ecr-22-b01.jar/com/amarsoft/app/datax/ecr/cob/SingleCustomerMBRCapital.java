// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SingleCustomerMBRCapital.java

package com.amarsoft.app.datax.ecr.cob;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class SingleCustomerMBRCapital extends DBMessageBodyReader
{

	private String recordSql;
	private String capiSql;
	private PreparedStatement psCapi;
	private String investSql;
	private PreparedStatement psInvest;
	private String keeperSql;
	private PreparedStatement psKeeper;
	private String familySql;
	private PreparedStatement psFamily;
	private ResultSet rsRecord;

	public SingleCustomerMBRCapital(Message message, String database)
	{
		super(message, database);
		recordSql = null;
		capiSql = null;
		psCapi = null;
		investSql = null;
		psInvest = null;
		keeperSql = null;
		psKeeper = null;
		familySql = null;
		psFamily = null;
		rsRecord = null;
	}

	public SingleCustomerMBRCapital(Message message)
	{
		super(message);
		recordSql = null;
		capiSql = null;
		psCapi = null;
		investSql = null;
		psInvest = null;
		keeperSql = null;
		psKeeper = null;
		familySql = null;
		psFamily = null;
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
		  goto _L1
_L3:
		String customerId;
		try
		{
			String sessionId = rsRecord.getString("SessionID");
			String occurDate = rsRecord.getString("OccurDate");
			customerId = rsRecord.getString("CustomerID");
			String superName = rsRecord.getString("SuperName");
			if (psKeeper == null)
				psKeeper = prepareStatement(keeperSql);
			psKeeper.setString(1, sessionId);
			psKeeper.setString(2, customerId);
			ResultSet rs = psKeeper.executeQuery();
			if (!rs.next())
				continue; /* Loop/switch isn't completed */
			Segment segB = fillBaseSegment(r, rsRecord);
			segB.getField(7503).setString(rsRecord.getString("LoanCardNo"));
			fillIDChangeSegment(r, rsRecord);
			Segment segD = r.createSegment("D");
			segD.getField(1501).setString(rsRecord.getString("Currency"));
			segD.getField(1503).setInt(rsRecord.getInt("RegistSum"));
			if (capiSql != null)
				fillSegmentE(r, sessionId, occurDate, customerId);
			if (investSql != null)
				fillSegmentF(r, sessionId, occurDate, customerId);
			if (superName != null && !superName.equals(""))
				fillSegmengG(r, rsRecord);
			if (keeperSql != null)
				fillSegmentH(r, sessionId, occurDate, customerId);
			if (familySql != null)
				fillSegmentI(r, sessionId, occurDate, customerId);
			int length = r.getLength();
			segB.getField(4501).setInt(length);
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return true;
		logger.warn((new StringBuilder("客户号")).append(customerId).append("没有任何高管信息，忽略资本构成记录！").toString());
_L1:
		if (rsRecord.next()) goto _L3; else goto _L2
_L2:
		return false;
	}

	private void fillSegmentE(Record r, String sessionId, String occurDate, String customerId)
		throws ECRException, SQLException
	{
		if (psCapi == null)
			psCapi = prepareStatement(capiSql);
		psCapi.setString(1, sessionId);
		psCapi.setString(2, customerId);
		ResultSet rs;
		Segment segE;
		for (rs = psCapi.executeQuery(); rs.next(); segE.getField(1507).setInt(rs.getInt("ContribSum")))
		{
			segE = r.createSegment("E");
			segE.getField(5577).setString(rs.getString("ContribName"));
			segE.getField(7505).setString(rs.getString("CLoanCardNo"));
			segE.getField(6511).setString(rs.getString("COrgCode"));
			segE.getField(5517).setString(rs.getString("CRegistNo"));
			segE.getField(5511).setString(rs.getString("CertType"));
			segE.getField(5553).setString(rs.getString("CertNo"));
			segE.getField(1501).setString(rs.getString("Currency"));
		}

		rs.close();
	}

	private void fillSegmentF(Record r, String sessionId, String occurDate, String customerId)
		throws ECRException, SQLException
	{
		if (psInvest == null)
			psInvest = prepareStatement(investSql);
		psInvest.setString(1, sessionId);
		psInvest.setString(2, customerId);
		ResultSet rs;
		Segment segF;
		for (rs = psInvest.executeQuery(); rs.next(); segF.getField(9609).setInt(rs.getInt("InvestSum3")))
		{
			segF = r.createSegment("F");
			segF.getField(5501).setString(rs.getString("InvestCorpName"));
			segF.getField(7503).setString(rs.getString("ILoanCardNo"));
			segF.getField(6511).setString(rs.getString("IOrgCode"));
			segF.getField(1501).setString(rs.getString("Currency1"));
			segF.getField(1509).setInt(rs.getInt("InvestSum1"));
			segF.getField(9501).setString(rs.getString("Currency2"));
			segF.getField(9509).setInt(rs.getInt("InvestSum2"));
			segF.getField(9601).setString(rs.getString("Currency3"));
		}

		rs.close();
	}

	private void fillSegmengG(Record r, ResultSet rsRec)
		throws SQLException, ECRException
	{
		String sLoanCardNo = rsRec.getString("SLoanCardNo");
		String sOrgCode = rsRec.getString("SOrgCode");
		if (sLoanCardNo != null || sOrgCode != null)
		{
			Segment segG = r.createSegment("G");
			segG.getField(5535).setString(rsRec.getString("SuperName"));
			segG.getField(7503).setString(sLoanCardNo);
			segG.getField(6511).setString(sOrgCode);
		}
	}

	private void fillSegmentH(Record r, String sessionId, String occurDate, String customerId)
		throws ECRException, SQLException
	{
		if (psKeeper == null)
			psKeeper = prepareStatement(keeperSql);
		psKeeper.setString(1, sessionId);
		psKeeper.setString(2, customerId);
		ResultSet rs;
		Segment segH;
		for (rs = psKeeper.executeQuery(); rs.next(); segH.getField(5549).setString(rs.getString("JobResume")))
		{
			segH = r.createSegment("H");
			segH.getField(5537).setString(rs.getString("KeeperName"));
			segH.getField(5511).setString(rs.getString("CertType"));
			segH.getField(5553).setString(rs.getString("CertNo"));
			segH.getField(5543).setString(rs.getString("KeeperType"));
			segH.getField(5545).setString(rs.getString("Sex"));
			segH.getField(2509).setDate(rs.getString("Birthdate"));
			segH.getField(5547).setString(rs.getString("Degree"));
		}

		rs.close();
	}

	private void fillSegmentI(Record r, String sessionId, String occurDate, String customerId)
		throws ECRException, SQLException
	{
		if (psFamily == null)
			psFamily = prepareStatement(familySql);
		psFamily.setString(1, sessionId);
		psFamily.setString(2, customerId);
		ResultSet rs;
		Segment segI;
		for (rs = psFamily.executeQuery(); rs.next(); segI.getField(7503).setString(rs.getString("FLoanCardNo")))
		{
			segI = r.createSegment("I");
			segI.getField(5551).setString(rs.getString("FamilyName"));
			segI.getField(5511).setString(rs.getString("CertType"));
			segI.getField(5553).setString(rs.getString("CertNo"));
			segI.getField(5555).setString(rs.getString("Relation"));
			segI.getField(5557).setString(rs.getString("FamilyCorpName"));
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
			capiSql = null;
			investSql = null;
			keeperSql = null;
			familySql = null;
			return;
		}
		String s = recordSql.toUpperCase();
		String capiTable = null;
		String investTable = null;
		String keeperTable = null;
		String familyTable = null;
		if (s.indexOf("ECR_CUSTCAPIINFO") > 0)
		{
			capiTable = "ECR_CUSTOMERCAPI";
			investTable = "ECR_CUSTOMERINVEST";
			keeperTable = "ECR_CUSTOMERKEEPER";
			familyTable = "ECR_CUSTOMERFAMILY";
		} else
		{
			capiTable = "HIS_CUSTOMERCAPI";
			investTable = "HIS_CUSTOMERINVEST";
			keeperTable = "HIS_CUSTOMERKEEPER";
			familyTable = "HIS_CUSTOMERFAMILY";
		}
		capiSql = (new StringBuilder("select * from ")).append(capiTable).append(" where SessionID=? and CustomerID=?").toString();
		investSql = (new StringBuilder("select * from ")).append(investTable).append(" where SessionID=? and CustomerID=?").toString();
		keeperSql = (new StringBuilder("select * from ")).append(keeperTable).append(" where SessionID=? and CustomerID=?").toString();
		familySql = (new StringBuilder("select * from ")).append(familyTable).append(" where SessionID=? and CustomerID=?").toString();
	}
}
