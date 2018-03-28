// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   RecordStub.java

package com.amarsoft.app.datax.ecr.cob;

import com.amarsoft.are.dpx.recordset.Field;
import java.util.ArrayList;

public class RecordStub
{

	private int messagType;
	private int recordType;
	private Field recordKey[];
	private boolean rootRecord;
	private boolean leafRecord;
	private ArrayList children;
	private RecordStub parent;
	private String occurDate;
	private String incrementFlag;
	private String sessionId;
	private String traceNumber;
	private String errorCode;
	private String modFlag;
	private String recordFlag;
	private Field brief[];
	private String recordId;
	private boolean hisrecord;

	public RecordStub()
	{
		recordId = null;
		hisrecord = false;
	}

	public RecordStub[] getChildren()
	{
		if (children == null)
			return null;
		else
			return (RecordStub[])children.toArray(new RecordStub[0]);
	}

	public void addChild(RecordStub child)
	{
		if (children == null)
			children = new ArrayList();
		children.add(child);
	}

	public String getErrorCode()
	{
		return errorCode;
	}

	public void setErrorCode(String errorCode)
	{
		this.errorCode = errorCode;
	}

	public String getIncrementFlag()
	{
		return incrementFlag;
	}

	public void setIncrementFlag(String incrementFlag)
	{
		this.incrementFlag = incrementFlag;
	}

	public boolean isLeafRecord()
	{
		return leafRecord;
	}

	public void setLeafRecord(boolean leafRecord)
	{
		this.leafRecord = leafRecord;
	}

	public int getMessagType()
	{
		return messagType;
	}

	public void setMessagType(int messagType)
	{
		this.messagType = messagType;
	}

	public String getModFlag()
	{
		return modFlag;
	}

	public void setModFlag(String modFlag)
	{
		this.modFlag = modFlag;
	}

	public String getOccurDate()
	{
		return occurDate;
	}

	public void setOccurDate(String occurDate)
	{
		this.occurDate = occurDate;
	}

	public RecordStub getParent()
	{
		return parent;
	}

	public void setParent(RecordStub parent)
	{
		this.parent = parent;
	}

	public String getRecordFlag()
	{
		return recordFlag;
	}

	public void setRecordFlag(String recordFlag)
	{
		this.recordFlag = recordFlag;
	}

	public Field[] getRecordKey()
	{
		return recordKey;
	}

	public void setRecordKey(Field recordkey[])
	{
		recordKey = recordkey;
	}

	public int getRecordType()
	{
		return recordType;
	}

	public void setRecordType(int recordType)
	{
		this.recordType = recordType;
	}

	public boolean isRootRecord()
	{
		return rootRecord;
	}

	public void setRootRecord(boolean rootRecord)
	{
		this.rootRecord = rootRecord;
	}

	public String getSessionId()
	{
		return sessionId;
	}

	public void setSessionId(String sessionId)
	{
		this.sessionId = sessionId;
	}

	public String getTraceNumber()
	{
		return traceNumber;
	}

	public void setTraceNumber(String traceNumber)
	{
		this.traceNumber = traceNumber;
	}

	public Field[] getBrief()
	{
		return brief;
	}

	public void setBrief(Field brief[])
	{
		this.brief = brief;
	}

	public String getRecordId()
	{
		return recordId;
	}

	protected void setRecordId(String recordId)
	{
		this.recordId = recordId;
	}

	public final boolean isHisrecord()
	{
		return hisrecord;
	}

	protected final void setHisrecord(boolean hisrecord)
	{
		this.hisrecord = hisrecord;
	}

	public String toString()
	{
		StringBuffer sb = new StringBuffer();
		Field kf[] = getRecordKey();
		sb.append("SessionId=").append(getSessionId());
		sb.append(",OccurDate=").append(getOccurDate());
		for (int i = 0; i < kf.length; i++)
			sb.append(",").append(kf[i].getName()).append("=").append(kf[i].getString());

		return sb.toString();
	}
}
