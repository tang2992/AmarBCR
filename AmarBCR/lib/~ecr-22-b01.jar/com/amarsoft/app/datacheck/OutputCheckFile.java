// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   OutputCheckFile.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.dpx.recordset.RecordSetException;
import com.amarsoft.task.units.dpx.PRHUnit;

public class OutputCheckFile extends PRHUnit
{

	public static final String FILENAME = "com.amarsoft.are.dpx.recordset.ExportFileHandler.fileName";

	public OutputCheckFile()
	{
	}

	protected void preprocess()
		throws RecordSetException
	{
		String folder = getProperty("com.amarsoft.are.dpx.recordset.ExportFileHandler.folder");
		String fileName = getProperty("com.amarsoft.are.dpx.recordset.ExportFileHandler.fileName");
		if (fileName.indexOf("/") != -1)
			fileName = fileName.replaceAll("/", "");
		setProperty("com.amarsoft.are.dpx.recordset.ExportFileHandler.fileName", (new StringBuilder(String.valueOf(folder))).append(fileName).toString());
	}
}
