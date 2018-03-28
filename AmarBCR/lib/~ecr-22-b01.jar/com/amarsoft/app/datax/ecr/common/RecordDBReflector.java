// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   RecordDBReflector.java

package com.amarsoft.app.datax.ecr.common;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.Record;
import com.amarsoft.app.datax.ecr.message.Segment;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.log.Log;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Properties;

// Referenced classes of package com.amarsoft.app.datax.ecr.common:
//			OrganizationStore, CustomerStore

public class RecordDBReflector
{

	private String mainTable;
	private Field mainKeyColumn[];
	private String relativeTables[];
	private Properties fieldMapper;
	private String loanBusinessType;
	private int parentRecordType;
	private boolean rootRecord;
	private int childrenRecordType[];
	private int recordType;
	private String loanCardNoField;
	private String recordName;
	private static HashMap reflectorPool = new HashMap();

	private RecordDBReflector(int recordType)
	{
		mainTable = null;
		relativeTables = null;
		loanBusinessType = null;
		parentRecordType = 0;
		rootRecord = true;
		childrenRecordType = null;
		this.recordType = 0;
		loanCardNoField = null;
		recordName = null;
		fieldMapper = new Properties();
		this.recordType = recordType;
		parentRecordType = recordType;
		rootRecord = true;
		loanCardNoField = "B.7503";
	}

	public final Field[] getMainKeyColumn()
	{
		return mainKeyColumn;
	}

	public final String getMainKeyString()
	{
		StringBuffer key = new StringBuffer();
		for (int i = 0; i < mainKeyColumn.length; i++)
		{
			key.append('{');
			key.append(mainKeyColumn[i].getType()).append(':');
			key.append(mainKeyColumn[i].getString()).append('}');
		}

		return key.toString();
	}

	public final void computeKey(Record rec)
	{
		for (int i = 0; i < mainKeyColumn.length; i++)
		{
			com.amarsoft.app.datax.ecr.message.Field fld = null;
			mainKeyColumn[i].setNull();
			if (mainKeyColumn[i].getName().equalsIgnoreCase("CustomerID"))
				mainKeyColumn[i].setValue(getCustomerID(rec));
			else
			if ("CIFCustomerId".equalsIgnoreCase(mainKeyColumn[i].getName()) && (rec.getType() == 74 || rec.getType() == 72))
			{
				String s = lookupField("CIFCUSTOMERID", rec).getString();
				mainKeyColumn[i].setValue(s != null ? s : getCIFCustomerId(rec));
			} else
			{
				fld = lookupField(mainKeyColumn[i].getName(), rec);
				if (fld != null)
					if (mainKeyColumn[i].getType() == 1)
						mainKeyColumn[i].setValue(fld.getInt());
					else
					if ("UpdateDate".equalsIgnoreCase(mainKeyColumn[i].getName()))
					{
						mainKeyColumn[i].setValue((new SimpleDateFormat("yyyy/MM/dd")).format(fld.getDate()));
					} else
					{
						String s = fld.getString();
						if (s != null)
							mainKeyColumn[i].setValue(s.trim());
					}
			}
		}

	}

	private String getCIFCustomerId(Record rec)
	{
		Segment seg;
		String managerCertType;
		String managerCertId;
		String memberRelaType;
		String memberCertType;
		String memberCertId;
		String updateDate;
		seg = rec.getFirstSegment("B");
		managerCertType = "";
		managerCertId = "";
		memberRelaType = "";
		memberCertType = "";
		memberCertId = "";
		updateDate = "";
		if (rec.getType() != 74)
			break MISSING_BLOCK_LABEL_154;
		managerCertType = seg.getField(2101).getString().trim();
		managerCertId = seg.getField(2102).getString().trim();
		memberRelaType = seg.getField(2103).getString().trim();
		memberCertType = seg.getField(2104).getString().trim();
		memberCertId = seg.getField(2105).getString().trim();
		updateDate = (new SimpleDateFormat("yyyy/MM/dd")).format(seg.getField(2106).getDate());
		return OrganizationStore.getCIFCustomerId("HIS_BATCHDELETEFAMILY", managerCertType, managerCertId, memberRelaType, memberCertType, memberCertId, updateDate);
		managerCertType = seg.getField(1903).getString().trim();
		managerCertId = seg.getField(1904).getString().trim();
		memberRelaType = seg.getField(1905).getString().trim();
		memberCertType = seg.getField(1907).getString().trim();
		memberCertId = seg.getField(1908).getString().trim();
		updateDate = (new SimpleDateFormat("yyyy/MM/dd")).format(seg.getField(1909).getDate());
		return OrganizationStore.getCIFCustomerId("HIS_ORGANFAMILY", managerCertType, managerCertId, memberRelaType, memberCertType, memberCertId, updateDate);
		ECRException e;
		e;
		ARE.getLog().debug(e);
		return null;
	}

