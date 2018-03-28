// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DelErrData.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class DelErrData extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmt;
	protected String allTables[] = {
		"ECR_LOANCONTRACT", "ECR_LOANDUEBILL", "ECR_LOANRETURN", "ECR_LOANEXTENSION", "ECR_FACTORING", "ECR_DISCOUNT", "ECR_FINAINFO", "ECR_FINADUEBILL", "ECR_FINARETURN", "ECR_FINAEXTENSION", 
		"ECR_CREDITLETTER", "ECR_GUARANTEEBILL", "ECR_ACCEPTANCE", "ECR_CUSTOMERCREDIT", "ECR_ASSURECONT", "ECR_GUARANTYCONT", "ECR_IMPAWNCONT", "ECR_FLOORFUND", "ECR_INTERESTDUE"
	};

	public DelErrData()
	{
		connection = null;
		stmt = null;
		try
		{
			init();
		}
		catch (ECRException e)
		{
			logger.fatal("初始化失败", e);
			clearResource();
		}
	}

	protected void init()
		throws ECRException
	{
		if (logger == null)
			logger = ARE.getLog();
		try
		{
			if (connection == null)
				connection = ARE.getDBConnection("ecr");
			stmt = connection.createStatement();
		}
		catch (SQLException e)
		{
			logger.debug("得到数据库连接时发生错误:", e);
			throw new ECRException("得到数据库连接时发生错误!", e);
		}
	}

	public void DelCustomerinfo()
		throws ECRException
	{
		for (int i = 0; i < allTables.length; i++)
			try
			{
				stmt.executeUpdate((new StringBuilder("delete from ")).append(allTables[i]).append(" where loancardno in(select loancardno from ecr_batchdel where delresult='1')").toString());
				logger.trace((new StringBuilder("删除表名")).append(allTables[i]).toString());
			}
			catch (SQLException e)
			{
				logger.debug((new StringBuilder("删除数据表")).append(allTables[i]).append("出错！").toString(), e);
			}

	}

	public int execute()
	{
		try
		{
			init();
			DelCustomerinfo();
		}
		catch (ECRException e)
		{
			logger.fatal((new StringBuilder("删除无客户业务信息出错！")).append(e.getMessage()).toString());
			return 2;
		}
		clearResource();
		logger.info("删除无客户业务信息完成！");
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
			stmt = null;
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
