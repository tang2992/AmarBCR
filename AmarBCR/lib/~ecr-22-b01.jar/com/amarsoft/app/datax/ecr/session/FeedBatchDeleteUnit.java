// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FeedBatchDeleteUnit.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.PBCFileClient;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.io.File;
import java.io.FilenameFilter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			FeedBatchDeleteSession

public class FeedBatchDeleteUnit extends ExecuteUnit
{

	private String backMessageDataFolder;

	public FeedBatchDeleteUnit()
	{
		backMessageDataFolder = "feedback/deleteresult";
	}

	public int execute()
	{
		transferUnitProperties();
		File dataFolder = new File(backMessageDataFolder);
		if (!dataFolder.exists() || !dataFolder.isDirectory())
		{
			logger.fatal((new StringBuilder("��Ч������Ŀ¼��")).append(backMessageDataFolder).toString());
			return 2;
		}
		File encfs[] = dataFolder.listFiles(new FilenameFilter() {

			final FeedBatchDeleteUnit this$0;

			public boolean accept(File dir, String name)
			{
				String vfilename = "11\\w{17}[1-3]{2}[12][0-9]{4}10\\.[Ee][Nn][Cc]$";
				if (!Pattern.matches(vfilename, name))
					return false;
				return (new SimpleDateFormat("yyMMdd")).parse(name.substring(13, 19)).before(new Date());
				ParseException e;
				e;
				return false;
			}

			
			{
				this$0 = FeedBatchDeleteUnit.this;
				super();
			}
		});
		FeedBatchDeleteSession session = new FeedBatchDeleteSession();
		String p;
		for (Iterator it = extendProperties.keySet().iterator(); it.hasNext(); ObjectX.setPropertyX(session, p, getProperty(p), true))
			p = (String)it.next();

		String cryptConfigFile = session.getCryptConfigFile();
		String cryptKeyFile = session.getCryptKeyFile();
		if (encfs.length < 1)
		{
			logger.info("����Ŀ¼����û����Ҫ���ܽ�ѹ�ķ����ļ���");
		} else
		{
			if (cryptConfigFile == null || cryptKeyFile == null)
				logger.fatal("�Ҳ������ܽ�ѹ��Ҫ��key�ļ�");
			logger.debug((new StringBuilder("Decrypt use config file:")).append(cryptConfigFile).toString());
			logger.debug((new StringBuilder("Decrypt use key file:")).append(cryptKeyFile).toString());
			PBCFileClient fc = new PBCFileClient();
			fc.setCryptConfigFile(cryptConfigFile);
			fc.setCryptKeyFile(cryptKeyFile);
			for (int i = 0; i < encfs.length; i++)
			{
				String messageFile = encfs[i].getPath().substring(0, encfs[i].getPath().length() - 4);
				logger.info((new StringBuilder("��ʼ�����ļ���")).append(messageFile).append(".enc").toString());
				try
				{
					fc.deCryptCompressFile((new StringBuilder(String.valueOf(messageFile))).append(".enc").toString(), (new StringBuilder(String.valueOf(messageFile))).append(".txt").toString());
					File f = new File((new StringBuilder(String.valueOf(messageFile))).append(".enc").toString());
					if (f.exists())
						f.delete();
				}
				catch (Exception e)
				{
					session.logger.fatal((new StringBuilder("���ܷ�������")).append(encfs[i].getPath()).append("ʧ��!").toString(), e);
					return 2;
				}
			}

		}
		File fs[] = dataFolder.listFiles(new FilenameFilter() {

			final FeedBatchDeleteUnit this$0;

			public boolean accept(File dir, String name)
			{
				String vfilename = "11\\w{17}[1-3]{2}[12][0-9]{4}10\\.[Tt][Xx][Tt]$";
				if (!Pattern.matches(vfilename, name))
					return false;
				return (new SimpleDateFormat("yyMMdd")).parse(name.substring(13, 19)).before(new Date());
				ParseException e;
				e;
				return false;
			}

			
			{
				this$0 = FeedBatchDeleteUnit.this;
				super();
			}
		});
		if (fs.length < 1)
		{
			logger.info("����Ŀ¼����û�з���Ҫ��ķ����ļ���");
			return 1;
		}
		for (int i = 0; i < fs.length; i++)
		{
			logger.info((new StringBuilder("��ʼ�����ļ���")).append(fs[i].getPath()).toString());
			session.setFeedbackFile(fs[i].getPath());
			try
			{
				session.start();
			}
			catch (ECRException e)
			{
				session.logger.fatal((new StringBuilder("����������")).append(fs[i].getPath()).append("ʧ��!").toString(), e);
				return 2;
			}
			if (session.getStatus() != 100)
			{
				session.logger.fatal((new StringBuilder("���б��Ĵ������")).append(fs[i].getPath()).append("ʧ��!").toString());
				return 2;
			}
		}

		logger.info((new StringBuilder("���з����ļ�������ɣ����ƴ���")).append(fs.length).append("����").toString());
		return 1;
	}

	public String getBackMessageDataFolder()
	{
		return backMessageDataFolder;
	}

	public void setBackMessageDataFolder(String backMessageDataFolder)
	{
		this.backMessageDataFolder = backMessageDataFolder;
	}
}
