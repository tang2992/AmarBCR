// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ValidateHandler.java

package com.amarsoft.app.datax.ecr.bizcollect;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.app.datax.ecr.validate.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.xml.Document;
import com.amarsoft.are.util.xml.Element;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

public class ValidateHandler
	implements Handler
{

	private String database;
	private String rulesFile;
	private int totalRecordNumber;
	private int correctRecordNumber;
	private int errorRecordNumber;
	private int errorRelativedRecordNumber;
	private Log logger;
	private Connection connection;
	private ValidateRule checkRules[];
	private ErrorRecord errorRecord;
	private Set errorBusiness;

	public ValidateHandler()
	{
		database = "ecr";
		rulesFile = null;
		totalRecordNumber = 0;
		correctRecordNumber = 0;
		errorRecordNumber = 0;
		errorRelativedRecordNumber = 0;
		logger = null;
		connection = null;
		errorRecord = null;
		errorBusiness = null;
	}

	public final String getDatabase()
	{
		return database;
	}

	public final void setDatabase(String database)
	{
		this.database = database;
	}

	public final int getCorrectRecordNumber()
	{
		return correctRecordNumber;
	}

	public final int getErrorRecordNumber()
	{
		return errorRecordNumber;
	}

	public final int getTotalRecordNumber()
	{
		return totalRecordNumber;
	}

	public void messageStart(Message message)
		throws ECRException
	{
		if (errorRecord == null)
		{
			errorRecord = new DBErrorRecord();
			errorRecord.open();
		}
		errorRecord.clearMessageError(message.getType());
	}

	public void handleHeader(Message message1, Record record)
		throws ECRException
	{
	}

	public void handleRecord(Message message, Record record)
		throws ECRException
	{
		if (record == null || record.getId().equalsIgnoreCase("header") || record.getId().equalsIgnoreCase("tail"))
			return;
		totalRecordNumber++;
		String err = validate(message, record);
		String mainBusinessNo = record.getMainBusinessNo();
		if (err != null)
		{
			errorBusiness.add(mainBusinessNo);
			logger.trace((new StringBuilder("Record validate not pass: ")).append(mainBusinessNo).toString());
			errorRecordNumber++;
		} else
		if (errorBusiness.contains(mainBusinessNo))
		{
			logger.trace((new StringBuilder("Record has relatived error: ")).append(mainBusinessNo).toString());
			errorRelativedRecordNumber++;
		} else
		{
			correctRecordNumber++;
		}
	}

	public void handleFooter(Message message1, Record record)
		throws ECRException
	{
	}

	public void messageEnd(Message message1)
		throws ECRException
	{
	}

	public void start(MessageSet messageSet)
		throws ECRException
	{
		logger = ARE.getLog();
		try
		{
			connection = ARE.getDBConnection(database);
			int isolation = ARE.getProperty("connection.ecr.isolation", -1);
			if (isolation != -1)
			{
				logger.debug((new StringBuilder("JDBC transactionIsolation set to ")).append(isolation).toString());
				connection.setTransactionIsolation(isolation);
			}
			connection.setAutoCommit(false);
		}
		catch (SQLException sqlE)
		{
			logger.debug(sqlE);
			throw new ECRException("数据库连接失败！", sqlE);
		}
		errorBusiness = new TreeSet();
		errorRecord = new DBErrorRecord();
		((DBErrorRecord)errorRecord).setDatabase(database);
		errorRecord.open();
	}

	public void end(MessageSet messageSet)
		throws ECRException
	{
		if (errorRecord != null)
		{
			errorRecord.close();
			errorRecord = null;
		}
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			connection = null;
		}
	}

	private String validate(Message message, Record record)
		throws ECRException
	{
		if (checkRules == null || checkRules.length == 0)
			return null;
		Segment segs[] = null;
		Segment segment = null;
		segs = record.getAllSegments();
		StringBuffer errCode = new StringBuffer();
		for (int i = 0; i < segs.length; i++)
		{
			segment = segs[i];
			for (int j = 0; j < checkRules.length; j++)
				if (checkRules[j].getmessageType() == message.getType() && checkRules[j].getRecordType() == record.getType() && checkRules[j].getSegmentFlag().equals(segment.getSegmentFlag()))
				{
					checkRules[j].setConnection(connection);
					if (!checkRules[j].validate(message, segment, record))
					{
						errCode.append(checkRules[j].getErrorCode());
						errorRecord.writeError(checkRules[j], segment);
					}
				}

		}

		if (errCode.length() > 0)
			return errCode.toString();
		else
			return null;
	}

	public void loadRulesFromXMLFile(String configFile)
		throws ECRException
	{
		Document doc = null;
		try
		{
			doc = new Document(configFile);
		}
		catch (Exception e)
		{
			throw new ECRException("Build Document error", e);
		}
		Element xRoot = doc.getRootElement();
		Element xrulemap = xRoot.getChild("rulemap");
		if (xrulemap == null)
			throw new ECRException((new StringBuilder("No rulemap  define--")).append(configFile).toString());
		Element xrulelist = xrulemap.getChild("rulelist");
		if (xrulelist == null)
			throw new ECRException((new StringBuilder("No rulelist define--")).append(configFile).toString());
		List xRuleList = xrulelist.getChildren("rule");
		checkRules = new ValidateRule[xRuleList.size()];
		try
		{
			for (int i = 0; i < xRuleList.size(); i++)
				checkRules[i] = ValidateRule.buildRule((Element)xRuleList.get(i));

		}
		catch (ECRException exception)
		{
			throw new ECRException((new StringBuilder()).append(exception.getMessage()).append(" @rulefile :").append(configFile).toString());
		}
	}

	public final String getRulesFile()
	{
		return rulesFile;
	}

	public final void setRulesFile(String rulesFile)
	{
		this.rulesFile = rulesFile;
	}

	public final int getErrorRelativedRecordNumber()
	{
		return errorRelativedRecordNumber;
	}
}
