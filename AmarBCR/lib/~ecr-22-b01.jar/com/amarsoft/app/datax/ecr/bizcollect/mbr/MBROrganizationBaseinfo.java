// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBROrganizationBaseinfo.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class MBROrganizationBaseinfo extends DBMessageBodyReader
{

	private String recordSql;
	private String organAttrSql;
	private PreparedStatement psOrganAttr;
	private String organStatusSql;
	private PreparedStatement psOrganStatus;
	private String organContactSql;
	private PreparedStatement psOrganContact;
	private String organKeeperSql;
	private PreparedStatement psOrganKeeper;
	private String organStockHolderSql;
	private PreparedStatement psOrganStockHolder;
	private String organRelaSql;
	private PreparedStatement psOrganRela;
	private String organSuperSql;
	private PreparedStatement psOrganSuper;
	private ResultSet rsRecord;
	private String dataFilter;

	public MBROrganizationBaseinfo(Message message)
	{
		super(message);
		organAttrSql = null;
		psOrganAttr = null;
		organStatusSql = null;
		psOrganStatus = null;
		organContactSql = null;
		psOrganContact = null;
		organKeeperSql = null;
		psOrganKeeper = null;
		organStockHolderSql = null;
		psOrganStockHolder = null;
		organRelaSql = null;
		psOrganRela = null;
		organSuperSql = null;
		psOrganSuper = null;
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
				String sessionId = rsRecord.getString("SessionID");
				String CIFCustomerId = rsRecord.getString("CIFCustomerId");
				Segment segB = r.createSegment("B");
				segB.getField(1102).setString(CIFCustomerId);
				segB.getField(1103).setString(rsRecord.getString("FinanceId"));
				segB.getField(1104).setString(rsRecord.getString("CustomerType"));
				segB.getField(1105).setString(rsRecord.getString("CreditCode"));
				segB.getField(1106).setString(rsRecord.getString("CorpId"));
				segB.getField(1107).setString(rsRecord.getString("RegisterType"));
				segB.getField(1108).setString(rsRecord.getString("RegisterNo"));
				segB.getField(1109).setString(rsRecord.getString("NationalTaxNo"));
				segB.getField(1110).setString(rsRecord.getString("LocalTaxNo"));
				segB.getField(1111).setString(rsRecord.getString("AccountPermitNo"));
				segB.getField(1112).setString(rsRecord.getString("LoancardNo"));
				segB.getField(1113).setDate(rsRecord.getString("GatherDate"));
				segB.getField(1114).setString(rsRecord.getString("Attribute1"));
				segB.getField(9993).setDate(rsRecord.getString("OccurDate"));
				if (organAttrSql != null)
					fillSegmentC(r, sessionId, CIFCustomerId);
				if (organStatusSql != null)
					fillSegmentD(r, sessionId, CIFCustomerId);
				if (organContactSql != null)
					fillSegmentE(r, sessionId, CIFCustomerId);
				if (organKeeperSql != null)
					fillSegmentF(r, sessionId, CIFCustomerId);
				if (organStockHolderSql != null)
					fillSegmentG(r, sessionId, CIFCustomerId);
				if (organRelaSql != null)
					fillSegmentH(r, sessionId, CIFCustomerId);
				if (organSuperSql != null)
					fillSegmentI(r, sessionId, CIFCustomerId);
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

	private void fillSegmentI(Record r, String sessionId, String CIFCustomerId)
		throws ECRException, SQLException
	{
		if (psOrganSuper == null)
			psOrganSuper = prepareStatement(organSuperSql);
		psOrganSuper.setString(1, sessionId);
		psOrganSuper.setString(2, CIFCustomerId);
		ResultSet rs = psOrganSuper.executeQuery();
		if (rs.next())
		{
			Segment seg = r.createSegment("I");
			seg.getField(1802).setString(rs.getString("SuperiorName"));
			seg.getField(1803).setString(rs.getString("RegisterType"));
			seg.getField(1804).setString(rs.getString("RegisterNo"));
			seg.getField(1805).setString(rs.getString("CorpId"));
			seg.getField(1806).setString(rs.getString("CreditCode"));
			seg.getField(1807).setDate(rs.getString("updateDate"));
			seg.getField(1808).setString("");
		}
		rs.close();
	}

	private void fillSegmentH(Record r, String sessionId, String CIFCustomerId)
		throws ECRException, SQLException
	{
		if (psOrganRela == null)
			psOrganRela = prepareStatement(organRelaSql);
		psOrganRela.setString(1, sessionId);
		psOrganRela.setString(2, CIFCustomerId);
		ResultSet rs;
		Segment seg;
		for (rs = psOrganRela.executeQuery(); rs.next(); seg.getField(1709).setString(""))
		{
			seg = r.createSegment("H");
			seg.getField(1702).setString(rs.getString("RelationShip"));
			seg.getField(1703).setString(rs.getString("RelativeEntName"));
			seg.getField(1704).setString(rs.getString("RegisterType"));
			seg.getField(1705).setString(rs.getString("RegisterNo"));
			seg.getField(1706).setString(rs.getString("CorpId"));
			seg.getField(1707).setString(rs.getString("CreditCode"));
			seg.getField(1708).setDate(rs.getString("updateDate"));
		}

		rs.close();
	}

	private void fillSegmentG(Record r, String sessionId, String CIFCustomerId)
		throws ECRException, SQLException
	{
		if (psOrganStockHolder == null)
			psOrganStockHolder = prepareStatement(organStockHolderSql);
		psOrganStockHolder.setString(1, sessionId);
		psOrganStockHolder.setString(2, CIFCustomerId);
		ResultSet rs;
		Segment seg;
		for (rs = psOrganStockHolder.executeQuery(); rs.next(); seg.getField(1610).setString(""))
		{
			seg = r.createSegment("G");
			seg.getField(1602).setString(rs.getString("StockHolderType"));
			seg.getField(1603).setString(rs.getString("StockHolderName"));
			seg.getField(1604).setString(rs.getString("CertType"));
			seg.getField(1605).setString(rs.getString("CertId"));
			seg.getField(1606).setString(rs.getString("CorpId"));
			seg.getField(1607).setString(rs.getString("CreditCode"));
			seg.getField(1608).setDouble(rs.getDouble("StockHodingRatio"));
			seg.getField(1609).setDate(rs.getString("updateDate"));
		}

		rs.close();
	}

	private void fillSegmentF(Record r, String sessionId, String CIFCustomerId)
		throws ECRException, SQLException
	{
		if (psOrganKeeper == null)
			psOrganKeeper = prepareStatement(organKeeperSql);
		psOrganKeeper.setString(1, sessionId);
		psOrganKeeper.setString(2, CIFCustomerId);
		ResultSet rs;
		Segment seg;
		for (rs = psOrganKeeper.executeQuery(); rs.next(); seg.getField(1507).setString(""))
		{
			seg = r.createSegment("F");
			seg.getField(1502).setString(rs.getString("ManagerType"));
			seg.getField(1503).setString(rs.getString("ManagerName"));
			seg.getField(1504).setString(rs.getString("CertType"));
			seg.getField(1505).setString(rs.getString("CertId"));
			seg.getField(1506).setDate(rs.getString("updateDate"));
		}

		rs.close();
	}

	private void fillSegmentE(Record r, String sessionId, String CIFCustomerId)
		throws ECRException, SQLException
	{
		if (psOrganContact == null)
			psOrganContact = prepareStatement(organContactSql);
		psOrganContact.setString(1, sessionId);
		psOrganContact.setString(2, CIFCustomerId);
		ResultSet rs = psOrganContact.executeQuery();
		if (rs.next())
		{
			Segment seg = r.createSegment("E");
			seg.getField(1402).setString(rs.getString("OfficeAdd"));
			seg.getField(1403).setString(rs.getString("OfficeContact"));
			seg.getField(1404).setString(rs.getString("FinanceContact"));
			seg.getField(1405).setDate(rs.getString("updateDate"));
			seg.getField(1406).setString("");
		}
		rs.close();
	}

	private void fillSegmentD(Record r, String sessionId, String CIFCustomerId)
		throws ECRException, SQLException
	{
		if (psOrganStatus == null)
			psOrganStatus = prepareStatement(organStatusSql);
		psOrganStatus.setString(1, sessionId);
		psOrganStatus.setString(2, CIFCustomerId);
		ResultSet rs = psOrganStatus.executeQuery();
		if (rs.next())
		{
			Segment seg = r.createSegment("D");
			seg.getField(1302).setString(rs.getString("AccountStatus"));
			seg.getField(1303).setString(rs.getString("Scope"));
			seg.getField(1304).setString(rs.getString("OrgStatus"));
			seg.getField(1305).setDate(rs.getString("updateDate"));
			seg.getField(1306).setString("");
		}
		rs.close();
	}

	private void fillSegmentC(Record r, String sessionId, String CIFCustomerId)
		throws ECRException, SQLException
	{
		if (psOrganAttr == null)
			psOrganAttr = prepareStatement(organAttrSql);
		psOrganAttr.setString(1, sessionId);
		psOrganAttr.setString(2, CIFCustomerId);
		ResultSet rs = psOrganAttr.executeQuery();
		if (rs.next())
		{
			Segment seg = r.createSegment("C");
			seg.getField(1202).setString(rs.getString("ChineseName"));
			seg.getField(1203).setString(rs.getString("EnglishName"));
			seg.getField(1204).setString(rs.getString("RegisterAdd"));
			seg.getField(1205).setString(rs.getString("RegisterCountry"));
			seg.getField(1206).setString(rs.getString("RegisterAreaCode"));
			seg.getField(1207).setDate(rs.getString("RegisterDate"));
			seg.getField(1208).setDate(rs.getString("RegisterDueDate"));
			seg.getField(1209).setString(rs.getString("BusinessScope"));
			seg.getField(1210).setString(rs.getString("CapitalCurrency"));
			seg.getField(1211).setDouble(rs.getDouble("CapitalFund"));
			seg.getField(1212).setString(rs.getString("OrgType"));
			seg.getField(1213).setString(rs.getString("OrgTypeSub"));
			seg.getField(1214).setString(rs.getString("Industry"));
			seg.getField(1215).setString(rs.getString("OrgNature"));
			seg.getField(1216).setDate(rs.getString("updateDate"));
			seg.getField(1217).setString("");
		}
		rs.close();
	}

	public String getDataFilter()
	{
		return dataFilter;
	}

	public void setDataFilter(String dataFilter)
	{
		this.dataFilter = dataFilter;
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
			organAttrSql = null;
			organStatusSql = null;
			organContactSql = null;
			organKeeperSql = null;
			organStockHolderSql = null;
			organRelaSql = null;
			organSuperSql = null;
			return;
		}
		String s = recordSql.toUpperCase();
		String organAttrTable = null;
		String organStatusTable = null;
		String organContactTable = null;
		String organKeeperTable = null;
		String organStockTable = null;
		String organRelaTable = null;
		String organSuperTable = null;
		if (s.indexOf("ECR_ORGANINFO") > 0)
		{
			organAttrTable = "ECR_ORGANATTRIBUTE";
			organStatusTable = "ECR_ORGANSTATUS";
			organContactTable = "ECR_ORGANCONTACT";
			organKeeperTable = "ECR_ORGANKEEPER";
			organStockTable = "ECR_ORGANSTOCKHOLDER";
			organRelaTable = "ECR_ORGANRELATED";
			organSuperTable = "ECR_ORGANSUPERIOR";
		} else
		{
			organAttrTable = "HIS_ORGANATTRIBUTE";
			organStatusTable = "HIS_ORGANSTATUS";
			organContactTable = "HIS_ORGANCONTACT";
			organKeeperTable = "HIS_ORGANKEEPER";
			organStockTable = "HIS_ORGANSTOCKHOLDER";
			organRelaTable = "HIS_ORGANRELATED";
			organSuperTable = "HIS_ORGANSUPERIOR";
		}
		organAttrSql = (new StringBuilder("select * from ")).append(organAttrTable).append(" where SessionID=? and CIFCustomerId=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		organStatusSql = (new StringBuilder("select * from ")).append(organStatusTable).append(" where SessionID=? and CIFCustomerId=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		organContactSql = (new StringBuilder("select * from ")).append(organContactTable).append(" where SessionID=? and CIFCustomerId=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		organKeeperSql = (new StringBuilder("select * from ")).append(organKeeperTable).append(" where SessionID=? and CIFCustomerId=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		organStockHolderSql = (new StringBuilder("select * from ")).append(organStockTable).append(" where SessionID=? and CIFCustomerId=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		organRelaSql = (new StringBuilder("select * from ")).append(organRelaTable).append(" where SessionID=?  and CIFCustomerId=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		organSuperSql = (new StringBuilder("select * from ")).append(organSuperTable).append(" where SessionID=? and CIFCustomerId=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
	}
}
