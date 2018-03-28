// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   OrganizeCodeChecker.java

package com.amarsoft.app.datax.ecr.common;

import java.io.PrintStream;

public class OrganizeCodeChecker
{

	public OrganizeCodeChecker()
	{
	}

	public static void main(String args[])
	{
		System.out.println((new StringBuilder("1")).append(organizeCodeCheck("75223491-8")).toString());
	}

	public static boolean organizeCodeCheck(String orgCode)
	{
		byte financecode[] = orgCode.getBytes();
		int w_i[] = new int[8];
		int c_i[] = new int[8];
		int s = 0;
		String code = new String(financecode);
		if (code.equals("00000000-0") || orgCode.trim().length() != 10)
			return false;
		w_i[0] = 3;
		w_i[1] = 7;
		w_i[2] = 9;
		w_i[3] = 10;
		w_i[4] = 5;
		w_i[5] = 8;
		w_i[6] = 4;
		w_i[7] = 2;
		if (financecode[8] != 45)
			return false;
		int c;
		for (int i = 0; i < 10; i++)
		{
			c = financecode[i];
			if (c <= 122 && c >= 97)
				return false;
		}

		byte fir_value = financecode[0];
		byte sec_value = financecode[1];
		if (fir_value >= 65 && fir_value <= 90)
			c_i[0] = (fir_value + 32) - 87;
		else
		if (fir_value >= 48 && fir_value <= 57)
			c_i[0] = fir_value - 48;
		else
			return false;
		s += w_i[0] * c_i[0];
		if (sec_value >= 65 && sec_value <= 90)
			c_i[1] = (sec_value - 65) + 10;
		else
		if (sec_value >= 48 && sec_value <= 57)
			c_i[1] = sec_value - 48;
		else
			return false;
		s += w_i[1] * c_i[1];
		for (int j = 2; j < 8; j++)
		{
			if (financecode[j] < 48 || financecode[j] > 57)
				return false;
			c_i[j] = financecode[j] - 48;
			s += w_i[j] * c_i[j];
		}

		c = 11 - s % 11;
		return financecode[9] == 88 && c == 10 || c == 11 && financecode[9] == 48 || c == financecode[9] - 48;
	}
}
