// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ANCChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.validate.ValidateRule;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker

public class ANCChecker extends AbstractFieldChecker
{

	public ANCChecker()
	{
	}

	public boolean getCheckResult()
	{
		String string = checkRule.getCheckedValue();
		return checkANC(string.trim().getBytes());
	}

	public static boolean checkANC(byte checkedByte[])
	{
		for (int i = 0; i < checkedByte.length; i++)
			if (byteToDec(checkedByte[i]) < 32 || byteToDec(checkedByte[i]) > 126)
			{
				if (i == checkedByte.length - 1)
					return false;
				if (byteToDec(checkedByte[i]) >= 161 && byteToDec(checkedByte[i]) <= 169 && byteToDec(checkedByte[i + 1]) >= 161 && byteToDec(checkedByte[i + 1]) <= 254 || byteToDec(checkedByte[i]) >= 168 && byteToDec(checkedByte[i]) <= 169 && byteToDec(checkedByte[i + 1]) >= 64 && byteToDec(checkedByte[i + 1]) <= 160 || byteToDec(checkedByte[i]) >= 176 && byteToDec(checkedByte[i]) <= 247 && byteToDec(checkedByte[i + 1]) >= 161 && byteToDec(checkedByte[i + 1]) <= 254 || byteToDec(checkedByte[i]) >= 129 && byteToDec(checkedByte[i]) <= 160 && byteToDec(checkedByte[i + 1]) >= 64 && byteToDec(checkedByte[i + 1]) <= 254 || byteToDec(checkedByte[i]) >= 170 && byteToDec(checkedByte[i]) <= 254 && byteToDec(checkedByte[i + 1]) >= 64 && byteToDec(checkedByte[i + 1]) <= 160)
					i++;
				else
					return false;
			}

		return true;
	}

	private static int byteToDec(byte byteValue)
	{
		int lowbyte = byteValue & 0xf;
		int highbyte = byteValue >>> 4 & 0xf;
		return highbyte * 16 + lowbyte;
	}
}
