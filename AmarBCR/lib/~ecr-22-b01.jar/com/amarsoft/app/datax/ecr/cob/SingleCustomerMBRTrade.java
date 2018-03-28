// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SingleCustomerMBRTrade.java

package com.amarsoft.app.datax.ecr.cob;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.*;
import java.util.Iterator;
import java.util.TreeSet;

public class SingleCustomerMBRTrade extends DBMessageBodyReader
{
	private class ContractInfo
	{

		String financeId;
		String contractNo;
		String loanCardNo;
		final SingleCustomerMBRTrade this$0;

		private ContractInfo()
		{
			this$0 = SingleCustomerMBRTrade.this;
			super();
			financeId = null;
			contractNo = null;
			loanCardNo = null;
		}

		ContractInfo(ContractInfo contractinfo)
		{
			this();
		}
	}


	private String contractTable;
	private String customerId;
	private String sqlFilter;
	private String contractRecordSql;
	private String duebillRecordSql;
	private String returnRecordSql;
	private String extensionRecordSql;
	private ResultSet rsRecord;
	private PreparedStatement psContractInfo;
	private TreeSet contractBuffer;
	private TreeSet duebillBuffer;

	public SingleCustomerMBRTrade(Message message, String database)
	{
		super(message, database);
		contractTable = "ECR_FINAINFO";
		customerId = null;
		sqlFilter = null;
		contractRecordSql = null;
		duebillRecordSql = null;
		returnRecordSql = null;
		extensionRecordSql = null;
		rsRecord = null;
		psContractInfo = null;
		contractBuffer = new TreeSet();
		duebillBuffer = new TreeSet();
	}

