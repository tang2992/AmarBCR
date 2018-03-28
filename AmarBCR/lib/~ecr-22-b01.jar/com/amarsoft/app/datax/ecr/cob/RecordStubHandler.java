// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   RecordStubHandler.java

package com.amarsoft.app.datax.ecr.cob;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.RecordDBReflector;
import com.amarsoft.app.datax.ecr.message.Field;
import com.amarsoft.app.datax.ecr.message.Handler;
import com.amarsoft.app.datax.ecr.message.Message;
import com.amarsoft.app.datax.ecr.message.MessageSet;
import com.amarsoft.app.datax.ecr.message.Record;
import com.amarsoft.app.datax.ecr.message.Segment;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

// Referenced classes of package com.amarsoft.app.datax.ecr.cob:
//			RecordStub, RecordStubFilter

public class RecordStubHandler
	implements Handler
{

	private ArrayList recordBuffer;
	private int lastRecordType;
	private Connection connection;
	private PreparedStatement pstmt;
	private PreparedStatement pstmtErrorCode;
	private String database;
	private boolean ecrRecord;
	private SimpleDateFormat df;
	private Log logger;
	private RecordStubFilter filter;

	public RecordStubHandler()
	{
		recordBuffer = null;
		lastRecordType = -1;
		connection = null;
		pstmt = null;
		pstmtErrorCode = null;
		database = "ecr";
		ecrRecord = true;
		df = new SimpleDateFormat("yyyy/MM/dd");
		logger = ARE.getLog();
		filter = null;
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}

	public boolean isEcrRecord()
	{
		return ecrRecord;
	}

	public void setEcrRecord(boolean ecrRecord)
	{
		this.ecrRecord = ecrRecord;
	}

	public void end(MessageSet messageSet)
		throws ECRException
	{
		if (pstmt != null)
			try
			{
				pstmt.close();
			}
			catch (SQLException sqlexception) { }
		if (pstmtErrorCode != null)
			try
			{
				pstmtErrorCode.close();
			}
			catch (SQLException sqlexception1) { }
		if (connection != null)
			try
			{
				connection.close();
				connection = null;
			}
			catch (SQLException sqlexception2) { }
	}

	public void handleFooter(Message message1, Record record)
		throws ECRException
	{
	}

	public void handleHeader(Message message1, Record record)
		throws ECRException
	{
	}

	public void handleRecord(Message message, Record record)
		throws ECRException
	{
		RecordStub rs = new RecordStub();
		Segment seg = record.getFirstSegment("B");
		RecordDBReflector ref = RecordDBReflector.getReflector(record.getType());
		if (seg == null)
			return;
		rs.setBrief(record.getBrief());
		rs.setIncrementFlag(seg.getField(7511).getString());
		rs.setMessagType(message.getType());
		rs.setOccurDate(df.format(seg.getField(2501).getDate()));
		rs.setRecordType(record.getType());
		rs.setTraceNumber(seg.getField(7641).getString());
		ref.computeKey(record);
		com.amarsoft.are.dpx.recordset.Field k[] = ref.getMainKeyColumn();
		com.amarsoft.are.dpx.recordset.Field mk[] = new com.amarsoft.are.dpx.recordset.Field[k.length];
		String keyString = new String(ref.getMainKeyString());
		for (int i = 0; i < k.length; i++)
			mk[i] = (com.amarsoft.are.dpx.recordset.Field)k[i].clone();

		rs.setRecordKey(mk);
		if (ref.getRecordType() != lastRecordType)
		{
			StringBuffer sb = new StringBuffer();
			sb.append("select ErrorCode,ModFlag,RecordFlag,SessionID from ");
			sb.append(isEcrRecord() ? "ECR_" : "HIS_");
			sb.append(ref.getMainTable());
			sb.append(" where ");
			for (int i = 0; i < mk.length; i++)
				sb.append(mk[i].getName()).append("=?").append(" and ");

			sb.append(" OccurDate=?");
			logger.debug((new StringBuilder("Get SessionId sql: ")).append(sb).toString());
			try
			{
				if (pstmt != null)
					try
					{
						pstmt.close();
					}
					catch (SQLException sqlexception) { }
				pstmt = connection.prepareStatement(sb.toString());
			}
			catch (SQLException ex)
			{
				if (connection != null)
					try
					{
						connection.close();
					}
					catch (SQLException sqlexception2) { }
				throw new ECRException(ex);
			}
			lastRecordType = record.getType();
		}
		try
		{
			for (int i = 0; i < mk.length; i++)
				if (mk[i].getType() == 1)
					pstmt.setInt(i + 1, mk[i].getInt());
				else
					pstmt.setString(i + 1, mk[i].getString());

			pstmt.setString(mk.length + 1, rs.getOccurDate());
			ResultSet rs1 = pstmt.executeQuery();
			if (rs1.next())
			{
				rs.setErrorCode(rs1.getString("ErrorCode"));
				rs.setModFlag(rs1.getString("ModFlag"));
				rs.setRecordFlag(rs1.getString("RecordFlag"));
				rs.setSessionId(rs1.getString("SessionID"));
			}
			rs1.close();
			StringBuffer sb = new StringBuffer();
			pstmtErrorCode.setInt(1, ref.getRecordType());
			pstmtErrorCode.setString(2, keyString);
			for (rs1 = pstmtErrorCode.executeQuery(); rs1.next(); sb.append(rs1.getString(1)));
			rs1.close();
			if (sb.length() > 0)
				rs.setErrorCode(sb.toString());
		}
		catch (SQLException ex)
		{
			if (connection != null)
				try
				{
					connection.close();
				}
				catch (SQLException sqlexception1) { }
			throw new ECRException(ex);
		}
		if (filter == null || filter.accept(rs))
			recordBuffer.add(rs);
	}

	public void messageEnd(Message message1)
		throws ECRException
	{
	}

	public void messageStart(Message message1)
		throws ECRException
	{
	}

	public void start(MessageSet messageSet)
		throws ECRException
	{
		if (recordBuffer == null)
			recordBuffer = new ArrayList();
		else
			recordBuffer.clear();
		try
		{
			connection = ARE.getDBConnection("ecr");
			pstmtErrorCode = connection.prepareStatement("select ErrCode from ECR_ERRHISTORY where RecordType=? and RecordKey=?");
		}
		catch (SQLException ex)
		{
			throw new ECRException(ex);
		}
	}

	public ArrayList getRecordBuffer()
	{
		return recordBuffer;
	}

	public final RecordStubFilter getFilter()
	{
		return filter;
	}

	public final void setFilter(RecordStubFilter filter)
	{
		this.filter = filter;
	}
}
