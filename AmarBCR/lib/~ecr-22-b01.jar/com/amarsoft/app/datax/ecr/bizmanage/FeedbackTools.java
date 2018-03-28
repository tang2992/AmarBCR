// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FeedbackTools.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.cob.RecordStub;
import com.amarsoft.app.datax.ecr.common.RecordDBReflector;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class FeedbackTools
{

	public static String database = "ecr";

	public FeedbackTools()
	{
	}

	public static void setRecordToRetry(RecordStub recordStub)
		throws ECRException
	{
		changeRecordPool(recordStub, "1111111111");
	}

	public static void setRecordToNeedntRetry(RecordStub recordStub)
		throws ECRException
	{
		changeRecordPool(recordStub, "6666666666");
	}

	private static void changeRecordPool(RecordStub recordStub, String newSessionId)
		throws ECRException
	{
		if (ARE.getLog().isTraceEnabled())
			ARE.getLog().trace(recordStub);
		String sessionId = recordStub.getSessionId();
		if (!sessionId.equals("9999999999"))
			throw new ECRException("������Ч�ķ�����¼������������������");
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
			String sql[] = prepareSql(recordStub, newSessionId);
			for (int i = 0; i < sql.length; i++)
				if (sql[i] != null)
				{
					ARE.getLog().debug((new StringBuilder("Feedback process sql: ")).append(sql[i]).toString());
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
			throw new ECRException("��������¼���ݿ����", e);
		}
	}

	private static String[] prepareSql(RecordStub recordStub, String newSessionId)
		throws SQLException
	{
		String sqls[] = new String[10];
		sqls[0] = (new StringBuilder("delete from ECR_FEEDBACK where TraceNumber='")).append(recordStub.getTraceNumber()).append("'").toString();
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
		sqls[1] = (new StringBuilder("update HIS_")).append(reflector.getMainTable()).append(" set SessionId='").append(newSessionId).append("'").append(sWhere).toString();
		String rtables[] = reflector.getRelativeTables();
		for (int i = 0; i < rtables.length; i++)
			sqls[i + 2] = (new StringBuilder("update HIS_")).append(rtables[i]).append(" set SessionId='").append(newSessionId).append("'").append(sWhere).toString();

		return sqls;
	}

}
