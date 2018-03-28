package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

public abstract class MessageProcessSessionUnit extends ExecuteUnit
{
  private MessageProcessSession session = null;

  protected abstract MessageProcessSession createSession()
    throws BCRException;

  public final int execute()
  {
    transferUnitProperties();
    try
    {
      this.session = createSession();
    } catch (BCRException e1) {
      ARE.getLog().fatal("�������Ĵ������ʧ��", e1);
      return 2;
    }

    if (this.session == null) {
      ARE.getLog().fatal("�������Ĵ������ʧ�ܣ�");
      return 2;
    }

    Iterator it = this.extendProperties.keySet().iterator();
    while (it.hasNext()) {
      String p = (String)it.next();
      ObjectX.setPropertyX(this.session, p, getProperty(p), true);
    }
    try {
      this.session.start();
    } catch (BCRException e) {
      this.session.logger.fatal("���д������" + this.session.getSessionId() + "ʧ��", e);
      sessionFailed(this.session);
      return 2;
    }
    int st = this.session.getStatus();
    if (st == 100) {
      this.session.logger.info("���д������" + this.session.getSessionId() + "�ɹ���");
      sessionSuccessful(this.session);
      return 1;
    }
    if (st == 10) {
      this.session.logger.info("���д������" + this.session.getSessionId() + "�������߱���");
      sessionWarning(this.session);
      return 3;
    }
    sessionFailed(this.session);
    return 2;
  }

  protected void sessionSuccessful(MessageProcessSession session)
  {
  }

  protected void sessionFailed(MessageProcessSession session)
  {
  }

  protected void sessionWarning(MessageProcessSession session)
  {
  }
}