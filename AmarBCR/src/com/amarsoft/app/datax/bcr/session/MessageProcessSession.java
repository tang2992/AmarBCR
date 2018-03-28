package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.DataProvider;
import com.amarsoft.app.datax.bcr.message.Handler;
import com.amarsoft.app.datax.bcr.message.MessageSet;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class MessageProcessSession
{
  public static final int STATUS_INIT = 0;
  public static final int STATUS_READY = 10;
  public static final int STATUS_PROCESS = 20;
  public static final int STATUS_COMPLETE = 100;
  public static final String DEFAULT_ECR_DATABASE = "bcr";
  public static final String VIRTUAL_FINANCEID = "99999999999";
  public static final String VIRTUAL_CONTACTPERSON = "***";
  public static final String VIRTUAL_CONTACTPHONE = "*******";
  public static final String VIRTUAL_SESSION_WAIT_REPORT = "0000000000";
  public static final String VIRTUAL_SESSION_WAIT_RETRY = "1111111111";
  public static final String VIRTUAL_SESSION_NEEDNT_RETRY = "6666666666";
  public static final String VIRTUAL_SESSION_FEEDBACK_POOL = "9999999999";
  public static final String VIRTUAL_SESSION_FEEDBACK_ERROR = "7777777777";
  public static final String VIRTUAL_SESSION_FEEDBACK_SUCCESS = "8888888888";
  private String sessionId = "1111111111";
  private String financeId = "99999999999";
  private String contactPerson = "***";
  private String contactPhone = "*******";
  private int status = 0;
  private String messageSetType = null;
  private Date createTime = null;
  private String note = null;
  private String messageConfigFile = null;
  protected SimpleDateFormat dateFormater = new SimpleDateFormat();
  protected Log logger = ARE.getLog();
  protected MessageSet messageSet = null;
  protected DataProvider provider = null;
  protected Handler handler = null;

  public void save()
    throws BCRException
  {
  }

  public abstract boolean init();

  public boolean ready()
  {
    return true;
  }

  public boolean process()
  {
    if (this.provider == null) {
      this.logger.error("报文数据提供器未设置，请在init过程中实现设置！");
      return false;
    }
    if (this.handler == null) {
      this.logger.error("报文数据处理控制器未设置，请在init过程中实现设置！");
      return false;
    }

    this.messageSet.setHandler(this.handler);
    try {
      this.messageSet.parse(this.provider);
    } catch (BCRException e) {
      this.logger.debug(e);
      return false;
    }
    return true;
  }

  public void postProcess()
  {
  }

  public final void start()
    throws BCRException
  {
    if (this.messageSet == null) {
      this.messageSet = MessageSet.createMessageSetFromXml(this.messageConfigFile);
      if (this.messageSetType == null) this.messageSetType = this.messageSet.getType();
      if (!(this.messageSetType.equals(this.messageSet.getType())))
        throw new BCRException("处理过程报文集合类型(" + this.messageSetType + 
          ")和配置文件的报文集合类型(" + this.messageSet.getType() + ")不一致！");
    }

    this.logger.info("初始化报文处理过程[" + getSessionId() + "]......");
    if (init()) {
      this.logger.info("初始化报文处理过程完成！");
      setStatus(10);
    } else {
      this.logger.error("初始化报文处理过程失败！");
      postProcess();
      return;
    }

    this.logger.info("检查报文处理过程条件[" + getSessionId() + "]......");
    if (ready()) {
      this.logger.info("处理条件就绪！");
      setStatus(20);
    } else {
      this.logger.warn("处理条件不成熟！");
      postProcess();
      return;
    }

    this.logger.info("执行处理报文处理过程[" + getSessionId() + "]......");
    if (process()) {
      this.logger.info("执行报文处理过程完成！");
      setStatus(100);
    } else {
      this.logger.error("执行报文处理过程失败！");
      throw new BCRException("执行报文处理过程失败！");
    }

    save();
    postProcess();
  }

  public final String getFinanceId()
  {
    return this.financeId;
  }

  public String getContactPerson()
  {
    return this.contactPerson;
  }

  public String getContactPhone()
  {
    return this.contactPhone;
  }

  public final String getSessionId()
  {
    return this.sessionId;
  }

  public final Date getCreateTime()
  {
    return this.createTime;
  }

  public final String getNote()
  {
    return this.note;
  }

  public final String getCreateTime(String format)
  {
    if (format == null) format = "yyyyMMdd";
    this.dateFormater.applyPattern(format);
    return this.dateFormater.format(this.createTime);
  }

  public final String getMessageSetType()
  {
    return this.messageSetType;
  }

  public final int getStatus()
  {
    return this.status;
  }

  public final void setStatus(int sessionStatus)
  {
    this.status = sessionStatus;
  }

  public final void setCreateTime(Date createTime)
  {
    this.createTime = createTime;
  }

  public final void setFinanceId(String financeCode)
  {
    this.financeId = financeCode;
  }

  public void setContactPerson(String contactPerson)
  {
    this.contactPerson = contactPerson;
  }

  public void setContactPhone(String contactPhone)
  {
    this.contactPhone = contactPhone;
  }

  public final void setMessageSetType(String messageSetType)
  {
    this.messageSetType = messageSetType;
  }

  public final void setNote(String note)
  {
    this.note = note;
  }

  public final void setSessionId(String sessionId)
  {
    this.sessionId = sessionId;
  }

  public final String getMessageConfigFile()
  {
    return this.messageConfigFile;
  }

  public final void setMessageConfigFile(String messageConfigFile)
  {
    this.messageConfigFile = messageConfigFile;
  }
}
