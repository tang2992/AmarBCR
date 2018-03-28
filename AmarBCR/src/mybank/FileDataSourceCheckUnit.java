package mybank;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.DataSourceURI;
import com.amarsoft.are.sql.TabularReader;
import com.amarsoft.task.ExecuteUnit;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

public class FileDataSourceCheckUnit extends ExecuteUnit
{
  private ArrayList dataSources = null;
  private OutputStreamWriter resultFile = null;
  private Log logger = ARE.getLog();
  private int errorNumber = 0;
  int[] colType = null;

  public int execute()
  {
    this.logger.info("��ʼ����Դ���......");
    if (!(init()))
    {
      this.logger.fatal("��ʼ����黷��ʧ�ܣ��޷�������һ����飡");
      return 2;
    }
    Iterator localIterator = this.dataSources.iterator();
    while (localIterator.hasNext())
    {
    	
      String str = (String)localIterator.next();
      this.logger.info("��ʼ�������Դ��" + str);
      writeInfo("��ʼ�������Դ��" + str);
      int i = checkDataSource(str);
      if (i > 0)
        this.logger.error("���δͨ��,���ִ�������" + i);
      else
        this.logger.info("���ͨ����");
      this.errorNumber += i;
      writeInfo("�������Դ��飺" + str + "\n");
    }
    close();
    if (this.errorNumber > 0)
    {
      this.logger.fatal("�ź�������Դ�����������ִ�������" + this.errorNumber + " ,��ϸ��Ϣ�������¼�ļ�����־�ļ���");
      return 2;
    }
    this.logger.info("��ϲ������Դ��������δ�������Դ���");
    return 1;
  }

  private boolean init()
  {
    String str1 = getProperty("resultFile", "export/datasource_check_report.txt");
    FileOutputStream localFileOutputStream = null;
    try
    {
      localFileOutputStream = new FileOutputStream(str1);
    }
    catch (FileNotFoundException localFileNotFoundException)
    {
      this.logger.error("��������ļ�" + str1 + "ʧ�ܣ�");
      return false;
    }
    try
    {
      this.resultFile = new OutputStreamWriter(localFileOutputStream, "GBK");
    }
    catch (UnsupportedEncodingException localUnsupportedEncodingException)
    {
      this.resultFile = new OutputStreamWriter(localFileOutputStream);
    }
    String[] arrayOfString = getProperties();
    if (this.dataSources == null)
      this.dataSources = new ArrayList(arrayOfString.length - 1);
    for (int i = 0; i < arrayOfString.length; ++i)
      if (arrayOfString[i].startsWith("dataSource_"))
      {
        String str2 = getProperty(arrayOfString[i]);
        if ((str2 != null) && (str2.trim().length() > 0))
          this.dataSources.add(str2);
      }
    return true;
  }

  private int checkDataSource(String paramString)
  {
    int l;
    TabularReader localTabularReader = null;
    int i = 0;
    this.colType = null;
    try
    {
      DataSourceURI localDataSourceURI = new DataSourceURI(paramString);
      String str = localDataSourceURI.getDataUrl();
      File localFile = new File(str);
      if (!(localFile.exists()))
      {
        ++i;
        writeInfo("����Դ�ļ������ڣ�" + str);
        return i;
      }
      localTabularReader = new TabularReader(localDataSourceURI);
    }
    catch (URISyntaxException localURISyntaxException)
    {
      ++i;
      writeInfo("������Դʧ�ܣ�" + paramString);
      this.logger.debug(localURISyntaxException);
      return i;
    }
    boolean bool = false;
    int j = 0;
    int k = 0;
    try
    {
      k = localTabularReader.getMetaData().getColumnCount();
      this.colType = new int[k + 1];
      for (l = 1; l <= k; ++l)
        this.colType[l] = localTabularReader.getMetaData().getColumnType(l);
    }
    catch (SQLException localSQLException)
    {
      ++i;
      writeInfo("����Դ�ļ���ʽ����");
      this.logger.debug(localSQLException);
      return i;
    }
    label351:
    do
    {
      int i1;
      ++j;
      try
      {
        bool = localTabularReader.next();
        if ((!(bool)) && (j == 1))
        {
          writeInfo("�����ļ�Ϊ�գ�");
          break label351 ;
        }
        for (i1 = 0; i1 < k; ++i1)
          if (!(checkValue(localTabularReader, i1 + 1)))
          {
            ++i;
            writeInfo("�д��������кţ�" + j);
          }
      }
      catch (Exception localException)
      {
        ++i;
        writeInfo("�д��������кţ�" + j);
        this.logger.debug(localException);
      }
    }
    while (bool);
   
    localTabularReader.close();
    return i;
  }

  private boolean checkValue(TabularReader paramTabularReader, int paramInt)
  {
    try
    {
      switch (this.colType[paramInt])
      {
      case 1:
      case 12:
        paramTabularReader.getString(paramInt);
        break;
      case -6:
      case 4:
      case 5:
        paramTabularReader.getInt(paramInt);
        break;
      case -5:
        paramTabularReader.getLong(paramInt);
        break;
      case 2:
      case 3:
      case 6:
      case 7:
      case 8:
        paramTabularReader.getDouble(paramInt);
        break;
      case 91:
        paramTabularReader.getDate(paramInt);
        break;
      case 92:
        paramTabularReader.getTime(paramInt);
        break;
      case 93:
        paramTabularReader.getTimestamp(paramInt);
        break;
      case 16:
        paramTabularReader.getBoolean(paramInt);
        break;
      default:
        paramTabularReader.getString(paramInt);
      }
    }
    catch (Exception localException)
    {
      this.logger.debug(localException.getMessage(), localException);
      return false;
    }
    return true;
  }

  private void close()
  {
    if (this.resultFile != null)
      try
      {
        this.resultFile.close();
      }
      catch (IOException localIOException)
      {
        this.logger.debug(localIOException);
      }
  }

  private void writeInfo(String paramString)
  {
    try
    {
      this.resultFile.write(paramString + "\n");
    }
    catch (IOException localIOException)
    {
      this.logger.debug(localIOException);
    }
  }
}