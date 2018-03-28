// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   CustomerStore.java

package com.amarsoft.app.datax.ecr.common;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.*;
import java.util.TreeMap;

public class CustomerStore
{

	private static TreeMap indexOfId = null;
	private static TreeMap indexOfLoanCard = null;
	private static String database = "ecr";
	private static String queryLoanCardNo = "select LoanCardNo from ECR_ORGANINFO where CustomerId='";
	private static String queryCustomerId = "select CifCustomerId from ECR_ORGANINFO where LoanCardNo='";

	public CustomerStore()
	{
	}

	public static String getCustomerId(String loanCardNo, String financeId)
	{
		if (indexOfLoanCard == null)
			indexOfLoanCard = new TreeMap();
		if (indexOfId == null)
			indexOfId = new TreeMap();
		if (loanCardNo == null)
			return null;
		String id = (String)indexOfLoanCard.get((new StringBuilder(String.valueOf(loanCardNo))).append(financeId).toString());
		if (id == null)
		{
			id = queryDB2(loanCardNo, financeId);
			if (id != null)
			{
				indexOfLoanCard.put((new StringBuilder(String.valueOf(loanCardNo))).append(financeId).toString(), id);
				indexOfId.put(id, loanCardNo);
			}
		}
		return id;
	}

	private static String queryDB2(String loanCardNo, String financeId)
	{
		Connection conn = null;
		String ret = null;
		try
		{
			conn = ARE.getDBConnection(database);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery((new StringBuilder(String.valueOf(queryCustomerId))).append(loanCardNo).append("' and financeId ='").append(financeId).append("'").toString());
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

	public static String getCustomerId(String loanCardNo)
	{
		if (indexOfLoanCard == null)
			indexOfLoanCard = new TreeMap();
		if (indexOfId == null)
			indexOfId = new TreeMap();
		if (loanCardNo == null)
			return null;
		String id = (String)indexOfLoanCard.get(loanCardNo);
		if (id == null)
		{
			id = queryDB(loanCardNo, false);
			if (id != null)
			{
				indexOfLoanCard.put(loanCardNo, id);
				indexOfId.put(id, loanCardNo);
			}
		}
		return id;
	}

	public static String getLoanCardNo(String customerId)
	{
		if (indexOfLoanCard == null)
			indexOfLoanCard = new TreeMap();
		if (indexOfId == null)
			indexOfId = new TreeMap();
		String lc = (String)indexOfId.get(customerId);
		if (lc == null)
		{
			lc = queryDB(customerId, true);
			if (lc != null)
			{
				indexOfId.put(customerId, lc);
				indexOfLoanCard.put(lc, customerId);
			}
		}
		return lc;
	}

	private static String queryDB(String param, boolean queryLoanCard)
	{
		Connection conn = null;
		String ret = null;
		try
		{
			conn = ARE.getDBConnection(database);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery((new StringBuilder(String.valueOf(queryLoanCard ? ((Object) (queryLoanCardNo)) : ((Object) (queryCustomerId))))).append(param).append("'").toString());
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

	public static String getDatabase()
	{
		return database;
	}

	public static void setDatabase(String database)
	{
		database = database;
	}

}
