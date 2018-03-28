// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MessageFileSplit.java

package com.amarsoft.app.datax.ecr.common;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.io.*;
import java.util.*;

public class MessageFileSplit
{

	private String exportFolder;
	private HashMap splitGroup;
	private File exportDir;

	public MessageFileSplit()
	{
		exportFolder = null;
		splitGroup = null;
		exportDir = null;
		splitGroup = new HashMap();
	}

	public void addGroup(String groupName, String memberOrgs[])
	{
		splitGroup.put(groupName, memberOrgs);
	}

	public void removeGroup(String groupName)
	{
		if (splitGroup.containsKey(groupName))
			splitGroup.remove(groupName);
	}

	public final String getExportFolder()
	{
		if (exportFolder == null)
		{
			String home = ARE.getProperty("ECR_HOME");
			if (home == null)
				exportFolder = ".";
			else
				exportFolder = (new StringBuilder(String.valueOf(home))).append("/export/").toString();
		}
		return exportFolder;
	}

	public final void setExportFolder(String exportFolder)
	{
		this.exportFolder = exportFolder;
		exportDir = null;
	}

	public void splitMessage(String messageFile)
		throws FileNotFoundException, IOException
	{
		if (exportDir == null)
		{
			exportDir = new File(getExportFolder());
			if (!exportDir.exists() || !exportDir.isDirectory())
				throw new FileNotFoundException((new StringBuilder(String.valueOf(exportDir.getAbsolutePath()))).append("不是有效的输出目录！").toString());
		}
		File messFile = new File(messageFile);
		if (!messFile.exists())
			throw new FileNotFoundException((new StringBuilder("报文文件不存在!")).append(messageFile).toString());
		for (Iterator groups = splitGroup.keySet().iterator(); groups.hasNext();)
		{
			String gName = (String)groups.next();
			String gMembers[] = (String[])splitGroup.get(gName);
			if (gMembers == null || gMembers.length < 1)
			{
				ARE.getLog().debug((new StringBuilder("No any member in group ")).append(gName).append(", ignore this group!").toString());
			} else
			{
				File gDir = new File(exportDir, gName);
				if (!gDir.exists() || !gDir.isFile())
					gDir.mkdir();
				splitAGroup(messFile, gDir, gMembers);
			}
		}

	}

	private void splitAGroup(File messageFile, File outDir, String orgs[])
		throws IOException
	{
		File outFile = new File(outDir, (new StringBuilder(String.valueOf(messageFile.getName().substring(0, 27)))).append("9.txt").toString());
		LineNumberReader line = new LineNumberReader(new FileReader(messageFile));
		line.skip(messageFile.length());
		int lineNumber = line.getLineNumber() + 1;
		line.close();
		BufferedReader in = new BufferedReader(new FileReader(messageFile));
		PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(outFile)));
		int recordCount = 0;
		String sortedOrgs[] = (String[])orgs.clone();
		Arrays.sort(sortedOrgs);
		int i = 0;
		String recordBuffer;
		while ((recordBuffer = in.readLine()) != null) 
		{
			i++;
			if (recordBuffer.length() == 0)
			{
				out.println();
				continue;
			}
			if (recordBuffer.charAt(0) == 'A')
			{
				out.println(recordBuffer);
				recordCount = 0;
				continue;
			}
			if (recordBuffer.charAt(0) == 'Z')
			{
				if (i == lineNumber)
				{
					out.print((new StringBuilder("Z")).append(formatRecordCount(recordCount)).toString());
					break;
				}
				out.println((new StringBuilder("Z")).append(formatRecordCount(recordCount)).toString());
			} else
			if (recordBuffer.charAt(0) != 'Z')
			{
				String financeId = recordBuffer.substring(7, 18);
				if (Arrays.binarySearch(sortedOrgs, financeId) >= 0)
				{
					out.println(recordBuffer);
					recordCount++;
				}
			}
		}
		in.close();
		out.close();
	}

	private String formatRecordCount(int count)
	{
		String s = String.valueOf(count);
		return (new StringBuilder(String.valueOf("0000000000".substring(s.length())))).append(s).toString();
	}
}
