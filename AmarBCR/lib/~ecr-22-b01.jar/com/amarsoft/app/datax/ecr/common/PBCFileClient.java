// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   PBCFileClient.java

package com.amarsoft.app.datax.ecr.common;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.cfcc.ecus.eft.*;
import com.cfcc.ecus.eft.crypt.MsgDecryptImpl2;
import com.cfcc.ecus.eft.cudata.CUCheckResult;
import com.cfcc.ecus.eft.util.CheckException;
import java.io.*;
import java.util.Iterator;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

// Referenced classes of package com.amarsoft.app.datax.ecr.common:
//			CompressUtil, PBCFileCheckHandler

public class PBCFileClient
{

	private Log logger;
	private String validatorRuleFile;
	private String validatorDicFile;
	private String cryptConfigFile;
	private String cryptKeyFile;

	public PBCFileClient()
	{
		validatorRuleFile = null;
		validatorDicFile = null;
		cryptConfigFile = null;
		cryptKeyFile = null;
	}

	public PBCFileClient(String validatorRuleFile, String validatorDicFile, String cryptConfigFile, String cryptKeyFile)
	{
		this.validatorRuleFile = null;
		this.validatorDicFile = null;
		this.cryptConfigFile = null;
		this.cryptKeyFile = null;
		this.validatorRuleFile = validatorRuleFile;
		this.validatorDicFile = validatorDicFile;
		this.cryptConfigFile = cryptConfigFile;
		this.cryptKeyFile = cryptKeyFile;
		logger = ARE.getLog();
	}

	public boolean encrypt(String inFile, String outFile)
	{
		boolean ret = false;
		try
		{
			Thread beforeEncrypt[] = new Thread[Thread.activeCount()];
			Thread.enumerate(beforeEncrypt);
			ret = CryptAPI.enCryptCompressFile(inFile, outFile, cryptConfigFile, cryptKeyFile, 1, "1.0");
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

			File f = new File((new StringBuilder(String.valueOf(inFile))).append(".tmp").toString());
			if (f.exists())
				f.delete();
		}
		catch (Exception e)
		{
			ret = false;
		}
		return ret;
	}

	public HeadMsg decrypt(String inFile, String outFile)
	{
		logger.debug((new StringBuilder("Encrypt use config file:")).append(cryptConfigFile).toString());
		logger.debug((new StringBuilder("Encrypt use key file:")).append(cryptKeyFile).toString());
		HeadMsg ret = null;
		try
		{
			ret = CryptAPI.deCryptCompressFile(inFile, outFile, cryptConfigFile, cryptKeyFile, 1);
		}
		catch (Exception e)
		{
			logger.debug("文件解密失败", e);
		}
		return ret;
	}

	public boolean deCryptCompressFile(String inFile, String outFile)
	{
		try
		{
			BatchContext.getInstance().setCrypConfig(cryptConfigFile);
			BatchContext.getInstance().setCrypPublickey(cryptKeyFile);
			MsgDecryptImpl2 mdi = new MsgDecryptImpl2();
			mdi.decryptMsg(inFile, (new StringBuilder(String.valueOf(inFile))).append(".tmp").toString(), 1);
			CompressUtil.deCompress((new StringBuilder(String.valueOf(inFile))).append(".tmp").toString(), outFile);
			String tf = (new StringBuilder(String.valueOf(inFile))).append(".tmp").toString();
			File f = new File(tf);
			if (f.exists())
				f.delete();
		}
		catch (Exception e)
		{
			logger.debug("文件解密失败", e);
			return false;
		}
		return true;
	}

	public boolean compress(String inFile, String outFile)
	{
		boolean ret = false;
		byte buf[] = new byte[1024];
		try
		{
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(outFile));
			File f = new File(inFile);
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
			logger.debug("文件压缩失败", e);
			ret = false;
		}
		return ret;
	}

	public boolean decompress(String inFile, String outFile)
	{
		boolean ret = false;
		try
		{
			ret = CryptAPI.compressFile(inFile, outFile);
		}
		catch (Exception e)
		{
			logger.debug("文件解压缩失败", e);
			ret = false;
		}
		return ret;
	}

	public boolean checkFileName(String messageFile, PBCFileCheckHandler handler)
	{
		boolean returnType = true;
		FormatChecker fChecker = new FormatChecker(messageFile, validatorDicFile, validatorRuleFile);
		CheckResultSet crs = fChecker.fileLevelCheck();
		List list = crs.getCheckResultList();
		Iterator iterator = list.iterator();
		try
		{
			while (iterator.hasNext()) 
			{
				CheckResult result = (CheckResult)iterator.next();
				handler.handleResult(result);
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
							handler.handleResult(result);
							returnType = false;
						}

					}
				}
				catch (CheckException e)
				{
					returnType = false;
				}
			} else
			{
				list = crs.getCheckResultList();
				for (iterator = list.iterator(); iterator.hasNext();)
				{
					CheckResult result = (CheckResult)iterator.next();
					handler.handleResult(result);
					returnType = false;
				}

			}
		}
		catch (Exception e)
		{
			logger.fatal(e.getMessage());
		}
		return returnType;
	}

	public boolean checkAll(String messageFile, PBCFileCheckHandler handler)
	{
		boolean returnType = true;
		CUCheckResult checkResult = null;
		checkResult = checkFile.checkall(validatorDicFile, validatorRuleFile, messageFile);
		if (checkResult.getResult() != 0)
			handler.handleResult(checkResult);
		return returnType;
	}

	public final String getCryptConfigFile()
	{
		return cryptConfigFile;
	}

	public final void setCryptConfigFile(String cryptConfigFile)
	{
		this.cryptConfigFile = cryptConfigFile;
	}

	public final String getCryptKeyFile()
	{
		return cryptKeyFile;
	}

	public final void setCryptKeyFile(String cryptKeyFile)
	{
		this.cryptKeyFile = cryptKeyFile;
	}

	public final String getValidatorDicFile()
	{
		return validatorDicFile;
	}

	public final void setValidatorDicFile(String validatorDicFile)
	{
		this.validatorDicFile = validatorDicFile;
	}

	public final String getValidatorRuleFile()
	{
		return validatorRuleFile;
	}

	public final void setValidatorRuleFile(String validatorRuleFile)
	{
		this.validatorRuleFile = validatorRuleFile;
	}
}
