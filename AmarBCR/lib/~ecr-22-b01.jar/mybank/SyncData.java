// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncData.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncData extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmt;
	public static final String PROPERTY_DATABASE = "database";

	public SyncData()
	{
		connection = null;
		stmt = null;
	}

	protected void init()
		throws ECRException
	{
		logger = ARE.getLog();
		String database = "ecr";
		try
		{
			connection = ARE.getDBConnection(database);
			stmt = connection.createStatement();
		}
		catch (SQLException e)
		{
			throw new ECRException(e);
		}
	}

	public int execute()
	{
		try
		{
			init();
		}
		catch (ECRException e)
		{
			logger.fatal("初始化失败", e);
			clearResource();
			return 2;
		}
		try
		{
			String sSql1 = "{call DeleteECRCustomer()}";
			stmt.executeUpdate(sSql1);
		}
		catch (SQLException e)
		{
			logger.fatal("删除重复客户失败！", e);
			clearResource();
			return 2;
		}
		try
		{
			String sSql2 = "{call UpdateGuarantyFlag()}";
			stmt.executeUpdate(sSql2);
		}
		catch (SQLException e)
		{
			logger.fatal("更新担保标志失败！", e);
			clearResource();
			return 2;
		}
		try
		{
			String sSql3 = "{call UpdateECRFloorFlag()}";
			stmt.executeUpdate(sSql3);
		}
		catch (SQLException e)
		{
			logger.fatal("更新垫款标志失败！", e);
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void clearResource()
	{
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
			connection = null;
		}
	}
}
