// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncErrorLoancardNO.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.RecordDBReflector;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncErrorLoancardNO extends ExecuteUnit
{

	private Connection connection;
	private PreparedStatement psDeleteCustomerInfo;
	private Statement stDelete;
	private PreparedStatement psSelectGuaranty;
	private String database;
	private String sqlDeleteCustomerInfo;
	private String sqlSelectGuaranty;
	protected String tables[][] = {
		{
			"ECR_CUSTCAPIINFO", "LoanCardNO", "2"
		}, {
			"ECR_CUSTOMERLAW", "LoanCardNO", "6"
		}, {
			"ECR_CUSTOMERFACT", "LoanCardNO", "7"
		}, {
			"ECR_FINANCEBS", "LoanCardNO", "3"
		}, {
			"ECR_FINANCEPS", "LoanCardNO", "4"
		}, {
			"ECR_FINANCECF", "LoanCardNO", "5"
		}, {
			"ECR_LOANCONTRACT", "LContractNO", "8"
		}, {
			"ECR_FACTORING", "FACTORINGNO", "12"
		}, {
			"ECR_DISCOUNT", "BillNO", "13"
		}, {
			"ECR_FINAINFO", "FContractNO", "14"
		}, {
			"ECR_CREDITLETTER", "CREDITLETTERNO", "18"
		}, {
			"ECR_GUARANTEEBILL", "GUARANTEEBILLNO", "19"
		}, {
			"ECR_ACCEPTANCE", "ACCEPTNO", "20"
		}, {
			"ECR_CUSTOMERCREDIT", "CCONTRACTNO", "21"
		}, {
			"ECR_FLOORFUND", "FLOORFUNDNO", "25"
		}, {
			"ECR_INTERESTDUE", "LoanCardNO", "26"
		}
	};

	public SyncErrorLoancardNO()
	{
		connection = null;
		psDeleteCustomerInfo = null;
		stDelete = null;
		psSelectGuaranty = null;
		database = "ecr";
		sqlDeleteCustomerInfo = "delete from ECR_CUSTOMERINFO where LoanCardNO in (select MainbusinessNO from ECR_ERRHISTORY where RecordType='1' and ErrCode='4034' and MainbusinessNO is not null)";
		sqlSelectGuaranty = "select RecordType,RecordKey,ErrMsg from ECR_ERRHISTORY where ErrCode = '4034' and RecordType in ('22','23','24') order by RecordType asc";
	}

	protected void init()
		throws ECRException
	{
		try
		{
			connection = ARE.getDBConnection(getDatabase());
			logger.trace(sqlDeleteCustomerInfo);
			psDeleteCustomerInfo = connection.prepareStatement(sqlDeleteCustomerInfo);
			logger.trace(sqlSelectGuaranty);
			psSelectGuaranty = connection.prepareStatement(sqlSelectGuaranty);
			stDelete = connection.createStatement();
		}
		catch (SQLException e)
		{
			throw new ECRException(e);
		}
	}

	public int execute()
	{
		transferUnitProperties();
		try
		{
			init();
		}
		catch (ECRException e)
		{
			logger.fatal("初始化数据库连接失败", e);
			clearResource();
			return 2;
		}
		for (int i = 0; i < tables.length; i++)
			try
			{
				updateTable(tables[i][0], tables[i][1], tables[i][2]);
			}
			catch (SQLException e)
			{
				logger.fatal("更新贷款卡为空失败！", e);
				clearResource();
				return 2;
			}

		try
		{
			deleteGuaranty();
		}
		catch (SQLException e)
		{
			logger.fatal("删除担保人贷款卡编码错误数据失败！", e);
			clearResource();
			return 2;
		}
		try
		{
			psDeleteCustomerInfo.execute();
		}
		catch (SQLException e)
		{
			logger.fatal("删除客户信息中贷款卡编码错误数据失败！", e);
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void updateTable(String updateTable, String keyColumn, String recordtype)
		throws SQLException
	{
		StringBuffer sql = new StringBuffer("update ");
		sql.append(updateTable).append(" set LoanCardNO = null where IncrementFlag ='1' and ").append(keyColumn).append(" in (select MainbusinessNO from ECR_ERRHISTORY where").append(" ErrCode='4034' and MainbusinessNO is not null and RecordType ='").append(recordtype).append("')");
		logger.trace(sql.toString());
		stDelete.executeUpdate(sql.toString());
	}

	private void deleteGuaranty()
		throws SQLException
	{
		int recordType = 0;
		int lastRecordType = 0;
		ResultSet rs = psSelectGuaranty.executeQuery();
		RecordDBReflector reflector = null;
		StringBuffer sb;
		for (; rs.next(); stDelete.execute(sb.toString()))
		{
			recordType = rs.getInt("RecordType");
			if (recordType != lastRecordType)
			{
				lastRecordType = recordType;
				reflector = RecordDBReflector.getReflector(lastRecordType);
			}
			Field field[] = reflector.getMainKeyColumn();
			String recordKey = rs.getString("RecordKey");
			String value[] = spiltArray(recordKey);
			if (value.length != field.length)
			{
				logger.warn("Field字段个数与Value值个数不匹配!");
				return;
			}
			sb = new StringBuffer();
			sb.append("DELETE FROM ECR_").append(reflector.getMainTable()).append(" WHERE 1=1");
			for (int i = 0; i < field.length; i++)
				if (field[i].getType() == 1 || field[i].getType() == 4 || field[i].getType() == 2)
					sb.append(" and ").append(field[i].getName()).append("=").append(value[i]);
				else
					sb.append(" and ").append(field[i].getName()).append("='").append(value[i]).append("'");

			logger.debug(sb.toString());
		}

		rs.close();
	}

	private String[] spiltArray(String recordKey)
	{
		String tmpArray[] = new String[10];
		if (recordKey == null || !recordKey.startsWith("{") || recordKey.indexOf("}") < 0)
			return null;
		int end = 0;
		int i = 0;
		while ((end = recordKey.indexOf("}")) > 0) 
		{
			String tmpField = recordKey.substring(1, end);
			int j = 0;
			if (tmpField != null && (j = tmpField.indexOf(":")) != -1)
				tmpArray[i] = tmpField.substring(j + 1);
			i++;
			recordKey = recordKey.substring(end + 1);
		}
		String valueArray[] = new String[i];
		for (int j = 0; j < i; j++)
			valueArray[j] = tmpArray[j];

		return valueArray;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}

	public String getDatabase()
	{
		return database;
	}

	private void clearResource()
	{
		if (psDeleteCustomerInfo != null)
			try
			{
				psDeleteCustomerInfo.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
		if (stDelete != null)
			try
			{
				stDelete.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
		if (psSelectGuaranty != null)
			try
			{
				psSelectGuaranty.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
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
}