	public SingleCustomerMBRTrade(Message message)
	{
		super(message);
		contractTable = "ECR_FINAINFO";
		customerId = null;
		sqlFilter = null;
		contractRecordSql = null;
		duebillRecordSql = null;
		returnRecordSql = null;
		extensionRecordSql = null;
		rsRecord = null;
		psContractInfo = null;
		contractBuffer = new TreeSet();
		duebillBuffer = new TreeSet();
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		int rt = r.getType();
		String where = sqlFilter == null ? "" : (new StringBuilder(" and (")).append(sqlFilter).append(")").toString();
		switch (rt)
		{
		case 14: // '\016'
			if (contractRecordSql == null)
				contractRecordSql = (new StringBuilder("select * from ")).append(contractTable).append(" where CustomerId='").append(customerId).append("' ").append(where).toString();
			return fillContract(r);

		case 15: // '\017'
			if (contractBuffer.isEmpty())
				return false;
			if (duebillRecordSql == null)
			{
				StringBuffer sb = new StringBuffer("select * from ");
				if (contractTable.equalsIgnoreCase("ECR_FINAINFO"))
					sb.append("ECR");
				else
					sb.append("HIS");
				sb.append("_FINADUEBILL  where (");
				Iterator it = contractBuffer.iterator();
				for (int i = 0; it.hasNext(); i++)
				{
					if (i > 0)
						sb.append(" or ");
					sb.append("FContractNo='").append(it.next()).append("'");
				}

				sb.append(") ");
				sb.append(where);
				duebillRecordSql = sb.toString();
			}
			return fillDuebill(r);

		case 16: // '\020'
			if (duebillBuffer.size() < 1)
				return false;
			if (returnRecordSql == null)
			{
				StringBuffer sb = new StringBuffer("select * from ");
				if (contractTable.equalsIgnoreCase("ECR_FINAINFO"))
					sb.append("ECR");
				else
					sb.append("HIS");
				sb.append("_FINARETURN  where (");
				Iterator it = duebillBuffer.iterator();
				for (int i = 0; it.hasNext(); i++)
				{
					if (i > 0)
						sb.append(" or ");
					sb.append("FDuebillNo='").append(it.next()).append("'");
				}

				sb.append(") ");
				sb.append(where);
				returnRecordSql = sb.toString();
			}
			return fillReturn(r);

		case 17: // '\021'
			if (duebillBuffer.size() < 1)
				return false;
			if (extensionRecordSql == null)
			{
				StringBuffer sb = new StringBuffer("select * from ");
				if (contractTable.equalsIgnoreCase("ECR_FINAINFO"))
					sb.append("ECR");
				else
					sb.append("HIS");
				sb.append("_FINAEXTENSION  where (");
				Iterator it = duebillBuffer.iterator();
				for (int i = 0; it.hasNext(); i++)
				{
					if (i > 0)
						sb.append(" or ");
					sb.append("FDuebillNo='").append(it.next()).append("'");
				}

				sb.append(") ");
				sb.append(where);
				extensionRecordSql = sb.toString();
			}
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
			break MISSING_BLOCK_LABEL_370;
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(7503).setString(rsRecord.getString("LoanCardNo"));
		segB.getField(7563).setString(rsRecord.getString("FContractNo"));
		fillIDChangeSegment(r, rsRecord);
		Segment segD = r.createSegment("D");
		segD.getField(5559).setString(rsRecord.getString("CustomerName"));
		segD.getField(7519).setString(rsRecord.getString("CreditNo"));
		segD.getField(2533).setDate(rsRecord.getString("StartDate"));
		segD.getField(2535).setDate(rsRecord.getString("EndDate"));
		segD.getField(7523).setString(rsRecord.getString("GuarantyFlag"));
		segD.getField(7565).setString(rsRecord.getString("AvailabStatus"));
		Segment segE = r.createSegment("E");
		segE.getField(1501).setString(rsRecord.getString("Currency"));
		segE.getField(1527).setDouble(rsRecord.getDouble("BusinessSum"));
		segE.getField(1529).setDouble(rsRecord.getDouble("AvailabBalance"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		contractBuffer.add(segB.getField(7563).getString());
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
			break MISSING_BLOCK_LABEL_395;
		String duebillNo = rsRecord.getString("FDuebillNo");
		ContractInfo ci = getContractInfo(duebillNo);
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(6501).setString(ci.financeId);
		segB.getField(7503).setString(ci.loanCardNo);
		segB.getField(7563).setString(ci.contractNo);
		Segment segF = r.createSegment("F");
		segF.getField(7575).setString(duebillNo);
		segF.getField(7569).setString(rsRecord.getString("BusinessType"));
		segF.getField(1501).setString(rsRecord.getString("Currency"));
		segF.getField(1531).setDouble(rsRecord.getDouble("PutoutAmount"));
		segF.getField(1533).setDouble(rsRecord.getDouble("Balance"));
		segF.getField(2537).setDate(rsRecord.getString("PutoutDate"));
		segF.getField(2539).setDate(rsRecord.getString("PutoutEndDate"));
		segF.getField(7573).setString(rsRecord.getString("ExtenFlag"));
		segF.getField(7539).setString(rsRecord.getString("Classify4"));
		segF.getField(7541).setString(rsRecord.getString("Classify5"));
		int length = r.getLength();
		segB.getField(4501).setInt(length);
		duebillBuffer.add(duebillNo);
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
			break MISSING_BLOCK_LABEL_272;
		String duebillNo = rsRecord.getString("FDuebillNo");
		ContractInfo ci = getContractInfo(duebillNo);
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(6501).setString(ci.financeId);
		segB.getField(7503).setString(ci.loanCardNo);
		segB.getField(7563).setString(ci.contractNo);
		Segment segG = r.createSegment("G");
		segG.getField(7575).setString(duebillNo);
		segG.getField(4507).setInt(rsRecord.getInt("ReturnTimes"));
		segG.getField(1515).setDouble(rsRecord.getDouble("ReturnSum"));
		segG.getField(2519).setDate(rsRecord.getString("ReturnDate"));
		segG.getField(7545).setString(rsRecord.getString("ReturnMode"));
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
			break MISSING_BLOCK_LABEL_272;
		String duebillNo = rsRecord.getString("FDuebillNo");
		ContractInfo ci = getContractInfo(duebillNo);
		Segment segB = fillBaseSegment(r, rsRecord);
		segB.getField(6501).setString(ci.financeId);
		segB.getField(7503).setString(ci.loanCardNo);
		segB.getField(7563).setString(ci.contractNo);
		Segment segH = r.createSegment("H");
		segH.getField(7575).setString(duebillNo);
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

	public void setContractRecordSql(String contractRecordSql)
	{
		this.contractRecordSql = contractRecordSql;
	}

	public final String getDuebillRecordSql()
	{
		return duebillRecordSql;
	}

	public void setDuebillRecordSql(String duebillRecordSql)
	{
		this.duebillRecordSql = duebillRecordSql;
	}

	public final String getReturnRecordSql()
	{
		return returnRecordSql;
	}

	public void seReturnRecordSql(String returnRecordSql)
	{
		this.returnRecordSql = returnRecordSql;
	}

	public final String getExtensionRecordSql()
	{
		return extensionRecordSql;
	}

	public void setExtensionRecordSql(String extensionRecordSql)
	{
		this.extensionRecordSql = extensionRecordSql;
	}

	private ContractInfo getContractInfo(String duebillNo)
		throws SQLException
	{
		ContractInfo ci = new ContractInfo(null);
		if (psContractInfo == null)
		{
			String sql = "select fc.FContractNo,fc.FinanceID,fc.LoanCardNo from ECR_FINAINFO fc,ECR_FINADUEBILL fd where fd.FDuebillNo=? and fc.FContractNo=fd.FContractNo";
			psContractInfo = prepareStatement(sql);
		}
		psContractInfo.setString(1, duebillNo);
		ResultSet rs = psContractInfo.executeQuery();
		if (rs.next())
		{
			ci.contractNo = rs.getString(1);
			ci.financeId = rs.getString(2);
			ci.loanCardNo = rs.getString(3);
		}
		rs.close();
		return ci;
	}

	public String getContractTable()
	{
		return contractTable;
	}

	public void setContractTable(String contractTable)
	{
		this.contractTable = contractTable;
	}

	public String getCustomerId()
	{
		return customerId;
	}

	public void setCustomerId(String customerId)
	{
		this.customerId = customerId;
	}

	public String getSqlFilter()
	{
		return sqlFilter;
	}

	public void setSqlFilter(String sqlFilter)
	{
		this.sqlFilter = sqlFilter;
	}
}
