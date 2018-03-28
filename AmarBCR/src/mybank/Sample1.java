/**
 * 本例是一个简单的例子，用于演示项目组如何扩展程序。
 * 本例只是演示如何书写自己的任务单元，和使用ARE最基本的设施log,除此之外没有任何的业务逻辑含义。
 * 本例的Unit支持的扩展属性为：returnValue，整数型
 */
package mybank;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;
class Sample1 extends ExecuteUnit{

	public int execute() {
		Log logger = ARE.getLog();
		logger.info("Sample1演示ARE Log的常用方法！");
		logger.info("这是用Log.info输出的信息，用于向最终用户显示提示信息。");
		logger.warn("这是Log.warn输出的信息，用于向最终用户显示警告信息，但不影响主要业务逻辑。");
		logger.error("这是Log.error输出的信息，用于向最终用户显示程序错误信息，但程序可以继续执行。");
		logger.fatal("这是Log.fatal输出的信息，用于向最终用户显示严重错误信息，程序将要终止。");
		logger.debug("这是Log.debug输出的信息，用于记录程序的出错，或者容易出错的内容，用于一般性逻辑调试。");
		logger.trace("这是Log.trace输出的信息，用于跟踪程序执行的各种中间数据，用于输出调试时的数据。");
		//根据单元的属性，返回一个整数值，缺省的返回成功
		return getProperty("returnValue",TaskConstants.ES_SUCCESSFUL);
	}
	
}