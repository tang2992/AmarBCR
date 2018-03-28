// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ImportDataFile.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.ARE;
import com.amarsoft.are.AREException;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.DataSourceURI;
import com.amarsoft.are.sql.TabularReader;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.Target;
import java.net.URISyntaxException;
import java.sql.*;

public class ImportDataFile extends ExecuteUnit
{

	protected String database;
	protected DataSourceURI dataSource;
	protected ResultSet fileResultSet;
	protected int bufferSize;
	protected Connection connection;
	protected int commitRecord;
	protected Log logger;
	protected String Uri;
	public static final String PROPERTY_DATABASE = "database";
	public static final String PROPERTY_DATASOURCE = "dataSource";
	public static final String PROPERTY_EXECUTESQL = "executeSql";
	public static final String PROPERTY_BUFFER_SIZE = "bufferSize";
	public static final String PROPERTY_TARGET_TABLE_DEFINE = "targetTableDefine";
	public static final String PROPERTY_COMMIT_RECORD = "commitRecord";
	private String sqlInsertDate;
	private PreparedStatement psInsertData;
	private int insertRecord;
	private int countMetaData;

	public ImportDataFile()
	{
		Uri = getProperty("dataSource");
		sqlInsertDate = null;
		psInsertData = null;
		insertRecord = 0;
		countMetaData = 0;
	}

	protected void init()
		throws AREException
	{
		logger = ARE.getLog();
		database = getProperty("database");
		if (database == null || database.equals(""))
			database = getTarget().getProperty("database");
		try
		{
			connection = ARE.getDBConnection(database);
		}
		catch (SQLException e)
		{
			logger.fatal("数据库连接初始化失败！", e);
			throw new AREException("请检查数据库连接！", e);
		}
		String buff = getProperty("bufferSize");
		if (buff == null || buff.equals(""))
		{
			buff = getTarget().getProperty("bufferSize");
			try
			{
				bufferSize = Integer.parseInt(buff);
			}
			catch (Exception ex)
			{
				bufferSize = 0;
				logger.warn("获取bufferSize失败！", ex);
			}
		}
		try
		{
			dataSource = new DataSourceURI(Uri);
		}
		catch (URISyntaxException e)
		{
			logger.fatal("创建DataSourceURI失败！", e);
			throw new AREException("请检查配置文件！", e);
		}
		try
		{
			TabularReader reader = new TabularReader(dataSource);
			if (bufferSize > 0)
				reader.setBufferSize(bufferSize);
			fileResultSet = reader.getResultSet();
		}
		catch (SQLException e1)
		{
			logger.fatal("通用结果集创建失败，无法与数据文件或数据源连接！", e1);
			throw new AREException("请检查数据文件或数据源！", e1);
		}
		String record = getProperty("commitRecord");
		if (record == null || record.equals(""))
		{
			record = getTarget().getProperty("commitRecord");
			try
			{
				commitRecord = Integer.parseInt(record);
			}
			catch (Exception ex)
			{
				commitRecord = 1;
				logger.warn("获取commitRecord失败！", ex);
			}
		}
	}

	protected void prepare()
		throws AREException
	{
		sqlInsertDate = getProperty("executeSql");
		for (int i = 0; i < sqlInsertDate.length(); i++)
			if (sqlInsertDate.charAt(i) == '?')
				countMetaData++;

		try
		{
			psInsertData = connection.prepareStatement(sqlInsertDate);
		}
		catch (SQLException e)
		{
			releaseResource();
			throw new AREException("打开statement出错", e);
		}
	}

	protected void postProcess()
		throws AREException
	{
		AREException ex = null;
		try
		{
			if (psInsertData != null)
				psInsertData.executeBatch();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			ex = new AREException("最后更新失败");
		}
		releaseResource();
		if (ex != null)
			throw ex;
		else
			return;
	}

	protected void processRow()
		throws AREException
	{
		try
		{
			for (int i = 1; i <= countMetaData; i++)
				psInsertData.setString(i, fileResultSet.getString(i));

			psInsertData.addBatch();
			insertRecord++;
			if (insertRecord >= commitRecord)
			{
				psInsertData.executeBatch();
				commitRecord = 0;
			}
		}
		catch (SQLException e)
		{
			releaseResource();
			logger.fatal((new StringBuilder("逐条处理失败：当前行 = [")).append(insertRecord).append("] (Caused by: ").append(e.getMessage()).append(")").toString());
		}
	}

	public int execute()
	{
		try
		{
			init();
		}
		catch (AREException e)
		{
			logger.fatal((new StringBuilder("初始化失败:")).append(e.getMessage()).toString());
			clearResource();
			return 2;
		}
		try
		{
			prepare();
		}
		catch (AREException e)
		{
			logger.fatal((new StringBuilder("准备工作失败:")).append(e.getMessage()).toString());
			clearResource();
			return 2;
		}
		int currentRow = 0;
		try
		{
			for (; fileResultSet.next(); processRow())
				currentRow = fileResultSet.getRow();

		}
		catch (SQLException e)
		{
			logger.fatal((new StringBuilder("逐条处理失败：当前行 = [")).append(currentRow).append("] (Caused by: ").append(e.getMessage()).append(")").toString());
			clearResource();
			return 2;
		}
		catch (AREException e)
		{
			logger.fatal((new StringBuilder("逐条处理失败：当前行 = [")).append(currentRow).append("] (Caused by: ").append(e.getMessage()).append(")").toString());
			clearResource();
			return 2;
		}
		try
		{
			postProcess();
		}
		catch (AREException e)
		{
			logger.fatal((new StringBuilder("后续处理失败:")).append(e.getMessage()).toString());
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void clearResource()
	{
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException e)
			{
				logger.warn((new StringBuilder("关闭数据库失败！")).append(e).toString());
			}
			connection = null;
		}
		if (fileResultSet != null)
		{
			try
			{
				fileResultSet.close();
			}
			catch (SQLException e)
			{
				logger.warn((new StringBuilder("关闭统一数据结果集失败！")).append(e).toString());
			}
			fileResultSet = null;
		}
	}

	private void releaseResource()
	{
		if (psInsertData != null)
			try
			{
				psInsertData.close();
			}
			catch (SQLException e)
			{
				logger.warn("psInsertData.close()", e);
			}
		psInsertData = null;
	}
}
