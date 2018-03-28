// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DelUnExistStockHolder.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class DelUnExistStockHolder extends ExecuteUnit
{

	protected Log logger;
	protected Connection conn;
	private PreparedStatement psDeleteStockHolder;
	private String selectSql;
	private boolean checkDigest;

	public DelUnExistStockHolder()
	{
		conn = null;
		psDeleteStockHolder = null;
		selectSql = "select cifcustomerid from ECR_ORGANSTOCKHOLDER group by cifcustomerid having count(distinct organdigest)>1 ";
		checkDigest = false;
	}

	protected void init()
		throws SQLException
	{
		logger = ARE.getLog();
		try
		{
			conn = ARE.getDBConnection("ecr");
			conn.setAutoCommit(false);
			String deleteStockHolderSql = (new StringBuilder("delete from ECR_ORGANSTOCKHOLDER where organdigest='")).append(ARE.getProperty("ORGANDIGEST")).append("' AND CIFCUSTOMERID=? ").toString();
			psDeleteStockHolder = conn.prepareStatement(deleteStockHolderSql);
		}
		catch (SQLException e)
		{
			logger.error("������ݿ�����ʧ�� ! ");
			throw e;
		}
	}

	public static int getSum(int arr[])
	{
		int sum = 0;
		int ai[];
		int k = (ai = arr).length;
		for (int j = 0; j < k; j++)
		{
			int i = ai[j];
			sum += i;
		}

		return sum;
	}

	public int execute()
	{
		int flag = 1;
		try
		{
			transferUnitProperties();
			init();
			logger.info("ɾ���Ŵ�ϵͳ���Ѳ����ڵĹɶ���Ϣ��ʼ...");
			if (!StringX.isEmpty(ARE.getProperty("ORGANDIGEST")))
			{
				if (checkStockHolder())
				{
					if (checkDigest)
						delUnExistStockHolder2();
					else
						delUnExistStockHolder();
					logger.info("ɾ���Ŵ�ϵͳ���Ѳ����ڵĹɶ���Ϣ�ɹ��� ");
				} else
				{
					logger.info("��鵽�ɶ���¼ȫ��δ��ǣ���鿴�����߼��Ƿ���ȷ��");
				}
			} else
			{
				logger.warn("ORGANDIGEST����δ���ã��������йɶ���ȡ��Ԫ");
			}
			break MISSING_BLOCK_LABEL_153;
		}
		catch (Exception e)
		{
			try
			{
				conn.rollback();
			}
			catch (SQLException e1)
			{
				logger.error(e1);
			}
			logger.error("ɾ���Ŵ�ϵͳ���Ѳ����ڵĹɶ���Ϣʧ�ܣ�", e);
			flag = 2;
		}
		clearResource();
		break MISSING_BLOCK_LABEL_157;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return flag;
	}

	private boolean checkStockHolder()
		throws SQLException
	{
		StringBuffer sBuf = new StringBuffer();
		sBuf.append((new StringBuilder(" select count(1) from ECR_ORGANSTOCKHOLDER where organdigest='")).append(ARE.getProperty("ORGANDIGEST")).append("' ").toString());
		logger.debug(sBuf.toString());
		Statement stat = conn.createStatement();
		int count = 0;
		ResultSet rs = stat.executeQuery(sBuf.toString());
		if (rs.next())
			count = rs.getInt(1);
		rs.close();
		stat.close();
		return count > 0;
	}

	private void delUnExistStockHolder2()
		throws SQLException
	{
		Statement st = conn.createStatement();
		ResultSet rs;
		for (rs = st.executeQuery(selectSql); rs.next(); psDeleteStockHolder.addBatch())
			psDeleteStockHolder.setString(1, rs.getString(1));

		int count[] = psDeleteStockHolder.executeBatch();
		rs.close();
		st.close();
		conn.commit();
		logger.trace((new StringBuilder("ɾ���Ŵ�ϵͳ���Ѳ����ڵĹɶ���Ϣ��������")).append(getSum(count)).toString());
	}

	private void delUnExistStockHolder()
		throws SQLException
	{
		StringBuffer sBuf = new StringBuffer();
		sBuf.append((new StringBuilder(" delete from ECR_ORGANSTOCKHOLDER where organdigest<>'")).append(ARE.getProperty("ORGANDIGEST")).append("' ").toString());
		logger.debug(sBuf.toString());
		Statement stat = conn.createStatement();
		int updateNum = stat.executeUpdate(sBuf.toString());
		conn.commit();
		logger.trace((new StringBuilder("ɾ���Ŵ�ϵͳ���Ѳ����ڵĹɶ���Ϣ��������")).append(updateNum).toString());
		stat.close();
	}

	private void clearResource()
	{
		if (psDeleteStockHolder != null)
			try
			{
				psDeleteStockHolder.executeBatch();
				psDeleteStockHolder.close();
				psDeleteStockHolder = null;
			}
			catch (SQLException e)
			{
				logger.debug("�ر�psDeleteStockHolder����", e);
			}
		if (conn != null)
			try
			{
				conn.close();
				conn = null;
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
	}
}
