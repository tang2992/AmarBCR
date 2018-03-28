// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRBillDiscount.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect.mbr:
//			MBRSingleSql

public class MBRBillDiscount extends MBRSingleSql
{

	public MBRBillDiscount(Message message, String database)
	{
		super(message, database);
	}

	public MBRBillDiscount(Message message)
	{
		super(message);
	}

	protected void fillSegmentB(Segment segB, ResultSet rs)
		throws ECRException, SQLException
	{
		segB.getField(7553).setString(rs.getString("BillNo"));
	}

	protected void fillSegmentD(Segment segD, ResultSet rs)
		throws ECRException, SQLException
	{
		segD.getField(7555).setString(rs.getString("BillType"));
		segD.getField(5561).setString(rs.getString("CustomerName"));
		segD.getField(7503).setString(rs.getString("LoanCardNo"));
		segD.getField(5563).setString(rs.getString("AccepterName"));
		segD.getField(9997).setString(rs.getString("ALoanCardNo"));
		segD.getField(6511).setString("");
		segD.getField(1501).setString(rs.getString("Currency"));
		segD.getField(1523).setDouble(rs.getDouble("DiscountSum"));
		segD.getField(2529).setDate(rs.getString("DiscountDate"));
		segD.getField(2531).setDate(rs.getString("AcceptMaturity"));
		segD.getField(1525).setDouble(rs.getDouble("BillSum"));
		segD.getField(7561).setString(rs.getString("BillStatus"));
		segD.getField(7539).setString(rs.getString("Classify4"));
		segD.getField(7541).setString(rs.getString("Classify5"));
	}
}
