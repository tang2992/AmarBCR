// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FIDChangeHandler.java

package com.amarsoft.app.datax.ecr.prepare.dataimport;

import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.dpx.recordset.Record;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.metadata.ColumnMetaData;

// Referenced classes of package com.amarsoft.app.datax.ecr.prepare.dataimport:
//			ECRUpdateHandler

public class FIDChangeHandler extends ECRUpdateHandler
{

	private int bakLengthLimit;

	public FIDChangeHandler()
	{
		bakLengthLimit = -1;
	}

	public boolean match(Record curRec, Record dbRec)
	{
		Field dbFid = null;
		Field curFid = null;
		Field dbBakFid = null;
		Field curBakFid = null;
		Field incr = null;
		curFid = curRec.getField("FinanceID");
		curBakFid = curRec.getField("OldFinanceID");
		dbFid = dbRec.getField("FinanceID");
		dbBakFid = dbRec.getField("OldFinanceID");
		incr = dbRec.getField("IncrementFlag");
		if (curFid == null || curBakFid == null || incr.isNull())
			return super.match(curRec, dbRec);
		curBakFid.setValue(dbBakFid);
		if (!incr.getString().equals("8"))
		{
			if (isCycleChange(curFid.getString(), curBakFid.getString()))
			{
				logger.warn((new StringBuilder("金融机构代码变更失败[")).append(dbFid.getString()).append("-->").append(curFid.getString()).append("]，不能进行循环变更！").toString());
				curFid.setValue(dbFid);
			}
			return super.match(curRec, dbRec);
		}
		if (curFid.compareTo(dbFid) != 0)
		{
			if (isCycleChange(curFid.getString(), curBakFid.getString()))
			{
				logger.warn((new StringBuilder("金融机构代码变更失败[")).append(dbFid.getString()).append("-->").append(curFid.getString()).append("]，不能进行循环变更！").toString());
				curFid.setValue(dbFid);
			} else
			{
				appendBakupField(curBakFid, dbFid.getString());
			}
		} else
		{
			String bf = curBakFid.getString();
			String nf = curFid.getString();
			if (bf != null && !bf.endsWith(nf))
			{
				appendBakupField(curBakFid, nf);
				dbBakFid.setValue(curBakFid);
			}
		}
		return super.match(curRec, dbRec);
	}

	private void appendBakupField(Field f, String appendFid)
	{
		if (bakLengthLimit == -1)
			bakLengthLimit = f.getMetaData().getDisplaySize();
		String ofid;
		for (ofid = f.getString(); !f.isNull() && ofid.length() + appendFid.length() + 1 > bakLengthLimit;)
		{
			int i = ofid.indexOf('#');
			if (i > 0 && i < ofid.length())
				ofid = ofid.substring(i + 1);
			else
				f.setNull();
		}

		if (f.isNull())
			f.setValue(appendFid);
		else
			f.setValue((new StringBuilder(String.valueOf(ofid))).append("#").append(appendFid).toString());
	}

	protected boolean isCycleChange(String newFid, String backFid)
	{
		if (newFid == null || backFid == null)
			return false;
		return backFid.indexOf(newFid) >= 0;
	}
}
