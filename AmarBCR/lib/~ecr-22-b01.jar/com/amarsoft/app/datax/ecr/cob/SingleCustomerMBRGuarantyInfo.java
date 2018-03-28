// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SingleCustomerMBRGuarantyInfo.java

package com.amarsoft.app.datax.ecr.cob;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class SingleCustomerMBRGuarantyInfo extends DBMessageBodyReader
{
	private class ContractInfo
	{

		String contractNo;
		String businessType;
		String financeId;
		String loanCardNo;
		final SingleCustomerMBRGuarantyInfo this$0;

		private ContractInfo()
		{
			this$0 = SingleCustomerMBRGuarantyInfo.this;
			super();
			contractNo = null;
			businessType = null;
			financeId = null;
			loanCardNo = null;
		}

		ContractInfo(ContractInfo contractinfo)
		{
			this();
		}
	}


	public static final int TOTAL_BIZ_TYPE = 8;
	private String assureRecordSql;
	private String guarantyRecordSql;
	private String impawnRecordSql;
	private String customerId;
	private String sqlFilter;
	private String where;
	private ResultSet rsRecord;
	private String contractNoRange[];
	private String contractNoDef[] = {
		"ECR_LOANCONTRACT.LContractNo", "ECR_FACTORING.FactoringNo", "ECR_DISCOUNT.BillNo", "ECR_FINAINFO.FContractNo", "ECR_CREDITLETTER.CreditLetterNo", "ECR_GUARANTEEBILL.GuaranteeBillNo", "ECR_ACCEPTANCE.AcceptNo", "ECR_CUSTOMERCREDIT.CContractNo"
	};
	private PreparedStatement psContractInfo[];

	public SingleCustomerMBRGuarantyInfo(Message message, String database)
	{
		super(message, database);
		assureRecordSql = null;
		guarantyRecordSql = null;
		impawnRecordSql = null;
		customerId = null;
		sqlFilter = null;
		where = null;
		rsRecord = null;
		contractNoRange = new String[8];
		psContractInfo = new PreparedStatement[8];
	}

	public SingleCustomerMBRGuarantyInfo(Message message)
	{
		super(message);
		assureRecordSql = null;
		guarantyRecordSql = null;
		impawnRecordSql = null;
		customerId = null;
		sqlFilter = null;
		where = null;
		rsRecord = null;
		contractNoRange = new String[8];
		psContractInfo = new PreparedStatement[8];
	}

	public void open()
		throws ECRException
	{
		super.open();
		try
		{
			getContractNoRange();
		}
		catch (SQLException ex)
		{
			logger.debug(ex);
			throw new ECRException("根据客户号获取业务号失败！", ex);
		}
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		int rt = r.getType();
		where = sqlFilter == null ? "" : (new StringBuilder(" and (")).append(sqlFilter).append(")").toString();
		switch (rt)
		{
		case 22: // '\026'
			return fillAssure(r);

		case 23: // '\027'
			return fillGuaranty(r);

		case 24: // '\030'
			return fillImpawn(r);

		case 32: // ' '
			return fillAssure(r);

		case 33: // '!'
			return fillGuaranty(r);

		case 34: // '"'
			return fillImpawn(r);

		case 25: // '\031'
		case 26: // '\032'
		case 27: // '\033'
		case 28: // '\034'
		case 29: // '\035'
		case 30: // '\036'
		case 31: // '\037'
		default:
			return false;
		}
	}

	private boolean fillAssure(Record r)
		throws ECRException
	{
		if (assureRecordSql == null)
			return false;
		if (rsRecord == null)
		{
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < 8; i++)
				if (contractNoRange[i] != null)
				{
					sb.append("union ");
					sb.append(assureRecordSql).append(" where (");
					sb.append(contractNoRange[i]);
					sb.append(") and BusinessType='").append(i + 1);
					sb.append("' ");
					sb.append(where);
				}

			if (sb.length() < 1)
				return false;
			sb.delete(0, 6);
			try
			{
				rsRecord = executeQuery(sb.toString());
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_493;
		Segment segB = fillBaseSegment(r, rsRecord);
		ContractInfo ci = new ContractInfo(null);
		ci.contractNo = rsRecord.getString("ContractNo");
		ci.businessType = rsRecord.getString("BusinessType");
		getContractInfo(ci);
		segB.getField(6501).setString(ci.financeId);
		segB.getField(7503).setString(ci.loanCardNo);
		segB.getField(7595).setString(ci.contractNo);
		segB.getField(7605).setString(ci.businessType);
		Segment segD = r.createSegment("D");
		segD.getField(7597).setString(rsRecord.getString("AssureContNo"));
		segD.getField(5567).setString(rsRecord.getString("AssurerName"));
		segD.getField(7503).setString(rsRecord.getString("ALoanCardNo"));
		segD.getField(1501).setString(rsRecord.getString("AssureCurrency"));
		segD.getField(1547).setDouble(rsRecord.getDouble("AssureSum"));
		segD.getField(2565).setDate(rsRecord.getString("CreateDate"));
		segD.getField(7603).setString(rsRecord.getString("AssureForm"));
		segD.getField(7525).setString(rsRecord.getString("AvailabStatus"));
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

	private boolean fillGuaranty(Record r)
		throws ECRException
	{
		if (guarantyRecordSql == null)
			return false;
		if (rsRecord == null)
		{
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < 8; i++)
				if (contractNoRange[i] != null)
				{
					sb.append("union ");
					sb.append(guarantyRecordSql).append(" where (");
					sb.append(contractNoRange[i]);
					sb.append(") and BusinessType='").append(i + 1);
					sb.append("' ");
					sb.append(where);
				}

			if (sb.length() < 1)
				return false;
			sb.delete(0, 6);
			try
			{
				rsRecord = executeQuery(sb.toString());
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_764;
		Segment segB = fillBaseSegment(r, rsRecord);
		ContractInfo ci = new ContractInfo(null);
		ci.contractNo = rsRecord.getString("ContractNo");
		ci.businessType = rsRecord.getString("BusinessType");
		getContractInfo(ci);
		segB.getField(6501).setString(ci.financeId);
		segB.getField(7503).setString(ci.loanCardNo);
		segB.getField(7595).setString(ci.contractNo);
		segB.getField(7605).setString(ci.businessType);
		Segment segE = r.createSegment("E");
		segE.getField(7607).setString(rsRecord.getString("GuarantyContNo"));
		String serialNo = rsRecord.getString("GuarantyNo");
		serialNo = serialNo != null ? serialNo : "01";
		for (int i = serialNo.length(); i < 2; i++)
			serialNo = (new StringBuilder("0")).append(serialNo).toString();

		segE.getField(7609).setString(serialNo);
		segE.getField(5583).setString(rsRecord.getString("PledgorName"));
		segE.getField(7503).setString(rsRecord.getString("GLoanCardNo"));
		segE.getField(9999).setString(rsRecord.getString("EvaluateCurrency"));
		segE.getField(1549).setDouble(rsRecord.getDouble("EvaluateSum"));
		segE.getField(2567).setString(rsRecord.getString("EvaluateDate"));
		segE.getField(5569).setString(rsRecord.getString("EvaluateOffice"));
		segE.getField(6507).setString(rsRecord.getString("EvaluateOfficeID"));
		segE.getField(2565).setDate(rsRecord.getString("CreateDate"));
		segE.getField(7617).setString(rsRecord.getString("GuarantyType"));
		segE.getField(1501).setString(rsRecord.getString("GuarantyCurrency"));
		segE.getField(1551).setDouble(rsRecord.getDouble("GuarantySum"));
		segE.getField(5571).setString(rsRecord.getString("RegistOrgName"));
		segE.getField(2569).setDate(rsRecord.getString("RegistDate"));
		segE.getField(8513).setString(rsRecord.getString("GuarantyExplain"));
		segE.getField(7525).setString(rsRecord.getString("AvailabStatus"));
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

	private boolean fillImpawn(Record r)
		throws ECRException
	{
		if (impawnRecordSql == null)
			return false;
		if (rsRecord == null)
		{
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < 8; i++)
				if (contractNoRange[i] != null)
				{
					sb.append("union ");
					sb.append(impawnRecordSql).append(" where (");
					sb.append(contractNoRange[i]);
					sb.append(") and BusinessType='").append(i + 1);
					sb.append("' ");
					sb.append(where);
				}

			if (sb.length() < 1)
				return false;
			sb.delete(0, 6);
			try
			{
				rsRecord = executeQuery(sb.toString());
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_626;
		Segment segB = fillBaseSegment(r, rsRecord);
		ContractInfo ci = new ContractInfo(null);
		ci.contractNo = rsRecord.getString("ContractNo");
		ci.businessType = rsRecord.getString("BusinessType");
		getContractInfo(ci);
		segB.getField(6501).setString(ci.financeId);
		segB.getField(7503).setString(ci.loanCardNo);
		segB.getField(7595).setString(ci.contractNo);
		segB.getField(7605).setString(ci.businessType);
		Segment segF = r.createSegment("F");
		segF.getField(7613).setString(rsRecord.getString("ImpawnContNo"));
		String serialNo = rsRecord.getString("ImpawNo");
		serialNo = serialNo != null ? serialNo : "01";
		for (int i = serialNo.length(); i < 2; i++)
			serialNo = (new StringBuilder("0")).append(serialNo).toString();

		segF.getField(7619).setString(serialNo);
		segF.getField(5573).setString(rsRecord.getString("ImpawnName"));
		segF.getField(7503).setString(rsRecord.getString("ILoanCardNo"));
		segF.getField(9999).setString(rsRecord.getString("ValueCurrency"));
		segF.getField(1571).setDouble(rsRecord.getDouble("ValueSum"));
		segF.getField(2565).setDate(rsRecord.getString("CreateDate"));
		segF.getField(7621).setString(rsRecord.getString("ImpawnType"));
		segF.getField(1501).setString(rsRecord.getString("ImpawnCurrency"));
		segF.getField(1557).setDouble(rsRecord.getDouble("ImpawnSum"));
		segF.getField(7525).setString(rsRecord.getString("AvailabStatus"));
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

	public final String getAssureRecordSql()
	{
		return assureRecordSql;
	}

	public final void setAssureRecordSql(String assureRecordSql)
	{
		this.assureRecordSql = assureRecordSql;
	}

	public final String getGuarantyRecordSql()
	{
		return guarantyRecordSql;
	}

	public final void setGuarantyRecordSql(String guarantyRecordSql)
	{
		this.guarantyRecordSql = guarantyRecordSql;
	}

	public final String getImpawnRecordSql()
	{
		return impawnRecordSql;
	}

	public final void setImpawnRecordSql(String impawnRecordSql)
	{
		this.impawnRecordSql = impawnRecordSql;
	}

	private void getContractInfo(ContractInfo ci)
		throws SQLException
	{
		int bt = 0;
		try
		{
			bt = Integer.parseInt(ci.businessType);
			if (bt < 1 || bt > 8)
				throw new NumberFormatException(ci.businessType);
		}
		catch (NumberFormatException e)
		{
			logger.debug((new StringBuilder("Invalid businessType : ")).append(ci.businessType).toString(), e);
		}
		if (psContractInfo[bt - 1] == null)
		{
			int dot = contractNoDef[bt - 1].indexOf('.');
			String sql = (new StringBuilder("select FinanceID,LoanCardNo from ")).append(contractNoDef[bt - 1].substring(0, dot)).append(" where ").append(contractNoDef[bt - 1].substring(dot + 1)).append("=?").toString();
			psContractInfo[bt - 1] = prepareStatement(sql);
		}
		psContractInfo[bt - 1].setString(1, ci.contractNo);
		ResultSet rs = psContractInfo[bt - 1].executeQuery();
		if (rs.next())
		{
			ci.financeId = rs.getString(1);
			ci.loanCardNo = rs.getString(2);
		}
		rs.close();
	}

	private void getContractNoRange()
		throws SQLException
	{
		for (int i = 0; i < 8; i++)
		{
			int dot = contractNoDef[i].indexOf('.');
			String sql = (new StringBuilder("select ")).append(contractNoDef[i].substring(dot + 1)).append(" from ").append(contractNoDef[i].substring(0, dot)).append(" where CustomerId='").append(customerId).append("'").toString();
			ResultSet rs = executeQuery(sql);
			StringBuffer sb = new StringBuffer();
			for (; rs.next(); sb.append("'"))
			{
				if (sb.length() == 0)
					sb.append(" ContractNo='");
				else
					sb.append(" or ContractNo='");
				sb.append(rs.getString(1));
			}

			if (sb.length() > 0)
				contractNoRange[i] = sb.toString();
			rs.close();
		}

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
