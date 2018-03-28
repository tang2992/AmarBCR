// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRFactoring.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect.mbr:
//			MBRSingleSql

public class MBRFactoring extends MBRSingleSql
{

	public MBRFactoring(Message message, String database)
	{
		super(message, database);
	}

	public MBRFactoring(Message message)
	{
		super(message);
	}

	protected void fillSegmentB(Segment segB, ResultSet rs)
		throws ECRException, SQLException
	{
		segB.getField(7547).setString(rs.getString("FactoringNo"));
	}

	protected void fillSegmentD(Segment segD, ResultSet rs)
		throws ECRException, SQLException
	{
		segD.getField(7549).setString(rs.getString("FactoringType"));
		segD.getField(7551).setString(rs.getString("FactoringStatus"));
		segD.getField(5559).setString(rs.getString("CustomerName"));
		segD.getField(7503).setString(rs.getString("LoanCardNo"));
		segD.getField(1501).setString(rs.getString("Currency"));
		segD.getField(1519).setDouble(rs.getDouble("BusinessSum"));
		segD.getField(2525).setDate(rs.getString("BusinessDate"));
		segD.getField(1521).setDouble(rs.getDouble("Balance"));
		segD.getField(2527).setDate(rs.getString("BalanceChangeDate"));
		segD.getField(7523).setString(rs.getString("GuarantyFlag"));
		segD.getField(7513).setString(rs.getString("FloorFlag"));
		segD.getField(7539).setString(rs.getString("Classify4"));
		segD.getField(7541).setString(rs.getString("Classify5"));
	}
}
