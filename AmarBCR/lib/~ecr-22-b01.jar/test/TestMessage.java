// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   TestMessage.java

package test;

import com.amarsoft.app.datax.ecr.cob.CustomerRecords;
import com.amarsoft.app.datax.ecr.cob.RecordStub;
import com.amarsoft.are.ARE;
import com.amarsoft.are.sql.TabularReader;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.*;

public class TestMessage
{

	public TestMessage()
	{
	}

	public static void main(String args[])
	{
		String xmlfile = "etc/ecr_message_businessinfo.xml";
		String exportFolder = "export/";
		ARE.init("etc/ecr_are.xml");
		String occurDate = getOccurDate(ARE.getProperty("businessOccurDate"));
		ARE.setProperty("businessOccurDate", occurDate);
		ARE.setProperty("occurDate", occurDate);
		try
		{
			TabularReader tr = new TabularReader("datasource:db:ecr:select CustomerId from ECR_CUSTOMERINFO");
			CustomerRecords cr = new CustomerRecords();
			int messageCount[] = new int[21];
			int recordCount[] = new int[26];
			while (tr.next()) 
			{
				cr.setCustomerId(tr.getString(1));
				cr.loadCurrentRecord();
				for (Iterator it = cr.getAllHistoryRecords().iterator(); it.hasNext();)
				{
					RecordStub r = (RecordStub)it.next();
					messageCount[r.getMessagType()]++;
					recordCount[r.getRecordType()]++;
				}

			}
			tr.close();
			for (int i = 0; i < messageCount.length; i++)
				if (i > 1 && i <= 4 || i > 10 && i <= 21)
					System.out.print((new StringBuilder(String.valueOf(messageCount[i]))).append("\t").toString());

			System.out.println();
			for (int i = 0; i < recordCount.length; i++)
				if (i > 1 && i <= 26)
					System.out.print((new StringBuilder(String.valueOf(recordCount[i]))).append("\t").toString());

		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	private static String getOccurDate(String od)
	{
		String occurDate = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		if (od == null)
			od = "AUTOSELECT";
		if (od.equalsIgnoreCase("TORDAY"))
			occurDate = sdf.format(new Date());
		else
		if (od.equalsIgnoreCase("YESTERDAY"))
		{
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			cal.roll(5, false);
			occurDate = sdf.format(cal.getTime());
		} else
		if (od.equalsIgnoreCase("AUTOSELECT"))
		{
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			if (cal.get(11) < 22)
				cal.roll(5, false);
			occurDate = sdf.format(cal.getTime());
		} else
		{
			try
			{
				occurDate = od;
				sdf.parse(od);
			}
			catch (Exception ex)
			{
				occurDate = getOccurDate("AUTOSELECT");
			}
		}
		return occurDate;
	}
}
