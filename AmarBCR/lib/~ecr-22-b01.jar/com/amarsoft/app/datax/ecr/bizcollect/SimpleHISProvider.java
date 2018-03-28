// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SimpleHISProvider.java

package com.amarsoft.app.datax.ecr.bizcollect;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRAdvancePay;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRAssetsProtectStripping;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRBankAcceptance;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRBillDiscount;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRCreditLetter;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRCustomerAttention;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRCustomerCapital;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRCustomerCredit;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRCustomerFinance;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRCustomerInfo;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRFactoring;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRGuaranteeBill;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRGuarantyInfo;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRLackOfInterest;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRLoan;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBROrganizationBaseinfo;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBROrganizationFamilyMember;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.MBRTrade;
import com.amarsoft.app.datax.ecr.bizmanage.*;
import com.amarsoft.app.datax.ecr.infoservice.MBRLoanCardInquire;
import com.amarsoft.app.datax.ecr.message.*;

public class SimpleHISProvider extends AbstractProvider
{

	private String dataFilter;

	public SimpleHISProvider()
	{
		dataFilter = null;
	}

	public SimpleHISProvider(String filter)
	{
		dataFilter = null;
		dataFilter = filter;
	}

	public MessageBodyReader getMessageBodyReader(Message message)
		throws ECRException
	{
		String where = dataFilter != null ? (new StringBuilder("where ")).append(dataFilter).toString() : "";
		int type = message.getType();
		switch (type)
		{
		case 1: // '\001'
		{
			MBRCustomerInfo mbr = new MBRCustomerInfo(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_CUSTOMERINFO ")).append(where).toString());
			return mbr;
		}

		case 2: // '\002'
		{
			MBRCustomerCapital mbr = new MBRCustomerCapital(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_CUSTCAPIINFO ")).append(where).toString());
			return mbr;
		}

		case 3: // '\003'
		{
			MBRCustomerFinance mbr = new MBRCustomerFinance(message);
			mbr.setFinanceBSSql((new StringBuilder("select * from HIS_FINANCEBS ")).append(where).toString());
			mbr.setFinancePSSql((new StringBuilder("select * from HIS_FINANCEPS ")).append(where).toString());
			mbr.setFinanceCFSql((new StringBuilder("select * from HIS_FINANCECF ")).append(where).toString());
			mbr.setFinanceBS2007Sql((new StringBuilder("select * from HIS_FINANCEBS_2007 ")).append(where).toString());
			mbr.setFinancePS2007Sql((new StringBuilder("select * from HIS_FINANCEPS_2007 ")).append(where).toString());
			mbr.setFinanceCF2007Sql((new StringBuilder("select * from HIS_FINANCECF_2007 ")).append(where).toString());
			mbr.setFinanceBSINSql((new StringBuilder("select * from HIS_FINANCEBS_IN ")).append(where).toString());
			mbr.setFinanceCFINSql((new StringBuilder("select * from HIS_FINANCECF_IN ")).append(where).toString());
			return mbr;
		}

		case 4: // '\004'
		{
			MBRCustomerAttention mbr = new MBRCustomerAttention(message);
			mbr.setLawRecordSql((new StringBuilder("select * from HIS_CUSTOMERLAW ")).append(where).toString());
			mbr.setFactRecordSql((new StringBuilder("select * from HIS_CUSTOMERFACT ")).append(where).toString());
			return mbr;
		}

		case 11: // '\013'
		{
			MBRLoan mbr = new MBRLoan(message);
			mbr.setContractRecordSql((new StringBuilder("select * from HIS_LOANCONTRACT ")).append(where).toString());
			mbr.setDuebillRecordSql((new StringBuilder("select * from HIS_LOANDUEBILL ")).append(where).toString());
			mbr.setReturnRecordSql((new StringBuilder("select * from HIS_LOANRETURN ")).append(where).append(" order by LduebillNo,ReturnTimes asc").toString());
			mbr.setExtensionRecordSql((new StringBuilder("select * from HIS_LOANEXTENSION ")).append(where).append(" order by LduebillNo,ExtenTimes asc").toString());
			return mbr;
		}

		case 12: // '\f'
		{
			MBRFactoring mbr = new MBRFactoring(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_FACTORING ")).append(where).toString());
			return mbr;
		}

		case 13: // '\r'
		{
			MBRBillDiscount mbr = new MBRBillDiscount(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_DISCOUNT ")).append(where).toString());
			return mbr;
		}

		case 14: // '\016'
		{
			MBRTrade mbr = new MBRTrade(message);
			mbr.setContractRecordSql((new StringBuilder("select * from HIS_FINAINFO ")).append(where).toString());
			mbr.setDuebillRecordSql((new StringBuilder("select * from HIS_FINADUEBILL ")).append(where).toString());
			mbr.setReturnRecordSql((new StringBuilder("select * from HIS_FINARETURN ")).append(where).append(" order by FduebillNo,ReturnTimes asc").toString());
			mbr.setExtensionRecordSql((new StringBuilder("select * from HIS_FINAEXTENSION ")).append(where).append(" order by FduebillNo,ExtenTimes asc").toString());
			return mbr;
		}

		case 15: // '\017'
		{
			MBRCreditLetter mbr = new MBRCreditLetter(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_CREDITLETTER ")).append(where).toString());
			return mbr;
		}

		case 16: // '\020'
		{
			MBRGuaranteeBill mbr = new MBRGuaranteeBill(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_GUARANTEEBILL ")).append(where).toString());
			return mbr;
		}

		case 17: // '\021'
		{
			MBRBankAcceptance mbr = new MBRBankAcceptance(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_ACCEPTANCE ")).append(where).toString());
			return mbr;
		}

		case 18: // '\022'
		{
			MBRCustomerCredit mbr = new MBRCustomerCredit(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_CUSTOMERCREDIT ")).append(where).toString());
			return mbr;
		}

		case 19: // '\023'
		{
			MBRGuarantyInfo mbr = new MBRGuarantyInfo(message);
			mbr.setAssureRecordSql((new StringBuilder("select * from HIS_ASSURECONT ")).append(where).append(" and REPORTTYPE='1' ").toString());
			mbr.setGuarantyRecordSql((new StringBuilder("select * from HIS_GUARANTYCONT ")).append(where).append(" and REPORTTYPE='1' order by ContractNo,GuarantyContNo,GuarantyNo asc").toString());
			mbr.setImpawnRecordSql((new StringBuilder("select * from HIS_IMPAWNCONT ")).append(where).append(" and REPORTTYPE='1' order by ContractNo,ImpawnContNo,ImpawNo asc").toString());
			mbr.setAssureRecordForNaturalPersonSql((new StringBuilder("select * from HIS_ASSURECONT ")).append(where).append(" and REPORTTYPE='2' ").toString());
			mbr.setGuarantyRecordForNaturalPersonSql((new StringBuilder("select * from HIS_GUARANTYCONT ")).append(where).append(" and REPORTTYPE='2' order by ContractNo,GuarantyContNo,GuarantyNo asc").toString());
			mbr.setImpawnRecordForNaturalPersonSql((new StringBuilder("select * from HIS_IMPAWNCONT ")).append(where).append(" and REPORTTYPE='2' order by ContractNo,ImpawnContNo,ImpawNo asc").toString());
			return mbr;
		}

		case 20: // '\024'
		{
			MBRAdvancePay mbr = new MBRAdvancePay(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_FLOORFUND ")).append(where).toString());
			return mbr;
		}

		case 21: // '\025'
		{
			MBRLackOfInterest mbr = new MBRLackOfInterest(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_INTERESTDUE ")).append(where).toString());
			return mbr;
		}

		case 61: // '='
		{
			MBRAssetsProtectStripping mbr = new MBRAssetsProtectStripping(message);
			mbr.setAssetsDisposeRecordSql((new StringBuilder("select * from HIS_ASSETSDISPOSE ")).append(where).toString());
			return mbr;
		}

		case 51: // '3'
		{
			MBRBatchDelete mbr = new MBRBatchDelete(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_BATCHDELETE ")).append(where).append(" and (RecordFlag='").append("40").append("')").toString());
			return mbr;
		}

		case 41: // ')'
		{
			MBRLoanCardInquire mbr = new MBRLoanCardInquire(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_LOANCARD ")).append(where).toString());
			return mbr;
		}

		case 7: // '\007'
		{
			MBROrganizationBaseinfo mbr = new MBROrganizationBaseinfo(message);
			mbr.setDataFilter(dataFilter);
			mbr.setRecordSql((new StringBuilder("select * from HIS_ORGANINFO ")).append(where).toString());
			return mbr;
		}

		case 8: // '\b'
		{
			MBROrganizationFamilyMember mbr = new MBROrganizationFamilyMember(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_ORGANFAMILY ")).append(where).toString());
			return mbr;
		}

		case 32: // ' '
		{
			MBROrganizationDelete mbr = new MBROrganizationDelete(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_BATCHDELETEORGAN ")).append(where).append(" and (RecordFlag='").append("40").append("')").toString());
			return mbr;
		}

		case 33: // '!'
		{
			MBRFamilyMemberDelete mbr = new MBRFamilyMemberDelete(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_BATCHDELETEFAMILY ")).append(where).append(" and (RecordFlag='").append("40").append("')").toString());
			return mbr;
		}
		}
		return new DummyMessageBodyReader(message);
	}

	public final String getDataFilter()
	{
		return dataFilter;
	}

	public final void setDataFilter(String dataFilter)
	{
		this.dataFilter = dataFilter;
	}
}
