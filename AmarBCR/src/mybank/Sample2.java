package mybank;
/**
 * 本例演示如何书写一个数据库操作的Unit,展示使用ARE数据库操作的一般方法和出错的处理。
 * 注意其中关于日志的几种用法。
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
		logger.info("开始执行Sample2...");
		try{
			conn = ARE.getDBConnection("ecr");
		}catch(SQLException ex){
			logger.debug("连接征信数据库失败！",ex);
			logger.fatal("连接征信数据库失败，Sample2执行结束");
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
			logger.info("Sample2成功执行结束！");
			return TaskConstants.ES_FAILED;
		}else{
			logger.fatal("Sample2执行数据库操作失败！");
			return TaskConstants.ES_FAILED;
		}
	}

}
