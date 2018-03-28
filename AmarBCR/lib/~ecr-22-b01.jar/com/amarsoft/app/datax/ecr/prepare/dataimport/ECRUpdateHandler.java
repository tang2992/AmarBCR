// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ECRUpdateHandler.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.*;
import java.sql.SQLException;

public class ECRUpdateHandler extends UpdateDBHandler
{

	private String oldIncrementFlag;
	private String occurDate;
	private String sessionid;
	private double curBalance;
	private double dbBalance;

	protected void insertRecord(Record arg0)
		throws SQLException
	{
		setIncrementFlag(arg0, "1");
		Field f = arg0.getField("OCCURDATE");
		if (f != null)
			f.setValue(occurDate);
		super.insertRecord(arg0);
	}

	protected void updateRecord(Record arg0)
		throws SQLException
	{
		if (oldIncrementFlag.equals("8"))
			setIncrementFlag(arg0, "2");
		else
			setIncrementFlag(arg0, oldIncrementFlag);
		setOccurDate(arg0, oldIncrementFlag);
		super.updateRecord(arg0);
	}

	private void setOccurDate(Record curRecord, String flag)
	{
		Field f = curRecord.getField("OCCURDATE");
		if (!flag.equals("1") && !flag.equals("2"))
			f.setValue(occurDate);
	}

	private void setIncrementFlag(Record curRecord, String flag)
	{
		Field f = curRecord.getField("IncrementFlag");
		if (f != null)
			f.setValue(flag);
		f = curRecord.getField("SESSIONID");
		if (f != null)
			f.setValue(sessionid);
	}

	public boolean match(Record curRec, Record dbRec)
	{
		Field dbf = null;
		Field curf = null;
		curf = curRec.getField("OccurDate");
		dbf = dbRec.getField("OccurDate");
		if (curf != null)
		{
			if (curf.getString() != null && curf.getString().compareTo(dbf.getString()) >= 0)
				occurDate = curf.getString();
			curf.setValue(dbf);
		}
		curf = curRec.getField("IncrementFlag");
		dbf = dbRec.getField("IncrementFlag");
		if (curf != null)
		{
			oldIncrementFlag = dbf.getString();
			if (oldIncrementFlag == null)
				oldIncrementFlag = "2";
			if (oldIncrementFlag.equals("6"))
				return true;
			curf.setNull();
			dbf.setNull();
		}
		curf = curRec.getField("LoanCardNo");
		dbf = dbRec.getField("LoanCardNo");
		if (curf != null && !"ECR_ORGANINFO".equalsIgnoreCase(getTable()))
			curf.setValue(dbf);
		curf = curRec.getField("RECORDFLAG");
		if (curf != null && curf.getString() != null)
		{
			if (curf.getString().equals("ECR_FACTORING"))
			{
				curBalance = curRec.getField("BALANCE").getDouble();
				dbBalance = dbRec.getField("BALANCE").getDouble();
				if (Math.abs(curBalance - dbBalance) <= getNumberMatchTolerance())
					curRec.getField("BALANCECHANGEDATE").setValue(dbRec.getField("BALANCECHANGEDATE"));
			}
			if (curf.getString().equals("ECR_CREDITLETTER"))
			{
				curBalance = curRec.getField("BALANCE").getDouble();
				dbBalance = dbRec.getField("BALANCE").getDouble();
				if (Math.abs(curBalance - dbBalance) <= getNumberMatchTolerance())
					curRec.getField("BALANCEREPORTDATE").setValue(dbRec.getField("BALANCEREPORTDATE"));
			}
			if (curf.getString().equals("ECR_GUARANTEEBILL"))
			{
				curBalance = curRec.getField("BALANCE").getDouble();
				dbBalance = dbRec.getField("BALANCE").getDouble();
				if (Math.abs(curBalance - dbBalance) <= getNumberMatchTolerance())
					curRec.getField("BALANCEOCCURDATE").setValue(dbRec.getField("BALANCEOCCURDATE"));
			}
			if (curf.getString().equals("ECR_FLOORFUND"))
			{
				curBalance = curRec.getField("FLOORBALANCE").getDouble();
				dbBalance = dbRec.getField("FLOORBALANCE").getDouble();
				if (Math.abs(curBalance - dbBalance) <= getNumberMatchTolerance())
					curRec.getField("BALANCEOCCURDATE").setValue(dbRec.getField("BALANCEOCCURDATE"));
			}
		}
		curRec.getField("RECORDFLAG").setNull();
		return super.match(curRec, dbRec);
	}

	public ECRUpdateHandler()
	{
		oldIncrementFlag = null;
		occurDate = ARE.getProperty("businessOccurDate");
		sessionid = "0000000000";
		curBalance = 0.0D;
		dbBalance = 0.0D;
		setDatabase("ecr");
	}
}
