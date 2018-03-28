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
		logger.info("Sample1演示ARE Log的常用方法！");
		logger.info("这是用Log.info输出的信息，用于向最终用户显示提示信息。");
		logger.warn("这是Log.warn输出的信息，用于向最终用户显示警告信息，但不影响主要业务逻辑。");
		logger.error("这是Log.error输出的信息，用于向最终用户显示程序错误信息，但程序可以继续执行。");
		logger.fatal("这是Log.fatal输出的信息，用于向最终用户显示严重错误信息，程序将要终止。");
		logger.debug("这是Log.debug输出的信息，用于记录程序的出错，或者容易出错的内容，用于一般性逻辑调试。");
		logger.trace("这是Log.trace输出的信息，用于跟踪程序执行的各种中间数据，用于输出调试时的数据。");
		return getProperty("returnValue", 1);
	}
}
