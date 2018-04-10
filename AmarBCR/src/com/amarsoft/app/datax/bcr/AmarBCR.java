package com.amarsoft.app.datax.bcr;

import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.util.CommandLineArgument;
import com.amarsoft.task.TaskRunner;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class AmarBCR
{
  public static final String PROPERTY_TASK_FILE = "TaskFile";
  public static final String DEFAULT_ARE_CONFIG = "etc/bcr_are.xml";

  public static void main(String[] args)
  {
    CommandLineArgument arg = new CommandLineArgument(args);
    String are = arg.getArgument("are", "etc/bcr_are.xml");

    ARE.init(are);
    String occurDate = getArgumentOccurDate(arg);
    if (occurDate == null) occurDate = getAREOccurDate(ARE.getProperty("businessOccurDate"));

    ARE.setProperty("businessOccurDate", occurDate);
    ARE.setProperty("occurDate", occurDate);

    String taskFile = ARE.getProperty(arg.getArgument("task", "validate") + "TaskFile");
    boolean gui = arg.getArgument("gui", false);

    int exitCode = 0;
    if (gui) {
      exitCode = TaskRunner.runGui(taskFile);
      ARE.getLog().info("自动计算后businessOccurDate：" + occurDate);
    } else {
      ARE.getLog().info("自动计算后businessOccurDate：" + occurDate);
      exitCode = TaskRunner.runCli(taskFile);
      System.exit(exitCode);
    }
  }

  private static String getArgumentOccurDate(CommandLineArgument arg)
  {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
    String occurDate = arg.getArgument("businessOccurDate");
    if (occurDate != null)
      try {
        sdf.parse(occurDate);
      } catch (Exception ex) {
        System.out.println("无效的发生日期参数：" + occurDate);
        occurDate = null;
      }


    return occurDate;
  }

  public static String getAREOccurDate(String od)
  {
    String occurDate = null;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
    if (od == null) od = "AUTOSELECT";
    if (od.equalsIgnoreCase("TODAY")) {
      occurDate = sdf.format(new Date());
    } else if (od.equalsIgnoreCase("YESTERDAY")) {
      occurDate = Tools.getLastDay("1");
    } else if (od.equalsIgnoreCase("AUTOSELECT")) {
      Calendar cal = Calendar.getInstance();
      cal.setTime(new Date());
      occurDate = Tools.getCurrentDay("1");
      if (cal.get(11) < 22)
        occurDate = Tools.getLastDay("1");
    } else if (od.equalsIgnoreCase("USERINPUT")) {
      Calendar cal = Calendar.getInstance();
      cal.setTime(new Date());
      occurDate = null;
      while (occurDate == null) {
        System.out.print("Input Business Date(yyyy/mm/dd)：");
        byte[] buf = new byte[10];
        try {
          int ii = System.in.read(buf);
          if (ii != 10) {
            System.out.println("Invalid input!");
            if (cal.get(11) < 22)
            occurDate = Tools.getLastDay("1");
          }
          occurDate = new String(buf);
          try {
            sdf.parse(occurDate);
          } catch (Exception e) {
            occurDate = null;
          }
        } catch (IOException e) {
          System.out.println(e);
        }
      }
    }
    else {
      try {
        occurDate = od;
        sdf.parse(od);
      } catch (Exception ex) {
        occurDate = getAREOccurDate("AUTOSELECT");
      }
    }
    return occurDate;
  }
}