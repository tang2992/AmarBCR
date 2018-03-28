// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRGuaranteeBill.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect.mbr:
//			MBRSingleSql

public class MBRGuaranteeBill extends MBRSingleSql
{

	public MBRGuaranteeBill(Message message, String database)
	{
		super(message, database);
	}

	public MBRGuaranteeBill(Message message)
	{
		super(message);
	}

	protected void fillSegmentB(Segment segB, ResultSet rs)
		throws ECRException, SQLException
	{
		segB.getField(7579).setString(rs.getString("GuaranteeBillNo"));
	}

	protected void fillSegmentD(Segment segD, ResultSet rs)
		throws ECRException, SQLException
	{
		segD.getField(5559).setString(rs.getString("CustomerName"));
		segD.getField(7503).setString(rs.getString("LoanCardNo"));
		segD.getField(7581).setString(rs.getString("GuaranteeType"));
		segD.getField(7583).setString(rs.getString("GuaranteeStatus"));
		segD.getField(1501).setString(rs.getString("Currency"));
		segD.getField(1539).setDouble(rs.getDouble("GuaranteeSum"));
		segD.getField(2547).setDate(rs.getString("CreateDate"));
		segD.getField(2549).setDate(rs.getString("EndDate"));
		segD.getField(4511).setInt(rs.getInt("DepositScale"));
		segD.getField(7523).setString(rs.getString("GuarantyFlag"));
		segD.getField(7513).setString(rs.getString("FloorFlag"));
		segD.getField(1541).setDouble(rs.getDouble("Balance"));
		segD.getField(2551).setDate(rs.getString("BalanceOccurDate"));
		segD.getField(7541).setString(rs.getString("Classify5"));
	}
}
