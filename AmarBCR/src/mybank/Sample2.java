package mybank;
/**
 * ������ʾ�����дһ�����ݿ������Unit,չʾʹ��ARE���ݿ������һ�㷽���ͳ���Ĵ���
 * ע�����й�����־�ļ����÷���
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;

public class Sample2 extends ExecuteUnit {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private Log logger = ARE.getLog();
	
	boolean ok = true; 
	
	public int execute() {
		logger.info("��ʼִ��Sample2...");
		try{
			conn = ARE.getDBConnection("ecr");
		}catch(SQLException ex){
			logger.debug("�����������ݿ�ʧ�ܣ�",ex);
			logger.fatal("�����������ݿ�ʧ�ܣ�Sample2ִ�н���");
			return TaskConstants.ES_FAILED;
		}
		
		try{
			String sql = "select sessionId from ECR_SESSION where CreateTime>?";
			pstmt = conn.prepareStatement(sql);
			String argDate = getProperty("dateArgument","2005/01/01");
			Date d = StringX.parseDate(argDate);
			pstmt.setDate(1,new java.sql.Date(d.getTime()));
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				if(logger.isTraceEnabled())
					logger.trace(rs.getString(1));
				//do some process here
			}
			rs.close();
			pstmt.close();
		}catch(SQLException ex){
			logger.debug(ex);
			ok = false;
		}finally{
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					logger.debug(e);
				}
			conn = null;
		}
		
		if(ok){
			logger.info("Sample2�ɹ�ִ�н�����");
			return TaskConstants.ES_FAILED;
		}else{
			logger.fatal("Sample2ִ�����ݿ����ʧ�ܣ�");
			return TaskConstants.ES_FAILED;
		}
	}

}
