// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   TransferHandler.java

package com.amarsoft.app.datax.ecr.bizcollect;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.RecordDBReflector;
import com.amarsoft.app.datax.ecr.message.Field;
import com.amarsoft.app.datax.ecr.message.Handler;
import com.amarsoft.app.datax.ecr.message.Message;
import com.amarsoft.app.datax.ecr.message.MessageSet;
import com.amarsoft.app.datax.ecr.message.Record;
import com.amarsoft.app.datax.ecr.message.Segment;
import com.amarsoft.app.datax.ecr.validate.ErrorRecord;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.metadata.ColumnMetaData;
import com.amarsoft.are.metadata.DataSourceMetaData;
import com.amarsoft.are.metadata.TableMetaData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

// Referenced classes of package com.amarsoft.app.datax.ecr.bizcollect:
//			TransferFilter

public class TransferHandler
	implements Handler
{

	private String database;
	private int totalRecordNumber;
	private int passedRecordNumber;
	private int refusedRecordNumber;
	private Log logger;
	private Connection connection;
	private int lastRecordType;
	private RecordDBReflector reflector;
	private SimpleDateFormat dateFormat;
	private PreparedStatement psDeleteHis[];
	private PreparedStatement psInsertHis[];
	private PreparedStatement psUpdateEcr[];
	private ErrorRecord errorRecord;
	private TransferFilter recordFilter;

	public TransferHandler()
	{
		database = "ecr";
		totalRecordNumber = 0;
		passedRecordNumber = 0;
		refusedRecordNumber = 0;
		logger = null;
		connection = null;
		lastRecordType = -1;
		reflector = null;
		dateFormat = null;
		psDeleteHis = null;
		psInsertHis = null;
		psUpdateEcr = null;
		errorRecord = null;
		recordFilter = null;
	}

	public final String getDatabase()
	{
		return database;
	}

	public final void setDatabase(String database)
	{
		this.database = database;
	}

	public final int getPassedRecordNumber()
	{
		return passedRecordNumber;
	}

	public final int getRefusedRecordNumber()
	{
		return refusedRecordNumber;
	}

	public final int getTotalRecordNumber()
	{
		return totalRecordNumber;
	}

	public void messageStart(Message message1)
		throws ECRException
	{
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
		if (recordFilter == null)
		{
			recordFilter = new TransferFilter();
			recordFilter.setDatabase(getDatabase());
			recordFilter.init();
		}
		if (recordFilter.accept(message, record))
		{
			moveRecord(record);
			passedRecordNumber++;
		} else
		{
			refusedRecordNumber++;
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
		if (errorRecord != null)
		{
			errorRecord.close();
			errorRecord = null;
		}
		if (psDeleteHis != null)
		{
			for (int i = 0; i < psDeleteHis.length; i++)
				if (psDeleteHis[i] != null)
				{
					try
					{
						psDeleteHis[i].close();
					}
					catch (SQLException e)
					{
						logger.debug(e);
					}
					psDeleteHis[i] = null;
				}

			psDeleteHis = null;
		}
		if (psInsertHis != null)
		{
			for (int i = 0; i < psInsertHis.length; i++)
				if (psInsertHis[i] != null)
				{
					try
					{
						psInsertHis[i].close();
					}
					catch (SQLException e)
					{
						logger.debug(e);
					}
					psInsertHis[i] = null;
				}

			psInsertHis = null;
		}
		if (psUpdateEcr != null)
		{
			for (int i = 0; i < psUpdateEcr.length; i++)
				if (psUpdateEcr[i] != null)
				{
					try
					{
						psUpdateEcr[i].close();
					}
					catch (SQLException e)
					{
						logger.debug(e);
					}
					psUpdateEcr[i] = null;
				}

			psUpdateEcr = null;
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
		if (recordFilter != null)
			recordFilter.close();
	}

	private void moveRecord(Record record)
		throws ECRException
	{
		int recordType = record.getType();
		if (recordType != lastRecordType)
		{
			reflector = RecordDBReflector.getReflector(recordType);
			lastRecordType = recordType;
			try
			{
				prepareStatement();
			}
			catch (SQLException e)
			{
				throw new ECRException("迁移记录数据库错误！", e);
			}
		}
		reflector.computeKey(record);
		com.amarsoft.are.dpx.recordset.Field param[] = reflector.getMainKeyColumn();
		try
		{
			int delnum = 0;
			int insnum = 0;
			int updnum = 0;
			for (int i = 0; i < psDeleteHis.length; i++)
			{
				setWhereParameter(psDeleteHis[i], record, param, 1);
				delnum += psDeleteHis[i].executeUpdate();
			}

			for (int i = 0; i < psInsertHis.length; i++)
			{
				setWhereParameter(psInsertHis[i], record, param, 1);
				insnum += psInsertHis[i].executeUpdate();
			}

			for (int i = 0; i < psUpdateEcr.length; i++)
			{
				setWhereParameter(psUpdateEcr[i], record, param, 1);
				updnum += psUpdateEcr[i].executeUpdate();
			}

			connection.commit();
			if (logger.isTraceEnabled())
				logger.trace((new StringBuilder("Delete his data: ")).append(delnum).append(", Insert his data: ").append(insnum).append(", Update ecr flag: ").append(updnum).toString());
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

	private void setWhereParameter(PreparedStatement ps, Record rec, com.amarsoft.are.dpx.recordset.Field param[], int begin)
		throws SQLException, ECRException
	{
		Date d = null;
		if (rec.getType() == 71 || rec.getType() == 72)
			d = rec.getFirstSegment("B").getField(9993).getDate();
		else
			d = rec.getFirstSegment("B").getField(2501).getDate();
		String od = null;
		if (d != null)
			od = dateFormat.format(d);
		ps.setString(begin, od);
		for (int i = 0; i < param.length; i++)
			if (param[i].getType() == 1)
				ps.setInt(i + begin + 1, param[i].getInt());
			else
				ps.setString(i + begin + 1, param[i].getString());

	}

	private void prepareStatement()
		throws SQLException
	{
		com.amarsoft.are.dpx.recordset.Field key[] = reflector.getMainKeyColumn();
		String keyCol[] = new String[key.length];
		for (int i = 0; i < keyCol.length; i++)
			keyCol[i] = key[i].getName();

		String rtables[] = reflector.getRelativeTables();
		psDeleteHis = new PreparedStatement[rtables.length + 1];
		psInsertHis = new PreparedStatement[rtables.length + 1];
		psUpdateEcr = new PreparedStatement[rtables.length + 1];
		for (int i = 0; i < rtables.length; i++)
		{
			StringBuffer sbWhere = new StringBuffer();
			sbWhere.append(" where SessionID='").append("0000000000").append("' and OccurDate=?");
			for (int j = 0; j < keyCol.length; j++)
				sbWhere.append(" and ").append(keyCol[j]).append("=?");

			String where = sbWhere.toString();
			String sqlDeleteHis = (new StringBuilder("delete from HIS_")).append(rtables[i]).append(where).toString();
			String cols = getTableColumns(rtables[i]);
			String sqlInsertHis = (new StringBuilder("insert into HIS_")).append(rtables[i]).append("(").append(cols).append(") select ").append(cols).append(" from ECR_").append(rtables[i]).append(where).toString();
			String sqlUpdateEcr = (new StringBuilder("update ECR_")).append(rtables[i]).append(" set IncrementFlag='8'").append(where).toString();
			logger.debug((new StringBuilder("Delete HIS Sql: ")).append(sqlDeleteHis).toString());
			logger.debug((new StringBuilder("Insert HIS Sql: ")).append(sqlInsertHis).toString());
			logger.debug((new StringBuilder("Update ECR Sql: ")).append(sqlUpdateEcr).toString());
			psDeleteHis[i] = connection.prepareStatement(sqlDeleteHis);
			psInsertHis[i] = connection.prepareStatement(sqlInsertHis);
			psUpdateEcr[i] = connection.prepareStatement(sqlUpdateEcr);
		}

		StringBuffer sbWhere = new StringBuffer();
		sbWhere.append(" where SessionID='").append("0000000000").append("' and OccurDate=?");
		for (int j = 0; j < keyCol.length; j++)
			sbWhere.append(" and ").append(keyCol[j]).append("=?");

		String where = sbWhere.toString();
		String sqlDeleteHis = (new StringBuilder("delete from HIS_")).append(reflector.getMainTable()).append(where).toString();
		String cols = getTableColumns(reflector.getMainTable());
		String sqlInsertHis = (new StringBuilder("insert into HIS_")).append(reflector.getMainTable()).append("(").append(cols).append(") select ").append(cols).append(" from ECR_").append(reflector.getMainTable()).append(where).toString();
		String sqlUpdateEcr = (new StringBuilder("update ECR_")).append(reflector.getMainTable()).append(" set IncrementFlag='8',ErrorCode=null").append(where).toString();
		logger.debug((new StringBuilder("Delete HIS Sql: ")).append(sqlDeleteHis).toString());
		logger.debug((new StringBuilder("Insert HIS Sql: ")).append(sqlInsertHis).toString());
		logger.debug((new StringBuilder("Update ECR Sql: ")).append(sqlUpdateEcr).toString());
		psDeleteHis[rtables.length] = connection.prepareStatement(sqlDeleteHis);
		psInsertHis[rtables.length] = connection.prepareStatement(sqlInsertHis);
		psUpdateEcr[rtables.length] = connection.prepareStatement(sqlUpdateEcr);
	}

	private String getTableColumns(String table)
		throws SQLException
	{
		StringBuffer sb = new StringBuffer();
		DataSourceMetaData dm = ARE.getMetaData("ecr_data");
		if (dm == null)
			throw new SQLException("ecr_data metadata不存在!");
		TableMetaData tm = dm.getTable((new StringBuilder("ECR_")).append(table).toString());
		if (tm == null)
			throw new SQLException((new StringBuilder(String.valueOf(table))).append("的metadata不存在!").toString());
		ColumnMetaData cm[] = tm.getColumns();
		for (int i = 0; i < cm.length; i++)
			sb.append(i != 0 ? "," : "").append(cm[i].getName());

		return sb.toString();
	}
}
