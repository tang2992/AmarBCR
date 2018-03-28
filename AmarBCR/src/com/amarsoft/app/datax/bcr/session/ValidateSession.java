package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.bizcollect.SimpleBCRProvider;
import com.amarsoft.app.datax.bcr.bizcollect.ValidateHandler;
import com.amarsoft.are.log.Log;
import com.cfcc.ecus.eft.util.DicUtil;
import java.io.File;

public class ValidateSession extends MessageProcessSession
{
  private String messageValidateRuleFile = null;
  private String validateDicFile = "etc/dic.xml";
  private String database = "bcr";

  public final String getDatabase()
  {
    return this.database;
  }

  public final void setDatabase(String database)
  {
    this.database = database;
  }

  public final String getMessageValidateRuleFile()
  {
    return this.messageValidateRuleFile;
  }

  public final void setMessageValidateRuleFile(String messageValidateRuleFile)
  {
    this.messageValidateRuleFile = messageValidateRuleFile;
  }

  public final String getValidateDicFile()
  {
    return this.validateDicFile;
  }

  public final void setValidateDicFile(String validateDicFile)
  {
    this.validateDicFile = validateDicFile;
  }

  public boolean init()
  {
    SimpleBCRProvider p = new SimpleBCRProvider();
    String f = " (IncrementFlag='1' or IncrementFlag='2') ";

    p.setDataFilter(f);

    if ((this.messageValidateRuleFile == null) || (!(new File(this.messageValidateRuleFile).exists()))) {
      this.logger.error("校验规则文件配置有误！");
      return false;
    }

    ValidateHandler h = new ValidateHandler();
    h.setDatabase(this.database);
    h.setRulesFile(this.messageValidateRuleFile);
    try {
      h.loadRulesFromXMLFile(this.messageValidateRuleFile);
    } catch (BCRException e1) {
      this.logger.error("校验规则文件加载失败,文件: " + this.messageValidateRuleFile, e1);
      return false;
    }

    try
    {
      DicUtil.initDicUtil(this.validateDicFile);
    } catch (Exception e) {
      this.logger.error("加载数据校验字典失败,文件 :" + this.validateDicFile, e);
      return false;
    }

    this.provider = p;
    this.handler = h;
    return true;
  }

  public void postProcess()
  {
    if (getStatus() == 100)
      this.logger.info("共校验记录数：" + ((ValidateHandler)this.handler).getTotalRecordNumber() + 
        ", 其中正确记录：" + ((ValidateHandler)this.handler).getCorrectRecordNumber() + 
        ", 检验到错误数：" + ((ValidateHandler)this.handler).getErrorRecordNumber() + 
        ", 错误关联记录：" + ((ValidateHandler)this.handler).getErrorRelativedRecordNumber());
  }
}