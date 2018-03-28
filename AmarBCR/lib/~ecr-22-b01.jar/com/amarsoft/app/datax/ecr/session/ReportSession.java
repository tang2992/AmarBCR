// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ReportSession.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizcollect.ExportFileHandler;
import com.amarsoft.app.datax.ecr.bizcollect.RecordCountHandler;
import com.amarsoft.app.datax.ecr.bizcollect.SimpleHISProvider;
import com.amarsoft.app.datax.ecr.common.PBCFileClient;
import com.amarsoft.app.datax.ecr.message.AbstractProvider;
import com.amarsoft.app.datax.ecr.message.MessageSet;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.Date;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			MessageProcessSession

public class ReportSession extends MessageProcessSession
{

	private static String database = "ecr";
	private boolean retryMessage;
	private boolean autoEcrypt;
	private boolean autoCompress;
	private boolean isMultiOrg;
	private String exportFolder;
	private ExportFileHandler fileHandler;
	private String cryptConfigFile;
	private String cryptKeyFile;

	public ReportSession()
	{
		retryMessage = false;
		autoEcrypt = true;
		autoCompress = true;
		isMultiOrg = false;
		exportFolder = null;
		fileHandler = null;
		cryptConfigFile = null;
		cryptKeyFile = null;
	}

	public static final ReportSession getSession(String messageSetType, boolean retry)
		throws ECRException
	{
		ReportSession session = null;
		String lastMaxSessionId = null;
		Connection conn = null;
		if (!messageSetType.equals("11") && !messageSetType.equals("12") && !messageSetType.equals("14") && !messageSetType.equals("31") && !messageSetType.equals("21") && !messageSetType.equals("51") && !messageSetType.equals("32"))
			throw new ECRException((new StringBuilder("无效的上报报文集合类型：")).append(messageSetType).toString());
		try
		{
			conn = ARE.getDBConnection(database);
			String sql = (new StringBuilder("select SessionID from ECR_SESSION where Status<100 and messageSetType='")).append(messageSetType).append("' ").append("and dataType=").append(retry ? 2 : 1).toString();
			lastMaxSessionId = querySession(conn, sql);
			session = new ReportSession();
			if (lastMaxSessionId != null)
			{
				session.setSessionId(lastMaxSessionId);
				session.load();
			} else
			{
				session.setCreateTime(new Date());
				session.setFinanceId(ARE.getProperty("baseFinanceId"));
				session.setRetryMessage(retry);
				session.setMessageSetType(messageSetType);
				session.setStatus(0);
				sql = (new StringBuilder("select max(SessionID) from ECR_SESSION where SessionID like '")).append(session.getCreateTime("yyMMdd")).append("%'").toString();
				lastMaxSessionId = querySession(conn, sql);
				int sn;
				if (lastMaxSessionId == null)
					sn = ARE.getProperty("baseMessageNumber", 1);
				else
					sn = Integer.parseInt(lastMaxSessionId.substring(6)) + 1;
				String newSessionId = (new StringBuilder(String.valueOf(session.getCreateTime("yyMMdd")))).append((new DecimalFormat("0000")).format(sn)).toString();
				session.setSessionId(newSessionId);
			}
			conn.close();
		}
		catch (NumberFormatException e)
		{
			try
			{
				conn.close();
			}
			catch (SQLException ex)
			{
				ARE.getLog().debug(ex);
			}
			throw new ECRException("生成新的sessionid出错", e);
		}
		catch (SQLException e)
		{
			if (conn != null)
				try
				{
					conn.close();
				}
				catch (SQLException ex)
				{
					ARE.getLog().debug(ex);
				}
			throw new ECRException(e);
		}
		return session;
	}

	private static String querySession(Connection conn, String query)
		throws SQLException
	{
		String sessionId = null;
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		if (rs.next())
			sessionId = rs.getString(1);
		rs.close();
		stmt.close();
		return sessionId;
	}

