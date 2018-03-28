package com.amarsoft.app.datax.bcr.bizmanage;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.ecr.common.ErrorMessage;
import com.amarsoft.app.datax.ecr.common.OrganizationStore;
import com.amarsoft.app.datax.bcr.common.RecordDBReflector;
import com.amarsoft.app.datax.bcr.message.Field;
import com.amarsoft.app.datax.bcr.message.Handler;
import com.amarsoft.app.datax.bcr.message.Message;
import com.amarsoft.app.datax.bcr.message.MessageSet;
import com.amarsoft.app.datax.bcr.message.Record;
import com.amarsoft.app.datax.bcr.message.Segment;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;


public class GuaranteeFeedbackHandler
	implements Handler
{

	private String database;
	private Log logger;
	private Connection connection;
	private int lastRecordType;
	private RecordDBReflector reflector;
	private PreparedStatement psInsertFeed;
	private PreparedStatement psDelFeed;
	private PreparedStatement psUpdateHis[];
	private String sessionId;

	public GuaranteeFeedbackHandler()
	{
		database = "bcr";
		logger = null;
		connection = null;
		lastRecordType = -1;
		reflector = null;
		psInsertFeed = null;
		psDelFeed = null;
		psUpdateHis = null;
		sessionId = null;
	}

	public void messageStart(Message message1)
		throws BCRException
	{
	}

	public void handleHeader(Message message, Record header)
		throws BCRException
	{
		String messageFile = header.getFirstSegment("A").getField(2305).getString();
		sessionId = (new StringBuilder(String.valueOf(messageFile.substring(16, 22)))).append(messageFile.substring(25, 29)).toString();
		logger.debug((new StringBuilder("File name: ")).append(messageFile).toString());
		logger.debug((new StringBuilder("Session ID: ")).append(sessionId).toString());
	}

	public void handleRecord(Message message, Record record)
		throws BCRException
	{
		GuaranteeFeedbackRecord fbr = new GuaranteeFeedbackRecord(record);
		Record rec = fbr.getRecordDataAsRecord();
		updateHis(rec, fbr);
	}

	public void handleFooter(Message message1, Record record)
		throws BCRException
	{
	}

	public void messageEnd(Message message)
		throws BCRException
	{
		if (message.getType() == 37)
			try
			{
				Statement stm = connection.createStatement();
				stm.executeUpdate("update BCR_GUARANTEEDELETE set sessionId = '7777777777' where sessionId='9999999999' ");
				stm.executeUpdate("update BCR_GUARANTEECHANGE set sessionId = '7777777777' where sessionId='9999999999' ");
				stm.executeUpdate((new StringBuilder("update BCR_GUARANTEEDELETE set sessionId = '8888888888' where sessionId= '")).append(sessionId).append("' ").toString());
				stm.executeUpdate((new StringBuilder("update BCR_GUARANTEECHANGE set sessionId = '8888888888' where sessionId= '")).append(sessionId).append("' ").toString());
				stm.close();
				connection.commit();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
			}
	}

	public void start(MessageSet messageSet)
		throws BCRException
	{
		logger = ARE.getLog();
		try
		{
			connection = ARE.getDBConnection(database);
			int isolation = ARE.getProperty("connection.bcr.isolation", -1);
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
			throw new BCRException("数据库连接失败！", sqlE);
		}
	}

	public void end(MessageSet messageSet)
		throws BCRException
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
		if (psInsertFeed != null)
		{
			try
			{
				psInsertFeed.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psInsertFeed = null;
		}
		if (psDelFeed != null)
		{
			try
			{
				psDelFeed.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psDelFeed = null;
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

	private void updateHis(Record record, GuaranteeFeedbackRecord fbr)
		throws BCRException
	{
		int recordType = record.getType();
		String retryFlag = "3";
		if (recordType != lastRecordType)
		{
			reflector = RecordDBReflector.getReflector(recordType);
			lastRecordType = recordType;
			reflector.computeKey(record);
			try
			{
				prepareStatement();
			}
			catch (SQLException e)
			{
				throw new BCRException("回写历史数据库错误！", e);
			}
		} else
		{
			reflector.computeKey(record);
		}
		com.amarsoft.are.dpx.recordset.Field param[] = reflector.getMainKeyColumn();
		String traceNumber = fbr.getTraceNumber();
		StringBuffer errbuff = new StringBuffer();
		String err[] = fbr.getErrorCode(recordType, fbr.getErrorCode(), fbr.getErrorColumns());
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
			psInsertFeed.setString(8, null);
			psInsertFeed.setString(9, param[0].getString());
			psInsertFeed.setString(10, null);
			psInsertFeed.setString(11, param[0].getString());
			psInsertFeed.setString(12, sbRecordKey.toString());
			psInsertFeed.execute();
			for (int i = 0; i < psUpdateHis.length; i++)
			{
				psUpdateHis[i].setString(1, traceNumber);
				psUpdateHis[i].setString(2, errbuff.toString());
				for (int p = 0; p < param.length; p++)
					if (param[p].getType() == 1)
						psUpdateHis[i].setInt(p + 3, param[p].getInt());
					else
						psUpdateHis[i].setString(p + 3, param[p].getString());

				if (logger.isTraceEnabled())
				{
					StringBuffer sb = new StringBuffer();
					sb.append("Update his parameter:  ");
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
			throw new BCRException("迁移记录数据库错误！", e);
		}
	}

	private void prepareStatement()
		throws SQLException
	{
		com.amarsoft.are.dpx.recordset.Field key[] = reflector.getMainKeyColumn();
		String keyCol[] = new String[key.length];
		for (int i = 0; i < keyCol.length; i++)
			keyCol[i] = key[i].getName();

		String rtables[] = reflector.getRelativeTables();
		psUpdateHis = new PreparedStatement[rtables.length + 1];
		String sqlDelFeed = "delete from BCR_FEEDBACK where traceNumber=?";
		String sqlInsertFeed = "insert into BCR_FEEDBACK(TraceNumber,RecordType,MessageType,ErrCode,ErrMsg,RetryFlag,Sessionid,FinanceId,MainBusinessNo,CustomerId,GContractNo,RecordKey)values(?,?,?,?,?,?,?,?,?,?,?,?)";
		logger.debug((new StringBuilder("Insert feedback Sql: ")).append(sqlInsertFeed).toString());
		psInsertFeed = connection.prepareStatement(sqlInsertFeed);
		psDelFeed = connection.prepareStatement(sqlDelFeed);
		for (int i = 0; i < rtables.length; i++)
		{
			StringBuffer sbWhere = new StringBuffer();
			sbWhere.append(" where SessionID='").append(sessionId).append("'");
			for (int j = 0; j < keyCol.length; j++)
				sbWhere.append(" and ").append(keyCol[j]).append("=?");

			String where = sbWhere.toString();
			String sqlUpdateHis = (new StringBuilder("update HIS_")).append(rtables[i]).append(" set SessionId='").append("9999999999").append("'").append(",TraceNumber=?,ErrorCode=?,ModFlag='1'").append(where).toString();
			logger.debug((new StringBuilder("Update HIS Sql: ")).append(sqlUpdateHis).toString());
			psUpdateHis[i] = connection.prepareStatement(sqlUpdateHis);
		}

		StringBuffer sbWhere = new StringBuffer();
		sbWhere.append(" where SessionID='").append(sessionId).append("'");
		for (int j = 0; j < keyCol.length; j++)
			sbWhere.append(" and ").append(keyCol[j]).append("=?");

		String where = sbWhere.toString();
		String sqlUpdateHis = (new StringBuilder("update HIS_")).append(reflector.getMainTable()).append(" set SessionId='").append("9999999999").append("'").append(",TraceNumber=?,ErrorCode=?,ModFlag='1'").append(where).toString();
		logger.debug((new StringBuilder("Update HIS Sql: ")).append(sqlUpdateHis).toString());
		psUpdateHis[rtables.length] = connection.prepareStatement(sqlUpdateHis);
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
