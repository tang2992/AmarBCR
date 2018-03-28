// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRGuarantyInfo.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class MBRGuarantyInfo extends DBMessageBodyReader
{
	private class ContractInfo
	{

		String contractNo;
		String businessType;
		String financeId;
		String loanCardNo;
		String customerID;
		final MBRGuarantyInfo this$0;

		private ContractInfo()
		{
			this$0 = MBRGuarantyInfo.this;
			super();
			contractNo = null;
			businessType = null;
			financeId = null;
			loanCardNo = null;
			customerID = null;
		}

		ContractInfo(ContractInfo contractinfo)
		{
			this();
		}
	}


	private String assureRecordSql;
	private String guarantyRecordSql;
	private String impawnRecordSql;
	private String assureRecordForNaturalPersonSql;
	private String guarantyRecordForNaturalPersonSql;
	private String impawnRecordForNaturalPersonSql;
	private ResultSet rsRecord;
	private PreparedStatement psContractInfo[];
	private String sqlContractNo[] = {
		"ECR_LOANCONTRACT.LContractNo", "ECR_FACTORING.FactoringNo", "ECR_DISCOUNT.BillNo", "ECR_FINAINFO.FContractNo", "ECR_CREDITLETTER.CreditLetterNo", "ECR_GUARANTEEBILL.GuaranteeBillNo", "ECR_ACCEPTANCE.AcceptNo", "ECR_CUSTOMERCREDIT.CContractNo"
	};

	public MBRGuarantyInfo(Message message, String database)
	{
		super(message, database);
		assureRecordSql = null;
		guarantyRecordSql = null;
		impawnRecordSql = null;
		assureRecordForNaturalPersonSql = null;
		guarantyRecordForNaturalPersonSql = null;
		impawnRecordForNaturalPersonSql = null;
		rsRecord = null;
		psContractInfo = new PreparedStatement[8];
	}

	public MBRGuarantyInfo(Message message)
	{
		super(message);
		assureRecordSql = null;
		guarantyRecordSql = null;
		impawnRecordSql = null;
		assureRecordForNaturalPersonSql = null;
		guarantyRecordForNaturalPersonSql = null;
		impawnRecordForNaturalPersonSql = null;
		rsRecord = null;
		psContractInfo = new PreparedStatement[8];
	}

	protected boolean fillRecord(Record r)
		throws ECRException
	{
		int rt = r.getType();
		switch (rt)
		{
		case 22: // '\026'
			return fillAssure(r);

		case 23: // '\027'
			return fillGuaranty(r);

		case 24: // '\030'
			return fillImpawn(r);

		case 32: // ' '
			return fillAssureForNaturalPerson(r);

		case 33: // '!'
			return fillGuarantyForNaturalPerson(r);

		case 34: // '"'
			return fillImpawnForNaturalPerson(r);

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

	private boolean fillAssureForNaturalPerson(Record r)
		throws ECRException
	{
		if (assureRecordForNaturalPersonSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(assureRecordForNaturalPersonSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_549;
		Segment segB = fillBaseSegment(r, rsRecord);
		ContractInfo ci = new ContractInfo(null);
		String str[] = rsRecord.getString("ContractNo").split("©¨", 2);
		String reportContractNo = "";
		if (str[0].equals(rsRecord.getString("ContractNo")))
		{
			ci.contractNo = str[0];
			reportContractNo = ci.contractNo;
		} else
		if (str[0].equals("QBZHT"))
		{
			ci.contractNo = str[1];
			reportContractNo = str[0];
		} else
		{
			ci.contractNo = rsRecord.getString("ContractNo");
			reportContractNo = ci.contractNo;
		}
		ci.businessType = rsRecord.getString("BusinessType");
		getContractInfo(ci);
		segB.getField(6501).setString(ci.financeId);
		if (!reportContractNo.equals(ci.contractNo))
		{
			segB.getField(7503).setString("0000000000000000");
			segB.getField(7595).setString("QBZHT");
		} else
		{
			segB.getField(7503).setString(ci.loanCardNo);
			segB.getField(7595).setString(ci.contractNo);
		}
		segB.getField(7605).setString(ci.businessType);
		segB.getField(9991).setString(ci.customerID);
		Segment segG = r.createSegment("G");
		segG.getField(7597).setString(rsRecord.getString("AssureContNo"));
		segG.getField(5567).setString(rsRecord.getString("AssurerName"));
		segG.getField(5511).setString(rsRecord.getString("CertType"));
		segG.getField(5553).setString(rsRecord.getString("CertID"));
		segG.getField(1501).setString(rsRecord.getString("AssureCurrency"));
		segG.getField(1547).setDouble(rsRecord.getDouble("AssureSum"));
		segG.getField(2565).setDate(rsRecord.getString("CreateDate"));
		segG.getField(7603).setString(rsRecord.getString("AssureForm"));
		segG.getField(7525).setString(rsRecord.getString("AvailabStatus"));
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

	private boolean fillGuarantyForNaturalPerson(Record r)
		throws ECRException
	{
		if (guarantyRecordForNaturalPersonSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(guarantyRecordForNaturalPersonSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_817;
		Segment segB = fillBaseSegment(r, rsRecord);
		ContractInfo ci = new ContractInfo(null);
		String str[] = rsRecord.getString("ContractNo").split("©¨", 2);
		String reportContractNo = "";
		if (str[0].equals(rsRecord.getString("ContractNo")))
		{
			ci.contractNo = str[0];
			reportContractNo = ci.contractNo;
		} else
		if (str[0].equals("QBZHT"))
		{
			ci.contractNo = str[1];
			reportContractNo = str[0];
		} else
		{
			ci.contractNo = rsRecord.getString("ContractNo");
			reportContractNo = ci.contractNo;
		}
		ci.businessType = rsRecord.getString("BusinessType");
		getContractInfo(ci);
		segB.getField(6501).setString(ci.financeId);
		if (!reportContractNo.equals(ci.contractNo))
		{
			segB.getField(7503).setString("0000000000000000");
			segB.getField(7595).setString("QBZHT");
		} else
		{
			segB.getField(7503).setString(ci.loanCardNo);
			segB.getField(7595).setString(ci.contractNo);
		}
		segB.getField(7605).setString(ci.businessType);
		segB.getField(9991).setString(ci.customerID);
		Segment segH = r.createSegment("H");
		segH.getField(7607).setString(rsRecord.getString("GuarantyContNo"));
		String serialNo = rsRecord.getString("GuarantyNo");
		serialNo = serialNo != null ? serialNo : "01";
		for (int i = serialNo.length(); i < 2; i++)
			serialNo = (new StringBuilder("0")).append(serialNo).toString();

		segH.getField(7609).setString(serialNo);
		segH.getField(5583).setString(rsRecord.getString("PledgorName"));
		segH.getField(5511).setString(rsRecord.getString("CertType"));
		segH.getField(5553).setString(rsRecord.getString("CertID"));
		segH.getField(9999).setString(rsRecord.getString("EvaluateCurrency"));
		segH.getField(1549).setDouble(rsRecord.getDouble("EvaluateSum"));
		segH.getField(2567).setDate(rsRecord.getString("EvaluateDate"));
		segH.getField(5569).setString(rsRecord.getString("EvaluateOffice"));
		segH.getField(6507).setString(rsRecord.getString("EvaluateOfficeID"));
		segH.getField(2565).setDate(rsRecord.getString("CreateDate"));
		segH.getField(7617).setString(rsRecord.getString("GuarantyType"));
		segH.getField(1501).setString(rsRecord.getString("GuarantyCurrency"));
		segH.getField(1551).setDouble(rsRecord.getDouble("GuarantySum"));
		segH.getField(5571).setString(rsRecord.getString("RegistOrgName"));
		segH.getField(2569).setDate(rsRecord.getString("RegistDate"));
		segH.getField(8513).setString(rsRecord.getString("GuarantyExplain"));
		segH.getField(7525).setString(rsRecord.getString("AvailabStatus"));
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

	private boolean fillImpawnForNaturalPerson(Record r)
		throws ECRException
	{
		if (impawnRecordForNaturalPersonSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(impawnRecordForNaturalPersonSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_682;
		Segment segB = fillBaseSegment(r, rsRecord);
		ContractInfo ci = new ContractInfo(null);
		String str[] = rsRecord.getString("ContractNo").split("©¨", 2);
		String reportContractNo = "";
		if (str[0].equals(rsRecord.getString("ContractNo")))
		{
			ci.contractNo = str[0];
			reportContractNo = ci.contractNo;
		} else
		if (str[0].equals("QBZHT"))
		{
			ci.contractNo = str[1];
			reportContractNo = str[0];
		} else
		{
			ci.contractNo = rsRecord.getString("ContractNo");
			reportContractNo = ci.contractNo;
		}
		ci.businessType = rsRecord.getString("BusinessType");
		getContractInfo(ci);
		segB.getField(6501).setString(ci.financeId);
		if (!reportContractNo.equals(ci.contractNo))
		{
			segB.getField(7503).setString("0000000000000000");
			segB.getField(7595).setString("QBZHT");
		} else
		{
			segB.getField(7503).setString(ci.loanCardNo);
			segB.getField(7595).setString(ci.contractNo);
		}
		segB.getField(7605).setString(ci.businessType);
		segB.getField(9991).setString(ci.customerID);
		Segment segI = r.createSegment("I");
		segI.getField(7613).setString(rsRecord.getString("ImpawnContNo"));
		String serialNo = rsRecord.getString("ImpawNo");
		serialNo = serialNo != null ? serialNo : "01";
		for (int i = serialNo.length(); i < 2; i++)
			serialNo = (new StringBuilder("0")).append(serialNo).toString();

		segI.getField(7619).setString(serialNo);
		segI.getField(5573).setString(rsRecord.getString("ImpawnName"));
		segI.getField(5511).setString(rsRecord.getString("CertType"));
		segI.getField(5553).setString(rsRecord.getString("CertID"));
		segI.getField(9999).setString(rsRecord.getString("ValueCurrency"));
		segI.getField(1571).setDouble(rsRecord.getDouble("ValueSum"));
		segI.getField(2565).setDate(rsRecord.getString("CreateDate"));
		segI.getField(7621).setString(rsRecord.getString("ImpawnType"));
		segI.getField(1501).setString(rsRecord.getString("ImpawnCurrency"));
		segI.getField(1557).setDouble(rsRecord.getDouble("ImpawnSum"));
		segI.getField(7525).setString(rsRecord.getString("AvailabStatus"));
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

	private boolean fillAssure(Record r)
		throws ECRException
	{
		if (assureRecordSql == null)
			return false;
		if (rsRecord == null)
			try
			{
				rsRecord = executeQuery(assureRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_529;
		Segment segB = fillBaseSegment(r, rsRecord);
		ContractInfo ci = new ContractInfo(null);
		String str[] = rsRecord.getString("ContractNo").split("©¨", 2);
		String reportContractNo = "";
		if (str[0].equals(rsRecord.getString("ContractNo")))
		{
			ci.contractNo = str[0];
			reportContractNo = ci.contractNo;
		} else
		if (str[0].equals("QBZHT"))
		{
			ci.contractNo = str[1];
			reportContractNo = str[0];
		} else
		{
			ci.contractNo = rsRecord.getString("ContractNo");
			reportContractNo = ci.contractNo;
		}
		ci.businessType = rsRecord.getString("BusinessType");
		getContractInfo(ci);
		segB.getField(6501).setString(ci.financeId);
		if (!reportContractNo.equals(ci.contractNo))
		{
			segB.getField(7503).setString("0000000000000000");
			segB.getField(7595).setString("QBZHT");
		} else
		{
			segB.getField(7503).setString(ci.loanCardNo);
			segB.getField(7595).setString(ci.contractNo);
		}
		segB.getField(7605).setString(ci.businessType);
		segB.getField(9991).setString(ci.customerID);
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
			try
			{
				rsRecord = executeQuery(guarantyRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_797;
		Segment segB = fillBaseSegment(r, rsRecord);
		ContractInfo ci = new ContractInfo(null);
		String str[] = rsRecord.getString("ContractNo").split("©¨", 2);
		String reportContractNo = "";
		if (str[0].equals(rsRecord.getString("ContractNo")))
		{
			ci.contractNo = str[0];
			reportContractNo = ci.contractNo;
		} else
		if (str[0].equals("QBZHT"))
		{
			ci.contractNo = str[1];
			reportContractNo = str[0];
		} else
		{
			ci.contractNo = rsRecord.getString("ContractNo");
			reportContractNo = ci.contractNo;
		}
		ci.businessType = rsRecord.getString("BusinessType");
		getContractInfo(ci);
		segB.getField(6501).setString(ci.financeId);
		if (!reportContractNo.equals(ci.contractNo))
		{
			segB.getField(7503).setString("0000000000000000");
			segB.getField(7595).setString("QBZHT");
		} else
		{
			segB.getField(7503).setString(ci.loanCardNo);
			segB.getField(7595).setString(ci.contractNo);
		}
		segB.getField(7605).setString(ci.businessType);
		segB.getField(9991).setString(ci.customerID);
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
		segE.getField(2567).setDate(rsRecord.getString("EvaluateDate"));
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
			try
			{
				rsRecord = executeQuery(impawnRecordSql);
			}
			catch (SQLException e)
			{
				logger.debug(e);
				throw new ECRException(e);
			}
		if (!rsRecord.next())
			break MISSING_BLOCK_LABEL_661;
		Segment segB = fillBaseSegment(r, rsRecord);
		ContractInfo ci = new ContractInfo(null);
		String str[] = rsRecord.getString("ContractNo").split("©¨", 2);
		String reportContractNo = "";
		if (str[0].equals(rsRecord.getString("ContractNo")))
		{
			ci.contractNo = str[0];
			reportContractNo = ci.contractNo;
		} else
		if (str[0].equals("QBZHT"))
		{
			ci.contractNo = str[1];
			reportContractNo = str[0];
		} else
		{
			ci.contractNo = rsRecord.getString("ContractNo");
			reportContractNo = ci.contractNo;
		}
		ci.businessType = rsRecord.getString("BusinessType");
		getContractInfo(ci);
		segB.getField(6501).setString(ci.financeId);
		if (!reportContractNo.equals(ci.contractNo))
		{
			segB.getField(7503).setString("0000000000000000");
			segB.getField(7595).setString("QBZHT");
		} else
		{
			segB.getField(7503).setString(ci.loanCardNo);
			segB.getField(7595).setString(ci.contractNo);
		}
		segB.getField(7605).setString(ci.businessType);
		segB.getField(9991).setString(ci.customerID);
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

	public String getAssureRecordForNaturalPersonSql()
	{
		return assureRecordForNaturalPersonSql;
	}

	public void setAssureRecordForNaturalPersonSql(String assureRecordForNaturalPersonSql)
	{
		this.assureRecordForNaturalPersonSql = assureRecordForNaturalPersonSql;
	}

	public String getGuarantyRecordForNaturalPersonSql()
	{
		return guarantyRecordForNaturalPersonSql;
	}

	public void setGuarantyRecordForNaturalPersonSql(String guarantyRecordForNaturalPersonSql)
	{
		this.guarantyRecordForNaturalPersonSql = guarantyRecordForNaturalPersonSql;
	}

	public String getImpawnRecordForNaturalPersonSql()
	{
		return impawnRecordForNaturalPersonSql;
	}

	public void setImpawnRecordForNaturalPersonSql(String impawnRecordForNaturalPersonSql)
	{
		this.impawnRecordForNaturalPersonSql = impawnRecordForNaturalPersonSql;
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
			int dot = sqlContractNo[bt - 1].indexOf('.');
			String sql = (new StringBuilder("select FinanceID,LoanCardNo,CustomerID from ")).append(sqlContractNo[bt - 1].substring(0, dot)).append(" where ").append(sqlContractNo[bt - 1].substring(dot + 1)).append("=?").toString();
			psContractInfo[bt - 1] = prepareStatement(sql);
		}
		psContractInfo[bt - 1].setString(1, ci.contractNo);
		ResultSet rs = psContractInfo[bt - 1].executeQuery();
		if (rs.next())
		{
			ci.financeId = rs.getString(1);
			ci.loanCardNo = rs.getString(2);
			ci.customerID = rs.getString(3);
		}
		rs.close();
	}
}
