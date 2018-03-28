// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   Sample2.java

package mybank;

import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Sample2 extends ExecuteUnit
{

	private Connection conn;
	private PreparedStatement pstmt;
	private Log logger;
	boolean ok;

	public Sample2()
	{
		conn = null;
		pstmt = null;
		logger = ARE.getLog();
		ok = true;
	}

	public int execute()
	{
		logger.info("开始执行Sample2...");
		try
		{
			conn = ARE.getDBConnection("ecr");
		}
		catch (SQLException ex)
		{
			logger.debug("连接征信数据库失败！", ex);
			logger.fatal("连接征信数据库失败，Sample2执行结束");
			return 2;
		}
		try
		{
			String sql = "select sessionId from ECR_SESSION where CreateTime>?";
			pstmt = conn.prepareStatement(sql);
			String argDate = getProperty("dateArgument", "2005/01/01");
			java.util.Date d = StringX.parseDate(argDate);
			pstmt.setDate(1, new Date(d.getTime()));
			ResultSet rs;
			for (rs = pstmt.executeQuery(); rs.next();)
				if (logger.isTraceEnabled())
					logger.trace(rs.getString(1));

			rs.close();
			pstmt.close();
			break MISSING_BLOCK_LABEL_271;
		}
		catch (SQLException ex)
		{
			logger.debug(ex);
			ok = false;
		}
		if (conn != null)
			try
			{
				conn.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
		conn = null;
		break MISSING_BLOCK_LABEL_308;
		Exception exception;
		exception;
		if (conn != null)
			try
			{
				conn.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
		conn = null;
		throw exception;
		if (conn != null)
			try
			{
				conn.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
		conn = null;
		if (ok)
		{
			logger.info("Sample2成功执行结束！");
			return 2;
		} else
		{
			logger.fatal("Sample2执行数据库操作失败！");
			return 2;
		}
	}
}
