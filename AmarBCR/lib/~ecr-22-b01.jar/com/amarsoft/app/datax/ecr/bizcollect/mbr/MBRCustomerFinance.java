// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRCustomerFinance.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MBRCustomerFinance extends DBMessageBodyReader
{

	private String financeBSSql;
	private String financeCFSql;
	private String financePSSql;
	private String financeBS2007Sql;
	private String financeCF2007Sql;
	private String financePS2007Sql;
	private String financeBSINSql;
	private String financeCFINSql;
	private ResultSet financeRS;

	public MBRCustomerFinance(Message message, String database)
	{
		super(message, database);
		financeBSSql = null;
		financeCFSql = null;
		financePSSql = null;
		financeBS2007Sql = null;
		financeCF2007Sql = null;
		financePS2007Sql = null;
		financeBSINSql = null;
		financeCFINSql = null;
		financeRS = null;
	}

	public MBRCustomerFinance(Message message)
	{
		super(message);
		financeBSSql = null;
		financeCFSql = null;
		financePSSql = null;
		financeBS2007Sql = null;
		financeCF2007Sql = null;
		financePS2007Sql = null;
		financeBSINSql = null;
		financeCFINSql = null;
		financeRS = null;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		int rt = r.getType();
		switch (rt)
		{
		case 3: // '\003'
			return fillFinanceBS(r);

		case 4: // '\004'
			return fillFinancePS(r);

		case 5: // '\005'
			return fillFinanceCF(r);

		case 43: // '+'
			return fillFinanceBSFor2007(r);

		case 44: // ','
			return fillFinancePSFor2007(r);

		case 45: // '-'
			return fillFinanceCFFor2007(r);

		case 46: // '.'
			return fillFinanceBSForIN(r);

		case 47: // '/'
			return fillFinancePSForIN(r);
		}
		return false;
	}

	private boolean fillFinanceBSForIN(Record r)
		throws ECRException
	{
		if (financeBSINSql == null)
			return false;
		if (financeRS == null)
			try
			{
				financeRS = executeQuery(financeBSINSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!financeRS.next())
			break MISSING_BLOCK_LABEL_1355;
		Segment segB = fillBaseSegment(r, financeRS);
		segB.getField(7503).setString(financeRS.getString("LoanCardNo"));
		segB.getField(5559).setString(financeRS.getString("CustomerName"));
		segB.getField(2591).setString(financeRS.getString("ReportYear"));
		segB.getField(7507).setString(financeRS.getString("ReportType"));
		segB.getField(7651).setString(financeRS.getString("ReportSubType"));
		segB.getField(5579).setString(financeRS.getString("AuditFirm"));
		segB.getField(5581).setString(financeRS.getString("Auditor"));
		segB.getField(2589).setDate(financeRS.getString("AuditDate"));
		segB.getField(9991).setString(financeRS.getString("CustomerID"));
		fillIDChangeSegment(r, financeRS);
		Segment segJ = r.createSegment("J");
		segJ.getField(9271).setDouble(financeRS.getDouble("M9271"));
		segJ.getField(9272).setDouble(financeRS.getDouble("M9272"));
		segJ.getField(9273).setDouble(financeRS.getDouble("M9273"));
		segJ.getField(9274).setDouble(financeRS.getDouble("M9274"));
		segJ.getField(9275).setDouble(financeRS.getDouble("M9275"));
		segJ.getField(9276).setDouble(financeRS.getDouble("M9276"));
		segJ.getField(9277).setDouble(financeRS.getDouble("M9277"));
		segJ.getField(9278).setDouble(financeRS.getDouble("M9278"));
		segJ.getField(9279).setDouble(financeRS.getDouble("M9279"));
		segJ.getField(9280).setDouble(financeRS.getDouble("M9280"));
		segJ.getField(9281).setDouble(financeRS.getDouble("M9281"));
		segJ.getField(9282).setDouble(financeRS.getDouble("M9282"));
		segJ.getField(9283).setDouble(financeRS.getDouble("M9283"));
		segJ.getField(9284).setDouble(financeRS.getDouble("M9284"));
		segJ.getField(9285).setDouble(financeRS.getDouble("M9285"));
		segJ.getField(9286).setDouble(financeRS.getDouble("M9286"));
		segJ.getField(9287).setDouble(financeRS.getDouble("M9287"));
		segJ.getField(9288).setDouble(financeRS.getDouble("M9288"));
		segJ.getField(9289).setDouble(financeRS.getDouble("M9289"));
		segJ.getField(9290).setDouble(financeRS.getDouble("M9290"));
		segJ.getField(9291).setDouble(financeRS.getDouble("M9291"));
		segJ.getField(9292).setDouble(financeRS.getDouble("M9292"));
		segJ.getField(9293).setDouble(financeRS.getDouble("M9293"));
		segJ.getField(9294).setDouble(financeRS.getDouble("M9294"));
		segJ.getField(9295).setDouble(financeRS.getDouble("M9295"));
		segJ.getField(9296).setDouble(financeRS.getDouble("M9296"));
		segJ.getField(9297).setDouble(financeRS.getDouble("M9297"));
		segJ.getField(9298).setDouble(financeRS.getDouble("M9298"));
		segJ.getField(9299).setDouble(financeRS.getDouble("M9299"));
		segJ.getField(9300).setDouble(financeRS.getDouble("M9300"));
		segJ.getField(9301).setDouble(financeRS.getDouble("M9301"));
		segJ.getField(9302).setDouble(financeRS.getDouble("M9302"));
		segJ.getField(9303).setDouble(financeRS.getDouble("M9303"));
		segJ.getField(9304).setDouble(financeRS.getDouble("M9304"));
		segJ.getField(9305).setDouble(financeRS.getDouble("M9305"));
		segJ.getField(9306).setDouble(financeRS.getDouble("M9306"));
		segJ.getField(9307).setDouble(financeRS.getDouble("M9307"));
		segJ.getField(9308).setDouble(financeRS.getDouble("M9308"));
		segJ.getField(9309).setDouble(financeRS.getDouble("M9309"));
		segJ.getField(9310).setDouble(financeRS.getDouble("M9310"));
		segJ.getField(9311).setDouble(financeRS.getDouble("M9311"));
		segJ.getField(9312).setDouble(financeRS.getDouble("M9312"));
		segJ.getField(9313).setDouble(financeRS.getDouble("M9313"));
		segJ.getField(9314).setDouble(financeRS.getDouble("M9314"));
		segJ.getField(9315).setDouble(financeRS.getDouble("M9315"));
		segJ.getField(9316).setDouble(financeRS.getDouble("M9316"));
		segJ.getField(9317).setDouble(financeRS.getDouble("M9317"));
		segJ.getField(9318).setDouble(financeRS.getDouble("M9318"));
		segJ.getField(9319).setDouble(financeRS.getDouble("M9319"));
		segJ.getField(9320).setDouble(financeRS.getDouble("M9320"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			financeRS.close();
			financeRS = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	private boolean fillFinancePSForIN(Record r)
		throws ECRException
	{
		if (financeCFINSql == null)
			return false;
		if (financeRS == null)
			try
			{
				financeRS = executeQuery(financeCFINSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!financeRS.next())
			break MISSING_BLOCK_LABEL_1135;
		Segment segB = fillBaseSegment(r, financeRS);
		segB.getField(7503).setString(financeRS.getString("LoanCardNo"));
		segB.getField(5559).setString(financeRS.getString("CustomerName"));
		segB.getField(2591).setString(financeRS.getString("ReportYear"));
		segB.getField(7507).setString(financeRS.getString("ReportType"));
		segB.getField(7651).setString(financeRS.getString("ReportSubType"));
		segB.getField(5579).setString(financeRS.getString("AuditFirm"));
		segB.getField(5581).setString(financeRS.getString("Auditor"));
		segB.getField(2589).setDate(financeRS.getString("AuditDate"));
		segB.getField(9991).setString(financeRS.getString("CustomerID"));
		fillIDChangeSegment(r, financeRS);
		Segment segK = r.createSegment("K");
		segK.getField(9330).setDouble(financeRS.getDouble("M9330"));
		segK.getField(9331).setDouble(financeRS.getDouble("M9331"));
		segK.getField(9332).setDouble(financeRS.getDouble("M9332"));
		segK.getField(9333).setDouble(financeRS.getDouble("M9333"));
		segK.getField(9334).setDouble(financeRS.getDouble("M9334"));
		segK.getField(9335).setDouble(financeRS.getDouble("M9335"));
		segK.getField(9336).setDouble(financeRS.getDouble("M9336"));
		segK.getField(9337).setDouble(financeRS.getDouble("M9337"));
		segK.getField(9338).setDouble(financeRS.getDouble("M9338"));
		segK.getField(9339).setDouble(financeRS.getDouble("M9339"));
		segK.getField(9340).setDouble(financeRS.getDouble("M9340"));
		segK.getField(9341).setDouble(financeRS.getDouble("M9341"));
		segK.getField(9342).setDouble(financeRS.getDouble("M9342"));
		segK.getField(9343).setDouble(financeRS.getDouble("M9343"));
		segK.getField(9344).setDouble(financeRS.getDouble("M9344"));
		segK.getField(9345).setDouble(financeRS.getDouble("M9345"));
		segK.getField(9346).setDouble(financeRS.getDouble("M9346"));
		segK.getField(9347).setDouble(financeRS.getDouble("M9347"));
		segK.getField(9348).setDouble(financeRS.getDouble("M9348"));
		segK.getField(9349).setDouble(financeRS.getDouble("M9349"));
		segK.getField(9350).setDouble(financeRS.getDouble("M9350"));
		segK.getField(9351).setDouble(financeRS.getDouble("M9351"));
		segK.getField(9352).setDouble(financeRS.getDouble("M9352"));
		segK.getField(9353).setDouble(financeRS.getDouble("M9353"));
		segK.getField(9354).setDouble(financeRS.getDouble("M9354"));
		segK.getField(9355).setDouble(financeRS.getDouble("M9355"));
		segK.getField(9356).setDouble(financeRS.getDouble("M9356"));
		segK.getField(9357).setDouble(financeRS.getDouble("M9357"));
		segK.getField(9358).setDouble(financeRS.getDouble("M9358"));
		segK.getField(9359).setDouble(financeRS.getDouble("M9359"));
		segK.getField(9360).setDouble(financeRS.getDouble("M9360"));
		segK.getField(9361).setDouble(financeRS.getDouble("M9361"));
		segK.getField(9362).setDouble(financeRS.getDouble("M9362"));
		segK.getField(9363).setDouble(financeRS.getDouble("M9363"));
		segK.getField(9364).setDouble(financeRS.getDouble("M9364"));
		segK.getField(9365).setDouble(financeRS.getDouble("M9365"));
		segK.getField(9366).setDouble(financeRS.getDouble("M9366"));
		segK.getField(9367).setDouble(financeRS.getDouble("M9367"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			financeRS.close();
			financeRS = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	private boolean fillFinanceBSFor2007(Record r)
		throws ECRException
	{
		if (financeBS2007Sql == null)
			return false;
		if (financeRS == null)
			try
			{
				financeRS = executeQuery(financeBS2007Sql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!financeRS.next())
			break MISSING_BLOCK_LABEL_1619;
		Segment segB = fillBaseSegment(r, financeRS);
		segB.getField(7503).setString(financeRS.getString("LoanCardNo"));
		segB.getField(5559).setString(financeRS.getString("CustomerName"));
		segB.getField(2591).setString(financeRS.getString("ReportYear"));
		segB.getField(7507).setString(financeRS.getString("ReportType"));
		segB.getField(7651).setString(financeRS.getString("ReportSubType"));
		segB.getField(5579).setString(financeRS.getString("AuditFirm"));
		segB.getField(5581).setString(financeRS.getString("Auditor"));
		segB.getField(2589).setDate(financeRS.getString("AuditDate"));
		segB.getField(9991).setString(financeRS.getString("CustomerID"));
		fillIDChangeSegment(r, financeRS);
		Segment segG = r.createSegment("G");
		segG.getField(9100).setDouble(financeRS.getDouble("M9100"));
		segG.getField(9101).setDouble(financeRS.getDouble("M9101"));
		segG.getField(9102).setDouble(financeRS.getDouble("M9102"));
		segG.getField(9103).setDouble(financeRS.getDouble("M9103"));
		segG.getField(9104).setDouble(financeRS.getDouble("M9104"));
		segG.getField(9105).setDouble(financeRS.getDouble("M9105"));
		segG.getField(9106).setDouble(financeRS.getDouble("M9106"));
		segG.getField(9107).setDouble(financeRS.getDouble("M9107"));
		segG.getField(9108).setDouble(financeRS.getDouble("M9108"));
		segG.getField(9109).setDouble(financeRS.getDouble("M9109"));
		segG.getField(9110).setDouble(financeRS.getDouble("M9110"));
		segG.getField(9111).setDouble(financeRS.getDouble("M9111"));
		segG.getField(9112).setDouble(financeRS.getDouble("M9112"));
		segG.getField(9113).setDouble(financeRS.getDouble("M9113"));
		segG.getField(9114).setDouble(financeRS.getDouble("M9114"));
		segG.getField(9115).setDouble(financeRS.getDouble("M9115"));
		segG.getField(9116).setDouble(financeRS.getDouble("M9116"));
		segG.getField(9117).setDouble(financeRS.getDouble("M9117"));
		segG.getField(9118).setDouble(financeRS.getDouble("M9118"));
		segG.getField(9119).setDouble(financeRS.getDouble("M9119"));
		segG.getField(9120).setDouble(financeRS.getDouble("M9120"));
		segG.getField(9121).setDouble(financeRS.getDouble("M9121"));
		segG.getField(9122).setDouble(financeRS.getDouble("M9122"));
		segG.getField(9123).setDouble(financeRS.getDouble("M9123"));
		segG.getField(9124).setDouble(financeRS.getDouble("M9124"));
		segG.getField(9125).setDouble(financeRS.getDouble("M9125"));
		segG.getField(9126).setDouble(financeRS.getDouble("M9126"));
		segG.getField(9127).setDouble(financeRS.getDouble("M9127"));
		segG.getField(9128).setDouble(financeRS.getDouble("M9128"));
		segG.getField(9129).setDouble(financeRS.getDouble("M9129"));
		segG.getField(9130).setDouble(financeRS.getDouble("M9130"));
		segG.getField(9131).setDouble(financeRS.getDouble("M9131"));
		segG.getField(9132).setDouble(financeRS.getDouble("M9132"));
		segG.getField(9133).setDouble(financeRS.getDouble("M9133"));
		segG.getField(9134).setDouble(financeRS.getDouble("M9134"));
		segG.getField(9135).setDouble(financeRS.getDouble("M9135"));
		segG.getField(9136).setDouble(financeRS.getDouble("M9136"));
		segG.getField(9137).setDouble(financeRS.getDouble("M9137"));
		segG.getField(9138).setDouble(financeRS.getDouble("M9138"));
		segG.getField(9139).setDouble(financeRS.getDouble("M9139"));
		segG.getField(9140).setDouble(financeRS.getDouble("M9140"));
		segG.getField(9141).setDouble(financeRS.getDouble("M9141"));
		segG.getField(9142).setDouble(financeRS.getDouble("M9142"));
		segG.getField(9143).setDouble(financeRS.getDouble("M9143"));
		segG.getField(9144).setDouble(financeRS.getDouble("M9144"));
		segG.getField(9145).setDouble(financeRS.getDouble("M9145"));
		segG.getField(9146).setDouble(financeRS.getDouble("M9146"));
		segG.getField(9147).setDouble(financeRS.getDouble("M9147"));
		segG.getField(9148).setDouble(financeRS.getDouble("M9148"));
		segG.getField(9149).setDouble(financeRS.getDouble("M9149"));
		segG.getField(9150).setDouble(financeRS.getDouble("M9150"));
		segG.getField(9151).setDouble(financeRS.getDouble("M9151"));
		segG.getField(9152).setDouble(financeRS.getDouble("M9152"));
		segG.getField(9153).setDouble(financeRS.getDouble("M9153"));
		segG.getField(9154).setDouble(financeRS.getDouble("M9154"));
		segG.getField(9155).setDouble(financeRS.getDouble("M9155"));
		segG.getField(9156).setDouble(financeRS.getDouble("M9156"));
		segG.getField(9157).setDouble(financeRS.getDouble("M9157"));
		segG.getField(9158).setDouble(financeRS.getDouble("M9158"));
		segG.getField(9159).setDouble(financeRS.getDouble("M9159"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			financeRS.close();
			financeRS = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	private boolean fillFinancePSFor2007(Record r)
		throws ECRException
	{
		if (financePS2007Sql == null)
			return false;
		if (financeRS == null)
			try
			{
				financeRS = executeQuery(financePS2007Sql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!financeRS.next())
			break MISSING_BLOCK_LABEL_717;
		Segment segB = fillBaseSegment(r, financeRS);
		segB.getField(7503).setString(financeRS.getString("LoanCardNo"));
		segB.getField(5559).setString(financeRS.getString("CustomerName"));
		segB.getField(2591).setString(financeRS.getString("ReportYear"));
		segB.getField(7507).setString(financeRS.getString("ReportType"));
		segB.getField(7651).setString(financeRS.getString("ReportSubType"));
		segB.getField(5579).setString(financeRS.getString("AuditFirm"));
		segB.getField(5581).setString(financeRS.getString("Auditor"));
		segB.getField(2589).setDate(financeRS.getString("AuditDate"));
		segB.getField(9991).setString(financeRS.getString("CustomerID"));
		fillIDChangeSegment(r, financeRS);
		Segment segH = r.createSegment("H");
		segH.getField(9170).setDouble(financeRS.getDouble("M9170"));
		segH.getField(9171).setDouble(financeRS.getDouble("M9171"));
		segH.getField(9172).setDouble(financeRS.getDouble("M9172"));
		segH.getField(9173).setDouble(financeRS.getDouble("M9173"));
		segH.getField(9174).setDouble(financeRS.getDouble("M9174"));
		segH.getField(9175).setDouble(financeRS.getDouble("M9175"));
		segH.getField(9176).setDouble(financeRS.getDouble("M9176"));
		segH.getField(9177).setDouble(financeRS.getDouble("M9177"));
		segH.getField(9178).setDouble(financeRS.getDouble("M9178"));
		segH.getField(9179).setDouble(financeRS.getDouble("M9179"));
		segH.getField(9180).setDouble(financeRS.getDouble("M9180"));
		segH.getField(9181).setDouble(financeRS.getDouble("M9181"));
		segH.getField(9182).setDouble(financeRS.getDouble("M9182"));
		segH.getField(9183).setDouble(financeRS.getDouble("M9183"));
		segH.getField(9184).setDouble(financeRS.getDouble("M9184"));
		segH.getField(9185).setDouble(financeRS.getDouble("M9185"));
		segH.getField(9186).setDouble(financeRS.getDouble("M9186"));
		segH.getField(9187).setDouble(financeRS.getDouble("M9187"));
		segH.getField(9188).setDouble(financeRS.getDouble("M9188"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			financeRS.close();
			financeRS = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	private boolean fillFinanceCFFor2007(Record r)
		throws ECRException
	{
		if (financeCF2007Sql == null)
			return false;
		if (financeRS == null)
			try
			{
				financeRS = executeQuery(financeCF2007Sql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!financeRS.next())
			break MISSING_BLOCK_LABEL_1685;
		Segment segB = fillBaseSegment(r, financeRS);
		segB.getField(7503).setString(financeRS.getString("LoanCardNo"));
		segB.getField(5559).setString(financeRS.getString("CustomerName"));
		segB.getField(2591).setString(financeRS.getString("ReportYear"));
		segB.getField(7507).setString(financeRS.getString("ReportType"));
		segB.getField(7651).setString(financeRS.getString("ReportSubType"));
		segB.getField(5579).setString(financeRS.getString("AuditFirm"));
		segB.getField(5581).setString(financeRS.getString("Auditor"));
		segB.getField(2589).setDate(financeRS.getString("AuditDate"));
		segB.getField(9991).setString(financeRS.getString("CustomerID"));
		fillIDChangeSegment(r, financeRS);
		Segment segI = r.createSegment("I");
		segI.getField(9199).setDouble(financeRS.getDouble("M9199"));
		segI.getField(9200).setDouble(financeRS.getDouble("M9200"));
		segI.getField(9201).setDouble(financeRS.getDouble("M9201"));
		segI.getField(9202).setDouble(financeRS.getDouble("M9202"));
		segI.getField(9203).setDouble(financeRS.getDouble("M9203"));
		segI.getField(9204).setDouble(financeRS.getDouble("M9204"));
		segI.getField(9205).setDouble(financeRS.getDouble("M9205"));
		segI.getField(9206).setDouble(financeRS.getDouble("M9206"));
		segI.getField(9207).setDouble(financeRS.getDouble("M9207"));
		segI.getField(9208).setDouble(financeRS.getDouble("M9208"));
		segI.getField(9209).setDouble(financeRS.getDouble("M9209"));
		segI.getField(9210).setDouble(financeRS.getDouble("M9210"));
		segI.getField(9211).setDouble(financeRS.getDouble("M9211"));
		segI.getField(9212).setDouble(financeRS.getDouble("M9212"));
		segI.getField(9213).setDouble(financeRS.getDouble("M9213"));
		segI.getField(9214).setDouble(financeRS.getDouble("M9214"));
		segI.getField(9215).setDouble(financeRS.getDouble("M9215"));
		segI.getField(9216).setDouble(financeRS.getDouble("M9216"));
		segI.getField(9217).setDouble(financeRS.getDouble("M9217"));
		segI.getField(9218).setDouble(financeRS.getDouble("M9218"));
		segI.getField(9219).setDouble(financeRS.getDouble("M9219"));
		segI.getField(9220).setDouble(financeRS.getDouble("M9220"));
		segI.getField(9221).setDouble(financeRS.getDouble("M9221"));
		segI.getField(9222).setDouble(financeRS.getDouble("M9222"));
		segI.getField(9223).setDouble(financeRS.getDouble("M9223"));
		segI.getField(9224).setDouble(financeRS.getDouble("M9224"));
		segI.getField(9225).setDouble(financeRS.getDouble("M9225"));
		segI.getField(9226).setDouble(financeRS.getDouble("M9226"));
		segI.getField(9227).setDouble(financeRS.getDouble("M9227"));
		segI.getField(9228).setDouble(financeRS.getDouble("M9228"));
		segI.getField(9229).setDouble(financeRS.getDouble("M9229"));
		segI.getField(9230).setDouble(financeRS.getDouble("M9230"));
		segI.getField(9231).setDouble(financeRS.getDouble("M9231"));
		segI.getField(9232).setDouble(financeRS.getDouble("M9232"));
		segI.getField(9233).setDouble(financeRS.getDouble("M9233"));
		segI.getField(9234).setDouble(financeRS.getDouble("M9234"));
		segI.getField(9235).setDouble(financeRS.getDouble("M9235"));
		segI.getField(9236).setDouble(financeRS.getDouble("M9236"));
		segI.getField(9237).setDouble(financeRS.getDouble("M9237"));
		segI.getField(9238).setDouble(financeRS.getDouble("M9238"));
		segI.getField(9239).setDouble(financeRS.getDouble("M9239"));
		segI.getField(9240).setDouble(financeRS.getDouble("M9240"));
		segI.getField(9241).setDouble(financeRS.getDouble("M9241"));
		segI.getField(9242).setDouble(financeRS.getDouble("M9242"));
		segI.getField(9243).setDouble(financeRS.getDouble("M9243"));
		segI.getField(9244).setDouble(financeRS.getDouble("M9244"));
		segI.getField(9245).setDouble(financeRS.getDouble("M9245"));
		segI.getField(9246).setDouble(financeRS.getDouble("M9246"));
		segI.getField(9247).setDouble(financeRS.getDouble("M9247"));
		segI.getField(9248).setDouble(financeRS.getDouble("M9248"));
		segI.getField(9249).setDouble(financeRS.getDouble("M9249"));
		segI.getField(9250).setDouble(financeRS.getDouble("M9250"));
		segI.getField(9251).setDouble(financeRS.getDouble("M9251"));
		segI.getField(9252).setDouble(financeRS.getDouble("M9252"));
		segI.getField(9253).setDouble(financeRS.getDouble("M9253"));
		segI.getField(9254).setDouble(financeRS.getDouble("M9254"));
		segI.getField(9255).setDouble(financeRS.getDouble("M9255"));
		segI.getField(9256).setDouble(financeRS.getDouble("M9256"));
		segI.getField(9257).setDouble(financeRS.getDouble("M9257"));
		segI.getField(9258).setDouble(financeRS.getDouble("M9258"));
		segI.getField(9259).setDouble(financeRS.getDouble("M9259"));
		segI.getField(9260).setDouble(financeRS.getDouble("M9260"));
		segI.getField(9261).setDouble(financeRS.getDouble("M9261"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			financeRS.close();
			financeRS = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	private boolean fillFinanceBS(Record r)
		throws ECRException
	{
		if (financeBSSql == null)
			return false;
		if (financeRS == null)
			try
			{
				financeRS = executeQuery(financeBSSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!financeRS.next())
			break MISSING_BLOCK_LABEL_2213;
		Segment segB = fillBaseSegment(r, financeRS);
		segB.getField(7503).setString(financeRS.getString("LoanCardNo"));
		segB.getField(5559).setString(financeRS.getString("CustomerName"));
		segB.getField(2591).setString(financeRS.getString("ReportYear"));
		segB.getField(7507).setString(financeRS.getString("ReportType"));
		segB.getField(7651).setString(financeRS.getString("ReportSubType"));
		segB.getField(5579).setString(financeRS.getString("AuditFirm"));
		segB.getField(5581).setString(financeRS.getString("Auditor"));
		segB.getField(2589).setDate(financeRS.getString("AuditDate"));
		segB.getField(9991).setString(financeRS.getString("CustomerID"));
		fillIDChangeSegment(r, financeRS);
		Segment segD = r.createSegment("D");
		segD.getField(9501).setDouble(financeRS.getDouble("M9501"));
		segD.getField(9503).setDouble(financeRS.getDouble("M9503"));
		segD.getField(9505).setDouble(financeRS.getDouble("M9505"));
		segD.getField(9507).setDouble(financeRS.getDouble("M9507"));
		segD.getField(9509).setDouble(financeRS.getDouble("M9509"));
		segD.getField(9511).setDouble(financeRS.getDouble("M9511"));
		segD.getField(9513).setDouble(financeRS.getDouble("M9513"));
		segD.getField(9515).setDouble(financeRS.getDouble("M9515"));
		segD.getField(9517).setDouble(financeRS.getDouble("M9517"));
		segD.getField(9519).setDouble(financeRS.getDouble("M9519"));
		segD.getField(9521).setDouble(financeRS.getDouble("M9521"));
		segD.getField(9523).setDouble(financeRS.getDouble("M9523"));
		segD.getField(9525).setDouble(financeRS.getDouble("M9525"));
		segD.getField(9527).setDouble(financeRS.getDouble("M9527"));
		segD.getField(9529).setDouble(financeRS.getDouble("M9529"));
		segD.getField(9531).setDouble(financeRS.getDouble("M9531"));
		segD.getField(9533).setDouble(financeRS.getDouble("M9533"));
		segD.getField(9535).setDouble(financeRS.getDouble("M9535"));
		segD.getField(9537).setDouble(financeRS.getDouble("M9537"));
		segD.getField(9539).setDouble(financeRS.getDouble("M9539"));
		segD.getField(9541).setDouble(financeRS.getDouble("M9541"));
		segD.getField(9543).setDouble(financeRS.getDouble("M9543"));
		segD.getField(9545).setDouble(financeRS.getDouble("M9545"));
		segD.getField(9547).setDouble(financeRS.getDouble("M9547"));
		segD.getField(9549).setDouble(financeRS.getDouble("M9549"));
		segD.getField(9551).setDouble(financeRS.getDouble("M9551"));
		segD.getField(9553).setDouble(financeRS.getDouble("M9553"));
		segD.getField(9555).setDouble(financeRS.getDouble("M9555"));
		segD.getField(9557).setDouble(financeRS.getDouble("M9557"));
		segD.getField(9559).setDouble(financeRS.getDouble("M9559"));
		segD.getField(9561).setDouble(financeRS.getDouble("M9561"));
		segD.getField(9563).setDouble(financeRS.getDouble("M9563"));
		segD.getField(9565).setDouble(financeRS.getDouble("M9565"));
		segD.getField(9567).setDouble(financeRS.getDouble("M9567"));
		segD.getField(9569).setDouble(financeRS.getDouble("M9569"));
		segD.getField(9571).setDouble(financeRS.getDouble("M9571"));
		segD.getField(9573).setDouble(financeRS.getDouble("M9573"));
		segD.getField(9575).setDouble(financeRS.getDouble("M9575"));
		segD.getField(9577).setDouble(financeRS.getDouble("M9577"));
		segD.getField(9579).setDouble(financeRS.getDouble("M9579"));
		segD.getField(9581).setDouble(financeRS.getDouble("M9581"));
		segD.getField(9583).setDouble(financeRS.getDouble("M9583"));
		segD.getField(9585).setDouble(financeRS.getDouble("M9585"));
		segD.getField(9587).setDouble(financeRS.getDouble("M9587"));
		segD.getField(9589).setDouble(financeRS.getDouble("M9589"));
		segD.getField(9591).setDouble(financeRS.getDouble("M9591"));
		segD.getField(9593).setDouble(financeRS.getDouble("M9593"));
		segD.getField(9595).setDouble(financeRS.getDouble("M9595"));
		segD.getField(9597).setDouble(financeRS.getDouble("M9597"));
		segD.getField(9599).setDouble(financeRS.getDouble("M9599"));
		segD.getField(9601).setDouble(financeRS.getDouble("M9601"));
		segD.getField(9603).setDouble(financeRS.getDouble("M9603"));
		segD.getField(9605).setDouble(financeRS.getDouble("M9605"));
		segD.getField(9607).setDouble(financeRS.getDouble("M9607"));
		segD.getField(9609).setDouble(financeRS.getDouble("M9609"));
		segD.getField(9611).setDouble(financeRS.getDouble("M9611"));
		segD.getField(9613).setDouble(financeRS.getDouble("M9613"));
		segD.getField(9615).setDouble(financeRS.getDouble("M9615"));
		segD.getField(9617).setDouble(financeRS.getDouble("M9617"));
		segD.getField(9619).setDouble(financeRS.getDouble("M9619"));
		segD.getField(9621).setDouble(financeRS.getDouble("M9621"));
		segD.getField(9623).setDouble(financeRS.getDouble("M9623"));
		segD.getField(9625).setDouble(financeRS.getDouble("M9625"));
		segD.getField(9627).setDouble(financeRS.getDouble("M9627"));
		segD.getField(9629).setDouble(financeRS.getDouble("M9629"));
		segD.getField(9631).setDouble(financeRS.getDouble("M9631"));
		segD.getField(9633).setDouble(financeRS.getDouble("M9633"));
		segD.getField(9635).setDouble(financeRS.getDouble("M9635"));
		segD.getField(9637).setDouble(financeRS.getDouble("M9637"));
		segD.getField(9639).setDouble(financeRS.getDouble("M9639"));
		segD.getField(9641).setDouble(financeRS.getDouble("M9641"));
		segD.getField(9643).setDouble(financeRS.getDouble("M9643"));
		segD.getField(9645).setDouble(financeRS.getDouble("M9645"));
		segD.getField(9647).setDouble(financeRS.getDouble("M9647"));
		segD.getField(9649).setDouble(financeRS.getDouble("M9649"));
		segD.getField(9651).setDouble(financeRS.getDouble("M9651"));
		segD.getField(9653).setDouble(financeRS.getDouble("M9653"));
		segD.getField(9655).setDouble(financeRS.getDouble("M9655"));
		segD.getField(9657).setDouble(financeRS.getDouble("M9657"));
		segD.getField(9659).setDouble(financeRS.getDouble("M9659"));
		segD.getField(9661).setDouble(financeRS.getDouble("M9661"));
		segD.getField(9663).setDouble(financeRS.getDouble("M9663"));
		segD.getField(9665).setDouble(financeRS.getDouble("M9665"));
		segD.getField(9667).setDouble(financeRS.getDouble("M9667"));
		segD.getField(9669).setDouble(financeRS.getDouble("M9669"));
		segD.getField(9671).setDouble(financeRS.getDouble("M9671"));
		segD.getField(9673).setDouble(financeRS.getDouble("M9673"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			financeRS.close();
			financeRS = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	private boolean fillFinancePS(Record r)
		throws ECRException
	{
		if (financePSSql == null)
			return false;
		if (financeRS == null)
			try
			{
				financeRS = executeQuery(financePSSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!financeRS.next())
			break MISSING_BLOCK_LABEL_1707;
		Segment segB = fillBaseSegment(r, financeRS);
		segB.getField(7503).setString(financeRS.getString("LoanCardNo"));
		segB.getField(5559).setString(financeRS.getString("CustomerName"));
		segB.getField(2591).setString(financeRS.getString("ReportYear"));
		segB.getField(7507).setString(financeRS.getString("ReportType"));
		segB.getField(7651).setString(financeRS.getString("ReportSubType"));
		segB.getField(5579).setString(financeRS.getString("AuditFirm"));
		segB.getField(5581).setString(financeRS.getString("Auditor"));
		segB.getField(2589).setDate(financeRS.getString("AuditDate"));
		segB.getField(9991).setString(financeRS.getString("CustomerID"));
		fillIDChangeSegment(r, financeRS);
		Segment segD = r.createSegment("E");
		segD.getField(9675).setDouble(financeRS.getDouble("M9675"));
		segD.getField(9677).setDouble(financeRS.getDouble("M9677"));
		segD.getField(9679).setDouble(financeRS.getDouble("M9679"));
		segD.getField(9681).setDouble(financeRS.getDouble("M9681"));
		segD.getField(9683).setDouble(financeRS.getDouble("M9683"));
		segD.getField(9685).setDouble(financeRS.getDouble("M9685"));
		segD.getField(9687).setDouble(financeRS.getDouble("M9687"));
		segD.getField(9689).setDouble(financeRS.getDouble("M9689"));
		segD.getField(9691).setDouble(financeRS.getDouble("M9691"));
		segD.getField(9693).setDouble(financeRS.getDouble("M9693"));
		segD.getField(9695).setDouble(financeRS.getDouble("M9695"));
		segD.getField(9697).setDouble(financeRS.getDouble("M9697"));
		segD.getField(9699).setDouble(financeRS.getDouble("M9699"));
		segD.getField(9701).setDouble(financeRS.getDouble("M9701"));
		segD.getField(9703).setDouble(financeRS.getDouble("M9703"));
		segD.getField(9705).setDouble(financeRS.getDouble("M9705"));
		segD.getField(9707).setDouble(financeRS.getDouble("M9707"));
		segD.getField(9709).setDouble(financeRS.getDouble("M9709"));
		segD.getField(9907).setDouble(financeRS.getDouble("M9907"));
		segD.getField(9711).setDouble(financeRS.getDouble("M9711"));
		segD.getField(9713).setDouble(financeRS.getDouble("M9713"));
		segD.getField(9715).setDouble(financeRS.getDouble("M9715"));
		segD.getField(9717).setDouble(financeRS.getDouble("M9717"));
		segD.getField(9719).setDouble(financeRS.getDouble("M9719"));
		segD.getField(9721).setDouble(financeRS.getDouble("M9721"));
		segD.getField(9723).setDouble(financeRS.getDouble("M9723"));
		segD.getField(9725).setDouble(financeRS.getDouble("M9725"));
		segD.getField(9727).setDouble(financeRS.getDouble("M9727"));
		segD.getField(9729).setDouble(financeRS.getDouble("M9729"));
		segD.getField(9909).setDouble(financeRS.getDouble("M9909"));
		segD.getField(9731).setDouble(financeRS.getDouble("M9731"));
		segD.getField(9733).setDouble(financeRS.getDouble("M9733"));
		segD.getField(9735).setDouble(financeRS.getDouble("M9735"));
		segD.getField(9737).setDouble(financeRS.getDouble("M9737"));
		segD.getField(9739).setDouble(financeRS.getDouble("M9739"));
		segD.getField(9741).setDouble(financeRS.getDouble("M9741"));
		segD.getField(9743).setDouble(financeRS.getDouble("M9743"));
		segD.getField(9745).setDouble(financeRS.getDouble("M9745"));
		segD.getField(9747).setDouble(financeRS.getDouble("M9747"));
		segD.getField(9749).setDouble(financeRS.getDouble("M9749"));
		segD.getField(9751).setDouble(financeRS.getDouble("M9751"));
		segD.getField(9753).setDouble(financeRS.getDouble("M9753"));
		segD.getField(9755).setDouble(financeRS.getDouble("M9755"));
		segD.getField(9757).setDouble(financeRS.getDouble("M9757"));
		segD.getField(9759).setDouble(financeRS.getDouble("M9759"));
		segD.getField(9761).setDouble(financeRS.getDouble("M9761"));
		segD.getField(9763).setDouble(financeRS.getDouble("M9763"));
		segD.getField(9765).setDouble(financeRS.getDouble("M9765"));
		segD.getField(9767).setDouble(financeRS.getDouble("M9767"));
		segD.getField(9769).setDouble(financeRS.getDouble("M9769"));
		segD.getField(9771).setDouble(financeRS.getDouble("M9771"));
		segD.getField(9773).setDouble(financeRS.getDouble("M9773"));
		segD.getField(9775).setDouble(financeRS.getDouble("M9775"));
		segD.getField(9777).setDouble(financeRS.getDouble("M9777"));
		segD.getField(9779).setDouble(financeRS.getDouble("M9779"));
		segD.getField(9911).setDouble(financeRS.getDouble("M9911"));
		segD.getField(9781).setDouble(financeRS.getDouble("M9781"));
		segD.getField(9783).setDouble(financeRS.getDouble("M9783"));
		segD.getField(9785).setDouble(financeRS.getDouble("M9785"));
		segD.getField(9787).setDouble(financeRS.getDouble("M9787"));
		segD.getField(9789).setDouble(financeRS.getDouble("M9789"));
		segD.getField(9913).setDouble(financeRS.getDouble("M9913"));
		segD.getField(9791).setDouble(financeRS.getDouble("M9791"));
		segD.getField(9793).setDouble(financeRS.getDouble("M9793"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			financeRS.close();
			financeRS = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	private boolean fillFinanceCF(Record r)
		throws ECRException
	{
		if (financeCFSql == null)
			return false;
		if (financeRS == null)
			try
			{
				financeRS = executeQuery(financeCFSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!financeRS.next())
			break MISSING_BLOCK_LABEL_1553;
		Segment segB = fillBaseSegment(r, financeRS);
		segB.getField(7503).setString(financeRS.getString("LoanCardNo"));
		segB.getField(5559).setString(financeRS.getString("CustomerName"));
		segB.getField(2591).setString(financeRS.getString("ReportYear"));
		segB.getField(7507).setString(financeRS.getString("ReportType"));
		segB.getField(7651).setString(financeRS.getString("ReportSubType"));
		segB.getField(5579).setString(financeRS.getString("AuditFirm"));
		segB.getField(5581).setString(financeRS.getString("Auditor"));
		segB.getField(2589).setDate(financeRS.getString("AuditDate"));
		segB.getField(9991).setString(financeRS.getString("CustomerID"));
		fillIDChangeSegment(r, financeRS);
		Segment segD = r.createSegment("F");
		segD.getField(9795).setDouble(financeRS.getDouble("M9795"));
		segD.getField(9797).setDouble(financeRS.getDouble("M9797"));
		segD.getField(9799).setDouble(financeRS.getDouble("M9799"));
		segD.getField(9823).setDouble(financeRS.getDouble("M9823"));
		segD.getField(9803).setDouble(financeRS.getDouble("M9803"));
		segD.getField(9805).setDouble(financeRS.getDouble("M9805"));
		segD.getField(9807).setDouble(financeRS.getDouble("M9807"));
		segD.getField(9809).setDouble(financeRS.getDouble("M9809"));
		segD.getField(9831).setDouble(financeRS.getDouble("M9831"));
		segD.getField(9813).setDouble(financeRS.getDouble("M9813"));
		segD.getField(9815).setDouble(financeRS.getDouble("M9815"));
		segD.getField(9817).setDouble(financeRS.getDouble("M9817"));
		segD.getField(9819).setDouble(financeRS.getDouble("M9819"));
		segD.getField(9821).setDouble(financeRS.getDouble("M9821"));
		segD.getField(9917).setDouble(financeRS.getDouble("M9917"));
		segD.getField(9825).setDouble(financeRS.getDouble("M9825"));
		segD.getField(9827).setDouble(financeRS.getDouble("M9827"));
		segD.getField(9829).setDouble(financeRS.getDouble("M9829"));
		segD.getField(9919).setDouble(financeRS.getDouble("M9919"));
		segD.getField(9833).setDouble(financeRS.getDouble("M9833"));
		segD.getField(9835).setDouble(financeRS.getDouble("M9835"));
		segD.getField(9837).setDouble(financeRS.getDouble("M9837"));
		segD.getField(9839).setDouble(financeRS.getDouble("M9839"));
		segD.getField(9921).setDouble(financeRS.getDouble("M9921"));
		segD.getField(9843).setDouble(financeRS.getDouble("M9843"));
		segD.getField(9845).setDouble(financeRS.getDouble("M9845"));
		segD.getField(9847).setDouble(financeRS.getDouble("M9847"));
		segD.getField(9923).setDouble(financeRS.getDouble("M9923"));
		segD.getField(9851).setDouble(financeRS.getDouble("M9851"));
		segD.getField(9853).setDouble(financeRS.getDouble("M9853"));
		segD.getField(9855).setDouble(financeRS.getDouble("M9855"));
		segD.getField(9857).setDouble(financeRS.getDouble("M9857"));
		segD.getField(9859).setDouble(financeRS.getDouble("M9859"));
		segD.getField(9861).setDouble(financeRS.getDouble("M9861"));
		segD.getField(9863).setDouble(financeRS.getDouble("M9863"));
		segD.getField(9865).setDouble(financeRS.getDouble("M9865"));
		segD.getField(9867).setDouble(financeRS.getDouble("M9867"));
		segD.getField(9869).setDouble(financeRS.getDouble("M9869"));
		segD.getField(9871).setDouble(financeRS.getDouble("M9871"));
		segD.getField(9873).setDouble(financeRS.getDouble("M9873"));
		segD.getField(9925).setDouble(financeRS.getDouble("M9925"));
		segD.getField(9877).setDouble(financeRS.getDouble("M9877"));
		segD.getField(9879).setDouble(financeRS.getDouble("M9879"));
		segD.getField(9881).setDouble(financeRS.getDouble("M9881"));
		segD.getField(9883).setDouble(financeRS.getDouble("M9883"));
		segD.getField(9885).setDouble(financeRS.getDouble("M9885"));
		segD.getField(9915).setDouble(financeRS.getDouble("M9915"));
		segD.getField(1813).setDouble(financeRS.getDouble("M1813"));
		segD.getField(9891).setDouble(financeRS.getDouble("M9891"));
		segD.getField(9893).setDouble(financeRS.getDouble("M9893"));
		segD.getField(9895).setDouble(financeRS.getDouble("M9895"));
		segD.getField(9897).setDouble(financeRS.getDouble("M9897"));
		segD.getField(9899).setDouble(financeRS.getDouble("M9899"));
		segD.getField(9901).setDouble(financeRS.getDouble("M9901"));
		segD.getField(9903).setDouble(financeRS.getDouble("M9903"));
		segD.getField(9905).setDouble(financeRS.getDouble("M9905"));
		segD.getField(1855).setDouble(financeRS.getDouble("M1855"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		return true;
		try
		{
			financeRS.close();
			financeRS = null;
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException(e);
		}
		return false;
	}

	public final String getFinanceBSSql()
	{
		return financeBSSql;
	}

	public final void setFinanceBSSql(String financeBSSql)
	{
		this.financeBSSql = financeBSSql;
	}

	public final String getFinanceCFSql()
	{
		return financeCFSql;
	}

	public final void setFinanceCFSql(String financeCFSql)
	{
		this.financeCFSql = financeCFSql;
	}

	public final String getFinancePSSql()
	{
		return financePSSql;
	}

	public final void setFinancePSSql(String financePSSql)
	{
		this.financePSSql = financePSSql;
	}

	public String getFinanceBS2007Sql()
	{
		return financeBS2007Sql;
	}

	public void setFinanceBS2007Sql(String financeBS2007Sql)
	{
		this.financeBS2007Sql = financeBS2007Sql;
	}

	public String getFinanceCF2007Sql()
	{
		return financeCF2007Sql;
	}

	public void setFinanceCF2007Sql(String financeCF2007Sql)
	{
		this.financeCF2007Sql = financeCF2007Sql;
	}

	public String getFinancePS2007Sql()
	{
		return financePS2007Sql;
	}

	public void setFinancePS2007Sql(String financePS2007Sql)
	{
		this.financePS2007Sql = financePS2007Sql;
	}

	public String getFinanceBSINSql()
	{
		return financeBSINSql;
	}

	public void setFinanceBSINSql(String financeBSINSql)
	{
		this.financeBSINSql = financeBSINSql;
	}

	public String getFinanceCFINSql()
	{
		return financeCFINSql;
	}

	public void setFinanceCFINSql(String financeCFINSql)
	{
		this.financeCFINSql = financeCFINSql;
	}
}
