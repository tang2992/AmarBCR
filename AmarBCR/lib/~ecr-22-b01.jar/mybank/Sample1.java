// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   Sample1.java

package mybank;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;

class Sample1 extends ExecuteUnit
{

	Sample1()
	{
	}

	public int execute()
	{
		Log logger = ARE.getLog();
		logger.info("Sample1��ʾARE Log�ĳ��÷�����");
		logger.info("������Log.info�������Ϣ�������������û���ʾ��ʾ��Ϣ��");
		logger.warn("����Log.warn�������Ϣ�������������û���ʾ������Ϣ������Ӱ����Ҫҵ���߼���");
		logger.error("����Log.error�������Ϣ�������������û���ʾ���������Ϣ����������Լ���ִ�С�");
		logger.fatal("����Log.fatal�������Ϣ�������������û���ʾ���ش�����Ϣ������Ҫ��ֹ��");
		logger.debug("����Log.debug�������Ϣ�����ڼ�¼����ĳ����������׳�������ݣ�����һ�����߼����ԡ�");
		logger.trace("����Log.trace�������Ϣ�����ڸ��ٳ���ִ�еĸ����м����ݣ������������ʱ�����ݡ�");
		return getProperty("returnValue", 1);
	}
}
