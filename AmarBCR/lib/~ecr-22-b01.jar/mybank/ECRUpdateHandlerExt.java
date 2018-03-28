// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ECRUpdateHandlerExt.java

package mybank;

import com.amarsoft.app.datax.ecr.prepare.dataimport.ECRUpdateHandler;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.dpx.recordset.Record;

public class ECRUpdateHandlerExt extends ECRUpdateHandler
{

	public ECRUpdateHandlerExt()
	{
	}

	public boolean match(Record curRecord, Record dbRecord)
	{
		Field curf = curRecord.getField("CustomerType");
		Field dbf = dbRecord.getField("CustomerType");
		if (dbf.getString() != null && !curf.getString().equals(dbf.getString()))
			curf.setValue("3");
		return super.match(curRecord, dbRecord);
	}
}
