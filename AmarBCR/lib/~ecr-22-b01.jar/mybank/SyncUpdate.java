// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncUpdate.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.io.PrintStream;
import java.sql.*;

public class SyncUpdate extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmtq;
	protected Statement stmt;
	protected String allTables[][] = {
		{
			"HIS_CUSTOMERINFO", "LOANCARDNO"
		}, {
			"HIS_CUSTCAPIINFO", "LOANCARDNO"
		}, {
			"HIS_CUSTOMERLAW", "LOANCARDNO"
		}, {
			"HIS_CUSTOMERFACT", "LOANCARDNO"
		}, {
			"HIS_LOANCONTRACT", "LCONTRACTNO"
		}, {
			"HIS_LOANDUEBILL", "LDUEBILLNO"
		}, {
			"HIS_LOANRETURN", "LDUEBILLNO"
		}, {
			"HIS_LOANEXTENSION", "LDUEBILLNO"
		}, {
			"HIS_FACTORING", "FACTORINGNO"
		}, {
			"HIS_DISCOUNT", "BILLNO"
		}, {
			"HIS_FINAINFO", "FCONTRACTNO"
		}, {
			"HIS_FINADUEBILL", "FDUEBILLNO"
		}, {
			"HIS_FINARETURN", "FDUEBILLNO"
		}, {
			"HIS_FINAEXTENSION", "FDUEBILLNO"
		}, {
			"HIS_CREDITLETTER", "CREDITLETTERNO"
		}, {
			"HIS_GUARANTEEBILL", "GUARANTEEBILLNO"
		}, {
			"HIS_ACCEPTANCE", "ACCEPTNO"
		}, {
			"HIS_CUSTOMERCREDIT", "CCONTRACTNO"
		}, {
			"HIS_ASSURECONT", "CONTRACTNO"
		}, {
			"HIS_GUARANTYCONT", "CONTRACTNO"
		}, {
			"HIS_IMPAWNCONT", "CONTRACTNO"
		}, {
			"HIS_FLOORFUND", "FLOORFUNDNO"
		}, {
			"HIS_INTERESTDUE", "LOANCARDNO"
		}
	};

	public SyncUpdate()
	{
		connection = null;
		stmtq = null;
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
			stmtq = connection.createStatement();
		}
		catch (SQLException e)
		{
			logger.debug("得到数据库连接时发生错误:", e);
			throw new ECRException("得到数据库连接时发生错误!", e);
		}
	}

	public void SyncOldUpdate()
		throws ECRException
	{
		String sqlQuery = "";
		String sOcurdate = "";
		String sqlUpdate = "";
		String sMainbusinessno = "";
		for (int i = 0; i < allTables.length; i++)
			try
			{
				sqlQuery = (new StringBuilder("select occurdate as occurdate,")).append(allTables[i][1]).append(" as mainbusinessno from ").append(allTables[i][0]).append(" where sessionid='0000000000'").toString();
				ResultSet rs = stmtq.executeQuery(sqlQuery);
				logger.debug(sqlQuery);
				for (; rs.next(); logger.trace((new StringBuilder("更新表名")).append(allTables[i]).toString()))
				{
					sOcurdate = rs.getString(1);
					sMainbusinessno = rs.getString(2);
					logger.debug(sMainbusinessno);
					System.out.println(sMainbusinessno);
					sqlUpdate = (new StringBuilder("update ")).append(allTables[i][0]).append(" set updatedate= '").append(sOcurdate).append("' where ").append(allTables[i][1]).append(" ='").append(sMainbusinessno).append("' and updatedate='9999/12/31' and sessionid<>'0000000000' ").toString();
					logger.debug((new StringBuilder("OldUpdate")).append(sqlUpdate).toString());
					stmt.executeUpdate(sqlUpdate);
				}

			}
			catch (SQLException e)
			{
				logger.debug((new StringBuilder("更新数据表")).append(allTables[i][0]).append("出错！").toString(), e);
			}

	}

	public void SyncNewUpdate()
		throws ECRException
	{
		String sUpdateNowTable = "";
		for (int i = 0; i < allTables.length; i++)
			try
			{
				sUpdateNowTable = (new StringBuilder("update ")).append(allTables[i][0]).append(" set updatedate= '9999/12/31'").append(" where sessionid='0000000000'").toString();
				logger.debug((new StringBuilder("newupdate")).append(sUpdateNowTable).toString());
				stmt.executeUpdate(sUpdateNowTable);
				logger.trace((new StringBuilder("更新表名")).append(allTables[i]).toString());
			}
			catch (SQLException e)
			{
				logger.debug((new StringBuilder("更新数据表")).append(allTables[i][0]).append("出错！").toString(), e);
			}

	}

	public int execute()
	{
		try
		{
			init();
			SyncOldUpdate();
			SyncNewUpdate();
		}
		catch (ECRException e)
		{
			logger.fatal((new StringBuilder("更新日期出错！")).append(e.getMessage()).toString());
			return 2;
		}
		clearResource();
		logger.info("更新日期信息完成！");
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
		if (stmtq != null)
		{
			try
			{
				stmtq.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
			stmtq = null;
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
