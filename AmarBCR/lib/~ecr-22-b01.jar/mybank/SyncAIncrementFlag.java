// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncAIncrementFlag.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;
import java.util.*;

public class SyncAIncrementFlag extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmt;
	private HashMap bizStatements;
	private PreparedStatement pstmtUpdate;
	protected String tables[][] = {
		{
			"ECR_LOANCONTRACT", "Lcontractno", "1"
		}, {
			"ECR_FACTORING", "FactoringNo", "2"
		}, {
			"ECR_FINAINFO", "FContractNo", "4"
		}, {
			"ECR_CREDITLETTER", "CreditLetterNo", "5"
		}, {
			"ECR_GUARANTEEBILL", "GuaranteeBillNo", "6"
		}, {
			"ECR_ACCEPTANCE", "AcceptNo", "7"
		}
	};

	public SyncAIncrementFlag()
	{
		connection = null;
		stmt = null;
		bizStatements = null;
		pstmtUpdate = null;
	}

	protected void init()
		throws ECRException
	{
		logger = ARE.getLog();
		String database = "ecr";
		try
		{
			connection = ARE.getDBConnection(database);
			stmt = connection.createStatement(1003, 1008);
		}
		catch (SQLException e)
		{
			throw new ECRException(e);
		}
		bizStatements = new HashMap();
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
				updateAssureTable(tables[i][0], tables[i][1], tables[i][2]);
				updateGuarantyTable(tables[i][0], tables[i][1], tables[i][2]);
				updateImpawnTable(tables[i][0], tables[i][1], tables[i][2]);
			}
			catch (SQLException e)
			{
				logger.fatal("更新担保标志失败！", e);
				clearResource();
				return 2;
			}

		clearResource();
		return 1;
	}

	private void updateAssureTable(String updateTable, String updateGuarantyFlag, String businessType)
		throws SQLException
	{
		StringBuffer sql = new StringBuffer("update ecr_assurecont ");
		sql.append(" set ").append(" incrementflag='2', occurdate='").append(Tools.getLastDay("1")).append("' where contractno in(select ").append(updateGuarantyFlag).append(" from ").append(updateTable).append(" where incrementflag ='2') and businesstype='").append(businessType).append("' and incrementflag='8'");
		logger.trace(sql.toString());
		stmt.executeUpdate(sql.toString());
	}

	private void updateGuarantyTable(String updateTable, String updateGuarantyFlag, String businessType)
		throws SQLException
	{
		StringBuffer sql = new StringBuffer("update ecr_guarantycont ");
		sql.append(" set ").append(" incrementflag='2', occurdate='").append(Tools.getLastDay("1")).append("' where contractno in(select ").append(updateGuarantyFlag).append(" from ").append(updateTable).append(" where incrementflag ='2') and businesstype='").append(businessType).append("' and incrementflag='8'");
		logger.trace(sql.toString());
		stmt.executeUpdate(sql.toString());
	}

	private void updateImpawnTable(String updateTable, String updateGuarantyFlag, String businessType)
		throws SQLException
	{
		StringBuffer sql = new StringBuffer("update ecr_impawncont ");
		sql.append(" set ").append(" incrementflag='2',occurdate='").append(Tools.getLastDay("1")).append("' where contractno in(select ").append(updateGuarantyFlag).append(" from ").append(updateTable).append(" where incrementflag ='2') and businesstype='").append(businessType).append("' and incrementflag='8'");
		logger.trace(sql.toString());
		stmt.executeUpdate(sql.toString());
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
				logger.debug(e);
			}
			stmt = null;
		}
		if (pstmtUpdate != null)
		{
			try
			{
				pstmtUpdate.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdate = null;
		}
		if (bizStatements != null)
		{
			for (Iterator it = bizStatements.values().iterator(); it.hasNext();)
				try
				{
					((PreparedStatement)it.next()).close();
				}
				catch (SQLException e)
				{
					logger.debug(e);
				}

			bizStatements.clear();
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
}
