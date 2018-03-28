// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncFinanceMap.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncFinanceMap extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmt;
	private PreparedStatement pstmtSelectorg;
	private PreparedStatement pstmtInsert;

	public SyncFinanceMap()
	{
		connection = null;
		stmt = null;
		pstmtSelectorg = null;
		pstmtInsert = null;
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
			logger.info("开始更新机构信息...");
			syncfinace();
		}
		catch (SQLException e)
		{
			logger.fatal("更新机构失败！", e);
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void syncfinace()
		throws SQLException
	{
		String sqlQueryorg = "select * from org_info where (bankid<>'' and bankid is not null) and bankid not in(select pbcode from ecr_codemap where colname='6501')";
		String sqlInsert = "insert into ecr_codemap(colname,ctcode,pbcode,note) values(?,?,?,?)";
		String ls_orgid = "";
		String ls_bankid = "";
		String ls_colname = "6501";
		String ls_orgname = "";
		logger.debug(sqlQueryorg);
		logger.debug(sqlInsert);
		pstmtSelectorg = connection.prepareStatement(sqlQueryorg);
		pstmtInsert = connection.prepareStatement(sqlInsert);
		ResultSet rs;
		for (rs = stmt.executeQuery(sqlQueryorg); rs.next(); pstmtInsert.executeUpdate())
		{
			ls_orgid = rs.getString("orgid");
			ls_bankid = rs.getString("bankid");
			ls_orgname = rs.getString("orgname");
			pstmtInsert.setString(1, ls_colname);
			pstmtInsert.setString(2, ls_orgid);
			pstmtInsert.setString(3, ls_bankid);
			pstmtInsert.setString(4, ls_orgname);
		}

		rs.close();
		pstmtInsert.close();
		pstmtInsert = null;
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
		if (pstmtInsert != null)
		{
			try
			{
				pstmtInsert.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtInsert = null;
		}
		if (pstmtSelectorg != null)
		{
			try
			{
				pstmtSelectorg.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtSelectorg = null;
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
