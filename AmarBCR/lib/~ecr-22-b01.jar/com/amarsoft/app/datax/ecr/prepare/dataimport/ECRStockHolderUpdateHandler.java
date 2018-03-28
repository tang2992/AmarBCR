// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ECRStockHolderUpdateHandler.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.*;
import com.amarsoft.are.lang.StringX;
import java.sql.SQLException;
import java.util.Random;

public class ECRStockHolderUpdateHandler extends UpdateDBHandler
{

	public static final String ORGANDIGEST = (new StringBuilder(String.valueOf(System.currentTimeMillis()))).append((new Random()).nextInt(100)).toString();
	private String occurDate;
	private String updateDate;
	private String sessionid;

	protected void insertRecord(Record arg0)
		throws SQLException
	{
		setIncrementFlag(arg0, "1");
		Field f = arg0.getField("OCCURDATE");
		if (f != null)
			f.setValue(occurDate);
		Field digest = arg0.getField("OrganDigest");
		if (digest != null)
			digest.setValue(ARE.getProperty("ORGANDIGEST"));
		super.insertRecord(arg0);
	}

	protected void updateRecord(Record arg0)
		throws SQLException
	{
		Field digest = arg0.getField("OrganDigest");
		if (digest != null)
			if (!StringX.isEmpty(digest))
			{
				if (arg0.getField("IncrementFlag").getValue().equals("1") || arg0.getField("IncrementFlag").getValue().equals("2"))
					setIncrementFlag(arg0, "2");
				setOccurDate(arg0, arg0.getField("IncrementFlag").getString());
				arg0.getField("UpdateDate").setValue(updateDate);
			} else
			{
				digest.setValue(ARE.getProperty("ORGANDIGEST"));
			}
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
		curf.setValue(dbf.getValue());
		curf = curRec.getField("UpdateDate");
		dbf = dbRec.getField("UpdateDate");
		if (curf != null)
		{
			updateDate = curf.getString();
			curf.setValue(dbf);
		}
		curf = curRec.getField("RECORDFLAG");
		curRec.getField("RECORDFLAG").setNull();
		Field digest = dbRec.getField("OrganDigest");
		Field curdigest = curRec.getField("OrganDigest");
		digest.setValue(ARE.getProperty("ORGANDIGEST"));
		curdigest.setValue(ARE.getProperty("ORGANDIGEST"));
		if (super.match(curRec, dbRec))
		{
			curRec.getField("OrganDigest").setValue("");
			return false;
		} else
		{
			curRec.getField("IncrementFlag").setValue("2");
			return false;
		}
	}

	public ECRStockHolderUpdateHandler()
	{
		occurDate = ARE.getProperty("businessOccurDate");
		updateDate = null;
		sessionid = "0000000000";
		setDatabase("ecr");
	}

}
