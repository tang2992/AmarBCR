// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   TempTools.java

package test;

import com.amarsoft.are.ARE;
import com.amarsoft.are.metadata.*;
import com.amarsoft.task.*;
import java.io.*;
import java.sql.SQLException;

public class TempTools
{

	public TempTools()
	{
	}

	public static void main(String args[])
	{
		ARE.init("etc/ecr_are.xml");
		metadataToSql();
	}

	public static void produceTaskTestTable()
	{
		StringBuffer sb = new StringBuffer();
		Task t = TaskBuilder.buildTaskFromXML("etc\\ect_task_prepare.xml");
		Target ta[] = t.getTargets();
		for (int i = 0; i < ta.length; i++)
		{
			System.out.println((new StringBuilder(String.valueOf(ta[i].getName()))).append("(").append(ta[i].getDescribe()).append(")").toString());
			ExecuteUnit u[] = ta[i].getUnits();
			for (int j = 0; j < u.length; j++)
			{
				System.out.print((new StringBuilder(String.valueOf(u[j].getName()))).append("(").append(u[j].getDescribe()).append(")").toString());
				System.out.print((new StringBuilder("\t")).append(u[j].getProperty("com.amarsoft.are.dpx.recordset.UpdateDBHandler.keyColumns")).toString());
				System.out.print((new StringBuilder("\t")).append(u[j].getProperty("com.amarsoft.are.dpx.recordset.UpdateDBHandler.updateColumns")).toString());
				System.out.println();
			}

			System.out.println();
		}

	}

	public static void metadataToSql()
	{
		DataSourceMetaData dsm = null;
		try
		{
			dsm = ARE.getMetaData("ecr_data");
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		if (dsm == null)
			return;
		for (String t = null; t == null;)
		{
			System.out.print("Input table name->");
			byte buf[] = new byte[100];
			try
			{
				int ii = System.in.read(buf);
				t = new String(buf);
			}
			catch (IOException e)
			{
				System.out.println(e);
			}
			if (t != null && t.length() != 0)
			{
				TableMetaData tm = null;
				try
				{
					tm = dsm.getTable(t);
				}
				catch (SQLException e)
				{
					System.out.println((new StringBuilder(String.valueOf(t))).append(" not exists!").toString());
				}
				if (tm != null)
				{
					StringBuffer sb = new StringBuffer("datasource:db:loan:select");
					ColumnMetaData cols[] = tm.getColumns();
					for (int i = 0; i < cols.length; i++)
					{
						sb.append("\n").append(cols[i].getName()).append(" as ").append(cols[i].getName()).append("{#").append(cols[i].getLabel()).append("}");
						if (i != cols.length - 1)
							sb.append(",");
					}

					System.out.println(sb);
				}
			}
		}

	}
}
