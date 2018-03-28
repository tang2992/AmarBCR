// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DeleteBusinessTypeDBReflector.java

package com.amarsoft.app.datax.ecr.common;

import java.util.HashMap;

public class DeleteBusinessTypeDBReflector
{

	private String mainTable;
	private String relativeTables[];
	private String contactNoColumn;
	private String businessType;
	private static HashMap reflectorPool = null;

	private DeleteBusinessTypeDBReflector()
	{
	}

	public static DeleteBusinessTypeDBReflector getReflector(String deleteBusinessType)
	{
		if (reflectorPool == null)
			reflectorPool = new HashMap();
		if (!reflectorPool.containsKey(deleteBusinessType))
		{
			DeleteBusinessTypeDBReflector rf = createReflector(deleteBusinessType);
			reflectorPool.put(deleteBusinessType, rf);
		}
		return (DeleteBusinessTypeDBReflector)reflectorPool.get(deleteBusinessType);
	}

	private static DeleteBusinessTypeDBReflector createReflector(String businessType)
	{
		DeleteBusinessTypeDBReflector rf = new DeleteBusinessTypeDBReflector();
		rf.businessType = businessType;
		if (businessType.equals("01"))
		{
			rf.mainTable = "LOANCONTRACT";
			rf.contactNoColumn = "LContractNo";
			rf.relativeTables = (new String[] {
				"LOANDUEBILL", "LOANEXTENSION", "LOANRETURN"
			});
		} else
		if (businessType.equals("02"))
		{
			rf.mainTable = "FACTORING";
			rf.contactNoColumn = "FactoringNo";
		} else
		if (businessType.equals("03"))
		{
			rf.mainTable = "DISCOUNT";
			rf.contactNoColumn = "BillNo";
		} else
		if (businessType.equals("04"))
		{
			rf.mainTable = "FINAINFO";
			rf.contactNoColumn = "FContractNo";
			rf.relativeTables = (new String[] {
				"FINADUEBILL", "FINAEXTENSION", "FINARETURN"
			});
		} else
		if (businessType.equals("05"))
		{
			rf.mainTable = "CREDITLETTER";
			rf.contactNoColumn = "CreditLetterNo";
		} else
		if (businessType.equals("06"))
		{
			rf.mainTable = "GUARANTEEBILL";
			rf.contactNoColumn = "GuaranteeBillNo";
		} else
		if (businessType.equals("07"))
		{
			rf.mainTable = "ACCEPTANCE";
			rf.contactNoColumn = "AcceptNo";
		} else
		if (businessType.equals("08"))
		{
			rf.mainTable = "CUSTOMERCREDIT";
			rf.contactNoColumn = "CContractNo";
		} else
		if (businessType.equals("09"))
		{
			rf.mainTable = "FLOORFUND";
			rf.contactNoColumn = "FloorFundNo";
		} else
		if (businessType.equals("10"))
		{
			rf.mainTable = "INTERESTDUE";
			rf.contactNoColumn = "LoanCardNo";
		}
		if (rf.relativeTables == null)
			rf.relativeTables = new String[0];
		return rf;
	}

	public String getContactNoColumn()
	{
		return contactNoColumn;
	}

	public String getMainTable()
	{
		return mainTable;
	}

	public String[] getRelativeTables()
	{
		return relativeTables;
	}

	public String getBusinessType()
	{
		return businessType;
	}

}
