// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DBErrorRecord.java

package com.amarsoft.app.datax.ecr.validate;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.RecordDBReflector;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate:
//			ErrorRecord, ValidateRule, ValidateHelp

public class DBErrorRecord
	implements ErrorRecord
{

	private String database;
	private Connection connection;
	private SimpleDateFormat dateFormat;
	private PreparedStatement psInsertError;
	private Log logger;
	int serialNo;

	public DBErrorRecord()
	{
		database = "ecr";
		connection = null;
		dateFormat = null;
		psInsertError = null;
		logger = null;
		serialNo = 0;
	}

	public void writeError(ValidateRule checkRule, Segment seg)
		throws ECRException
	{
		Record r = checkRule.getRecord();
		RecordDBReflector ref = RecordDBReflector.getReflector(r);
		ref.computeKey(r);
		String k = ref.getMainKeyString();
		dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		Date d = null;
		if (r.getType() == 71)
			d = r.getFirstSegment("B").getField(1113).getDate();
		else
		if (r.getType() == 72)
			d = r.getFirstSegment("B").getField(1909).getDate();
		else
			d = r.getFirstSegment("B").getField(2501).getDate();
		String customerID = null;
		if (r.getType() == 71)
			customerID = r.getFirstSegment("B").getField(1102).getString();
		else
		if (r.getType() == 72)
			customerID = r.getFirstSegment("B").getField(9992).getString();
		else
			customerID = r.getFirstSegment("B").getField(9991).getString();
		String errTableName = null;
		String errTableKey = null;
		if ((r.getType() == 71 || r.getType() == 72) && seg != null)
		{
			errTableName = ValidateHelp.getTableNameById((new StringBuilder(String.valueOf(r.getType()))).append(seg.getSegmentFlag()).toString());
			errTableKey = ValidateHelp.getTableKey(seg, (new StringBuilder(String.valueOf(r.getType()))).append(seg.getSegmentFlag()).toString());
		}
		try
		{
			serialNo++;
			psInsertError.setInt(1, serialNo);
			psInsertError.setString(2, String.valueOf(checkRule.getRecordType()));
			psInsertError.setString(3, String.valueOf(checkRule.getMessageType()));
			psInsertError.setString(4, checkRule.getErrorCode());
			psInsertError.setString(5, checkRule.getErrorMsg());
			psInsertError.setString(6, checkRule.getCheckedFieldName());
			if (ref.getRecordType() == 51)
				psInsertError.setString(7, r.getFirstSegment("B").getField(6509).getString());
			else
			if (ref.getRecordType() == 71)
				psInsertError.setString(7, r.getFirstSegment("B").getField(1103).getString());
			else
				psInsertError.setString(7, r.getFirstSegment("B").getField(6501) != null ? r.getFirstSegment("B").getField(6501).getString() : "");
			psInsertError.setString(8, r.getMainBusinessNo());
			psInsertError.setString(9, customerID);
			if (r.getType() == 72)
				psInsertError.setString(10, "");
			else
				psInsertError.setString(10, r.getLoanCardNo());
			psInsertError.setString(11, k);
			psInsertError.setString(12, dateFormat.format(d != null ? d : new Date()));
			psInsertError.setString(13, errTableName);
			psInsertError.setString(14, errTableKey);
			psInsertError.executeUpdate();
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException("写入错误信息出错!", e);
		}
	}

	public void writeError(ValidateRule checkRule)
		throws ECRException
	{
		writeError(checkRule, null);
	}

	public void clearAllError()
		throws ECRException
	{
		try
		{
			Statement st = connection.createStatement();
			String sql = "delete from ECR_ERRHISTORY";
			logger.debug((new StringBuilder("Clear MessageError")).append(sql).toString());
			st.executeUpdate(sql);
			st.close();
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException("清除错误信息出错!", e);
		}
	}

	public void clearMessageError(int messageType)
		throws ECRException
	{
		try
		{
			Statement st = connection.createStatement();
			String sql = (new StringBuilder("delete from ECR_ERRHISTORY where MessageType='")).append(messageType).append("'").toString();
			logger.debug((new StringBuilder("Clear MessageError")).append(sql).toString());
			st.executeUpdate(sql);
			st.close();
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new ECRException("清除错误信息出错!", e);
		}
	}

	public void open()
		throws ECRException
	{
		logger = ARE.getLog();
		try
		{
			connection = ARE.getDBConnection(database);
			String sql = "insert into ECR_ErrHistory(SerialNo,RecordType,MessageType,ErrCode, ErrMsg,ErrField,Financeid,MainBusinessNo,CustomerId,LoanCardNo,RecordKey,OccurDate,errtablename,errtablekey) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			psInsertError = connection.prepareStatement(sql);
			Statement st = connection.createStatement();
			String s = "select max(SerialNo) from ECR_ERRHISTORY";
			ResultSet rs = st.executeQuery(s);
			if (rs.next())
				serialNo = rs.getInt(1);
			rs.close();
			st.close();
		}
		catch (SQLException e)
		{
			logger.debug(e);
			if (connection != null)
				try
				{
					connection.close();
				}
				catch (Exception e1)
				{
					logger.debug(e1);
				}
			throw new ECRException("打开错误信息数据库出错!", e);
		}
	}

	public void close()
	{
	}

	public final String getDatabase()
	{
		return database;
	}

	public final void setDatabase(String database)
	{
		this.database = database;
	}
}
