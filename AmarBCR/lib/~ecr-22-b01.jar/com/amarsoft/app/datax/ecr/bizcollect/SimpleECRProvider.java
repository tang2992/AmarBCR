// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SimpleECRProvider.java

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
import com.amarsoft.app.datax.ecr.message.*;

public class SimpleECRProvider extends AbstractProvider
{

	private String dataFilter;

	public SimpleECRProvider()
	{
		dataFilter = null;
	}

	public SimpleECRProvider(String filter)
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
			mbr.setRecordSql((new StringBuilder("select * from ECR_CUSTOMERINFO ")).append(where).toString());
			return mbr;
		}

		case 2: // '\002'
		{
			MBRCustomerCapital mbr = new MBRCustomerCapital(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_CUSTCAPIINFO ")).append(where).toString());
			return mbr;
		}

		case 3: // '\003'
		{
			MBRCustomerFinance mbr = new MBRCustomerFinance(message);
			mbr.setFinanceBSSql((new StringBuilder("select * from ECR_FINANCEBS ")).append(where).toString());
			mbr.setFinancePSSql((new StringBuilder("select * from ECR_FINANCEPS ")).append(where).toString());
			mbr.setFinanceCFSql((new StringBuilder("select * from ECR_FINANCECF ")).append(where).toString());
			mbr.setFinanceBS2007Sql((new StringBuilder("select * from ECR_FINANCEBS_2007 ")).append(where).toString());
			mbr.setFinancePS2007Sql((new StringBuilder("select * from ECR_FINANCEPS_2007 ")).append(where).toString());
			mbr.setFinanceCF2007Sql((new StringBuilder("select * from ECR_FINANCECF_2007 ")).append(where).toString());
			mbr.setFinanceBSINSql((new StringBuilder("select * from ECR_FINANCEBS_IN ")).append(where).toString());
			mbr.setFinanceCFINSql((new StringBuilder("select * from ECR_FINANCECF_IN ")).append(where).toString());
			return mbr;
		}

		case 4: // '\004'
		{
			MBRCustomerAttention mbr = new MBRCustomerAttention(message);
			mbr.setLawRecordSql((new StringBuilder("select * from ECR_CUSTOMERLAW ")).append(where).toString());
			mbr.setFactRecordSql((new StringBuilder("select * from ECR_CUSTOMERFACT ")).append(where).toString());
			return mbr;
		}

		case 11: // '\013'
		{
			MBRLoan mbr = new MBRLoan(message);
			mbr.setContractRecordSql((new StringBuilder("select * from ECR_LOANCONTRACT ")).append(where).toString());
			mbr.setDuebillRecordSql((new StringBuilder("select * from ECR_LOANDUEBILL ")).append(where).toString());
			mbr.setReturnRecordSql((new StringBuilder("select * from ECR_LOANRETURN ")).append(where).toString());
			mbr.setExtensionRecordSql((new StringBuilder("select * from ECR_LOANEXTENSION ")).append(where).toString());
			return mbr;
		}

		case 12: // '\f'
		{
			MBRFactoring mbr = new MBRFactoring(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_FACTORING ")).append(where).toString());
			return mbr;
		}

		case 13: // '\r'
		{
			MBRBillDiscount mbr = new MBRBillDiscount(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_DISCOUNT ")).append(where).toString());
			return mbr;
		}

		case 14: // '\016'
		{
			MBRTrade mbr = new MBRTrade(message);
			mbr.setContractRecordSql((new StringBuilder("select * from ECR_FINAINFO ")).append(where).toString());
			mbr.setDuebillRecordSql((new StringBuilder("select * from ECR_FINADUEBILL ")).append(where).toString());
			mbr.setReturnRecordSql((new StringBuilder("select * from ECR_FINARETURN ")).append(where).toString());
			mbr.setExtensionRecordSql((new StringBuilder("select * from ECR_FINAEXTENSION ")).append(where).toString());
			return mbr;
		}

		case 15: // '\017'
		{
			MBRCreditLetter mbr = new MBRCreditLetter(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_CREDITLETTER ")).append(where).toString());
			return mbr;
		}

		case 16: // '\020'
		{
			MBRGuaranteeBill mbr = new MBRGuaranteeBill(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_GUARANTEEBILL ")).append(where).toString());
			return mbr;
		}

		case 17: // '\021'
		{
			MBRBankAcceptance mbr = new MBRBankAcceptance(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_ACCEPTANCE ")).append(where).toString());
			return mbr;
		}

		case 18: // '\022'
		{
			MBRCustomerCredit mbr = new MBRCustomerCredit(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_CUSTOMERCREDIT ")).append(where).toString());
			return mbr;
		}

		case 19: // '\023'
		{
			MBRGuarantyInfo mbr = new MBRGuarantyInfo(message);
			mbr.setAssureRecordSql((new StringBuilder("select * from ECR_ASSURECONT ")).append(where).append(" and REPORTTYPE='1' ").toString());
			mbr.setGuarantyRecordSql((new StringBuilder("select * from ECR_GUARANTYCONT ")).append(where).append(" and REPORTTYPE='1'").toString());
			mbr.setImpawnRecordSql((new StringBuilder("select * from ECR_IMPAWNCONT ")).append(where).append(" and REPORTTYPE='1' ").toString());
			mbr.setAssureRecordForNaturalPersonSql((new StringBuilder("select * from ECR_ASSURECONT ")).append(where).append(" and REPORTTYPE='2' ").toString());
			mbr.setGuarantyRecordForNaturalPersonSql((new StringBuilder("select * from ECR_GUARANTYCONT ")).append(where).append(" and REPORTTYPE='2'").toString());
			mbr.setImpawnRecordForNaturalPersonSql((new StringBuilder("select * from ECR_IMPAWNCONT ")).append(where).append(" and REPORTTYPE='2' ").toString());
			return mbr;
		}

		case 20: // '\024'
		{
			MBRAdvancePay mbr = new MBRAdvancePay(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_FLOORFUND ")).append(where).toString());
			return mbr;
		}

		case 21: // '\025'
		{
			MBRLackOfInterest mbr = new MBRLackOfInterest(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_INTERESTDUE ")).append(where).toString());
			return mbr;
		}

		case 61: // '='
		{
			MBRAssetsProtectStripping mbr = new MBRAssetsProtectStripping(message);
			mbr.setAssetsDisposeRecordSql((new StringBuilder("select * from ECR_ASSETSDISPOSE ")).append(where).toString());
			return mbr;
		}

		case 7: // '\007'
		{
			MBROrganizationBaseinfo mbr = new MBROrganizationBaseinfo(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_ORGANINFO ")).append(where).toString());
			return mbr;
		}

		case 8: // '\b'
		{
			MBROrganizationFamilyMember mbr = new MBROrganizationFamilyMember(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_ORGANFAMILY ")).append(where).toString());
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