	public final void save()
		throws ECRException
	{
		ECRException ecre;
		String sqlInsert;
		String sqlUpdate;
		Connection conn;
		PreparedStatement pstmt;
		Statement stmt;
		ecre = null;
		sqlInsert = "insert into ECR_SESSION(SessionID,FinanceID,Status,MessageSetType,DataType,CreateTime,Note) values(?,?,?,?,?,?,?)";
		sqlUpdate = "update ECR_SESSION set Status=?,Note=? where SessionID=?";
		conn = null;
		try
		{
			conn = ARE.getDBConnection(database);
			int isolation = ARE.getProperty("connection.ecr.isolation", -1);
			if (isolation != -1)
			{
				logger.debug((new StringBuilder("JDBC transactionIsolation set to ")).append(isolation).toString());
				conn.setTransactionIsolation(isolation);
			}
			conn.setAutoCommit(false);
		}
		catch (SQLException se)
		{
			ARE.getLog().debug(se);
			throw new ECRException("保存Session时连接数据库失败!");
		}
		pstmt = null;
		stmt = null;
		try
		{
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery((new StringBuilder("select SessionId from ECR_SESSION where SessionID='")).append(getSessionId()).append("'").toString());
			boolean exists = rs.next();
			rs.close();
			if (exists)
			{
				pstmt = conn.prepareStatement(sqlUpdate);
				pstmt.setInt(1, getStatus());
				pstmt.setString(2, getNote());
				pstmt.setString(3, getSessionId());
			} else
			{
				pstmt = conn.prepareStatement(sqlInsert);
				pstmt.setString(1, getSessionId());
				pstmt.setString(2, getFinanceId());
				pstmt.setInt(3, getStatus());
				pstmt.setString(4, getMessageSetType());
				pstmt.setInt(5, isRetryMessage() ? 2 : 1);
				pstmt.setDate(6, new java.sql.Date(getCreateTime().getTime()));
				pstmt.setString(7, getNote());
			}
			pstmt.executeUpdate();
			conn.commit();
			break MISSING_BLOCK_LABEL_552;
		}
		catch (SQLException e)
		{
			ARE.getLog().debug(e);
			ecre = new ECRException("Save session failed", e);
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
		if (pstmt != null)
			try
			{
				pstmt.close();
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
		conn = null;
		break MISSING_BLOCK_LABEL_634;
		Exception exception;
		exception;
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
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
		try
		{
			conn.close();
		}
		catch (SQLException e1)
		{
			logger.debug(e1);
		}
		conn = null;
		throw exception;
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e1)
			{
				logger.debug(e1);
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
		try
		{
			conn.close();
		}
		catch (SQLException e1)
		{
			logger.debug(e1);
		}
		conn = null;
		if (ecre != null)
			throw ecre;
		else
			return;
	}

	public final void load()
		throws ECRException
	{
		Connection conn = null;
		try
		{
			conn = ARE.getDBConnection(database);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery((new StringBuilder("select * from ECR_SESSION where SessionId='")).append(getSessionId()).append("'").toString());
			if (rs.next())
			{
				setFinanceId(rs.getString("FinanceID"));
				setStatus(rs.getInt("Status"));
				setMessageSetType(rs.getString("MessageSetType"));
				setRetryMessage(rs.getInt("DataType") == 2);
				setCreateTime(rs.getDate("CreateTime"));
				setNote(rs.getString("Note"));
			}
			rs.close();
			stmt.close();
			conn.close();
		}
		catch (SQLException e)
		{
			if (conn != null)
				try
				{
					conn.close();
				}
				catch (SQLException e1)
				{
					ARE.getLog().debug(e1);
				}
			conn = null;
			throw new ECRException("Load session failed", e);
		}
	}

	public final boolean init()
	{
		AbstractProvider ap = null;
		try
		{
			ap = createProvider();
		}
		catch (ECRException ex)
		{
			logger.error("创建provider失败！", ex);
			return false;
		}
		if (ap == null)
		{
			logger.error("provider未创建！");
			return false;
		}
		ap.setReportFinanceCode(getFinanceId());
		if (isMultiOrg())
		{
			ap.setFileFinanceCode(getFinanceId());
			ap.setContactPerson(getContactPerson());
			ap.setContactPhone(getContactPhone());
		} else
		{
			ap.setFileFinanceCode(ARE.getProperty("fileFinanceId"));
			ap.setContactPerson(ARE.getProperty("contactPerson"));
			ap.setContactPhone(ARE.getProperty("contactPhone"));
		}
		ap.setRetryMessage(isRetryMessage());
		ap.setFileSerialNo(getSessionId().substring(6, 10));
		provider = ap;
		fileHandler = new ExportFileHandler();
		fileHandler.setSessionId(getSessionId());
		fileHandler.setRetryMessage(retryMessage);
		if (exportFolder != null)
			fileHandler.setExportFolder(exportFolder);
		handler = fileHandler;
		return true;
	}

	protected AbstractProvider createProvider()
		throws ECRException
	{
		SimpleHISProvider p = new SimpleHISProvider();
		String f = null;
		if (!isRetryMessage())
			f = (new StringBuilder("(SessionID='0000000000') and (Incrementflag='1' or Incrementflag='2' or Incrementflag='3' or Incrementflag='4') and (OccurDate<='")).append(getCreateTime("yyyy/MM/dd")).append("')").toString();
		else
			f = "(SessionID='1111111111') and (Incrementflag='1' or Incrementflag='2' or Incrementflag='3' or Incrementflag='4') and (ModFlag='1')";
		if (isMultiOrg)
			f = (new StringBuilder(String.valueOf(f))).append(" and financeID in (select OrgID from ORG_TASK_INFO where OrgCode='").append(getFinanceId()).append("')").toString();
		p.setDataFilter(f);
		return p;
	}

	public void postProcess()
	{
		if (getStatus() != 100)
		{
			logger.warn("报文文件未能正确生成,不能进行后续处理! ");
			return;
		}
		logger.info("恭喜，报文文件生成完成! ");
		try
		{
			saveStatus();
		}
		catch (Exception e)
		{
			logger.debug(e);
		}
		if (!isAutoEcrypt())
		{
			logger.info("根据设置,报文文件未进行加密和加压处理! ");
			return;
		}
		String exportFileName = fileHandler.getExportFile();
		String messageFile = exportFileName.substring(0, exportFileName.length() - 4);
		String encryptFileName = (new StringBuilder(String.valueOf(messageFile))).append(".enc").toString();
		String zipFileName = (new StringBuilder(String.valueOf(messageFile))).append(".zip").toString();
		PBCFileClient fc = new PBCFileClient();
		fc.setCryptConfigFile(cryptConfigFile);
		fc.setCryptKeyFile(cryptKeyFile);
		String tf;
		File f;
		if (!fc.encrypt(exportFileName, encryptFileName))
		{
			logger.warn("很遗憾，生成加密文件失败，你需要手工加密和压缩! ");
			tf = (new StringBuilder(String.valueOf(exportFileName))).append(".tmp").toString();
			f = new File(tf);
			if (f.exists())
				f.delete();
			return;
		}
		logger.info("恭喜，生成加密文件成功! ");
		if (!isAutoCompress())
		{
			logger.info("根据设置,报文文件未进行压缩处理! ");
			return;
		}
		if (!fc.compress(encryptFileName, zipFileName))
		{
			logger.warn("很遗憾，生成压缩文件失败，需要手工进行压缩和发送! ");
			tf = (new StringBuilder(String.valueOf(exportFileName))).append(".tmp").toString();
			f = new File(tf);
			if (f.exists())
				f.delete();
			return;
		}
		logger.info("恭喜，生成压缩文件成功! ");
		tf = (new StringBuilder(String.valueOf(exportFileName))).append(".tmp").toString();
		f = new File(tf);
		if (f.exists())
			f.delete();
	}

	public void saveStatus()
		throws Exception
	{
		Connection conn;
		PreparedStatement pstmt;
		ResultSet rs;
		String sqlInsert;
		String sqlUpdate;
		conn = ARE.getDBConnection(database);
		pstmt = null;
		Statement stmt = null;
		rs = null;
		sqlInsert = "insert into ECR_REPORTSTATUS (SessionID,MessageType,RetryType,RecordNumber) values(?,?,?,?)";
		sqlUpdate = "update ECR_REPORTSTATUS set MessageType = ?,RetryType = ?,RecordNumber = ? where SessionID = ?";
		try
		{
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery((new StringBuilder("select 1 from ECR_REPORTSTATUS where SessionID = '")).append(getSessionId()).append("'").toString());
			if (rs.next())
			{
				pstmt = conn.prepareStatement(sqlUpdate);
				pstmt.setString(1, getMessageSetType());
				pstmt.setString(2, retryMessage ? "1" : "0");
				pstmt.setInt(3, fileHandler.getReportCount());
				pstmt.setString(4, getSessionId());
			} else
			{
				pstmt = conn.prepareStatement(sqlInsert);
				pstmt.setString(1, getSessionId());
				pstmt.setString(2, getMessageSetType());
				pstmt.setString(3, retryMessage ? "1" : "0");
				pstmt.setInt(4, fileHandler.getReportCount());
			}
			pstmt.executeUpdate();
			conn.commit();
			break MISSING_BLOCK_LABEL_392;
		}
		catch (SQLException e)
		{
			ARE.getLog().debug(e);
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
		try
		{
			rs.close();
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
		break MISSING_BLOCK_LABEL_463;
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
		try
		{
			rs.close();
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
		try
		{
			rs.close();
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

	public boolean ready()
	{
		RecordCountHandler h = new RecordCountHandler();
		messageSet.setHandler(h);
		try
		{
			messageSet.parse(provider);
		}
		catch (ECRException e)
		{
			logger.error("检查上报记录出错", e);
			return false;
		}
		logger.info((new StringBuilder("检查到待上报记录条数: ")).append(h.getTotalRecordNumber()).toString());
		return h.getTotalRecordNumber() > 0;
	}

	public final boolean isRetryMessage()
	{
		return retryMessage;
	}

	public final void setRetryMessage(boolean retryMessage)
	{
		this.retryMessage = retryMessage;
	}

	public static final String getDatabase()
	{
		return database;
	}

	public static final void setDatabase(String database)
	{
		database = database;
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

	public final String getExportFolder()
	{
		return exportFolder;
	}

	public final void setExportFolder(String exportFolder)
	{
		this.exportFolder = exportFolder;
	}

	public final boolean isAutoCompress()
	{
		return autoCompress;
	}

	public final void setAutoCompress(boolean autoCompress)
	{
		this.autoCompress = autoCompress;
	}

	public final boolean isAutoEcrypt()
	{
		return autoEcrypt;
	}

	public final void setAutoEcrypt(boolean autoEcrypt)
	{
		this.autoEcrypt = autoEcrypt;
	}

	public boolean isMultiOrg()
	{
		return isMultiOrg;
	}

	public void setMultiOrg(boolean isMultiOrg)
	{
		this.isMultiOrg = isMultiOrg;
	}

}
