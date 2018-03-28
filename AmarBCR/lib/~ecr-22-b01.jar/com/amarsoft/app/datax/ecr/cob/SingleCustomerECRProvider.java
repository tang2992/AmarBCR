// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SingleCustomerECRProvider.java

package com.amarsoft.app.datax.ecr.cob;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizcollect.mbr.*;
import com.amarsoft.app.datax.ecr.message.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.cob:
//			SingleCustomerMBRCapital, SingleCustomerMBRLoan, SingleCustomerMBRTrade, SingleCustomerMBRGuarantyInfo

public class SingleCustomerECRProvider extends AbstractProvider
{

	private String customerId;
	private String sqlFilter;

	public SingleCustomerECRProvider(String customerId)
	{
		this.customerId = null;
		sqlFilter = null;
		this.customerId = customerId;
	}

	public SingleCustomerECRProvider()
	{
		customerId = null;
		sqlFilter = null;
	}

	public MessageBodyReader getMessageBodyReader(Message message)
		throws ECRException
	{
		String where = (new StringBuilder("where CustomerId='")).append(customerId).append("'").toString();
		String where2 = sqlFilter == null ? "" : (new StringBuilder(" and (")).append(sqlFilter).append(")").toString();
		where = (new StringBuilder(String.valueOf(where))).append(where2).toString();
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
			SingleCustomerMBRCapital mbr = new SingleCustomerMBRCapital(message);
			mbr.setRecordSql((new StringBuilder("select * from ECR_CUSTCAPIINFO ")).append(where).toString());
			return mbr;
		}

		case 3: // '\003'
		{
			MBRCustomerFinance mbr = new MBRCustomerFinance(message);
			mbr.setFinanceBSSql((new StringBuilder("select * from ECR_FINANCEBS ")).append(where).toString());
			mbr.setFinancePSSql((new StringBuilder("select * from ECR_FINANCEPS ")).append(where).toString());
			mbr.setFinanceCFSql((new StringBuilder("select * from ECR_FINANCECF ")).append(where).toString());
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
			SingleCustomerMBRLoan mbr = new SingleCustomerMBRLoan(message);
			mbr.setContractTable("ECR_LOANCONTRACT");
			mbr.setSqlFilter(sqlFilter);
			mbr.setCustomerId(customerId);
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
			SingleCustomerMBRTrade mbr = new SingleCustomerMBRTrade(message);
			mbr.setContractTable("ECR_FINAINFO");
			mbr.setSqlFilter(sqlFilter);
			mbr.setCustomerId(customerId);
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
			SingleCustomerMBRGuarantyInfo mbr = new SingleCustomerMBRGuarantyInfo(message);
			mbr.setCustomerId(customerId);
			mbr.setSqlFilter(sqlFilter);
			mbr.setAssureRecordSql("select * from ECR_ASSURECONT ");
			mbr.setGuarantyRecordSql("select * from ECR_GUARANTYCONT ");
			mbr.setImpawnRecordSql("select * from ECR_IMPAWNCONT ");
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

		case 5: // '\005'
		case 6: // '\006'
		case 7: // '\007'
		case 8: // '\b'
		case 9: // '\t'
		case 10: // '\n'
		default:
		{
			return new DummyMessageBodyReader(message);
		}
		}
	}

	public final String getCustomerId()
	{
		return customerId;
	}

	public final void setCustomerId(String customerId)
	{
		this.customerId = customerId;
	}

	public final String getSqlFilter()
	{
		return sqlFilter;
	}

	public final void setSqlFilter(String sqlFilter)
	{
		if (sqlFilter != null && sqlFilter.equals(""))
			sqlFilter = null;
		this.sqlFilter = sqlFilter;
	}
}
