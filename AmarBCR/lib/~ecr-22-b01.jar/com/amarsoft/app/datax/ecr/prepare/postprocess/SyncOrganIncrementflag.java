// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncOrganIncrementflag.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.io.PrintStream;
import java.sql.*;

public class SyncOrganIncrementflag extends ExecuteUnit
{

	protected Log logger;
	protected Connection conn;

	public SyncOrganIncrementflag()
	{
		conn = null;
	}

	protected void init()
		throws SQLException
	{
		logger = ARE.getLog();
		try
		{
			conn = ARE.getDBConnection("ecr");
			conn.setAutoCommit(false);
		}
		catch (SQLException e)
		{
			logger.error("获得数据库连接失败 ! ");
			throw e;
		}
	}

	public int execute()
	{
		try
		{
			init();
			logger.info("开始更新机构信息增量标志...");
			updateIncrementflag();
			logger.info("更新机构信息增量标志成功 ");
			break MISSING_BLOCK_LABEL_82;
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
			logger.error("更新机构信息增量标志失败！", e);
		}
		clearResource();
		return 2;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return 1;
	}

	private void updateIncrementflag()
		throws SQLException
	{
		String ecrTables[] = {
			"ECR_ORGANATTRIBUTE", "ECR_ORGANSTATUS", "ECR_ORGANCONTACT", "ECR_ORGANKEEPER", "ECR_ORGANSTOCKHOLDER", "ECR_ORGANRELATED", "ECR_ORGANSUPERIOR"
		};
		StringBuffer sBuf = new StringBuffer();
		sBuf.append((new StringBuilder(" update  ECR_organInfo  set  IncrementFlag='2' , OccurDate='")).append(ARE.getProperty("occurDate")).append("' ").append("  where IncrementFlag='").append("8").append("' and CIFCustomerID in ( ").toString());
		for (int i = 0; i < ecrTables.length; i++)
		{
			if (i != 0)
				sBuf.append(" union ");
			sBuf.append((new StringBuilder("select CIFCustomerID from ")).append(ecrTables[i]).append(" where   (IncrementFlag='").append("1").append("' or IncrementFlag='").append("2").append("')  ").toString());
		}

		sBuf.append(")");
		logger.debug(sBuf.toString());
		Statement stat = conn.createStatement();
		int updateNum = stat.executeUpdate(sBuf.toString());
		String updateECR_Holder = (new StringBuilder("update ECR_ORGANSTOCKHOLDER set incrementFlag='2' , OccurDate='")).append(ARE.getProperty("occurDate")).append("' ").append(" where incrementFlag='").append("8").append("'  and ").append("      CIFCustomerID in ( select  CIFCustomerID   from  ECR_ORGANSTOCKHOLDER  where IncrementFlag='").append("1").append("' or IncrementFlag='").append("2").append("') ").toString();
		System.out.println((new StringBuilder("updateECR_Holder:")).append(updateECR_Holder).toString());
		int updateHolderNum = stat.executeUpdate(updateECR_Holder);
		String updateECR_related = (new StringBuilder("update ECR_ORGANRELATED set incrementFlag='2' , OccurDate='")).append(ARE.getProperty("occurDate")).append("' ").append(" where incrementFlag='").append("8").append("'  and  ").append("     CIFCustomerID in ( select  CIFCustomerID   from  ECR_ORGANRELATED  where IncrementFlag='").append("1").append("' or IncrementFlag='").append("2").append("') ").toString();
		int updateRelatedNum = stat.executeUpdate(updateECR_related);
		conn.commit();
		logger.trace((new StringBuilder("更新机构信息基础段增量标志的条数：")).append(updateNum).toString());
		logger.trace((new StringBuilder("更新股东信息增量标志的条数：")).append(updateHolderNum).toString());
		logger.trace((new StringBuilder("更新关联企业增量标志的条数：")).append(updateRelatedNum).toString());
		stat.close();
	}

	private void clearResource()
	{
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
