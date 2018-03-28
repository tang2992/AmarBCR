// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ExportFileHandler.java

package com.amarsoft.app.datax.ecr.bizcollect;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.RecordDBReflector;
import com.amarsoft.app.datax.ecr.message.Field;
import com.amarsoft.app.datax.ecr.message.Handler;
import com.amarsoft.app.datax.ecr.message.Message;
import com.amarsoft.app.datax.ecr.message.MessageSet;
import com.amarsoft.app.datax.ecr.message.Record;
import com.amarsoft.app.datax.ecr.message.Segment;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ExportFileHandler
	implements Handler
{

	private String database;
	private int recordCount;
	private int reportCount;
	private String exportFile;
	private String exportFolder;
	private String sessionId;
	private boolean retryMessage;
	private BufferedWriter br;
	private boolean firstMessage;
	private Log logger;
	private Connection connection;
	private int lastRecordType;
	private RecordDBReflector reflector;
	private SimpleDateFormat dateFormat;
	private PreparedStatement psUpdateHis[];

	public ExportFileHandler()
	{
		database = "ecr";
		recordCount = 0;
		reportCount = 0;
		exportFile = null;
		exportFolder = null;
		sessionId = null;
		retryMessage = false;
		br = null;
		firstMessage = true;
		logger = null;
		connection = null;
		lastRecordType = -1;
		reflector = null;
		dateFormat = null;
		psUpdateHis = null;
		exportFolder = "export/";
	}

	public ExportFileHandler(String folder)
	{
		database = "ecr";
		recordCount = 0;
		reportCount = 0;
		exportFile = null;
		exportFolder = null;
		sessionId = null;
		retryMessage = false;
		br = null;
		firstMessage = true;
		logger = null;
		connection = null;
		lastRecordType = -1;
		reflector = null;
		dateFormat = null;
		psUpdateHis = null;
		exportFolder = folder;
	}

	public void messageStart(Message message)
		throws ECRException
	{
		if (firstMessage)
			firstMessage = false;
		else
			writeFile("\n\n");
	}

	public void handleHeader(Message message, Record header)
		throws ECRException
	{
		recordCount = 0;
		writeRecord(header);
		writeFile("\n");
	}

	public void handleRecord(Message message, Record record)
		throws ECRException
	{
		writeRecord(record);
		recordCount++;
		writeFile("\n");
		updateSessionId(record);
	}

	public void handleFooter(Message message, Record footer)
		throws ECRException
	{
		footer.getFirstSegment("Z").getField("RecordNum").setInt(recordCount);
		reportCount += recordCount;
		writeRecord(footer);
		recordCount = 0;
	}

	public void messageEnd(Message message1)
		throws ECRException
	{
	}

	public void start(MessageSet messageSet)
		throws ECRException
	{
		logger = ARE.getLog();
		exportFile = (new StringBuilder(String.valueOf(exportFolder))).append(messageSet.getFileName()).append(".txt").toString();
		retryMessage = isRetryMessage();
		try
		{
			br = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(exportFile), "GB18030"));
		}
		catch (IOException exception)
		{
			logger.debug(exception);
			throw new ECRException("打开文件失败！", exception);
		}
		dateFormat = new SimpleDateFormat("yyyy/MM/dd");
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
		String f = messageSet.getFileName();
		String setType = messageSet.getType();
		if ("51".equals(setType) || "32".equals(setType))
			sessionId = (new StringBuilder(String.valueOf(f.substring(22, 28)))).append(f.substring(31, 35)).toString();
		else
			sessionId = (new StringBuilder(String.valueOf(f.substring(13, 19)))).append(f.substring(22, 26)).toString();
	}

	public void end(MessageSet messageSet)
		throws ECRException
	{
		try
		{
			br.close();
		}
		catch (IOException e)
		{
			logger.debug(e);
		}
		if (psUpdateHis != null)
		{
			for (int i = 0; i < psUpdateHis.length; i++)
				if (psUpdateHis[i] != null)
				{
					try
					{
						psUpdateHis[i].close();
					}
					catch (SQLException e)
					{
						logger.debug(e);
					}
					psUpdateHis[i] = null;
				}

			psUpdateHis = null;
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

	private void writeRecord(Record record)
		throws ECRException
	{
		StringBuffer sb = new StringBuffer();
		Segment seg[] = record.getAllSegments();
		int rt = record.getType();
		for (int s = 0; s < seg.length; s++)
			if (rt == 8004 && seg[s].getSegmentFlag().equals("B") && seg[s].getField(8539).getString().equals("10"))
			{
				sb.append(seg[s].getField(8539).getTextValue());
				sb.append(seg[s].getField(6501).getTextValue());
				sb.append(seg[s].getField(7503).getTextValue());
				sb.append("                                                            ");
			} else
			{
				for (int f = 0; f < seg[s].getFieldNumber(); f++)
				{
					Field field = seg[s].getFields()[f];
					if (field != null && !field.getId().equals("9991") && !field.getId().equals("9992") && !field.getId().equals("9993") && (rt != 8004 && rt != 8001 || !field.getId().equals("2501")))
						sb.append(field.getTextValue());
				}

			}

		writeFile(sb.toString());
	}

	private void writeFile(String s)
		throws ECRException
	{
		try
		{
			br.write(s);
			br.flush();
		}
		catch (IOException exception)
		{
			throw new ECRException(exception);
		}
	}

	private void updateSessionId(Record record)
		throws ECRException
	{
		boolean relieveGuaranty = false;
		int recordType = record.getType();
		if (recordType != lastRecordType)
		{
			reflector = RecordDBReflector.getReflector(recordType);
			lastRecordType = recordType;
			reflector.computeKey(record);
			try
			{
				relieveGuaranty = prepareStatement();
			}
			catch (SQLException e)
			{
				throw new ECRException("回写Session信息数据库错误！", e);
			}
		} else
		{
			reflector.computeKey(record);
		}
		com.amarsoft.are.dpx.recordset.Field param[] = reflector.getMainKeyColumn();
		try
		{
			for (int i = 0; i < psUpdateHis.length; i++)
			{
				Date d = null;
				int recType = record.getType();
				if (recType == 71 || recType == 72 || recType == 73 || recType == 74)
					d = record.getFirstSegment("B").getField(9993).getDate();
				else
					d = record.getFirstSegment("B").getField(2501).getDate();
				String od = null;
				if (d != null)
					od = dateFormat.format(d);
				psUpdateHis[i].setString(1, od);
				for (int p = 0; p < param.length; p++)
					if (param[p].getType() == 1)
						psUpdateHis[i].setInt(p + 2, param[p].getInt());
					else
					if ("UPDATEDATE".equalsIgnoreCase(param[p].getName()) && (record.getType() == 73 || record.getType() == 74))
						psUpdateHis[i].setString(p + 2, (new SimpleDateFormat("yyyy/MM/dd")).format(record.getFirstSegment("B").getField("UpdateDate").getDate()));
					else
					if (relieveGuaranty)
					{
						psUpdateHis[i].setString(p + 2, (new StringBuilder(String.valueOf(param[p].getString()))).append("┄").append("%").toString());
						relieveGuaranty = false;
					} else
					{
						psUpdateHis[i].setString(p + 2, param[p].getString());
					}

				psUpdateHis[i].executeUpdate();
			}

			connection.commit();
		}
		catch (SQLException e)
		{
			logger.debug(e);
			try
			{
				connection.rollback();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
			}
			throw new ECRException("更新SessionID数据库错误！", e);
		}
	}

	private boolean prepareStatement()
		throws SQLException
	{
		com.amarsoft.are.dpx.recordset.Field key[] = reflector.getMainKeyColumn();
		String keyCol[] = new String[key.length];
		for (int i = 0; i < keyCol.length; i++)
			keyCol[i] = key[i].getName();

		String rtables[] = reflector.getRelativeTables();
		psUpdateHis = new PreparedStatement[rtables.length + 1];
		String where;
		String sqlUpdateHis;
		for (int i = 0; i < rtables.length; i++)
		{
			StringBuffer sbWhere = new StringBuffer();
			if (!isRetryMessage())
				sbWhere.append(" where SessionID='").append("0000000000").append("' and OccurDate=?");
			else
				sbWhere.append(" where SessionID='").append("1111111111").append("' and OccurDate=?");
			for (int j = 0; j < keyCol.length; j++)
				sbWhere.append(" and ").append(keyCol[j]).append("=?");

			where = sbWhere.toString();
			sqlUpdateHis = (new StringBuilder("update HIS_")).append(rtables[i]).append(" set SessionId='").append(sessionId).append("'").append(where).toString();
			logger.debug((new StringBuilder("Update HIS Sql: ")).append(sqlUpdateHis).toString());
			psUpdateHis[i] = connection.prepareStatement(sqlUpdateHis);
		}

		StringBuffer sbWhere = new StringBuffer();
		if (!isRetryMessage())
			sbWhere.append(" where SessionID='").append("0000000000").append("' and OccurDate=?");
		else
			sbWhere.append(" where SessionID='").append("1111111111").append("' and OccurDate=?");
		boolean relieveGuaranty = false;
		if ("ASSURECONT".equalsIgnoreCase(reflector.getMainTable()) || "GUARANTYCONT".equalsIgnoreCase(reflector.getMainTable()) || "IMPAWNCONT".equalsIgnoreCase(reflector.getMainTable()))
		{
			com.amarsoft.are.dpx.recordset.Field param[] = reflector.getMainKeyColumn();
			if ("QBZHT".equals(param[0].getString()))
				relieveGuaranty = true;
		}
		for (int j = 0; j < keyCol.length; j++)
			if (j == 0 && relieveGuaranty)
				sbWhere.append(" and ").append(keyCol[j]).append(" like ? ");
			else
				sbWhere.append(" and ").append(keyCol[j]).append("=?");

		j = sbWhere.toString();
		sqlUpdateHis = (new StringBuilder("update HIS_")).append(reflector.getMainTable()).append(" set SessionId='").append(sessionId).append("'").append(j).toString();
		logger.debug((new StringBuilder("Update HIS Sql: ")).append(sqlUpdateHis).toString());
		psUpdateHis[rtables.length] = connection.prepareStatement(sqlUpdateHis);
		return relieveGuaranty;
	}

	public String getExportFile()
	{
		return exportFile;
	}

	public final String getExportFolder()
	{
		return exportFolder;
	}

	public final void setExportFolder(String exportFolder)
	{
		this.exportFolder = exportFolder;
	}

	public final String getDatabase()
	{
		return database;
	}

	public final void setDatabase(String database)
	{
		this.database = database;
	}

	public final String getSessionId()
	{
		return sessionId;
	}

	public final void setSessionId(String sessionId)
	{
		this.sessionId = sessionId;
	}

	public void setReportCount(int reportCount)
	{
		this.reportCount = reportCount;
	}

	public int getReportCount()
	{
		return reportCount;
	}

	public final boolean isRetryMessage()
	{
		return retryMessage;
	}

	public final void setRetryMessage(boolean retryMessage)
	{
		this.retryMessage = retryMessage;
	}
}
