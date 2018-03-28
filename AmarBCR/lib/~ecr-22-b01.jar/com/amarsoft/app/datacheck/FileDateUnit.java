// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   FileDateUnit.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.ARE;
import com.amarsoft.task.*;
import java.io.PrintStream;

public class FileDateUnit extends ExecuteUnit
{

	public FileDateUnit()
	{
	}

	public int execute()
	{
		String occurDate = ARE.getProperty("businessOccurDate");
		System.out.println(occurDate);
		getTarget().getTask().setProperty("exportFileDate", (new StringBuilder(String.valueOf(occurDate.substring(0, 4)))).append(occurDate.substring(5, 7)).append(occurDate.substring(8, 10)).toString());
		System.out.println(getTarget().getTask().getProperty("exportFileDate"));
		return 1;
	}
}
