// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   LoanBusinessTypeDBReflector.java

package com.amarsoft.app.datax.ecr.common;

import java.util.HashMap;

public class LoanBusinessTypeDBReflector
{

	private String mainTable;
	private String relativeTables[];
	private String contactNoColumn;
	private String businessType;
	private static HashMap reflectorPool = null;

	private LoanBusinessTypeDBReflector()
	{
	}

	public static LoanBusinessTypeDBReflector getReflector(String loanBusinessType)
	{
		if (reflectorPool == null)
			reflectorPool = new HashMap();
		if (!reflectorPool.containsKey(loanBusinessType))
		{
			LoanBusinessTypeDBReflector rf = createReflector(loanBusinessType);
			reflectorPool.put(loanBusinessType, rf);
		}
		return (LoanBusinessTypeDBReflector)reflectorPool.get(loanBusinessType);
	}

	private static LoanBusinessTypeDBReflector createReflector(String businessType)
	{
		LoanBusinessTypeDBReflector rf = new LoanBusinessTypeDBReflector();
		rf.businessType = businessType;
		if (businessType.equals("1"))
		{
			rf.mainTable = "LOANCONTRACT";
			rf.contactNoColumn = "LContractNo";
			rf.relativeTables = (new String[] {
				"LOANDUEBILL", "LOANEXTENSION", "LOANRETURN"
			});
		} else
		if (businessType.equals("2"))
		{
			rf.mainTable = "FACTORING";
			rf.contactNoColumn = "FactoringNo";
		} else
		if (businessType.equals("3"))
		{
			rf.mainTable = "DISCOUNT";
			rf.contactNoColumn = "BillNo";
		} else
		if (businessType.equals("4"))
		{
			rf.mainTable = "FINAINFO";
			rf.contactNoColumn = "FContractNo";
			rf.relativeTables = (new String[] {
				"FINADUEBILL", "FINAEXTENSION", "FINARETURN"
			});
		} else
		if (businessType.equals("5"))
		{
			rf.mainTable = "CREDITLETTER";
			rf.contactNoColumn = "CreditLetterNo";
		} else
		if (businessType.equals("6"))
		{
			rf.mainTable = "GUARANTEEBILL";
			rf.contactNoColumn = "GuaranteeBillNo";
		} else
		if (businessType.equals("7"))
		{
			rf.mainTable = "ACCEPTANCE";
			rf.contactNoColumn = "AContractNo";
		} else
		if (businessType.equals("8"))
		{
			rf.mainTable = "CUSTOMERCREDIT";
			rf.contactNoColumn = "CContractNo";
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
