package com.amarsoft.app.datax.bcr.validate;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.common.RecordDBReflector;
import com.amarsoft.app.datax.bcr.message.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

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
		database = "bcr";
		connection = null;
		dateFormat = null;
		psInsertError = null;
		logger = null;
		serialNo = 0;
	}

	public void writeError(ValidateRule checkRule, Segment seg)
		throws BCRException
	{
		Record r = checkRule.getRecord();
		RecordDBReflector ref = RecordDBReflector.getReflector(r);
		ref.computeKey(r);
		String k = ref.getMainKeyString();
		dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		Date d = null;
		if (r.getType() == 811){
			d = r.getFirstSegment("B").getField(1111).getDate();
		}else if(r.getType() == 821){
			d = r.getFirstSegment("C").getField(2004).getDate();
		}else if(r.getType() == 831){
			d = r.getFirstSegment("S").getField(2004).getDate();
		}			
		String GContractNo = null;
		if (r.getType() == 811){
			GContractNo = r.getFirstSegment("B").getField(1106).getString();
		}			
		String errTableName = null;
		String errTableKey = null;
		if ((r.getType() == 811 || r.getType() == 821 || r.getType() == 831) && seg != null)
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
			if (ref.getRecordType() == 811){
				psInsertError.setString(7, r.getFirstSegment("B").getField(1104).getString());
			}else if(ref.getRecordType() == 821){
				psInsertError.setString(7, r.getFirstSegment("C").getField(2001).getString());
			}else if(ref.getRecordType() == 831){
				psInsertError.setString(7, r.getFirstSegment("S").getField(2001).getString());
			}				
			psInsertError.setString(8, r.getMainBusinessNo());			
			if (r.getType() == 811 || r.getType() == 821 || r.getType() == 831)
				psInsertError.setString(9, "");
			if (r.getType() == 811){
				psInsertError.setString(10, GContractNo);
			}else if(r.getType() == 821 || r.getType() == 831){
				psInsertError.setString(10, "");
			}			
			psInsertError.setString(11, k);
			psInsertError.setString(12, dateFormat.format(d != null ? d : new Date()));
			psInsertError.setString(13, errTableName);
			psInsertError.setString(14, errTableKey);
			psInsertError.executeUpdate();
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new BCRException("写入错误信息出错!", e);
		}
	}

	public void writeError(ValidateRule checkRule)
		throws BCRException
	{
		writeError(checkRule, null);
	}

	public void clearAllError()
		throws BCRException
	{
		try
		{
			Statement st = connection.createStatement();
			String sql = "delete from BCR_ERRHISTORY";
			logger.debug((new StringBuilder("Clear MessageError")).append(sql).toString());
			st.executeUpdate(sql);
			st.close();
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new BCRException("清除错误信息出错!", e);
		}
	}

	public void clearMessageError(int messageType)
		throws BCRException
	{
		try
		{
			Statement st = connection.createStatement();
			String sql = (new StringBuilder("delete from BCR_ERRHISTORY where MessageType='")).append(messageType).append("'").toString();
			logger.debug((new StringBuilder("Clear MessageError:")).append(sql).toString());
			st.executeUpdate(sql);
			st.close();
		}
		catch (SQLException e)
		{
			logger.debug(e);
			throw new BCRException("清除错误信息出错!", e);
		}
	}

	public void open()
		throws BCRException
	{
		logger = ARE.getLog();
		try
		{
			connection = ARE.getDBConnection(database);
			String sql = "insert into BCR_ErrHistory(SerialNo,RecordType,MessageType,ErrCode, ErrMsg,ErrField,Financeid,MainBusinessNo,CustomerId,GContractNo,RecordKey,OccurDate,errtablename,errtablekey) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			psInsertError = connection.prepareStatement(sql);
			Statement st = connection.createStatement();
			String s = "select max(SerialNo) from BCR_ERRHISTORY";
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
			throw new BCRException("打开错误信息数据库出错!", e);
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
