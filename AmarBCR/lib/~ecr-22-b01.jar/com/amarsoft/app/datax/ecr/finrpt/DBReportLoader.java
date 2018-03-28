// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DBReportLoader.java

package com.amarsoft.app.datax.ecr.finrpt;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.Connection;
import java.sql.SQLException;

// Referenced classes of package com.amarsoft.app.datax.ecr.finrpt:
//			AbstractReportLoader

public abstract class DBReportLoader extends AbstractReportLoader
{

	private String database;
	protected Connection connection;

	public DBReportLoader()
	{
	}

	public void open()
		throws ECRException
	{
		try
		{
			connection = ARE.getDBConnection(getDatabase());
		}
		catch (SQLException ex)
		{
			logger.debug(ex);
			throw new ECRException("打开数据库失败！", ex);
		}
	}

	public void close()
	{
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
			connection = null;
		}
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}

	protected Connection getConnection()
	{
		return connection;
	}
}
