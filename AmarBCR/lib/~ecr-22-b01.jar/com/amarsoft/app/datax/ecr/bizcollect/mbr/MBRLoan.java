// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRLoan.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class MBRLoan extends DBMessageBodyReader
{
	private class ContractInfo
	{

		String financeId;
		String contractNo;
		String loanCardNo;
		String customerID;
		final MBRLoan this$0;

		private ContractInfo()
		{
			this$0 = MBRLoan.this;
			super();
			financeId = null;
			contractNo = null;
			loanCardNo = null;
			customerID = null;
		}

		ContractInfo(ContractInfo contractinfo)
		{
			this();
		}
	}


	private String contractRecordSql;
	private String duebillRecordSql;
	private String returnRecordSql;
	private String extensionRecordSql;
	private ResultSet rsRecord;
	private PreparedStatement psContractInfo;

	public MBRLoan(Message message, String database)
	{
		super(message, database);
		contractRecordSql = null;
		duebillRecordSql = null;
		returnRecordSql = null;
		extensionRecordSql = null;
		rsRecord = null;
		psContractInfo = null;
	}

	public MBRLoan(Message message)
	{
		super(message);
		contractRecordSql = null;
		duebillRecordSql = null;
		returnRecordSql = null;
		extensionRecordSql = null;
		rsRecord = null;
		psContractInfo = null;
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		int rt = r.getType();
		switch (rt)
		{
		case 8: // '\b'
			return fillContract(r);

		case 9: // '\t'
			return fillDuebill(r);

		case 10: // '\n'
			return fillReturn(r);

		case 11: // '\013'
			return fillExtension(r);
		}
		return false;
	}

	private boolean fillContract(Record r)
		throws ECRException
	{
		if (contractRecordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(contractRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_393;
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(7503).setString(rsRecord.getString("LoanCardNo"));
		segB.getField(7509).setString(rsRecord.getString("LContractNo"));
		segB.getField(9991).setString(rsRecord.getString("CustomerID"));
		fillIDChangeSegment(r, rsRecord);
		Segment segD = r.createSegment("D");
		segD.getField(5559).setString(rsRecord.getString("CustomerName"));
		segD.getField(7519).setString(rsRecord.getString("CreditNo"));
		segD.getField(2511).setDate(rsRecord.getString("StartDate"));
		segD.getField(2513).setDate(rsRecord.getString("EndDate"));
		segD.getField(7521).setString(rsRecord.getString("BankFlag"));
		segD.getField(7523).setString(rsRecord.getString("GuarantyFlag"));
		segD.getField(7525).setString(rsRecord.getString("AvailabStatus"));
		Segment segE = r.createSegment("E");
		segE.getField(1501).setString(rsRecord.getString("Currency"));
		segE.getField(1573).setDouble(rsRecord.getDouble("BusinessSum"));
		segE.getField(1575).setDouble(rsRecord.getDouble("AvailabBalance"));
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

	private boolean fillDuebill(Record r)
		throws ECRException
	{
		if (duebillRecordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(duebillRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_479;
		String duebillNo = rsRecord.getString("LDuebillNo");
		ContractInfo ci = getContractInfo(duebillNo);
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(6501).setString(ci.financeId);
		segB.getField(7503).setString(ci.loanCardNo);
		segB.getField(7509).setString(ci.contractNo);
		segB.getField(9991).setString(ci.customerID);
		Segment segF = r.createSegment("F");
		segF.getField(7527).setString(duebillNo);
		segF.getField(1501).setString(rsRecord.getString("Currency"));
		segF.getField(1511).setDouble(rsRecord.getDouble("PutoutAmount"));
		segF.getField(1513).setDouble(rsRecord.getDouble("Balance"));
		segF.getField(2515).setDate(rsRecord.getString("PutoutDate"));
		segF.getField(2517).setDate(rsRecord.getString("PutoutEndDate"));
		segF.getField(7529).setString(rsRecord.getString("BusinessType"));
		segF.getField(7531).setString(rsRecord.getString("Form"));
		segF.getField(7533).setString(rsRecord.getString("LoanCharacter"));
		segF.getField(7535).setString(rsRecord.getString("Way"));
		segF.getField(7537).setString(rsRecord.getString("Kind"));
		segF.getField(7573).setString(rsRecord.getString("ExtenFlag"));
		segF.getField(7539).setString(rsRecord.getString("Classify4"));
		segF.getField(7541).setString(rsRecord.getString("Classify5"));
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

	private boolean fillReturn(Record r)
		throws ECRException
	{
		if (returnRecordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(returnRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_281;
		String duebillNo = rsRecord.getString("LDuebillNo");
		ContractInfo ci = getContractInfo(duebillNo);
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(6501).setString(ci.financeId);
		segB.getField(7503).setString(ci.loanCardNo);
		segB.getField(7509).setString(ci.contractNo);
		segB.getField(9991).setString(ci.customerID);
		Segment segG = r.createSegment("G");
		segG.getField(7527).setString(duebillNo);
		segG.getField(2519).setDate(rsRecord.getString("ReturnDate"));
		segG.getField(4507).setInt(rsRecord.getInt("ReturnTimes"));
		segG.getField(7545).setString(rsRecord.getString("ReturnMode"));
		segG.getField(1515).setDouble(rsRecord.getDouble("ReturnSum"));
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

	private boolean fillExtension(Record r)
		throws ECRException
	{
		if (extensionRecordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(extensionRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_281;
		String duebillNo = rsRecord.getString("LDuebillNo");
		ContractInfo ci = getContractInfo(duebillNo);
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(6501).setString(ci.financeId);
		segB.getField(7503).setString(ci.loanCardNo);
		segB.getField(7509).setString(ci.contractNo);
		segB.getField(9991).setString(ci.customerID);
		Segment segH = r.createSegment("H");
		segH.getField(7527).setString(duebillNo);
		segH.getField(4509).setString(rsRecord.getString("ExtenTimes"));
		segH.getField(1517).setDouble(rsRecord.getDouble("ExtenSum"));
		segH.getField(2521).setDate(rsRecord.getString("ExtenStartDate"));
		segH.getField(2523).setDate(rsRecord.getString("ExtenEndDate"));
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

	public final String getContractRecordSql()
	{
		return contractRecordSql;
	}

	public final void setContractRecordSql(String contractRecordSql)
	{
		this.contractRecordSql = contractRecordSql;
	}

	public final String getDuebillRecordSql()
	{
		return duebillRecordSql;
	}

	public final void setDuebillRecordSql(String duebillRecordSql)
	{
		this.duebillRecordSql = duebillRecordSql;
	}

	public final String getReturnRecordSql()
	{
		return returnRecordSql;
	}

	public final void setReturnRecordSql(String returnRecordSql)
	{
		this.returnRecordSql = returnRecordSql;
	}

	public final String getExtensionRecordSql()
	{
		return extensionRecordSql;
	}

	public final void setExtensionRecordSql(String extensionRecordSql)
	{
		this.extensionRecordSql = extensionRecordSql;
	}

	private ContractInfo getContractInfo(String duebillNo)
		throws SQLException
	{
		ContractInfo ci = new ContractInfo(null);
		if (psContractInfo == null)
		{
			String sql = "select lc.LContractNo,lc.FinanceID,lc.LoanCardNo,lc.CustomerID from ECR_LOANCONTRACT lc,ECR_LOANDUEBILL ld where ld.LDuebillNo=? and lc.LContractNo=ld.LContractNo";
			psContractInfo = prepareStatement(sql);
		}
		psContractInfo.setString(1, duebillNo);
		ResultSet rs = psContractInfo.executeQuery();
		if (rs.next())
		{
			ci.contractNo = rs.getString(1);
			ci.financeId = rs.getString(2);
			ci.loanCardNo = rs.getString(3);
			ci.customerID = rs.getString(4);
		}
		rs.close();
		return ci;
	}
}
