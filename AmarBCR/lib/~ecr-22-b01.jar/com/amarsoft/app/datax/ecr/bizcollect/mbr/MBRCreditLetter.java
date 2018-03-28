// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRCreditLetter.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect.mbr:
//			MBRSingleSql

public class MBRCreditLetter extends MBRSingleSql
{

	public MBRCreditLetter(Message message, String database)
	{
		super(message, database);
	}

	public MBRCreditLetter(Message message)
	{
		super(message);
	}

	protected void fillSegmentB(Segment segB, ResultSet rs)
		throws ECRException, SQLException
	{
		segB.getField(7577).setString(rs.getString("CreditLetterNo"));
	}

	protected void fillSegmentD(Segment segD, ResultSet rs)
		throws ECRException, SQLException
	{
		segD.getField(5559).setString(rs.getString("CustomerName"));
		segD.getField(7503).setString(rs.getString("LoanCardNo"));
		segD.getField(1501).setString(rs.getString("Currency"));
		segD.getField(1535).setDouble(rs.getDouble("CreateSum"));
		segD.getField(2541).setDate(rs.getString("CreateDate"));
		segD.getField(2583).setDate(rs.getString("AvailabTerm"));
		segD.getField(2579).setString(rs.getString("PayTerm"));
		segD.getField(4511).setInt(rs.getInt("DepositScale"));
		segD.getField(7523).setString(rs.getString("GuarantyFlag"));
		segD.getField(7513).setString(rs.getString("FloorFlag"));
		segD.getField(7501).setString(rs.getString("CreditStatus"));
		segD.getField(2581).setDate(rs.getString("LogoutDate"));
		segD.getField(1537).setNumber(rs.getString("Balance"));
		segD.getField(2545).setDate(rs.getString("BalanceReportDate"));
		segD.getField(7541).setString(rs.getString("Classify5"));
	}
}
