package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.common.PBCFileClient;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.io.File;
import java.io.FilenameFilter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;
import java.util.regex.Pattern;

public class GuaranteeFeedbackUnit extends ExecuteUnit{
	
	 private String backMessageDataFolder = "feedback/organfeedback";

	  public int execute()
	  {
	    transferUnitProperties();
	    File dataFolder = new File(this.backMessageDataFolder);
	    if ((!(dataFolder.exists())) || (!(dataFolder.isDirectory()))) {
	      this.logger.fatal("无效的数据目录：" + this.backMessageDataFolder);
	      return 2;
	    }

	    File[] encfs = dataFolder.listFiles(
	      new FilenameFilter()
	    {
	      public boolean accept(File dir, String name)
	      {
	        String vfilename = "11[0]{3}\\w{17}(15|16|17)1[0-9]{4}10\\.[Ee][Nn][Cc]$";
	        if (!(Pattern.matches(vfilename, name))) return false;
	        try {
	          return new SimpleDateFormat("yyMMdd").parse(name.substring(16, 22)).before(new Date()); 
	          } catch (ParseException e) {
	        }
	        return false;
	      }

	    });
	    GuaranteeFeedbackSession session = new GuaranteeFeedbackSession();

	    Iterator it = this.extendProperties.keySet().iterator();
	    while (it.hasNext()) {
	      String p = (String)it.next();
	      ObjectX.setPropertyX(session, p, getProperty(p), true);
	    }

	    String cryptConfigFile = session.getCryptConfigFile();
	    String cryptKeyFile = session.getCryptKeyFile();

	    if (encfs.length < 1) {
	      this.logger.info("数据目录下面没有需要解密解压的反馈文件！");
	    }
	    else
	    {
	      if ((cryptConfigFile == null) || (cryptKeyFile == null))
	      {
	        this.logger.fatal("找不到解密解压需要的key文件");
	      }
	      this.logger.debug("Decrypt use config file:" + cryptConfigFile);
	      this.logger.debug("Decrypt use key file:" + cryptKeyFile);
	      PBCFileClient fc = new PBCFileClient();
	      fc.setCryptConfigFile(cryptConfigFile);
	      fc.setCryptKeyFile(cryptKeyFile);
	      for (int i = 0; i < encfs.length; ++i) {
	        String messageFile = encfs[i].getPath().substring(0, encfs[i].getPath().length() - 4);
	        this.logger.info("开始解密文件：" + messageFile + ".enc");
	        try {
	          fc.deCryptCompressFile(messageFile + ".enc", messageFile + ".txt");
	          File f = new File(messageFile + ".enc");
	          if (!(f.exists())) f.delete();
	        } catch (Exception e) {
	          session.logger.fatal("解密反馈报文" + encfs[i].getPath() + "失败!", e);
	          return 2;
	        }

	      }

	    }

	    File[] fs = dataFolder.listFiles(
	      new FilenameFilter()
	    {
	      public boolean accept(File dir, String name)
	      {
	        String vfilename = "11[0]{3}\\w{17}(15|16|17)1[0-9]{4}10\\.[Tt][Xx][Tt]$";
	        if (!(Pattern.matches(vfilename, name))) return false;
	        try {
	          return new SimpleDateFormat("yyMMdd").parse(name.substring(22, 28)).before(new Date()); 
	          } catch (ParseException e) {
	        }
	        return false;
	      }

	    });
	    if (fs.length < 1) {
	      this.logger.info("数据目录下面没有符合要求的反馈文件！");
	      return 1;
	    }

	    for (int i = 0; i < fs.length; ++i) {
	      this.logger.info("开始处理文件：" + fs[i].getPath());
	      session.setFeedbackFile(fs[i].getPath());
	      try {
	        session.start();
	      } catch (BCRException e) {
	        session.logger.fatal("处理反馈报文" + fs[i].getPath() + "失败!", e);
	        return 2;
	      }

	      if (session.getStatus() != 100) {
	        session.logger.fatal("运行报文处理过程" + fs[i].getPath() + "失败!");
	        return 2;
	      }
	    }
	    this.logger.info("所有反馈文件处理完成，共计处理" + fs.length + "个！");
	    return 1;
	  }

	  public String getBackMessageDataFolder()
	  {
	    return this.backMessageDataFolder;
	  }

	  public void setBackMessageDataFolder(String backMessageDataFolder)
	  {
	    this.backMessageDataFolder = backMessageDataFolder;
	  }

}
