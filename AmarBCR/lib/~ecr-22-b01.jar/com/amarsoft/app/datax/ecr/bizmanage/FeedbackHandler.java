// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FeedbackHandler.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.CustomerStore;
import com.amarsoft.app.datax.ecr.common.ErrorMessage;
import com.amarsoft.app.datax.ecr.common.RecordDBReflector;
import com.amarsoft.app.datax.ecr.message.Field;
import com.amarsoft.app.datax.ecr.message.Handler;
import com.amarsoft.app.datax.ecr.message.Message;
import com.amarsoft.app.datax.ecr.message.MessageSet;
import com.amarsoft.app.datax.ecr.message.Record;
import com.amarsoft.app.datax.ecr.message.Segment;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizmanage:
//			FeedbackRecord

public class FeedbackHandler
	implements Handler
{

	private String database;
	private Log logger;
	private Connection connection;
	private int lastRecordType;
	private RecordDBReflector reflector;
	private SimpleDateFormat dateFormat;
	private PreparedStatement psInsertFeed;
	private PreparedStatement psDelFeed;
	private PreparedStatement psUpdateHis[];
	private String sessionId;

	public FeedbackHandler()
	{
		database = "ecr";
		logger = null;
		connection = null;
		lastRecordType = -1;
		reflector = null;
		dateFormat = null;
		psInsertFeed = null;
		psDelFeed = null;
		psUpdateHis = null;
		sessionId = null;
	}

	public void messageStart(Message message1)
		throws ECRException
	{
	}

	public void handleHeader(Message message, Record header)
		throws ECRException
	{
		String messageFile = header.getFirstSegment("A").getField(7643).getString();
		sessionId = (new StringBuilder(String.valueOf(messageFile.substring(13, 19)))).append(messageFile.substring(22, 26)).toString();
		int retry = header.getFirstSegment("A").getField(7645).getInt();
		logger.debug((new StringBuilder("File name: ")).append(messageFile).toString());
		logger.debug((new StringBuilder("Session ID: ")).append(sessionId).toString());
	}

	public void handleRecord(Message message, Record record)
		throws ECRException
	{
		FeedbackRecord fbr = new FeedbackRecord(record);
		Record rec = fbr.getRecordDataAsRecord();
		updateHis(rec, fbr);
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
	}

	public void end(MessageSet messageSet)
		throws ECRException
	{
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

	private void updateHis(Record record, FeedbackRecord fbr)
		throws ECRException
	{
		int recordType = record.getType();
		boolean relieveGuaranty = false;
		String retryFlag = "3";
		String financeId = fbr.getFinanceCode();
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
				throw new ECRException("回写历史数据库错误！", e);
			}
		} else
		{
			reflector.computeKey(record);
		}
		com.amarsoft.are.dpx.recordset.Field param[] = reflector.getMainKeyColumn();
		Date d = record.getFirstSegment("B").getField(2501).getDate();
		String occurDate = dateFormat.format(d);
		String traceNumber = fbr.getTraceNumber();
		StringBuffer errbuff = new StringBuffer();
		String err[] = fbr.getErrorCode(fbr.getErrorCode(), fbr.getErrorColumns());
		String errCode = "";
		String errmsg[] = new String[err.length];
		for (int i = 0; i < err.length; i++)
		{
			if (errbuff.indexOf(err[i]) < 0)
				errbuff.append(err[i].substring(0, 8));
			errCode = (new StringBuilder(String.valueOf(errCode))).append(err[i].substring(4, 8)).toString();
			errmsg[i] = err[i].substring(8);
		}

		try
		{
			StringBuffer sbRecordKey = new StringBuffer();
			for (int p = 0; p < param.length; p++)
				if (p == 0)
					sbRecordKey.append(param[p].getString());
				else
					sbRecordKey.append("@").append(param[p].getString());

			psDelFeed.setString(1, traceNumber);
			psDelFeed.execute();
			psInsertFeed.setString(1, traceNumber);
			psInsertFeed.setString(2, String.valueOf(recordType));
			psInsertFeed.setString(3, null);
			psInsertFeed.setString(4, errbuff.toString());
			psInsertFeed.setString(5, ErrorMessage.getErrorMessage(errCode, true, errmsg));
			psInsertFeed.setString(6, retryFlag);
			psInsertFeed.setString(7, sessionId);
			psInsertFeed.setString(8, financeId);
			psInsertFeed.setString(9, record.getMainBusinessNo());
			psInsertFeed.setString(10, CustomerStore.getCustomerId(record.getLoanCardNo(), financeId));
			psInsertFeed.setString(11, record.getLoanCardNo());
			psInsertFeed.setString(12, sbRecordKey.toString());
			psInsertFeed.execute();
			for (int i = 0; i < psUpdateHis.length; i++)
			{
				psUpdateHis[i].setString(1, traceNumber);
				psUpdateHis[i].setString(2, errbuff.toString());
				psUpdateHis[i].setString(3, occurDate);
				for (int p = 0; p < param.length; p++)
					if (param[p].getType() == 1)
						psUpdateHis[i].setInt(p + 4, param[p].getInt());
					else
					if (relieveGuaranty)
					{
						psUpdateHis[i].setString(p + 4, (new StringBuilder(String.valueOf(param[p].getString()))).append("┄").append("%").toString());
						relieveGuaranty = false;
					} else
					{
						psUpdateHis[i].setString(p + 4, param[p].getString());
					}

				if (logger.isTraceEnabled())
				{
					StringBuffer sb = new StringBuffer();
					sb.append("Update his parameter: '").append(occurDate).append("'");
					for (int p = 0; p < param.length; p++)
					{
						sb.append(',');
						if (param[p].getType() == 1)
							sb.append(param[p].getInt());
						else
							sb.append("'").append(param[p].getString()).append("'");
					}

					logger.trace(sb);
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
			throw new ECRException("迁移记录数据库错误！", e);
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
		String sqlDelFeed = "delete from ECR_FEEDBACK where traceNumber=?";
		String sqlInsertFeed = "insert into ECR_FEEDBACK(TraceNumber,RecordType,MessageType,ErrCode,ErrMsg,RetryFlag,Sessionid,FinanceId,MainBusinessNo,CustomerId,LoanCardNo,RecordKey)values(?,?,?,?,?,?,?,?,?,?,?,?)";
		logger.debug((new StringBuilder("Insert feedback Sql: ")).append(sqlInsertFeed).toString());
		psInsertFeed = connection.prepareStatement(sqlInsertFeed);
		psDelFeed = connection.prepareStatement(sqlDelFeed);
		String where;
		String sqlUpdateHis;
		for (int i = 0; i < rtables.length; i++)
		{
			StringBuffer sbWhere = new StringBuffer();
			sbWhere.append(" where SessionID='").append(sessionId).append("' and OccurDate=?");
			for (int j = 0; j < keyCol.length; j++)
				sbWhere.append(" and ").append(keyCol[j]).append("=?");

			where = sbWhere.toString();
			sqlUpdateHis = (new StringBuilder("update HIS_")).append(rtables[i]).append(" set SessionId='").append("9999999999").append("'").append(",TraceNumber=?,ErrorCode=?,ModFlag='1'").append(where).toString();
			logger.debug((new StringBuilder("Update HIS Sql: ")).append(sqlUpdateHis).toString());
			psUpdateHis[i] = connection.prepareStatement(sqlUpdateHis);
		}

		StringBuffer sbWhere = new StringBuffer();
		sbWhere.append(" where SessionID='").append(sessionId).append("' and OccurDate=?");
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
		sqlUpdateHis = (new StringBuilder("update HIS_")).append(reflector.getMainTable()).append(" set SessionId='").append("9999999999").append("'").append(",TraceNumber=?,ErrorCode=?,ModFlag='1'").append(j).toString();
		logger.debug((new StringBuilder("Update HIS Sql: ")).append(sqlUpdateHis).toString());
		psUpdateHis[rtables.length] = connection.prepareStatement(sqlUpdateHis);
		return relieveGuaranty;
	}

	public final String getDatabase()
	{
		return database;
	}

	public final void setDatabase(String database)
	{
		this.database = database;
	}
}
