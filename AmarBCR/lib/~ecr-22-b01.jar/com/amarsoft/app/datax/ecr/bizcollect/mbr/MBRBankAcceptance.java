// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRBankAcceptance.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect.mbr:
//			MBRSingleSql

public class MBRBankAcceptance extends MBRSingleSql
{

	public MBRBankAcceptance(Message message, String database)
	{
		super(message, database);
	}

	public MBRBankAcceptance(Message message)
	{
		super(message);
	}

	protected void fillSegmentB(Segment segB, ResultSet rs)
		throws ECRException, SQLException
	{
		segB.getField(7585).setString(rs.getString("AContractNo"));
		segB.getField(7587).setString(rs.getString("AcceptNo"));
		segB.getField(7519).setString(rs.getString("CreditNo"));
	}

	protected void fillSegmentD(Segment segD, ResultSet rs)
		throws ECRException, SQLException
	{
		segD.getField(5565).setString(rs.getString("CustomerName"));
		segD.getField(7503).setString(rs.getString("LoanCardNo"));
		segD.getField(1501).setString(rs.getString("Currency"));
		segD.getField(1543).setDouble(rs.getDouble("AccepSum"));
		segD.getField(2553).setDate(rs.getString("AccepDate"));
		segD.getField(2555).setDate(rs.getString("AccepEndDate"));
		segD.getField(2557).setDate(rs.getString("AccepPayDate"));
		segD.getField(4511).setInt(rs.getInt("AssureScale"));
		segD.getField(7523).setString(rs.getString("GuarantyFlag"));
		segD.getField(7513).setString(rs.getString("FloorFlag"));
		segD.getField(7591).setString(rs.getString("DraftStatus"));
		segD.getField(7541).setString(rs.getString("Classify5"));
	}
}
