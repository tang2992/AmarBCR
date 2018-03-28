// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FilesChecker.java

package com.amarsoft.app.datax.ecr.validate;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.cfcc.ecus.eft.*;
import com.cfcc.ecus.eft.cudata.CUCheckResult;
import com.cfcc.ecus.eft.util.CheckException;
import java.io.*;
import java.util.Iterator;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class FilesChecker
{

	protected static Log Logger;
	public static final String File_Verify_Type = "01";
	private String sCfgFile;
	private String sDicFile;
	private String sFileName;
	private String sErrorFileName;
	private String sFileEncrypt;
	private String sFileCheckType;

	public void setCfgFile(String cfgfile)
	{
		sCfgFile = cfgfile;
	}

	public void setDicFile(String dicfile)
	{
		sDicFile = dicfile;
	}

	public void setFileName(String filename)
	{
		sFileName = filename;
	}

	public void setErrorFileName(String errorfilename)
	{
		sErrorFileName = errorfilename;
	}

	public void setFileEncrypt(String fileencrypt)
	{
		sFileEncrypt = fileencrypt;
	}

	public void setFileCheckType(String filechecktype)
	{
		sFileCheckType = filechecktype;
	}

	public String getCfgFile()
	{
		return sCfgFile;
	}

	public String getDicFile()
	{
		return sDicFile;
	}

	public String getFileName()
	{
		return sFileName;
	}

	public String getErrorFileName()
	{
		return sErrorFileName;
	}

	public String getFileEncrypt()
	{
		return sFileEncrypt;
	}

	public String getFileCheckType()
	{
		return sFileCheckType;
	}

	public FilesChecker()
	{
		sCfgFile = "";
		sDicFile = "";
		sFileName = "";
		sErrorFileName = "";
		sFileEncrypt = "";
		sFileCheckType = "02";
		Logger = ARE.getLog();
	}

	public FilesChecker(String cfgfile, String dicfile, String filename, String errorfilename, String fileencrypt)
	{
		sCfgFile = "";
		sDicFile = "";
		sFileName = "";
		sErrorFileName = "";
		sFileEncrypt = "";
		sFileCheckType = "02";
		Logger = ARE.getLog();
		sCfgFile = cfgfile;
		sDicFile = dicfile;
		sFileName = filename;
		sErrorFileName = errorfilename;
		sFileEncrypt = fileencrypt;
	}

	public boolean CheckFileResult()
	{
		boolean returnType = true;
		try
		{
			if (sFileCheckType.equals("01"))
				returnType = checkInterfaceFileName(sCfgFile, sDicFile, sFileName, sErrorFileName);
			else
				returnType = checkFileName(sCfgFile, sDicFile, sFileName, sErrorFileName);
		}
		catch (Exception e)
		{
			Logger.fatal("文件检测失败", e);
		}
		return returnType;
	}

	public boolean enCryptCompressFileResult(String xmlPathConfig)
	{
		boolean ret = false;
		try
		{
			Thread beforeEncrypt[] = new Thread[Thread.activeCount()];
			Thread.enumerate(beforeEncrypt);
			ret = CryptAPI.enCryptCompressFile(sFileName, sFileEncrypt, (new StringBuilder(String.valueOf(xmlPathConfig))).append("Crypt.xml").toString(), (new StringBuilder(String.valueOf(xmlPathConfig))).append("public.key").toString(), 1, "1.0");
			Thread afterEncrypt[] = new Thread[Thread.activeCount()];
			Thread.enumerate(afterEncrypt);
			for (int i = 0; i < afterEncrypt.length; i++)
				if (afterEncrypt[i] != null)
				{
					int j;
					for (j = 0; j < beforeEncrypt.length; j++)
						if (beforeEncrypt[j] != null && afterEncrypt[i].equals(beforeEncrypt[j]))
							break;

					if (j == beforeEncrypt.length)
						afterEncrypt[i].interrupt();
				}

			File f = new File((new StringBuilder(String.valueOf(sFileName))).append(".tmp").toString());
			if (f.exists())
				f.delete();
		}
		catch (Exception e)
		{
			Logger.debug("文件加密压缩失败", e);
			ret = false;
		}
		return ret;
	}

	public HeadMsg deCryptCompressFileResult(String sdeFileName, String sdeFileEncrypt, String xmlPathConfig)
	{
		HeadMsg ret = null;
		try
		{
			ret = CryptAPI.deCryptCompressFile(sdeFileName, sdeFileEncrypt, (new StringBuilder(String.valueOf(xmlPathConfig))).append("Crypt.xml").toString(), (new StringBuilder(String.valueOf(xmlPathConfig))).append("public.key").toString(), 1);
		}
		catch (Exception e)
		{
			Logger.debug("文件解密失败", e);
		}
		return ret;
	}

	public boolean CompressFileResult(String comfile, String comfileres)
	{
		boolean ret = false;
		byte buf[] = new byte[1024];
		try
		{
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(comfileres));
			File f = new File(comfile);
			FileInputStream in = new FileInputStream(f);
			out.putNextEntry(new ZipEntry(f.getName()));
			for (int len = 0; (len = in.read(buf)) > 0;)
				out.write(buf, 0, len);

			out.closeEntry();
			in.close();
			out.close();
			ret = true;
		}
		catch (Exception e)
		{
			Logger.debug("文件压缩失败", e);
			ret = false;
		}
		return ret;
	}

	public boolean deCompressFileResult(String decomfile, String decomfileres)
	{
		boolean ret = false;
		try
		{
			ret = CryptAPI.compressFile(decomfile, decomfileres);
		}
		catch (Exception e)
		{
			Logger.debug("文件解压缩失败", e);
			ret = false;
		}
		return ret;
	}

	public static boolean checkInterfaceFileName(String cfgfile, String dicfile, String filename, String errorfilename)
	{
		FormatChecker fChecker = new FormatChecker(filename, dicfile, cfgfile);
		boolean returnType = true;
		CheckResultSet crs = fChecker.fileLevelCheck();
		List list = crs.getCheckResultList();
		Iterator iterator = list.iterator();
		try
		{
			PrintWriter pw = new PrintWriter(new OutputStreamWriter(new FileOutputStream(errorfilename, false)), false);
			while (iterator.hasNext()) 
			{
				CheckResult result = (CheckResult)iterator.next();
				pw.println((new StringBuilder("第")).append(crs.getLine()).append("行,").append("第").append(result.getOffset()).append("列，错误描述：").append(result.getResultDesc()).append("，错误码:").append(result.getResultCode()).toString());
				returnType = false;
			}
			crs = fChecker.initial();
			if (crs.getRtnCode() == 0)
			{
				crs = null;
				try
				{
					while (fChecker.hasNextCheckResultSet()) 
					{
						crs = fChecker.getNextCheckResultSet();
						list = crs.getCheckResultList();
						for (iterator = list.iterator(); iterator.hasNext();)
						{
							CheckResult result = (CheckResult)iterator.next();
							pw.println((new StringBuilder("第")).append(crs.getLine()).append("行,").append("第").append(result.getOffset()).append("列，数据").append(new String(crs.getSrcData())).append("有误,错误描述：").append(result.getResultDesc()).append("，错误码:").append(result.getResultCode()).toString());
							returnType = false;
						}

					}
				}
				catch (CheckException e)
				{
					e.printStackTrace();
					pw.println((new StringBuilder("第")).append(crs.getLine()).append("行,").append("第").append(crs.getOffset()).append("列").toString());
					returnType = false;
				}
			} else
			{
				list = crs.getCheckResultList();
				for (iterator = list.iterator(); iterator.hasNext();)
				{
					CheckResult result = (CheckResult)iterator.next();
					pw.println((new StringBuilder("第")).append(crs.getLine()).append("行,").append("第").append(result.getOffset()).append("列，错误描述：").append(result.getResultDesc()).append("，错误码:").append(result.getResultCode()).toString());
					returnType = false;
				}

			}
			pw.close();
		}
		catch (Exception e)
		{
			Logger.fatal(e.getMessage());
		}
		return returnType;
	}

	public static boolean checkFileName(String cfgfile, String dicfile, String filename, String errorfilename)
	{
		boolean returnType = true;
		CUCheckResult checkResult = null;
		checkResult = checkFile.checkall(cfgfile, dicfile, filename);
		if (checkResult.getResult() != 0)
			try
			{
				PrintWriter pw = new PrintWriter(new OutputStreamWriter(new FileOutputStream(errorfilename, false)), false);
				String errorMsg = checkResult.dump();
				pw.println(errorMsg);
				if (errorMsg.length() > 0)
					returnType = false;
				pw.close();
			}
			catch (Exception e)
			{
				Logger.fatal(e.getMessage());
			}
		return returnType;
	}

	public static void main(String args[])
	{
		checkFileName("D:/Project/workspace/AmarECR/etc/validator.xml", "D:/Project/workspace/AmarECR/etc/dic.xml", "D:/1139103140108051021111000200.txt", "D:/1139103140108051021111000200.bad");
		checkInterfaceFileName("D:/Project/workspace/AmarECR/etc/validator.xml", "D:/Project/workspace/AmarECR/etc/dic.xml", "D:/1139103140108051021111000200.txt", "D:/1139103140108051021111000200.bad");
	}
}
