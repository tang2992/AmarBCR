// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   CustomerRecords.java

package com.amarsoft.app.datax.ecr.cob;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.MessageSet;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.util.ArrayList;

// Referenced classes of package com.amarsoft.app.datax.ecr.cob:
//			RecordStub, SingleCustomerECRProvider, RecordStubHandler, RecordStubFilter, 
//			SingleCustomerHISProvider

public class CustomerRecords
{

	private String customerId;
	private String customerName;
	private String loanCardNo;
	private String foreignName;
	private String database;
	private ArrayList currentRecord;
	private ArrayList historyRecord;

	public CustomerRecords(String customerId)
	{
		database = "ecr";
		this.customerId = customerId;
		currentRecord = new ArrayList();
		historyRecord = new ArrayList();
	}

	public CustomerRecords()
	{
		database = "ecr";
		currentRecord = new ArrayList();
		historyRecord = new ArrayList();
	}

	public ArrayList getAllCurrentRecords()
	{
		return currentRecord;
	}

	public ArrayList getCurrentRecords(int recordType)
	{
		ArrayList al = new ArrayList();
		for (int i = 0; i < currentRecord.size(); i++)
		{
			RecordStub r = (RecordStub)currentRecord.get(i);
			if (r.getRecordType() == recordType)
				al.add(r);
		}

		return al;
	}

	public ArrayList getCurrentRecordsByMessage(int messageType)
	{
		ArrayList al = new ArrayList();
		for (int i = 0; i < currentRecord.size(); i++)
		{
			RecordStub r = (RecordStub)currentRecord.get(i);
			if (r.getMessagType() == messageType)
				al.add(r);
		}

		return al;
	}

	public ArrayList getAllHistoryRecords()
	{
		return historyRecord;
	}

	public ArrayList getHistoryRecords(int recordType)
	{
		ArrayList al = new ArrayList();
		for (int i = 0; i < historyRecord.size(); i++)
		{
			RecordStub r = (RecordStub)historyRecord.get(i);
			if (r.getRecordType() == recordType)
				al.add(r);
		}

		return al;
	}

	public ArrayList getHistoryRecordsByMessage(int messageType)
	{
		ArrayList al = new ArrayList();
		for (int i = 0; i < historyRecord.size(); i++)
		{
			RecordStub r = (RecordStub)historyRecord.get(i);
			if (r.getMessagType() == messageType)
				al.add(r);
		}

		return al;
	}

	public RecordStub getRecord(String id)
	{
		if (id == null || id.length() < 2)
			return null;
		char c = id.charAt(0);
		if (c != 'C' && c != 'H')
			return null;
		int x = -1;
		try
		{
			x = Integer.parseInt(id.substring(1));
		}
		catch (Exception ex)
		{
			ARE.getLog().debug(ex);
			return null;
		}
		if (x < 0)
			return null;
		RecordStub r = null;
		if (c == 'C' && x < currentRecord.size())
			r = (RecordStub)currentRecord.get(x);
		else
		if (c == 'H' && x < historyRecord.size())
			r = (RecordStub)historyRecord.get(x);
		return r;
	}

	public void loadCurrentRecord(RecordStubFilter filter)
		throws ECRException
	{
		currentRecord.clear();
		String ecrHome = ARE.getProperty("ECR_HOME", "./");
		SingleCustomerECRProvider provider = new SingleCustomerECRProvider();
		RecordStubHandler handler = new RecordStubHandler();
		provider.setCustomerId(customerId);
		handler.setDatabase(database);
		handler.setEcrRecord(true);
		handler.setFilter(filter);
		MessageSet messageSet = MessageSet.createMessageSetFromXml((new StringBuilder(String.valueOf(ecrHome))).append("/etc/ecr_message_customerinfo.xml").toString());
		messageSet.setHandler(handler);
		messageSet.parse(provider);
		currentRecord.addAll(handler.getRecordBuffer());
		messageSet = MessageSet.createMessageSetFromXml((new StringBuilder(String.valueOf(ecrHome))).append("/etc/ecr_message_businessinfo.xml").toString());
		messageSet.setHandler(handler);
		messageSet.parse(provider);
		currentRecord.addAll(handler.getRecordBuffer());
		for (int i = 0; i < currentRecord.size(); i++)
		{
			RecordStub rs = (RecordStub)currentRecord.get(i);
			rs.setHisrecord(false);
			rs.setRecordId((new StringBuilder("C")).append(i).toString());
		}

	}

