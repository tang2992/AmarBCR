package com.amarsoft.app.util;

import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.DateX;
import com.amarsoft.are.util.StringFunction;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

public class RunTask
{
  private String taskName = null;
  private String orgList = null;
  private String userID = null;

  public String getTaskName()
  {
    return this.taskName;
  }

  public void setTaskName(String taskName) {
    this.taskName = taskName;
  }

  public String getOrgList() {
    return this.orgList;
  }

  public void setOrgList(String orgList) {
    this.orgList = orgList;
  }

  public String getUserID() {
    return this.userID;
  }

  public void setUserID(String userID) {
    this.userID = userID;
  }

  public String doRun()
  {
    Connection conn = null;
    PreparedStatement ps = null;
    String taskstatus = "执行异常";
    try {
      conn = ARE.getDBConnection("ecr");
      if ((getOrgList() != null) && 
        ("report".equalsIgnoreCase(getTaskName()))) {
        ps = conn.prepareStatement("update ORG_TASK_INFO set  currenttask=?,taskstatus=?,starttime=?,endtime=null,taskrunuserid=?,taskrundate=? where orgid=?");

        String[] orgs = getOrgList().split("~");
        for (int i = 0; i < orgs.length; ++i) {
          ps.setString(1, this.taskName);
          ps.setString(2, "START");
          ps.setString(3, StringFunction.getTodayNow());
          ps.setString(4, getUserID());
          ps.setString(5, DateX.format(new Date()));
          ps.setString(6, orgs[i]);
          ps.addBatch();
        }
        ps.executeBatch();
        ps.close();
        conn.commit();
      }

      int ret = CallBatchCommand.getInstance().execute(this.taskName);
      if (ret == CallBatchCommand.EXEC_STATUS_SUCCESS)
        taskstatus = "执行成功";

      if (ret == CallBatchCommand.EXEC_STATUS_FAILED)
        taskstatus = "执行失败";

      if (ret == CallBatchCommand.EXEC_STATUS_NOCALL) {
        taskstatus = "已有任务正在运行，请稍后再执行";
      }

      if ((getOrgList() != null) && 
        ("report".equalsIgnoreCase(getTaskName()))) {
        ps = conn.prepareStatement("update ORG_TASK_INFO set  currenttask=?,taskstatus=?,endtime=? where orgid=?");

        String[] orgs = getOrgList().split("~");
        for (int i = 0; i < orgs.length; ++i) {
          ps.setString(1, this.taskName);
          ps.setString(2, taskstatus);
          ps.setString(3, StringFunction.getTodayNow());
          ps.setString(4, orgs[i]);
          ps.addBatch();
        }
        ps.executeBatch();
        ps.close();
        conn.commit();
      }
      conn.close();
    }
    catch (SQLException e) {
      e.printStackTrace();
    }

    return taskstatus;
  }
}
