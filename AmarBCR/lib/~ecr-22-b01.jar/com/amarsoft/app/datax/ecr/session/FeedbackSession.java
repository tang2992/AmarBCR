// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FeedbackSession.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizmanage.*;
import com.amarsoft.app.datax.ecr.infoservice.LoanCardInquireResultHandler;
import com.amarsoft.app.datax.ecr.message.MessageSet;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import java.io.File;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			MessageProcessSession

public class FeedbackSession extends MessageProcessSession
{

	private String feedbackFile;
	private String cryptConfigFile;
	private String cryptKeyFile;
	private String originalMessageList;
	private Map messageSetMap;
	private String database;

	public FeedbackSession()
	{
		feedbackFile = null;
		cryptConfigFile = null;
		cryptKeyFile = null;
		originalMessageList = "{etc/ecr_message_customerinfo.xml}{etc/ecr_message_businessinfo.xml}{etc/ecr_message_assetssaving.xml}";
		messageSetMap = new HashMap();
		database = "ecr";
		feedbackFile = null;
		setMessageConfigFile("etc/ecr_message_feedback.xml");
	}

	public FeedbackSession(String backMesageDataFile)
	{
		feedbackFile = null;
		cryptConfigFile = null;
		cryptKeyFile = null;
		originalMessageList = "{etc/ecr_message_customerinfo.xml}{etc/ecr_message_businessinfo.xml}{etc/ecr_message_assetssaving.xml}";
		messageSetMap = new HashMap();
		database = "ecr";
		feedbackFile = backMesageDataFile;
		setMessageConfigFile("etc/ecr_message_feedback.xml");
	}

	public void setFeedbackFile(String backFile)
	{
		feedbackFile = backFile;
	}

	public String getFeedbackFile()
	{
		return feedbackFile;
	}

	public boolean init()
	{
		String s = getMessageSetType();
		if (s == null)
		{
			logger.error("反馈报文集合类型(messageSetType)未配置！");
			return false;
		}
		try
		{
			provider = new FeedbackFileProvider(feedbackFile);
		}
		catch (ECRException e1)
		{
			logger.error("初始化反馈报文提供器失败！", e1);
			return false;
		}
		if (s.equals("22"))
			handler = new LoanCardInquireResultHandler();
		else
		if (s.equals("35"))
			handler = new BatchDeleteResultHandler();
		else
		if (messageSet.getType().equals("50"))
		{
			String ol[] = StringX.parseArray(originalMessageList);
			if (ol == null || ol.length < 1)
			{
				logger.error("原始报文列表(originalMessageList)未配置！");
				return false;
			}
			for (int i = 0; i < ol.length; i++)
				try
				{
					addOriginalMessageConfig(ol[i]);
				}
				catch (ECRException ex)
				{
					logger.error("增加原始报文配置失败！");
					return false;
				}

			String mess[] = new String[3];
			mess[0] = (String)messageSetMap.get("11");
			mess[1] = (String)messageSetMap.get("12");
			mess[2] = (String)messageSetMap.get("14");
			try
			{
				FeedbackRecord.init(mess);
			}
			catch (ECRException e)
			{
				logger.error("初始化反馈报文原始报文集合失败!", e);
				return false;
			}
			FeedbackHandler h = new FeedbackHandler();
			h.setDatabase(database);
			handler = h;
		}
		return true;
	}

	public void addOriginalMessageConfig(String xmlMessageConfigFile)
		throws ECRException
	{
		MessageSet ms = MessageSet.createMessageSetFromXml(xmlMessageConfigFile);
		messageSetMap.put(ms.getType(), xmlMessageConfigFile);
	}

	public void postProcess()
	{
		if (getStatus() != 100)
		{
			logger.fatal((new StringBuilder("运行报文处理过程")).append(getSessionId()).append("失败!").toString());
			return;
		}
		logger.info((new StringBuilder("处理返回报文文件")).append(feedbackFile).append("成功！").toString());
		File fs = new File(feedbackFile);
		if (fs.renameTo(new File((new StringBuilder(String.valueOf(fs.getPath()))).append(".bak").toString())))
			logger.info((new StringBuilder("更名")).append(fs.getPath()).append("为").append(fs.getPath()).append(".bak成功！").toString());
		else
			logger.warn((new StringBuilder("更名")).append(fs.getPath()).append("为").append(fs.getPath()).append(".bak失败！").toString());
		try
		{
			saveStatus();
		}
		catch (Exception e)
		{
			logger.debug(e);
		}
	}

	public void saveStatus()
		throws Exception
	{
		Connection conn;
		PreparedStatement pstmt;
		Statement stmt;
		int iCount;
		String reportSessionid;
		String sqlUpdate;
		conn = ARE.getDBConnection(database);
		pstmt = null;
		stmt = null;
		iCount = 0;
		File file = new File(feedbackFile);
		reportSessionid = (new StringBuilder(String.valueOf(file.getName().substring(13, 19)))).append(file.getName().substring(22, 26)).toString();
		sqlUpdate = "update ECR_REPORTSTATUS set FeedbackNumber = ?,FeedbackDate = ? where SessionID = ?";
		conn.setAutoCommit(false);
		try
		{
			stmt = conn.createStatement();
			ResultSet rs = null;
			rs = stmt.executeQuery((new StringBuilder("select count(*) from ECR_FEEDBACK where SessionID = '")).append(reportSessionid).append("'").toString());
			if (rs.next())
				iCount = rs.getInt(1);
			rs.close();
			pstmt = conn.prepareStatement(sqlUpdate);
			pstmt.setInt(1, iCount);
			pstmt.setString(2, ARE.getProperty("businessOccurDate"));
			pstmt.setString(3, reportSessionid);
			pstmt.executeUpdate();
			conn.commit();
			break MISSING_BLOCK_LABEL_376;
		}
		catch (SQLException e)
		{
			logger.info(e);
		}
		if (pstmt != null)
			try
			{
				pstmt.close();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
			}
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
			}
		try
		{
			conn.close();
		}
		catch (SQLException e1)
		{
			logger.debug(e1);
		}
		break MISSING_BLOCK_LABEL_450;
		Exception exception;
		exception;
		if (pstmt != null)
			try
			{
				pstmt.close();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
			}
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
			}
		try
		{
			conn.close();
		}
		catch (SQLException e1)
		{
			logger.debug(e1);
		}
		throw exception;
		if (pstmt != null)
			try
			{
				pstmt.close();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
			}
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
			}
		try
		{
			conn.close();
		}
		catch (SQLException e1)
		{
			logger.debug(e1);
		}
	}

	public String getOriginalMessageList()
	{
		return originalMessageList;
	}

	public void setOriginalMessageList(String messageConfigFiles)
	{
		originalMessageList = messageConfigFiles;
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}

	public final String getCryptConfigFile()
	{
		return cryptConfigFile;
	}

	public final void setCryptConfigFile(String cryptConfigFile)
	{
		this.cryptConfigFile = cryptConfigFile;
	}

	public final String getCryptKeyFile()
	{
		return cryptKeyFile;
	}

	public final void setCryptKeyFile(String cryptKeyFile)
	{
		this.cryptKeyFile = cryptKeyFile;
	}
}