	public void loadCurrentRecord(String sqlFilter)
		throws ECRException
	{
		currentRecord.clear();
		String ecrHome = ARE.getProperty("ECR_HOME", "./");
		SingleCustomerECRProvider provider = new SingleCustomerECRProvider();
		provider.setSqlFilter(sqlFilter);
		RecordStubHandler handler = new RecordStubHandler();
		provider.setCustomerId(customerId);
		handler.setDatabase(database);
		handler.setEcrRecord(true);
		MessageSet messageSet = MessageSet.createMessageSetFromXml((new StringBuilder(String.valueOf(ecrHome))).append("/etc/ecr_message_customerinfo.xml").toString());
		messageSet.setHandler(handler);
		messageSet.parse(provider);
		currentRecord.addAll(handler.getRecordBuffer());
		messageSet = MessageSet.createMessageSetFromXml((new StringBuilder(String.valueOf(ecrHome))).append("/etc/ecr_message_businessinfo.xml").toString());
		messageSet.setHandler(handler);
		messageSet.parse(provider);
		currentRecord.addAll(handler.getRecordBuffer());
		for (int i = 0; i < currentRecord.size(); i++)
		{
			RecordStub rs = (RecordStub)currentRecord.get(i);
			rs.setHisrecord(false);
			rs.setRecordId((new StringBuilder("C")).append(i).toString());
		}

	}

	public void loadCurrentRecord()
		throws ECRException
	{
		loadCurrentRecord(((String) (null)));
	}

	public void loadHistoryRecord(RecordStubFilter filter)
		throws ECRException
	{
		historyRecord.clear();
		String ecrHome = ARE.getProperty("ECR_HOME", "./");
		SingleCustomerHISProvider provider = new SingleCustomerHISProvider();
		RecordStubHandler handler = new RecordStubHandler();
		provider.setCustomerId(customerId);
		handler.setDatabase(database);
		handler.setEcrRecord(false);
		handler.setFilter(filter);
		MessageSet messageSet = MessageSet.createMessageSetFromXml((new StringBuilder(String.valueOf(ecrHome))).append("/etc/ecr_message_customerinfo.xml").toString());
		messageSet.setHandler(handler);
		messageSet.parse(provider);
		historyRecord.addAll(handler.getRecordBuffer());
		messageSet = MessageSet.createMessageSetFromXml((new StringBuilder(String.valueOf(ecrHome))).append("/etc/ecr_message_businessinfo.xml").toString());
		messageSet.setHandler(handler);
		messageSet.parse(provider);
		historyRecord.addAll(handler.getRecordBuffer());
		for (int i = 0; i < historyRecord.size(); i++)
		{
			RecordStub rs = (RecordStub)historyRecord.get(i);
			rs.setHisrecord(false);
			rs.setRecordId((new StringBuilder("H")).append(i).toString());
		}

	}

	public void loadHistoryRecord(String sqlFilter)
		throws ECRException
	{
		historyRecord.clear();
		String ecrHome = ARE.getProperty("ECR_HOME", "./");
		SingleCustomerHISProvider provider = new SingleCustomerHISProvider();
		RecordStubHandler handler = new RecordStubHandler();
		provider.setCustomerId(customerId);
		provider.setSqlFilter(sqlFilter);
		handler.setDatabase(database);
		handler.setEcrRecord(false);
		MessageSet messageSet = MessageSet.createMessageSetFromXml((new StringBuilder(String.valueOf(ecrHome))).append("/etc/ecr_message_customerinfo.xml").toString());
		messageSet.setHandler(handler);
		messageSet.parse(provider);
		historyRecord.addAll(handler.getRecordBuffer());
		messageSet = MessageSet.createMessageSetFromXml((new StringBuilder(String.valueOf(ecrHome))).append("/etc/ecr_message_businessinfo.xml").toString());
		messageSet.setHandler(handler);
		messageSet.parse(provider);
		historyRecord.addAll(handler.getRecordBuffer());
		for (int i = 0; i < historyRecord.size(); i++)
		{
			RecordStub rs = (RecordStub)historyRecord.get(i);
			rs.setHisrecord(false);
			rs.setRecordId((new StringBuilder("H")).append(i).toString());
		}

	}

	public void loadHistoryRecord()
		throws ECRException
	{
		loadHistoryRecord(((String) (null)));
	}

	public String getCustomerId()
	{
		return customerId;
	}

	public void setCustomerId(String customerId)
	{
		this.customerId = customerId;
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}

	public String getCustomerName()
	{
		return customerName;
	}

	public String getForeignName()
	{
		return foreignName;
	}

	public String getLoanCardNo()
	{
		return loanCardNo;
	}
}
