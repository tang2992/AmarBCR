// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   OrganizationStore.java

package com.amarsoft.app.datax.ecr.common;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class OrganizationStore
{

	public OrganizationStore()
	{
	}

	public static String getCIFCustomerId(String tableName, String managerCertType, String managerCertId, String memberRelaType, String memberCertType, String memberCertId, String updateDate)
	{
		Connection conn = null;
		String ret = null;
		try
		{
			conn = ARE.getDBConnection("ecr");
			Statement stmt = conn.createStatement();
			String queryCIFCustomerIdSql = (new StringBuilder("select CIFCustomerId from ")).append(tableName).append(" where ManagerCertType='").append(managerCertType).append("' and ManagerCertId='").append(managerCertId).append("' and MemberRelaType='").append(memberRelaType).append("' and MemberCertType='").append(memberCertType).append("' and MemberCertId='").append(memberCertId).append("' and UpdateDate='").append(updateDate).append("' ").toString();
			ARE.getLog().debug((new StringBuilder("queryCIFCustomerIdSql : ")).append(queryCIFCustomerIdSql).toString());
			ResultSet rs = stmt.executeQuery(queryCIFCustomerIdSql);
			if (rs.next())
				ret = rs.getString(1);
			rs.close();
			stmt.close();
			conn.close();
		}
		catch (SQLException ex)
		{
			ARE.getLog().debug(ex);
			if (conn != null)
				try
				{
					conn.clearWarnings();
					conn = null;
				}
				catch (SQLException sqlexception) { }
		}
		return ret;
	}

	public static String getCustomerId(String CIFCustomerId)
	{
		Connection conn = null;
		String ret = null;
		try
		{
			conn = ARE.getDBConnection("ecr");
			Statement stmt = conn.createStatement();
			String queryLSCustomerIdSql = (new StringBuilder("select LSCustomerId from  ECR_ORGANINFO where CIFCustomerId='")).append(CIFCustomerId).append("' ").toString();
			ARE.getLog().debug((new StringBuilder("queryLSCustomerIdSql : ")).append(queryLSCustomerIdSql).toString());
			ResultSet rs = stmt.executeQuery(queryLSCustomerIdSql);
			if (rs.next())
				ret = rs.getString(1);
			rs.close();
			stmt.close();
			conn.close();
		}
		catch (SQLException ex)
		{
			ARE.getLog().debug(ex);
			if (conn != null)
				try
				{
					conn.clearWarnings();
					conn = null;
				}
				catch (SQLException sqlexception) { }
		}
		return ret;
	}
}
