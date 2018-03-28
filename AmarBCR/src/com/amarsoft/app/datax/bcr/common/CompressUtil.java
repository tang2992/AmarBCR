package com.amarsoft.app.datax.bcr.common;

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
    GZIPOutputStream gout;
    try
    {
      int read;
      gout = new GZIPOutputStream(gzipout);
      byte[] bytes = new byte[2048];

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
      compress(in, out);
      try
      {
        out.close();
      }
      catch (IOException localIOException) {
      }
    }
    catch (FileNotFoundException ex) {
      throw new CompressException(2347, "无法进行压缩,文件路径不对", ex);
    }
  }

  public static void deCompress(String fileGzipIn, String fileOut)
    throws CompressException
  {
    FileInputStream gzipIn = null;
    FileOutputStream out = null;
    try
    {
      gzipIn = new FileInputStream(fileGzipIn);
      out = new FileOutputStream(fileOut);
      deCompress(gzipIn, out);
    }
    catch (FileNotFoundException ex)
    {
      throw new CompressException(2347, "无法进行解压缩,文件路径不对", ex);
    }
    finally
    {
      try
      {
        out.close();
        gzipIn.close();
      }
      catch (IOException localIOException1)
      {
      }
    }
  }

  public static void deCompress(InputStream gzipIn, OutputStream out) throws CompressException
  {
    GZIPInputStream in;
    try {
      int num;
      in = new GZIPInputStream(gzipIn);
      byte[] buf = new byte[2048];

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
        int num;
        FileOutputStream fileout = new FileOutputStream(fileOutPath + zipentry.getName());
        byte[] buf = new byte[2048];

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
        filenames.add(fileOutPath + zipentry.getName());

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
    byte[] buf = new byte[2048];
    try
    {
      zipOut = new ZipOutputStream(new FileOutputStream(fileout));
      for (int i = 0; i < filenames.size(); ++i)
      {
        int len;
        String shortfilename = (String)filenames.get(i);
        shortfilename = shortfilename.substring(shortfilename.lastIndexOf("/") + 1);
        FileInputStream in = new FileInputStream((String)filenames.get(i));
        zipOut.putNextEntry(new ZipEntry(shortfilename));

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
