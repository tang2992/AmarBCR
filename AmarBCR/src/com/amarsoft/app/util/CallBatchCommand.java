package com.amarsoft.app.util;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;

public class CallBatchCommand
{
  public String batchFileName = null;
  private static CallBatchCommand call = null;
  private static int status = 0;
  public static int EXEC_STATUS_SUCCESS = 1;
  public static int EXEC_STATUS_FAILED = -1;
  public static int EXEC_STATUS_NOCALL = 0; 

  public static CallBatchCommand getInstance()
  {
    if (call == null) return new CallBatchCommand();

    status = -1;
    return call;
  }

  public int execute(String batchFileName)
  {
    if (batchFileName != null) this.batchFileName = batchFileName;

    if (status == -1) {
      ARE.getLog().debug(" 已经有一个任务在运行，请稍后再尝试运行... ");
      return EXEC_STATUS_NOCALL;
    }

    if (!(getBatchFileName().matches("report|feedback|transfer|init|prepare|validate"))) {
      ARE.getLog().debug(getBatchFileName() + " not report|feedback|transfer|init|prepare|validate");
      return EXEC_STATUS_FAILED;
    }

    String command = ARE.getProperty("BCR_HOME") + "/bcr";
    
    boolean isWinOS = System.getProperty("os.name").toLowerCase().indexOf("windows") != -1;
    if(isWinOS){
    	command = command + ".bat ";
    }else{
    	command = command + ".sh ";
    }

    if (!(new File(command).exists())) {
      ARE.getLog().debug(command + " 脚本不存在...");
      return EXEC_STATUS_FAILED;
    }
    try
    {
      Process pcs = null;
      if(isWinOS){
    	  //Runtime.getRuntime().exec("cd /d " + ARE.getProperty("BCR_HOME"));
    	  pcs = Runtime.getRuntime().exec(command + " " + getBatchFileName());
      }else{
    	  pcs = Runtime.getRuntime().exec("sh " + command + " " + getBatchFileName());
      }       

      BufferedReader br = new BufferedReader(
        new InputStreamReader(pcs.getInputStream()));
      String line = null;
      while ((line = br.readLine()) != null)
        ARE.getLog().trace("--- " + line);

      br.close();
      try {
        if (pcs.waitFor() == 0)
          return EXEC_STATUS_SUCCESS;

        ARE.getLog().trace("--- 注意：因为" + command + " 脚本存在错误，不能正确完整的执行，请检查...");
        return EXEC_STATUS_FAILED;
      }
      catch (InterruptedException e) {
        e.printStackTrace();
        return EXEC_STATUS_FAILED;
      }
    } catch (IOException e) {
      e.printStackTrace(); }
    return EXEC_STATUS_FAILED;
  }

  public String getBatchFileName()
  {
    return this.batchFileName;
  }

  public void setBatchFileName(String batchFileName) {
    this.batchFileName = batchFileName;
  }

  public static void main(String[] args)
  {
    ARE.init();
    ARE.setProperty("ECR_HOME", "/home/amarsoft/Work/Space/AmarECRCZ");
    int ret = getInstance().execute("report");
    System.out.println((ret == 1) ? "运行成功" : "运行失败");
  }
}