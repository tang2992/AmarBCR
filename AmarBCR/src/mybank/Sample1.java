/**
 * ������һ���򵥵����ӣ�������ʾ��Ŀ�������չ����
 * ����ֻ����ʾ�����д�Լ�������Ԫ����ʹ��ARE���������ʩlog,����֮��û���κε�ҵ���߼����塣
 * ������Unit֧�ֵ���չ����Ϊ��returnValue��������
 */
package mybank;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;
class Sample1 extends ExecuteUnit{

	public int execute() {
		Log logger = ARE.getLog();
		logger.info("Sample1��ʾARE Log�ĳ��÷�����");
		logger.info("������Log.info�������Ϣ�������������û���ʾ��ʾ��Ϣ��");
		logger.warn("����Log.warn�������Ϣ�������������û���ʾ������Ϣ������Ӱ����Ҫҵ���߼���");
		logger.error("����Log.error�������Ϣ�������������û���ʾ���������Ϣ����������Լ���ִ�С�");
		logger.fatal("����Log.fatal�������Ϣ�������������û���ʾ���ش�����Ϣ������Ҫ��ֹ��");
		logger.debug("����Log.debug�������Ϣ�����ڼ�¼����ĳ����������׳�������ݣ�����һ�����߼����ԡ�");
		logger.trace("����Log.trace�������Ϣ�����ڸ��ٳ���ִ�еĸ����м����ݣ������������ʱ�����ݡ�");
		//���ݵ�Ԫ�����ԣ�����һ������ֵ��ȱʡ�ķ��سɹ�
		return getProperty("returnValue",TaskConstants.ES_SUCCESSFUL);
	}
	
}