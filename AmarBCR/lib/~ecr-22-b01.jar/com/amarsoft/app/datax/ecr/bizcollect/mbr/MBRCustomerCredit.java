// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MBRCustomerCredit.java

package com.amarsoft.app.datax.ecr.bizcollect.mbr;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect.mbr:
//			MBRSingleSql

public class MBRCustomerCredit extends MBRSingleSql
{

	public MBRCustomerCredit(Message message, String database)
	{
		super(message, database);
	}

	public MBRCustomerCredit(Message message)
	{
		super(message);
	}

	protected void fillSegmentB(Segment segB, ResultSet rs)
		throws ECRException, SQLException
	{
		segB.getField(7593).setString(rs.getString("CContractNo"));
	}

	protected void fillSegmentD(Segment segD, ResultSet rs)
		throws ECRException, SQLException
	{
		segD.getField(5559).setString(rs.getString("CustomerName"));
		segD.getField(7503).setString(rs.getString("LoanCardNo"));
		segD.getField(1501).setString(rs.getString("Currency"));
		segD.getField(1545).setDouble(rs.getDouble("CreditLimit"));
		segD.getField(2559).setDate(rs.getString("CreditStartDate"));
		segD.getField(2561).setDate(rs.getString("CreditEndDate"));
		segD.getField(2563).setDate(rs.getString("CreditLogoutDate"));
		segD.getField(8511).setString(rs.getString("CreditLogoutCause"));
	}
}
