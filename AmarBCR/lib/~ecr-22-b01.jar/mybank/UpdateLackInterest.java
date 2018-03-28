// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   UpdateLackInterest.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.Target;
import java.sql.*;

public class UpdateLackInterest extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmt;
	public static final String PROPERTY_DATABASE = "database";

	public UpdateLackInterest()
	{
		connection = null;
		stmt = null;
	}

	protected void init()
		throws ECRException
	{
		logger = ARE.getLog();
		String database = "ecr";
		if (database == null || database.equals(""))
			database = getTarget().getProperty("database");
		try
		{
			connection = ARE.getDBConnection(database);
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
			stmt = connection.createStatement();
			stmt.executeUpdate("Update ECR_INTERESTDUE set InterestBalance=0.00,ChangeDate=to_char(sysdate-1,'yyyymmdd'),UpdateDate=to_char(sysdate-1,'yyyymmdd'),IncrementFlag='3' where IncrementFlag='2' and InterestBalance>0 and ChangeDate=( select max(I.ChangeDate) from ECR_INTERESTDUE I  where I.CustomerID= ECR_INTERESTDUE.CustomerID and I.FinanceID = ECR_INTERESTDUE.FinanceID  and I.InterestType = ECR_INTERESTDUE.InterestType)");
			clearResource();
		}
		catch (Exception e)
		{
			logger.fatal("更新欠息时发生错误", e);
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void clearResource()
	{
		if (stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
			connection = null;
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
