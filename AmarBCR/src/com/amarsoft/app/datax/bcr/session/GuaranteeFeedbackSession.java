package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.bizmanage.GuaranteeFeedbackFileProvider;
import com.amarsoft.app.datax.bcr.bizmanage.GuaranteeFeedbackHandler;
import com.amarsoft.app.datax.bcr.bizmanage.GuaranteeFeedbackRecord;
import com.amarsoft.app.datax.bcr.message.MessageSet;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class GuaranteeFeedbackSession extends MessageProcessSession{
	
	private String feedbackFile = null;
	  private String cryptConfigFile = null;
	  private String cryptKeyFile = null;
	  private String originalMessageList = "{etc/bcr_message_guaranteedelete.xml}{etc/bcr_message_guaranteechange.xml}{etc/bcr_message_guaranteeinfo.xml}";
	  private Map messageSetMap = new HashMap();
	  private String database = "bcr";

	  public GuaranteeFeedbackSession()
	  {
	    this.feedbackFile = null;
	    setMessageConfigFile("etc/bcr_message_guaranteefeedback.xml");
	  }

	  public GuaranteeFeedbackSession(String backMesageDataFile)
	  {
	    this.feedbackFile = backMesageDataFile;
	    setMessageConfigFile("etc/bcr_message_guaranteefeedback.xml");
	  }

	  public void setFeedbackFile(String backFile) {
	    this.feedbackFile = backFile;
	  }

	  public String getFeedbackFile()
	  {
	    return this.feedbackFile;
	  }

	  public boolean init()
	  {
	    String s = getMessageSetType();
	    if (s == null) {
	      this.logger.error("����ҵ����Ϣ�������ļ�������(messageSetType)δ���ã�");
	      return false;
	    }
	    try
	    {
	      this.provider = new GuaranteeFeedbackFileProvider(this.feedbackFile);
	    } catch (BCRException e1) {
	      this.logger.error("��ʼ������ҵ����Ϣ���������ṩ��ʧ�ܣ�", e1);
	      return false;
	    }

	    String[] ol = StringX.parseArray(this.originalMessageList);
	    if ((ol == null) || (ol.length < 1)) {
	      this.logger.error("ԭʼ�����б�(originalMessageList)δ���ã�");
	      return false;
	    }
	    for (int i = 0; i < ol.length; ) {
	      try {
	        addOriginalMessageConfig(ol[i]);
	      } catch (BCRException ex) {
	        this.logger.error("����ԭʼ��������ʧ�ܣ�");
	        return false;
	      }
	      ++i;
	    }

	    String[] mess = new String[3];
	    mess[0] = ((String)this.messageSetMap.get("15"));
	    mess[1] = ((String)this.messageSetMap.get("16"));
	    mess[2] = ((String)this.messageSetMap.get("17"));
	    try {
	      GuaranteeFeedbackRecord.init(mess);
	    } catch (BCRException e) {
	      this.logger.error("��ʼ������ҵ����Ϣ��������ԭʼ���ļ���ʧ��!", e);
	      return false;
	    }
	    this.handler = new GuaranteeFeedbackHandler();
	    return true;
	  }

	  public void addOriginalMessageConfig(String xmlMessageConfigFile)
	    throws BCRException
	  {
	    MessageSet ms = MessageSet.createMessageSetFromXml(xmlMessageConfigFile);
	    this.messageSetMap.put(ms.getType(), xmlMessageConfigFile);
	  }

	  public void postProcess()
	  {
	    if (getStatus() != 100) {
	      this.logger.fatal("���б��Ĵ������" + getSessionId() + "ʧ��!");
	      return;
	    }
	    this.logger.info("�����ر����ļ�" + this.feedbackFile + "�ɹ���");

	    File fs = new File(this.feedbackFile);
	    if (fs.renameTo(new File(fs.getPath() + ".bak")))
	      this.logger.info("����" + fs.getPath() + "Ϊ" + fs.getPath() + ".bak�ɹ���");
	    else
	      this.logger.warn("����" + fs.getPath() + "Ϊ" + fs.getPath() + ".bakʧ�ܣ�");
	  }

	  public String getOriginalMessageList()
	  {
	    return this.originalMessageList;
	  }

	  public void setOriginalMessageList(String messageConfigFiles)
	  {
	    this.originalMessageList = messageConfigFiles;
	  }

	  public String getDatabase()
	  {
	    return this.database;
	  }

	  public void setDatabase(String database)
	  {
	    this.database = database; }

	  public final String getCryptConfigFile() {
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

}
