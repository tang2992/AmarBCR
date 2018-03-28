// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   OrgListUnit.java

package com.amarsoft.app.datax.ecr.common;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.DataSourceURI;
import com.amarsoft.are.sql.TabularReader;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.Target;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

public class OrgListUnit extends ExecuteUnit
{

	private String orgListSource;
	private Iterator ol;
	private Iterator ol2;
	boolean inited;

	public OrgListUnit()
	{
		orgListSource = null;
		ol = null;
		ol2 = null;
		inited = false;
	}

	public int execute()
	{
		if (!inited)
		{
			if (!init())
				ARE.getLog().error("初始化失败！");
			inited = true;
		}
		if (ol == null)
			return 2;
		if (ol.hasNext())
		{
			String orgcode = (String)ol.next();
			String orgname = (String)ol2.next();
			getTarget().setProperty("BankID", orgcode);
			getTarget().setProperty("BankName", orgname);
			ARE.getLog().debug((new StringBuilder("Current orgname: ")).append(orgname).toString());
			return 1;
		} else
		{
			ARE.getLog().debug("No more org");
			return 2;
		}
	}

	private boolean init()
	{
		transferUnitProperties();
		DataSourceURI ds = null;
		if (getOrgListSource() == null)
		{
			ARE.getLog().error("机构选择数据源未设置！");
			return false;
		}
		try
		{
			ds = new DataSourceURI(getOrgListSource());
		}
		catch (URISyntaxException e)
		{
			ARE.getLog().error("机构选择数据源不正确！", e);
			return false;
		}
		ArrayList orgCodeList = new ArrayList();
		ArrayList orgNameList = new ArrayList();
		TabularReader tr = new TabularReader(ds);
		try
		{
			while (tr.next()) 
			{
				orgCodeList.add(tr.getString(1));
				orgNameList.add(tr.getString(2));
			}
			tr.close();
		}
		catch (SQLException ex)
		{
			ARE.getLog().error("获取机构列表出错！", ex);
			tr.close();
			return false;
		}
		ol = orgCodeList.iterator();
		ol2 = orgNameList.iterator();
		ARE.getLog().debug((new StringBuilder("OrgList Size: ")).append(orgCodeList.size()).toString());
		return true;
	}

	public String getOrgListSource()
	{
		return orgListSource;
	}

	public void setOrgListSource(String orgListSource)
	{
		this.orgListSource = orgListSource;
	}
}
