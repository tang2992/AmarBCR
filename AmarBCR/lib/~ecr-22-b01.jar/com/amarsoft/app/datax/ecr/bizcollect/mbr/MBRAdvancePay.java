// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRAdvancePay.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect.mbr:
//			MBRSingleSql

public class MBRAdvancePay extends MBRSingleSql
{

	public MBRAdvancePay(Message message, String database)
	{
		super(message, database);
	}

	public MBRAdvancePay(Message message)
	{
		super(message);
	}

	protected void fillSegmentB(Segment segB, ResultSet rs)
		throws ECRException, SQLException
	{
		segB.getField(7623).setString(rs.getString("FloorFundNo"));
	}

	protected void fillSegmentD(Segment segD, ResultSet rs)
		throws ECRException, SQLException
	{
		segD.getField(5559).setString(rs.getString("CustomerName"));
		segD.getField(7503).setString(rs.getString("loanCardNo"));
		segD.getField(7625).setString(rs.getString("FloorType"));
		segD.getField(7627).setString(rs.getString("BusinessNo"));
		segD.getField(1501).setString(rs.getString("Currency"));
		segD.getField(1559).setDouble(rs.getDouble("FloorSum"));
		segD.getField(2571).setDate(rs.getString("FloorDate"));
		segD.getField(1561).setDouble(rs.getDouble("FloorBalance"));
		segD.getField(2551).setDate(rs.getString("BalanceOccurDate"));
		segD.getField(7545).setString(rs.getString("ReturnMode"));
		segD.getField(7539).setString(rs.getString("Classify4"));
		segD.getField(7541).setString(rs.getString("Classify5"));
	}
}
