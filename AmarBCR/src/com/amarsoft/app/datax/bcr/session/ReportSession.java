package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.bizcollect.ExportFileHandler;
import com.amarsoft.app.datax.bcr.bizcollect.RecordCountHandler;
import com.amarsoft.app.datax.bcr.bizcollect.SimpleHISProvider;
import com.amarsoft.app.datax.bcr.common.PBCFileClient;
import com.amarsoft.app.datax.bcr.message.AbstractProvider;
import com.amarsoft.app.datax.bcr.message.MessageSet;
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

public class ReportSession extends MessageProcessSession
{
  private static String database = "bcr";
  private boolean retryMessage = false;
  private boolean autoEcrypt = true;
  private boolean autoCompress = true;
  private boolean isMultiOrg = false;
  private String exportFolder = null;
  private String messageSetType = null;
  private ExportFileHandler fileHandler = null;
  private String cryptConfigFile = null;
  private String cryptKeyFile = null;

  public static final ReportSession getSession(String messageSetType, boolean retry)
    throws BCRException
  {
    ReportSession session = null;
    String lastMaxSessionId = null;
    Connection conn = null;

    if ((!(messageSetType.equals("11"))) && 
      (!(messageSetType.equals("12"))) && 
      (!(messageSetType.equals("14"))) && 
      (!(messageSetType.equals("15"))) && 
      (!(messageSetType.equals("16"))) && 
      (!(messageSetType.equals("17"))) && 
      (!(messageSetType.equals("31"))) && 
      (!(messageSetType.equals("21"))) && 
      (!(messageSetType.equals("51"))) && 
      (!(messageSetType.equals("32"))))
    {
      throw new BCRException("��Ч���ϱ����ļ������ͣ�" + messageSetType);
    }
    try
    {
      conn = ARE.getDBConnection(database);

      String sql = "select SessionID from BCR_SESSION where Status<100 and messageSetType='" + 
        messageSetType + "' " + 
        "and dataType=" + ((retry) ? 2 : 1);
      lastMaxSessionId = querySession(conn, sql);

      session = new ReportSession();
      if (lastMaxSessionId != null) {
        session.setSessionId(lastMaxSessionId);
        session.load();
      }
      else {
        int sn;
        session.setCreateTime(new java.util.Date());
        session.setFinanceId(ARE.getProperty("baseFinanceId"));
        session.setRetryMessage(retry);
        session.setMessageSetType(messageSetType);
        session.setStatus(0);

        sql = "select max(SessionID) from BCR_SESSION where SessionID like '" + 
          session.getCreateTime("yyMMdd") + "%'";
        lastMaxSessionId = querySession(conn, sql);

        if (lastMaxSessionId == null)
          sn = ARE.getProperty("baseMessageNumber", 1);
        else
          sn = Integer.parseInt(lastMaxSessionId.substring(6)) + 1;

        String newSessionId = session.getCreateTime("yyMMdd") + new DecimalFormat("0000").format(sn);
        session.setSessionId(newSessionId);
      }
      conn.close(); } catch (NumberFormatException e) {
      try {
        conn.close(); } catch (SQLException ex) { ARE.getLog().debug(ex); }
      throw new BCRException("�����µ�sessionid����", e);
    } catch (SQLException e) {
      if (conn != null) try {
          conn.close(); } catch (SQLException ex) { ARE.getLog().debug(ex);
        }
      throw new BCRException(e);
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

  public final void save() throws BCRException
  {
    BCRException ecre = null;
    String sqlInsert = "insert into BCR_SESSION(SessionID,FinanceID,Status,MessageSetType,DataType,CreateTime,Note) values(?,?,?,?,?,?,?)";

    String sqlUpdate = "update BCR_SESSION set Status=?,Note=? where SessionID=?";

    Connection conn = null;
    try {
      conn = ARE.getDBConnection(database);

      int isolation = ARE.getProperty("connection.bcr.isolation", -1);
      if (isolation != -1) {
        this.logger.debug("JDBC transactionIsolation set to " + isolation);
        conn.setTransactionIsolation(isolation);
      }

      conn.setAutoCommit(false);
    } catch (SQLException se) {
      ARE.getLog().debug(se);
      throw new BCRException("����Sessionʱ�������ݿ�ʧ��!");
    }

    PreparedStatement pstmt = null;
    Statement stmt = null;
    try {
      stmt = conn.createStatement();

      ResultSet rs = stmt.executeQuery("select SessionId from BCR_SESSION where SessionID='" + getSessionId() + "'");
      boolean exists = rs.next();
      rs.close();
      if (exists) {
        pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setInt(1, getStatus());
        pstmt.setString(2, getNote());
        pstmt.setString(3, getSessionId());
      } else {
        pstmt = conn.prepareStatement(sqlInsert);
        pstmt.setString(1, getSessionId());
        pstmt.setString(2, getFinanceId());
        pstmt.setInt(3, getStatus());
        pstmt.setString(4, getMessageSetType());
        pstmt.setInt(5, (isRetryMessage()) ? 2 : 1);
        pstmt.setDate(6, new java.sql.Date(getCreateTime().getTime()));
        pstmt.setString(7, getNote());
      }
      pstmt.executeUpdate();
      conn.commit();
    } catch (SQLException e) {
      ARE.getLog().debug(e);
      ecre = new BCRException("Save session failed", e);

      if (stmt != null) try {
          stmt.close(); } catch (SQLException e1) { this.logger.debug(e1); }
      if (pstmt != null) try {
          pstmt.close(); } catch (SQLException e1) { this.logger.debug(e1); } try {
        conn.close(); } catch (SQLException e1) { this.logger.debug(e1); }
      conn = null;
    }
    finally
    {
      if (stmt != null) try {
          stmt.close(); } catch (SQLException e1) { this.logger.debug(e1); }
      if (pstmt != null) try {
          pstmt.close(); } catch (SQLException e1) { this.logger.debug(e1); } try {
        conn.close(); } catch (SQLException e1) { this.logger.debug(e1); }
      conn = null;
    }
    if (ecre != null) throw ecre;
  }

  public final void load()
    throws BCRException
  {
    Connection conn = null;
    try {
      conn = ARE.getDBConnection(database);
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery("select * from BCR_SESSION where SessionId='" + getSessionId() + "'");
      if (rs.next()) {
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
    } catch (SQLException e) {
      if (conn != null) try {
          conn.close(); } catch (SQLException e1) { ARE.getLog().debug(e1);
        }
      conn = null;
      throw new BCRException("Load session failed", e);
    }
  }

  public final boolean init()
  {
    AbstractProvider ap = null;
    try {
      ap = createProvider();
    } catch (BCRException ex) {
      this.logger.error("����providerʧ�ܣ�", ex);
      return false;
    }
    if (ap == null) {
      this.logger.error("providerδ������");
      return false;
    }
    ap.setReportFinanceCode(getFinanceId());

    if (isMultiOrg()) {
      ap.setFileFinanceCode(getFinanceId());
      ap.setContactPerson(getContactPerson());
      ap.setContactPhone(getContactPhone());
    }
    else {
      ap.setFileFinanceCode(ARE.getProperty("fileFinanceId"));
      ap.setContactPerson(ARE.getProperty("contactPerson"));
      ap.setContactPhone(ARE.getProperty("contactPhone"));
    }
    ap.setRetryMessage(isRetryMessage());
    ap.setFileSerialNo(getSessionId().substring(6, 10));

    this.provider = ap;

    this.fileHandler = new ExportFileHandler();
    this.fileHandler.setSessionId(getSessionId());
    this.fileHandler.setRetryMessage(this.retryMessage);
    if (this.exportFolder != null) this.fileHandler.setExportFolder(this.exportFolder);
    this.handler = this.fileHandler;

    return true;
  }

  protected AbstractProvider createProvider()
    throws BCRException
  {
    SimpleHISProvider p = new SimpleHISProvider();
    String f = null;
    if (!(isRetryMessage()))
      f = "(SessionID='0000000000') and (Incrementflag='1' or Incrementflag='2' or Incrementflag='3' or Incrementflag='4') and (OccurDate<='" + 
        getCreateTime("yyyy/MM/dd") + 
        "')";
    else {
      f = "(SessionID='1111111111') and (Incrementflag='1' or Incrementflag='2' or Incrementflag='3' or Incrementflag='4') and (ModFlag='1')";
    }

    if (this.isMultiOrg) f = f + " and financeID in (select OrgID from ORG_TASK_INFO where OrgCode='" + getFinanceId() + "')";

    p.setDataFilter(f);

    return p;
  }

  public void postProcess()
  {
    if (getStatus() != 100) {
      this.logger.warn("�����ļ�δ����ȷ����,���ܽ��к�������! ");
      return;
    }

    this.logger.info("��ϲ�������ļ��������! ");
    try
    {
      saveStatus();
    } catch (Exception e) {
      this.logger.debug(e);
    }

    if (!(isAutoEcrypt())) {
      this.logger.info("��������,�����ļ�δ���м��ܺͼ�ѹ����! ");
      return;
    }

    String exportFileName = this.fileHandler.getExportFile();
    String messageFile = exportFileName.substring(0, exportFileName.length() - 4);
    String encryptFileName = messageFile + ".enc";
    String zipFileName = messageFile + ".zip";

    PBCFileClient fc = new PBCFileClient();
    fc.setCryptConfigFile(this.cryptConfigFile);
    fc.setCryptKeyFile(this.cryptKeyFile);
    
    String tf;
	File f;

    if (!(fc.encrypt(exportFileName, encryptFileName))) {
      this.logger.warn("���ź������ɼ����ļ�ʧ�ܣ�����Ҫ�ֹ����ܺ�ѹ��! ");
      tf = exportFileName + ".tmp";
      f = new File(tf);
      if (f.exists()) f.delete();
      return;
    }
    this.logger.info("��ϲ�����ɼ����ļ��ɹ�! ");

    if (!(isAutoCompress())) {
      this.logger.info("��������,�����ļ�δ����ѹ������! ");
      return;
    }

    if (!(fc.compress(encryptFileName, zipFileName))) {
      this.logger.warn("���ź�������ѹ���ļ�ʧ�ܣ���Ҫ�ֹ�����ѹ���ͷ���! ");
      tf = exportFileName + ".tmp";
      f = new File(tf);
      if (f.exists()) f.delete();
      return;
    }
    this.logger.info("��ϲ������ѹ���ļ��ɹ�! ");
    tf = exportFileName + ".tmp";
    f = new File(tf);
    if (f.exists()) f.delete();
  }

  public void saveStatus() throws Exception {
    Connection conn = ARE.getDBConnection(database);
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sqlInsert = "insert into BCR_REPORTSTATUS (SessionID,MessageType,RetryType,RecordNumber) values(?,?,?,?)";

    String sqlUpdate = "update BCR_REPORTSTATUS set MessageType = ?,RetryType = ?,RecordNumber = ? where SessionID = ?";
    try
    {
      stmt = conn.createStatement();
      rs = stmt.executeQuery("select 1 from ECR_REPORTSTATUS where SessionID = '" + getSessionId() + "'");

      if (rs.next()) {
        pstmt = conn.prepareStatement(sqlUpdate);
        pstmt.setString(1, getMessageSetType());
        pstmt.setString(2, (this.retryMessage) ? "1" : "0");
        pstmt.setInt(3, this.fileHandler.getReportCount());
        pstmt.setString(4, getSessionId());
      } else {
        pstmt = conn.prepareStatement(sqlInsert);
        pstmt.setString(1, getSessionId());
        pstmt.setString(2, getMessageSetType());
        pstmt.setString(3, (this.retryMessage) ? "1" : "0");
        pstmt.setInt(4, this.fileHandler.getReportCount());
      }
      pstmt.executeUpdate();
      conn.commit();
    } catch (SQLException e) {
      ARE.getLog().debug(e);

      if (pstmt != null)
        try {
          pstmt.close();
        } catch (SQLException e1) {
          this.logger.debug(e1);
        }
      try {
        rs.close();
      } catch (SQLException e1) {
        this.logger.debug(e1);
      }
      try {
        conn.close();
      } catch (SQLException e1) {
        this.logger.debug(e1);
      }
    }
    finally
    {
      if (pstmt != null)
        try {
          pstmt.close();
        } catch (SQLException e1) {
          this.logger.debug(e1);
        }
      try {
        rs.close();
      } catch (SQLException e1) {
        this.logger.debug(e1);
      }
      try {
        conn.close();
      } catch (SQLException e1) {
        this.logger.debug(e1);
      }
    }
  }

  public boolean ready()
  {
    RecordCountHandler h = new RecordCountHandler();
    this.messageSet.setHandler(h);
    try {
      this.messageSet.parse(this.provider);
    } catch (BCRException e) {
      this.logger.error("����ϱ���¼����", e);
      return false;
    }
    this.logger.info("��鵽���ϱ���¼����: " + h.getTotalRecordNumber());
    return (h.getTotalRecordNumber() > 0);
  }  

  public final boolean isRetryMessage()
  {
    return this.retryMessage;
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
    return this.cryptConfigFile;
  }

  public final void setCryptConfigFile(String cryptConfigFile)
  {
    this.cryptConfigFile = cryptConfigFile;
  }

  public final String getCryptKeyFile()
  {
    return this.cryptKeyFile;
  }

  public final void setCryptKeyFile(String cryptKeyFile)
  {
    this.cryptKeyFile = cryptKeyFile;
  }

  public final String getExportFolder()
  {
    return this.exportFolder;
  }

  public final void setExportFolder(String exportFolder)
  {
    this.exportFolder = exportFolder;
  }

  public final boolean isAutoCompress()
  {
    return this.autoCompress;
  }

  public final void setAutoCompress(boolean autoCompress)
  {
    this.autoCompress = autoCompress;
  }

  public final boolean isAutoEcrypt()
  {
    return this.autoEcrypt;
  }

  public final void setAutoEcrypt(boolean autoEcrypt)
  {
    this.autoEcrypt = autoEcrypt;
  }

  public boolean isMultiOrg() {
    return this.isMultiOrg;
  }

  public void setMultiOrg(boolean isMultiOrg) {
    this.isMultiOrg = isMultiOrg;
  }
}
