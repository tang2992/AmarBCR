// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   test1.java

package test;

import com.amarsoft.are.ARE;
import java.io.PrintStream;
import java.util.Date;

// Referenced classes of package test:
//			test0

public class test1 extends test0
{

	int i;
	String s;
	Date d;
	boolean b;

	public test1()
	{
		i = 0;
		s = null;
		d = null;
		b = false;
	}

	public static void main(String args[])
	{
		ARE.init("etc/ecr_are.xml");
		String s = "select EI.CustomerID as CUSTOMERID{#¿Í»§±àºÅ}, from table";
		System.out.println(s);
		System.out.println(replaceComment(s));
		System.out.println(ARE.replaceComment(s));
	}

	public static String replaceComment(String srcString)
	{
		String comm = "\\{#[^\\}]*\\}";
		return srcString.replaceAll(comm, "");
	}
}
