// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DataCheck.java

package com.amarsoft.app.datax.ecr;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.io.*;
import java.sql.*;

public class DataCheck
{

	public static final String DEFAULT_ARE_CONCFIG = "etc/icr_are.xml";
	public static final String DEFAULT_REPORT_FILE = "export/pid_data_report.csv";

	public DataCheck()
	{
	}

	public static void main(String args[])
	{
		Log logger;
		String sql;
		String reportFile;
		PrintWriter report;
		int total;
		Connection conn;
		Statement stmt;
		SQLException sqle;
		if (args.length > 0)
			ARE.init(args[0]);
		else
			ARE.init("etc/icr_are.xml");
		logger = ARE.getLog();
		sql = "";
		sql = "select * from ECR_DATAREPORT ";
		reportFile = ARE.getProperty("datareport.reportFile");
		if (reportFile == null || reportFile.trim().equals(""))
			reportFile = "export/pid_data_report.csv";
		report = null;
		try
		{
			report = new PrintWriter(new FileWriter(reportFile));
			logger.info((new StringBuilder("�򿪱����ļ���")).append(reportFile).toString());
		}
		catch (IOException e1)
		{
			ARE.getLog().fatal("�򿪱����ļ�����", e1);
			System.exit(-1);
		}
		total = 0;
		String sSessionid = "";
		String sBusinessType = "";
		String sAmountNo = "";
		double AmountSum = 0.0D;
		String sNAmountNo = "";
		double NAmountSum = 0.0D;
		String sCAmountNo = "";
		double CAmountSum = 0.0D;
		conn = null;
		stmt = null;
		ResultSet rs = null;
		sqle = null;
		report.println("�����ڴ�\tҵ������\t��ҵ����\t�ܽ��\t������\t�����ܽ��\t�仯��\t�仯�ܽ��");
		try
		{
			conn = ARE.getDBConnection("ecr");
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			logger.info("�������ݿ�ɹ���");
			double CAmountSum;
			for (; rs.next(); report.println((new StringBuilder(String.valueOf(CAmountSum))).append("\t").toString()))
			{
				total++;
				String sSessionid = rs.getString(1);
				String sBusinessType = rs.getString(2);
				String sAmountNo = rs.getString(3);
				double AmountSum = rs.getDouble(4);
				String sNAmountNo = rs.getString(5);
				double NAmountSum = rs.getDouble(6);
				String sCAmountNo = rs.getString(7);
				CAmountSum = rs.getDouble(8);
				report.print((new StringBuilder(String.valueOf(sSessionid))).append("\t").toString());
				report.print((new StringBuilder(String.valueOf(sBusinessType))).append("\t").toString());
				report.print((new StringBuilder(String.valueOf(sAmountNo))).append("\t").toString());
				report.print((new StringBuilder(String.valueOf(AmountSum))).append("\t").toString());
				report.println((new StringBuilder(String.valueOf(sNAmountNo))).append("\t").toString());
				report.println((new StringBuilder(String.valueOf(NAmountSum))).append("\t").toString());
				report.println((new StringBuilder(String.valueOf(sCAmountNo))).append("\t").toString());
			}

			rs.close();
			break MISSING_BLOCK_LABEL_633;
		}
		catch (SQLException e)
		{
			sqle = e;
			logger.fatal(e);
		}
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
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
		break MISSING_BLOCK_LABEL_683;
		Exception exception;
		exception;
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
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
		throw exception;
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
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
		if (sqle != null)
			logger.fatal("���ݿ�������󣬳����˳���");
		report.close();
		logger.info((new StringBuilder("��ϸ����鿴�����ļ���")).append(reportFile).toString());
		return;
	}
}
