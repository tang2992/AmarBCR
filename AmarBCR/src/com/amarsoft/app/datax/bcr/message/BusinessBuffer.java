package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;
import java.util.*;

public class BusinessBuffer
	implements Handler
{

	private SortedMap bizBuffer;

	public BusinessBuffer()
	{
		bizBuffer = new TreeMap();
	}

	public void messageStart(Message message1)
		throws BCRException
	{
	}

	public void handleHeader(Message message1, Record record)
		throws BCRException
	{
	}

	public void handleRecord(Message message, Record record)
		throws BCRException
	{
		String mainBizNo = record.getMainBusinessNo();
		Vector rv = (Vector)bizBuffer.get(mainBizNo);
		if (rv == null)
		{
			rv = new Vector();
			bizBuffer.put(mainBizNo, rv);
		}
		try
		{
			Record r = (Record)record.clone();
			rv.add(r);
		}
		catch (CloneNotSupportedException e)
		{
			throw new BCRException(mainBizNo, e);
		}
	}

	public void handleFooter(Message message1, Record record)
		throws BCRException
	{
	}

	public void messageEnd(Message message1)
		throws BCRException
	{
	}

	public void start(MessageSet messageset)
		throws BCRException
	{
	}

	public void end(MessageSet messageset)
		throws BCRException
	{
	}

	public String[] getAllBusiness()
	{
		return (String[])bizBuffer.keySet().toArray(new String[0]);
	}

	public Record[] getAllRecords()
	{
		Vector v = new Vector();
		Vector v0;
		for (Iterator it = bizBuffer.values().iterator(); it.hasNext(); v.addAll(v0))
			v0 = (Vector)it.next();

		return (Record[])v.toArray(new Record[0]);
	}

	public Record[] getRecord(String bizNo)
	{
		Vector v = (Vector)bizBuffer.get(bizNo);
		Record r[] = new Record[0];
		if (v == null)
			return r;
		else
			return (Record[])v.toArray(r);
	}

	public int getBusinessCount()
	{
		return bizBuffer.size();
	}
}
