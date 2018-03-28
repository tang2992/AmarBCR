// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   test.java

package test;

import com.amarsoft.app.datax.ecr.common.DeleteBusinessTypeDBReflector;
import com.amarsoft.are.ARE;
import java.io.PrintStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class test
{

	public test()
	{
	}

	public static void main(String args[])
	{
		ARE.init("etc/ecr_are.xml");
		String oid;
		int i;
		for (oid = "111111111#222222222#444444444"; oid.indexOf("#") != -1; oid = oid.substring(i + 1))
		{
			System.out.println(oid);
			i = oid.indexOf("#");
		}

		System.out.println(oid);
	}

	static String getSql(DeleteBusinessTypeDBReflector r)
	{
		StringBuffer sb = new StringBuffer((new StringBuilder("select count(*) from ECR_")).append(r.getMainTable()).toString());
		String s[] = r.getRelativeTables();
		StringBuffer w = new StringBuffer((new StringBuilder(" where ECR_")).append(r.getMainTable()).append(".").toString());
		w.append(r.getContactNoColumn()).append(">'0000000000'");
		for (int i = 0; i < s.length; i++)
		{
			sb.append(",ECR_").append(s[i]);
			w.append(" and ECR_").append(r.getMainTable()).append(".").append(r.getContactNoColumn()).append("=ECR_").append(s[i]).append(".").append(r.getContactNoColumn());
		}

		sb.append(w);
		return sb.toString();
	}

	protected static String truncateLength(String str, int bytes)
	{
		byte b[] = str.getBytes();
		if (b.length <= bytes)
			return str;
		byte nb[] = new byte[bytes];
		for (int i = 0; i < bytes; i++)
			nb[i] = b[i];

		System.out.println(nb.length);
		int halfHZ = 0;
		for (int i = nb.length - 1; i >= 0; i--)
		{
			if (nb[i] >= 0)
				break;
			halfHZ++;
		}

		String s = halfHZ % 2 != 0 ? new String(nb, 0, nb.length - 1) : new String(nb);
		System.out.println(s.getBytes().length);
		return s;
	}

	protected static String fixPID(String str)
	{
		int weight[] = {
			7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 
			7, 9, 10, 5, 8, 4, 2, 1
		};
		char vcode[] = {
			'1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', 
			'2'
		};
		String ID15 = str;
		if (ID15.length() != 15)
			return ID15.toUpperCase();
		StringBuffer ID18 = new StringBuffer(ID15);
		ID18.insert(6, "19");
		int vsum = 0;
		for (int i = 0; i < 17; i++)
			vsum += Character.digit(ID18.charAt(i), 10) * weight[i];

		ID18.append(vcode[vsum % 11]);
		return ID18.toString();
	}

	protected static String fixDigital(String str)
	{
		String hzDigital = "([£±Ò»Ò¼])|([£²¶þ·¡])|([£³ÈýÈþ])|([£´ËÄËÁ])|([£µÎåÎé])|([£¶ÁùÂ½])|([£·ÆßÆâ])|([£¸°Ë°Æ])|([£¹¾Å¾Á])|([£°©–Áã])";
		Pattern dpattern = Pattern.compile(hzDigital);
		Matcher m = dpattern.matcher(str);
		StringBuffer sb = new StringBuffer();
		int g;
		for (; m.find(); m.appendReplacement(sb, String.valueOf(g % 10)))
		{
			g = 0;
			for (int i = 1; i <= 10; i++)
			{
				if (m.group(i) == null)
					continue;
				g = i;
				break;
			}

		}

		m.appendTail(sb);
		return sb.toString();
	}
}
