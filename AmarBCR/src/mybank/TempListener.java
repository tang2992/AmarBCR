package mybank;

import java.sql.SQLException;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.util.StringFunction;
import com.amarsoft.task.TaskEvent;

public class TempListener {
    /**
     * ���ָ��ʱ�����Ƿ��������������Ϣ <li>unitSum ���������0�����ʾ��unit��Ԫ�ڵ�ǰ����ʱ���Ѿ�ִ�й�һ�� <li>failSum
     * ���������0�����ʾ�����������л�����ʧ�ܵĳ��� <li>lockSum
     * ���������0�����ʾ�������л�����ʧ�ܵĳ����д���SINGLE�ų�(����SINGLE�ųⵥԪ����ͬʱ����)
     */
    String selectSQL = "";
    /**
     * @param args
     */
    public static void main(String[] args) {
//	 selectSQL = "SELECT max(serialNo) as serialNO,"
//		    + "sum(case when (taskCode = ? and targetCode=? and unitCode =? and batchdate=?)then SerialNO else 0 end) as unitSum,"
//		    + "sum(case when (SUCCESSFLAG='" + SUCCESSFLAG_OF_FAILED
//		    + "' or SUCCESSFLAG='" + SUCCESSFLAG_OF_RUNNING
//		    + "') then 1 else 0 end) as failSum,"
//		    + "sum(case when (LOCKFLAG = '" + LOCLFLAG_OF_SINGLE
//		    + "' and  (SUCCESSFLAG='" + SUCCESSFLAG_OF_FAILED
//		    + "' or SUCCESSFLAG='" + SUCCESSFLAG_OF_RUNNING
//		    + "')) then 1 else 0 end) as lockSum "
//		    + "FROM Batch_Ctrl where BatchDate>= ?";

    }
    
//    public void before(TaskEvent e) throws Exception {
//	if (!(isExecuted)) {
//	    targetBefore(e);
//	}
//	long currentTime = System.currentTimeMillis();
//	ARE.setProperty("startTime", String.valueOf(currentTime));
//	ARE.setProperty("beginTime", StringFunction.getTodayNow());
//
//	String tempDate = Tools.getAssignedDay(batchDate, assignedDay, "1");
//	try {
//	    selectPS.setString(1, e.getTask().getName());
//	    selectPS.setString(2, e.getTarget().getName());
//	    selectPS.setString(3, e.getUnit().getName());
//	    selectPS.setString(4, batchDate);
//	    selectPS.setString(5, tempDate);
//	    rs = selectPS.executeQuery();
//	    int unitSum = 0, failSum = 0, lockSum = 0;
//	    if (rs.next()) {
//		serialNO = rs.getInt("serialNO");
//		unitSum = rs.getInt("unitSum");
//		failSum = rs.getInt("failSum");
//		lockSum = rs.getInt("lockSum");
//
//		if (failSum > 0) {
//		    throw new ECRException("��ǰ���������������л�����ʧ�ܵĳ���!");
//		}
//
//		if (lockSum > 0 && "SINGLE".equals(lockFlag)) {
//		    throw new ECRException(
//			    "��ǰ���������������е�SINGLE�ųⵥԪ,����SINGLE�ųⵥԪ����ͬʱ����!");
//		}
//		if (unitSum > 0) {
//		    if(repeatFlag&&"Y".){
//			
//		    }else{
//			serialNO = unitSum;
//			isInsert = false;
//		    }
//		} else {
//		    isInsert = true;
//		}
//	    } else
//		isInsert = false;
//	    rs.close();
//	} catch (SQLException e1) {
//	    logger.error("��" + serialNO + "����Ԫ��ʼ��������Ԫ����"
//		    + e.getUnit().getName() + ",������Ϣ,����������ʧ�ܣ�" + e1);
//	    isContinue = false;
//	    release();
//	    throw e1;
//	}
//    }

}
