// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncErrFinance.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncErrFinance extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmt;
	protected String tables[][] = {
		{
			"ECR_CUSTOMERINFO"
		}, {
			"ECR_CUSTOMERKEEPER"
		}, {
			"ECRP_FINANCEBS"
		}, {
			"ECRP_FINANCEPS"
		}, {
			"ECRP_FINANCECF"
		}, {
			"ECR_CUSTOMERLAW"
		}, {
			"ECR_CUSTOMERFACT"
		}, {
			"ECR_CONTRACT"
		}, {
			"ECR_DUEBILL"
		}, {
			"ECR_LOANRETURN"
		}, {
			"ECR_EXTENSION"
		}, {
			"ECR_GUARANTEEBILL"
		}, {
			"ECR_FACTORING"
		}, {
			"ECR_FLOORFUND"
		}, {
			"ECR_CUSTOMERCREDIT"
		}, {
			"ECR_FINANCEINFO"
		}, {
			"ECR_FINADUEBILL"
		}, {
			"ECR_FINANCERETURN"
		}, {
			"ECR_FINAEXTENSION"
		}, {
			"ECR_DISCOUNT"
		}, {
			"ECR_INTERESTDUE"
		}, {
			"ECR_CREDITLETTER"
		}, {
			"ECR_ACCEPTANCE"
		}, {
			"ECR_ASSURECONT"
		}, {
			"ECR_GUARANTYCONT"
		}, {
			"ECR_IMPAWNCONT"
		}, {
			"ECR_CUSTOMERCREDIT"
		}
	};
	public static final String PROPERTY_DATABASE = "database";

	public SyncErrFinance()
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
		for (int i = 0; i < tables.length; i++)
			try
			{
				updateTable(tables[i][0]);
			}
			catch (SQLException e)
			{
				logger.fatal("更新金融机构失败！", e);
				clearResource();
				return 2;
			}

		clearResource();
		return 1;
	}

	private void updateTable(String updateTable)
		throws SQLException
	{
		StringBuffer sql = new StringBuffer("update ");
		sql.append(updateTable).append(" set Financeid='29003090004' where len(financeid)<5");
		logger.trace(sql.toString());
		stmt.executeUpdate(sql.toString());
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