	private String getCustomerID(Record rec)
	{
		String customerID = null;
		try
		{
			Segment seg = rec.getFirstSegment("B");
			com.amarsoft.app.datax.ecr.message.Field fld = seg.getField(9991);
			if (fld != null)
				customerID = fld.getString();
			if (customerID == null || customerID.length() == 0)
			{
				fld = seg.getField(7503);
				com.amarsoft.app.datax.ecr.message.Field fld2 = seg.getField(6501);
				if (fld != null && fld2 != null)
				{
					String loancardNo = fld.getString();
					String financeId = fld2.getString();
					if (loancardNo != null && loancardNo.length() > 0)
						customerID = CustomerStore.getCustomerId(loancardNo.trim(), financeId);
				} else
				if (fld != null)
				{
					String loancardNo = fld.getString();
					if (loancardNo != null && loancardNo.length() > 0)
						customerID = CustomerStore.getCustomerId(loancardNo.trim());
				}
			}
		}
		catch (ECRException e)
		{
			ARE.getLog().debug(e);
		}
		return customerID;
	}

	private com.amarsoft.app.datax.ecr.message.Field lookupField(String fd, Record rec)
	{
		String kf = fieldMapper.getProperty(fd);
		String f[] = kf.split("\\.");
		Segment seg = null;
		com.amarsoft.app.datax.ecr.message.Field fld = null;
		try
		{
			seg = rec.getFirstSegment(f[0]);
			fld = seg.getField(Integer.parseInt(f[1]));
		}
		catch (ECRException e)
		{
			ARE.getLog().debug(e);
		}
		return fld;
	}

	public final String getMainTable()
	{
		return mainTable;
	}

	public final String[] getRelativeTables()
	{
		if (relativeTables == null)
			relativeTables = new String[0];
		return relativeTables;
	}

	public static RecordDBReflector getReflector(Record record)
	{
		return getReflector(record.getType());
	}

