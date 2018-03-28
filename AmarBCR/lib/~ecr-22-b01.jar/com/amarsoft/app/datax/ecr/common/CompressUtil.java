// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   CompressUtil.java

package com.amarsoft.app.datax.ecr.common;

import com.cfcc.ecus.eft.compress.CompressException;
import com.cfcc.ecus.eft.compress.CompressObserver;
import java.io.*;
import java.util.*;
import java.util.zip.*;

public class CompressUtil
{

	private static final int BUFFER_SIZE = 2048;
	private static ArrayList observers = new ArrayList();
	private static long fileLength = 0L;
	private static long compressFinished = 0L;

	private CompressUtil()
	{
	}

	public static void addObserver(CompressObserver obs)
	{
		observers.add(obs);
	}

	public static void update(long value)
	{
		CompressObserver observer;
		for (Iterator it = observers.iterator(); it.hasNext(); observer.compressUpdate((float)value / (float)fileLength))
			observer = (CompressObserver)it.next();

	}

	public static void compress(InputStream in, OutputStream gzipout)
		throws CompressException
	{
		try
		{
			GZIPOutputStream gout = new GZIPOutputStream(gzipout);
			byte bytes[] = new byte[2048];
			int read;
			while ((read = in.read(bytes, 0, 2048)) != -1) 
			{
				gout.write(bytes, 0, read);
				gout.flush();
				compressFinished += read;
				update(compressFinished);
			}
			in.close();
			gout.close();
		}
		catch (Exception ex)
		{
			throw new CompressException(2345, "无法进行压缩", ex);
		}
	}

	public static void compress(String fileIn, String fileGzipout)
		throws CompressException
	{
		try
		{
			compressFinished = 0L;
			File inFile = new File(fileIn);
			fileLength = inFile.length();
			FileInputStream in = new FileInputStream(inFile);
			FileOutputStream out = new FileOutputStream(fileGzipout);
			compress(((InputStream) (in)), ((OutputStream) (out)));
			try
			{
				out.close();
			}
			catch (IOException ioexception) { }
		}
		catch (FileNotFoundException ex)
		{
			throw new CompressException(2347, "无法进行压缩,文件路径不对", ex);
		}
	}

	public static void deCompress(String fileGzipIn, String fileOut)
		throws CompressException
	{
		FileInputStream gzipIn;
		FileOutputStream out;
		gzipIn = null;
		out = null;
		try
		{
			gzipIn = new FileInputStream(fileGzipIn);
			out = new FileOutputStream(fileOut);
			deCompress(((InputStream) (gzipIn)), ((OutputStream) (out)));
		}
		catch (FileNotFoundException ex)
		{
			throw new CompressException(2347, "无法进行解压缩,文件路径不对", ex);
		}
		break MISSING_BLOCK_LABEL_65;
		Exception exception;
		exception;
		try
		{
			out.close();
			gzipIn.close();
		}
		catch (IOException ioexception) { }
		throw exception;
		try
		{
			out.close();
			gzipIn.close();
		}
		catch (IOException ioexception1) { }
		return;
	}

	public static void deCompress(InputStream gzipIn, OutputStream out)
		throws CompressException
	{
		try
		{
			GZIPInputStream in = new GZIPInputStream(gzipIn);
			byte buf[] = new byte[2048];
			int num;
			while ((num = in.read(buf, 0, 2048)) != -1) 
				out.write(buf, 0, num);
			in.close();
		}
		catch (IOException e)
		{
			throw new CompressException(2346, "无法进行解压缩", e);
		}
	}

	public static void deCompressZip(String filein, String fileOutPath)
		throws CompressException
	{
		ZipInputStream zipIn = null;
		try
		{
			zipIn = new ZipInputStream(new FileInputStream(filein));
			ZipEntry zipentry = null;
			for (zipentry = zipIn.getNextEntry(); zipentry != null; zipentry = zipIn.getNextEntry())
			{
				FileOutputStream fileout = new FileOutputStream((new StringBuilder(String.valueOf(fileOutPath))).append(zipentry.getName()).toString());
				byte buf[] = new byte[2048];
				int num;
				while ((num = zipIn.read(buf, 0, 2048)) != -1) 
					fileout.write(buf, 0, num);
				fileout.close();
			}

		}
		catch (FileNotFoundException ex)
		{
			throw new CompressException(2347, "无法进行解压缩,文件路径不对", ex);
		}
		catch (Exception ex1)
		{
			throw new CompressException(2347, "无法进行解压缩", ex1);
		}
	}

	public static Vector getZipFilenames(String filein, String fileOutPath)
		throws CompressException
	{
		ZipInputStream zipIn = null;
		Vector filenames = new Vector();
		try
		{
			zipIn = new ZipInputStream(new FileInputStream(filein));
			ZipEntry zipentry = null;
			for (zipentry = zipIn.getNextEntry(); zipentry != null; zipentry = zipIn.getNextEntry())
				filenames.add((new StringBuilder(String.valueOf(fileOutPath))).append(zipentry.getName()).toString());

		}
		catch (FileNotFoundException ex)
		{
			throw new CompressException(2347, "无法进行解压缩,文件路径不对", ex);
		}
		catch (Exception ex1)
		{
			throw new CompressException(2347, "无法进行解压缩", ex1);
		}
		return filenames;
	}

	public static void compressZip(ArrayList filenames, String fileout)
		throws CompressException
	{
		ZipOutputStream zipOut = null;
		byte buf[] = new byte[2048];
		try
		{
			zipOut = new ZipOutputStream(new FileOutputStream(fileout));
			for (int i = 0; i < filenames.size(); i++)
			{
				String shortfilename = (String)filenames.get(i);
				shortfilename = shortfilename.substring(shortfilename.lastIndexOf("/") + 1);
				FileInputStream in = new FileInputStream((String)filenames.get(i));
				zipOut.putNextEntry(new ZipEntry(shortfilename));
				int len;
				while ((len = in.read(buf)) > 0) 
					zipOut.write(buf, 0, len);
				zipOut.closeEntry();
				in.close();
			}

			zipOut.close();
		}
		catch (FileNotFoundException ex)
		{
			throw new CompressException(2347, "无法进行压缩,文件路径不对", ex);
		}
		catch (Exception ex1)
		{
			throw new CompressException(2347, "无法进行压缩", ex1);
		}
	}

}
