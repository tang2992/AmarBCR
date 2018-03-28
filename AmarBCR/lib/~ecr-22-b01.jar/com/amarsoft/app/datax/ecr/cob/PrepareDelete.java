// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   PrepareDelete.java

package com.amarsoft.app.datax.ecr.cob;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.RecordDBReflector;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.log.Log;
import java.sql.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.cob:
//			RecordStub

public class PrepareDelete
{

	public static String database = "ecr";

	public PrepareDelete()
	{
	}

	public static void setRecordToDelete(RecordStub recordStub)
		throws ECRException
	{
		changeRecordPool(recordStub, "0000000000", "4");
	}

	private static void changeRecordPool(RecordStub recordStub, String newSessionId, String newIncrementFlag)
		throws ECRException
	{
		if (ARE.getLog().isTraceEnabled())
			ARE.getLog().trace(recordStub);
		String sessionId = recordStub.getSessionId();
		String incrementFlag = recordStub.getIncrementFlag();
		if (incrementFlag != null && incrementFlag.equals("4"))
			throw new ECRException("删除类型已经设定,不能重复设置！");
		if (sessionId == null || sessionId.equals("0000000000") || sessionId.equals("6666666666"))
			throw new ECRException("未上报或不需要上报的纪录不能设置单笔删除！");
		Connection conn = null;
		try
		{
			conn = ARE.getDBConnection(database);
			int isolation = ARE.getProperty("connection.ecr.isolation", -1);
			if (isolation != -1)
			{
				ARE.getLog().debug((new StringBuilder("JDBC transactionIsolation set to ")).append(isolation).toString());
				conn.setTransactionIsolation(isolation);
			}
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			String sql[] = prepareSql(recordStub, newSessionId, newIncrementFlag);
			for (int i = 1; i < sql.length; i++)
				if (sql[i] != null)
				{
					ARE.getLog().debug((new StringBuilder("PrepareDelete process sql: ")).append(sql[i]).toString());
					stmt.executeUpdate(sql[i]);
				}

			conn.commit();
			stmt.close();
			conn.close();
		}
		catch (SQLException e)
		{
			if (conn != null)
			{
				try
				{
					conn.rollback();
					conn.close();
				}
				catch (SQLException ex)
				{
					ARE.getLog().debug(ex);
				}
				conn = null;
			}
			ARE.getLog().debug(e);
			throw new ECRException("处理反馈记录数据库错误！", e);
		}
	}

	private static String[] prepareSql(RecordStub recordStub, String newSessionId, String incrementflag)
		throws SQLException
	{
		String sqls[] = new String[10];
		RecordDBReflector reflector = RecordDBReflector.getReflector(recordStub.getRecordType());
		Field keys[] = recordStub.getRecordKey();
		StringBuffer sbWhere = new StringBuffer();
		sbWhere.append(" where SessionID='").append(recordStub.getSessionId()).append("'").append(" and OccurDate='").append(recordStub.getOccurDate()).append("'");
		for (int i = 0; i < keys.length; i++)
			if (keys[i].getType() == 1)
				sbWhere.append(" and ").append(keys[i].getName()).append("=").append(keys[i].getInt());
			else
				sbWhere.append(" and ").append(keys[i].getName()).append("='").append(keys[i].getString()).append("'");

		String sWhere = sbWhere.toString();
		sqls[1] = (new StringBuilder("update HIS_")).append(reflector.getMainTable()).append(" set SessionId='").append(newSessionId).append("',IncrementFlag='").append(incrementflag).append("'").append(sWhere).toString();
		String rtables[] = reflector.getRelativeTables();
		for (int i = 1; i < rtables.length; i++)
			sqls[i + 1] = (new StringBuilder("update HIS_")).append(rtables[i]).append(" set SessionId='").append(newSessionId).append("',IncrementFlag='").append(incrementflag).append("'").append(sWhere).toString();

		return sqls;
	}

}
