// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   CheckContact.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.DateX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.Connection;
import com.amarsoft.task.*;
import java.sql.*;
import java.util.Date;

public class CheckContact extends ExecuteUnit
{

	private boolean exitTaskWhenFialed;
	private boolean autoFillContact;
	protected Log logger;
	protected Connection connection;
	protected Statement stmt;

	public CheckContact()
	{
		exitTaskWhenFialed = true;
		autoFillContact = false;
		connection = null;
		stmt = null;
	}

	public int execute()
	{
		int executeStatus = 1;
		try
		{
			transferUnitProperties();
			init();
			stmt = connection.createStatement();
			String sSql = "select count(1) from ORG_TASK_INFO where orgcode not in (select orgcode from Contact_Info)";
			logger.debug(sSql);
			ResultSet rs = stmt.executeQuery(sSql);
			int count = 0;
			if (rs.next())
				count = rs.getInt(1);
			rs.close();
			stmt.close();
			if (count > 0)
				executeStatus = 2;
			break MISSING_BLOCK_LABEL_166;
		}
		catch (Exception e)
		{
			logger.fatal((new StringBuilder(String.valueOf(getTarget().getName()))).append("[").append(getTarget().getDescribe()).append("]运行失败！").toString(), e);
			executeStatus = 2;
			e.printStackTrace();
		}
		clearResource();
		break MISSING_BLOCK_LABEL_170;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		if (executeStatus == 2)
			if (isAutoFillContact())
				try
				{
					autoFillContact();
					executeStatus = 1;
				}
				catch (Exception ex)
				{
					ARE.getLog().warn("自动填充联系人信息失败！");
					ex.printStackTrace();
				}
			else
			if (isExitTaskWhenFialed())
				setTaskEnable(getTarget().getTask(), false, (new StringBuilder(String.valueOf(getName()))).append("[").append(getDescribe()).append("]").toString());
		return executeStatus;
	}

	public void setTaskEnable(Task task, boolean enabled, String unitName)
	{
		if (task != null)
		{
			Target atarget[];
			int j = (atarget = task.getTargets()).length;
			for (int i = 0; i < j; i++)
			{
				Target target = atarget[i];
				target.setEnabled(enabled);
			}

			ARE.getLog().warn((new StringBuilder(String.valueOf(unitName))).append("运行失败，退出当前Task-").append(task.getName()).append("[").append(task.getDescribe()).append("]。。。").toString());
		}
	}

	public void autoFillContact()
		throws Exception
	{
		Connection conn = ARE.getDBConnection("ecr");
		conn.setAutoCommit(false);
		String sql = (new StringBuilder("insert into contact_info(orgcode,inputuserid,inputorgid,inputdate) (select distinct oi.orgcode,'autofilled','system','")).append(DateX.format(new Date())).append("' from org_task_info oi ").append("where oi.orgcode not in (select ci.orgcode from Contact_Info ci))").toString();
		ARE.getLog().debug((new StringBuilder("插入联系人信息：")).append(sql).toString());
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.executeUpdate();
		conn.commit();
		ps.close();
		conn.close();
		ps = null;
		conn = null;
	}

	protected void init()
		throws ECRException
	{
		logger = ARE.getLog();
		try
		{
			connection = ARE.getDBConnection("ecr");
		}
		catch (SQLException e)
		{
			throw new ECRException(e);
		}
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

	public boolean isExitTaskWhenFialed()
	{
		return exitTaskWhenFialed;
	}

	public void setExitTaskWhenFialed(boolean exitTaskWhenFialed)
	{
		this.exitTaskWhenFialed = exitTaskWhenFialed;
	}

	public boolean isAutoFillContact()
	{
		return autoFillContact;
	}

	public void setAutoFillContact(boolean autoFillContact)
	{
		this.autoFillContact = autoFillContact;
	}
}