	public static RecordDBReflector getReflector(int recordType)
	{
		Integer key = new Integer(recordType);
		if (reflectorPool.containsKey(key))
			return (RecordDBReflector)reflectorPool.get(key);
		RecordDBReflector reflector = new RecordDBReflector(recordType);
		reflectorPool.put(key, reflector);
		switch (recordType)
		{
		case 1: // '\001'
			reflector.mainTable = "CUSTOMERINFO";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0)
			});
			reflector.relativeTables = (new String[] {
				"CustomerStock"
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.recordName = "借款人基本信息";
			break;

		case 2: // '\002'
			reflector.mainTable = "CUSTCAPIINFO";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0)
			});
			reflector.relativeTables = (new String[] {
				"CUSTOMERCAPI", "CUSTOMERINVEST", "CUSTOMERKEEPER", "CUSTOMERFAMILY"
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.recordName = "借款人资本构成";
			break;

		case 3: // '\003'
			reflector.mainTable = "FINANCEBS";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "ReportYear", (byte)0), new Field(3, "ReportType", (byte)0), new Field(4, "ReportSubType", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("ReportYear", "B.2591");
			reflector.fieldMapper.setProperty("ReportType", "B.7507");
			reflector.fieldMapper.setProperty("ReportSubType", "B.7651");
			reflector.recordName = "资产负债表";
			break;

		case 4: // '\004'
			reflector.mainTable = "FINANCEPS";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "ReportYear", (byte)0), new Field(3, "ReportType", (byte)0), new Field(4, "ReportSubType", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("ReportYear", "B.2591");
			reflector.fieldMapper.setProperty("ReportType", "B.7507");
			reflector.fieldMapper.setProperty("ReportSubType", "B.7651");
			reflector.recordName = "利润及利润分配表";
			break;

		case 5: // '\005'
			reflector.mainTable = "FINANCECF";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "ReportYear", (byte)0), new Field(3, "ReportType", (byte)0), new Field(4, "ReportSubType", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("ReportYear", "B.2591");
			reflector.fieldMapper.setProperty("ReportType", "B.7507");
			reflector.fieldMapper.setProperty("ReportSubType", "B.7651");
			reflector.recordName = "现金流量表";
			break;

		case 6: // '\006'
			reflector.mainTable = "CUSTOMERLAW";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "LawNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("LawNo", "D.7647");
			reflector.recordName = "借款人法律诉讼";
			break;

		case 7: // '\007'
			reflector.mainTable = "CUSTOMERFACT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "FactNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("FactNo", "E.7649");
			reflector.recordName = "借款人大事记";
			break;

		case 8: // '\b'
			reflector.mainTable = "LOANCONTRACT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "LContractNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("LContractNo", "B.7509");
			reflector.loanBusinessType = "1";
			reflector.childrenRecordType = (new int[] {
				9
			});
			reflector.recordName = "贷款合同";
			break;

		case 9: // '\t'
			reflector.mainTable = "LOANDUEBILL";
			reflector.mainKeyColumn = reflector.mainKeyColumn = (new Field[] {
				new Field(1, "LDuebillNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("LDuebillNo", "F.7527");
			reflector.loanBusinessType = "1";
			reflector.rootRecord = false;
			reflector.parentRecordType = 8;
			reflector.childrenRecordType = (new int[] {
				10, 11
			});
			reflector.recordName = "贷款借据";
			break;

		case 10: // '\n'
			reflector.mainTable = "LOANRETURN";
			reflector.mainKeyColumn = reflector.mainKeyColumn = (new Field[] {
				new Field(1, "LDuebillNo", (byte)0), new Field(1, "ReturnTimes", (byte)1)
			});
			reflector.fieldMapper.setProperty("LDuebillNo", "G.7527");
			reflector.fieldMapper.setProperty("ReturnTimes", "G.4507");
			reflector.loanBusinessType = "1";
			reflector.rootRecord = false;
			reflector.parentRecordType = 9;
			reflector.recordName = "贷款还款";
			break;

		case 11: // '\013'
			reflector.mainTable = "LOANEXTENSION";
			reflector.mainKeyColumn = reflector.mainKeyColumn = (new Field[] {
				new Field(1, "LDuebillNo", (byte)0), new Field(1, "ExtenTimes", (byte)0)
			});
			reflector.fieldMapper.setProperty("LDuebillNo", "H.7527");
			reflector.fieldMapper.setProperty("ExtenTimes", "H.4509");
			reflector.loanBusinessType = "1";
			reflector.rootRecord = false;
			reflector.parentRecordType = 9;
			reflector.recordName = "贷款展期";
			break;

		case 12: // '\f'
			reflector.mainTable = "FACTORING";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "FactoringNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("FactoringNo", "B.7547");
			reflector.loanBusinessType = "2";
			reflector.loanCardNoField = "D.7503";
			reflector.recordName = "保理业务";
			break;

		case 13: // '\r'
			reflector.mainTable = "DISCOUNT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "BillNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("BillNo", "B.7553");
			reflector.loanBusinessType = "3";
			reflector.loanCardNoField = "D.7503";
			reflector.recordName = "票据贴现业务";
			break;

		case 14: // '\016'
			reflector.mainTable = "FINAINFO";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "FContractNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("FContractNo", "B.7563");
			reflector.loanBusinessType = "4";
			reflector.childrenRecordType = (new int[] {
				15
			});
			reflector.recordName = "贸易融资协议";
			break;

		case 15: // '\017'
			reflector.mainTable = "FINADUEBILL";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "FDuebillNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("FDuebillNo", "F.7575");
			reflector.loanBusinessType = "4";
			reflector.rootRecord = false;
			reflector.parentRecordType = 14;
			reflector.childrenRecordType = (new int[] {
				16, 17
			});
			reflector.recordName = "贸易融资借据";
			break;

		case 16: // '\020'
			reflector.mainTable = "FINARETURN";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "FDuebillNo", (byte)0), new Field(1, "ReturnTimes", (byte)1)
			});
			reflector.fieldMapper.setProperty("FDuebillNo", "G.7575");
			reflector.fieldMapper.setProperty("ReturnTimes", "G.4507");
			reflector.loanBusinessType = "4";
			reflector.rootRecord = false;
			reflector.parentRecordType = 15;
			reflector.recordName = "贸易融资还款";
			break;

		case 17: // '\021'
			reflector.mainTable = "FINAEXTENSION";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "FDuebillNo", (byte)0), new Field(1, "ExtenTimes", (byte)0)
			});
			reflector.fieldMapper.setProperty("FDuebillNo", "H.7575");
			reflector.fieldMapper.setProperty("ExtenTimes", "H.4509");
			reflector.loanBusinessType = "4";
			reflector.rootRecord = false;
			reflector.parentRecordType = 15;
			reflector.recordName = "贸易融资展期";
			break;

		case 18: // '\022'
			reflector.mainTable = "CREDITLETTER";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CreditLetterNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("CreditLetterNo", "B.7577");
			reflector.loanBusinessType = "5";
			reflector.loanCardNoField = "D.7503";
			reflector.recordName = "信用证业务";
			break;

		case 19: // '\023'
			reflector.mainTable = "GUARANTEEBILL";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "GuaranteeBillNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("GuaranteeBillNo", "B.7579");
			reflector.loanBusinessType = "6";
			reflector.loanCardNoField = "D.7503";
			reflector.recordName = "保函业务";
			break;

		case 20: // '\024'
			reflector.mainTable = "ACCEPTANCE";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "AcceptNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("AcceptNo", "B.7587");
			reflector.loanBusinessType = "7";
			reflector.loanCardNoField = "D.7503";
			reflector.recordName = "银行承兑汇票";
			break;

		case 21: // '\025'
			reflector.mainTable = "CUSTOMERCREDIT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CContractNO", (byte)0)
			});
			reflector.fieldMapper.setProperty("CContractNO", "B.7593");
			reflector.loanBusinessType = "8";
			reflector.loanCardNoField = "D.7503";
			reflector.recordName = "公开授信";
			break;

		case 22: // '\026'
			reflector.mainTable = "ASSURECONT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "ContractNo", (byte)0), new Field(2, "AssureContNo", (byte)0), new Field(3, "AssurerName", (byte)0)
			});
			reflector.fieldMapper.setProperty("ContractNo", "B.7595");
			reflector.fieldMapper.setProperty("AssureContNo", "D.7597");
			reflector.fieldMapper.setProperty("AssurerName", "D.5567");
			reflector.recordName = "保证合同";
			break;

		case 23: // '\027'
			reflector.mainTable = "GUARANTYCONT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "ContractNo", (byte)0), new Field(2, "GuarantyContNo", (byte)0), new Field(3, "GuarantyNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("ContractNo", "B.7595");
			reflector.fieldMapper.setProperty("GuarantyContNo", "E.7607");
			reflector.fieldMapper.setProperty("GuarantyNo", "E.7609");
			reflector.recordName = "抵押物合同";
			break;

		case 24: // '\030'
			reflector.mainTable = "IMPAWNCONT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "ContractNo", (byte)0), new Field(2, "ImpawnContNo", (byte)0), new Field(3, "ImpawNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("ContractNo", "B.7595");
			reflector.fieldMapper.setProperty("ImpawnContNo", "F.7613");
			reflector.fieldMapper.setProperty("ImpawNo", "F.7619");
			reflector.recordName = "质押物合同";
			break;

		case 25: // '\031'
			reflector.mainTable = "FLOORFUND";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "FloorFundNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("FloorFundNo", "B.7623");
			reflector.loanCardNoField = "D.7503";
			reflector.recordName = "垫款信息";
			break;

		case 26: // '\032'
			reflector.mainTable = "INTERESTDUE";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "FinanceID", (byte)0), new Field(3, "Currency", (byte)0), new Field(4, "InterestType", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("FinanceID", "B.6501");
			reflector.fieldMapper.setProperty("Currency", "D.1501");
			reflector.fieldMapper.setProperty("InterestType", "D.7631");
			reflector.recordName = "欠息信息";
			break;

		case 51: // '3'
			reflector.mainTable = "ASSETSDISPOSE";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "BusinessNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("BusinessNo", "B.7661");
			reflector.recordName = "不良信贷资产处置信息";
			break;

		case 8004: 
			reflector.mainTable = "BATCHDELETE";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "ContractNo", (byte)0), new Field(2, "BusinessType", (byte)0), new Field(2, "LoanCardNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("ContractNo", "B.7695");
			reflector.fieldMapper.setProperty("BusinessType", "B.8539");
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.recordName = "业务删除记录";
			break;

		case 8001: 
			reflector.mainTable = "LOANCARD";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "LoanCardNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.recordName = "贷款卡查询";
			break;

		case 32: // ' '
			reflector.mainTable = "ASSURECONT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "ContractNo", (byte)0), new Field(2, "AssureContNo", (byte)0), new Field(3, "AssurerName", (byte)0)
			});
			reflector.fieldMapper.setProperty("ContractNo", "B.7595");
			reflector.fieldMapper.setProperty("AssureContNo", "G.7597");
			reflector.fieldMapper.setProperty("AssurerName", "G.5567");
			reflector.recordName = "自然人保证合同";
			break;

		case 33: // '!'
			reflector.mainTable = "GUARANTYCONT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "ContractNo", (byte)0), new Field(2, "GuarantyContNo", (byte)0), new Field(3, "GuarantyNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("ContractNo", "B.7595");
			reflector.fieldMapper.setProperty("GuarantyContNo", "H.7607");
			reflector.fieldMapper.setProperty("GuarantyNo", "H.7609");
			reflector.recordName = "自然人抵押物合同";
			break;

		case 34: // '"'
			reflector.mainTable = "IMPAWNCONT";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "ContractNo", (byte)0), new Field(2, "ImpawnContNo", (byte)0), new Field(3, "ImpawNo", (byte)0)
			});
			reflector.fieldMapper.setProperty("ContractNo", "B.7595");
			reflector.fieldMapper.setProperty("ImpawnContNo", "I.7613");
			reflector.fieldMapper.setProperty("ImpawNo", "I.7619");
			reflector.recordName = "自然人质押物合同";
			break;

		case 43: // '+'
			reflector.mainTable = "FINANCEBS_2007";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "ReportYear", (byte)0), new Field(3, "ReportType", (byte)0), new Field(4, "ReportSubType", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("ReportYear", "B.2591");
			reflector.fieldMapper.setProperty("ReportType", "B.7507");
			reflector.fieldMapper.setProperty("ReportSubType", "B.7651");
			reflector.recordName = "2007版资产负债表";
			break;

		case 44: // ','
			reflector.mainTable = "FINANCEPS_2007";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "ReportYear", (byte)0), new Field(3, "ReportType", (byte)0), new Field(4, "ReportSubType", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("ReportYear", "B.2591");
			reflector.fieldMapper.setProperty("ReportType", "B.7507");
			reflector.fieldMapper.setProperty("ReportSubType", "B.7651");
			reflector.recordName = "2007版利润及利润分配表";
			break;

		case 45: // '-'
			reflector.mainTable = "FINANCECF_2007";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "ReportYear", (byte)0), new Field(3, "ReportType", (byte)0), new Field(4, "ReportSubType", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("ReportYear", "B.2591");
			reflector.fieldMapper.setProperty("ReportType", "B.7507");
			reflector.fieldMapper.setProperty("ReportSubType", "B.7651");
			reflector.recordName = "2007版现金流量表";
			break;

		case 46: // '.'
			reflector.mainTable = "FINANCEBS_IN";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "ReportYear", (byte)0), new Field(3, "ReportType", (byte)0), new Field(4, "ReportSubType", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("ReportYear", "B.2591");
			reflector.fieldMapper.setProperty("ReportType", "B.7507");
			reflector.fieldMapper.setProperty("ReportSubType", "B.7651");
			reflector.recordName = "事业单位资产负债表";
			break;

		case 47: // '/'
			reflector.mainTable = "FINANCECF_IN";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CustomerID", (byte)0), new Field(2, "ReportYear", (byte)0), new Field(3, "ReportType", (byte)0), new Field(4, "ReportSubType", (byte)0)
			});
			reflector.fieldMapper.setProperty("LoanCardNo", "B.7503");
			reflector.fieldMapper.setProperty("ReportYear", "B.2591");
			reflector.fieldMapper.setProperty("ReportType", "B.7507");
			reflector.fieldMapper.setProperty("ReportSubType", "B.7651");
			reflector.recordName = "事业单位收入支出表";
			break;

		case 72: // 'H'
			reflector.mainTable = "ORGANFAMILY";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CIFCUSTOMERID", (byte)0), new Field(2, "ManagerCertType", (byte)0), new Field(3, "ManagerCertId", (byte)0), new Field(4, "MemberRelaType", (byte)0), new Field(5, "MemberCertType", (byte)0), new Field(6, "MemberCertId", (byte)0)
			});
			reflector.fieldMapper.setProperty("CIFCUSTOMERID", "B.9992");
			reflector.fieldMapper.setProperty("ManagerCertType", "B.1903");
			reflector.fieldMapper.setProperty("ManagerCertId", "B.1904");
			reflector.fieldMapper.setProperty("MemberRelaType", "B.1905");
			reflector.fieldMapper.setProperty("MemberCertType", "B.1907");
			reflector.fieldMapper.setProperty("MemberCertId", "B.1908");
			reflector.recordName = "家族成员信息记录";
			break;

		case 71: // 'G'
			reflector.mainTable = "ORGANINFO";
			reflector.loanCardNoField = "B.1112";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CIFCUSTOMERID", (byte)0)
			});
			reflector.relativeTables = (new String[] {
				"ORGANATTRIBUTE", "ORGANSTATUS", "ORGANCONTACT", "ORGANKEEPER", "ORGANSTOCKHOLDER", "ORGANRELATED", "ORGANSUPERIOR"
			});
			reflector.fieldMapper.setProperty("CIFCUSTOMERID", "B.1102");
			reflector.recordName = "机构基本信息";
			break;

		case 73: // 'I'
			reflector.mainTable = "BATCHDELETEORGAN";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CIFCUSTOMERID", (byte)0), new Field(2, "SEGMENTTYPE", (byte)0), new Field(3, "UPDATEDATE", (byte)0)
			});
			reflector.fieldMapper.setProperty("CIFCUSTOMERID", "B.2001");
			reflector.fieldMapper.setProperty("SEGMENTTYPE", "B.2002");
			reflector.fieldMapper.setProperty("UPDATEDATE", "B.2004");
			reflector.recordName = "机构基本信息删除记录";
			break;

		case 74: // 'J'
			reflector.mainTable = "BATCHDELETEFAMILY";
			reflector.mainKeyColumn = (new Field[] {
				new Field(1, "CIFCUSTOMERID", (byte)0), new Field(2, "MANAGERCERTTYPE", (byte)0), new Field(3, "MANAGERCERTID", (byte)0), new Field(4, "MEMBERRELATYPE", (byte)0), new Field(5, "MEMBERCERTTYPE", (byte)0), new Field(6, "MEMBERCERTID", (byte)0), new Field(7, "UPDATEDATE", (byte)0)
			});
			reflector.fieldMapper.setProperty("CIFCUSTOMERID", "B.9992");
			reflector.fieldMapper.setProperty("MANAGERCERTTYPE", "B.2101");
			reflector.fieldMapper.setProperty("MANAGERCERTID", "B.2102");
			reflector.fieldMapper.setProperty("MEMBERRELATYPE", "B.2103");
			reflector.fieldMapper.setProperty("MEMBERCERTTYPE", "B.2104");
			reflector.fieldMapper.setProperty("MEMBERCERTID", "B.2105");
			reflector.fieldMapper.setProperty("UPDATEDATE", "B.2106");
			reflector.recordName = "机构家族成员删除记录";
			break;

		default:
			reflector = null;
			break;
		}
		return reflector;
	}

	public String getLoanBusinessType()
	{
		return loanBusinessType;
	}

	public Properties getFieldMapper()
	{
		return fieldMapper;
	}

	public int getParentRecordType()
	{
		return parentRecordType;
	}

	public int getRecordType()
	{
		return recordType;
	}

	public boolean isRootRecord()
	{
		return rootRecord;
	}

	public int[] getChildrenRecordType()
	{
		return childrenRecordType;
	}

	public String getLoanCardNoField()
	{
		return loanCardNoField;
	}

	public String getRecordName()
	{
		return recordName;
	}

}
