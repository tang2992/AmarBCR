// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRLackOfInterest.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect.mbr:
//			MBRSingleSql

public class MBRLackOfInterest extends MBRSingleSql
{

	public MBRLackOfInterest(Message message, String database)
	{
		super(message, database);
	}

	public MBRLackOfInterest(Message message)
	{
		super(message);
	}

	protected void fillSegmentB(Segment segB, ResultSet rs)
		throws ECRException, SQLException
	{
		segB.getField(7503).setString(rs.getString("LoanCardNo"));
	}

	protected void fillSegmentD(Segment segD, ResultSet rs)
		throws ECRException, SQLException
	{
		segD.getField(1501).setString(rs.getString("Currency"));
		segD.getField(1563).setDouble(rs.getDouble("InterestBalance"));
		segD.getField(7631).setString(rs.getString("InterestType"));
		segD.getField(2573).setDate(rs.getString("ChangeDate"));
	}
}
