package mybank;
/**
 * 处理欠息
 * 每天企业征信抽数后执行此单元，更新ECR_INTERESTDUE中的内容
 * add by fhuang
 */
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;


public class UpdateLackInterest extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmt=null;

	/**
	 * 数据导入的目标数据库
	 */
   public static final String PROPERTY_DATABASE = "database";

 
   /*
    * 初始化
    */
   protected void init() throws ECRException
   {
		logger = ARE.getLog();
		//--------------------------------------------------数据库连接初始化
		String database = "ecr";//getProperty(PROPERTY_DATABASE);
		if(database==null || database.equals("")){
			database = getTarget().getProperty(PROPERTY_DATABASE);
		}
		try {
			connection = ARE.getDBConnection(database);
		} catch (SQLException e) {
			throw new ECRException(e);
		}
   }
   
   public int execute()
   {
		//初始化，数据库连接和数据文件连接
		try {
			init();
		} catch (ECRException e) {
			logger.fatal("初始化失败",e);
			clearResource();
			return TaskConstants.ES_FAILED;
		}
		
		try{
			stmt = connection.createStatement();
			stmt.executeUpdate("Update ECR_INTERESTDUE set InterestBalance=0.00,ChangeDate=to_char(sysdate-1,'yyyymmdd'),UpdateDate=to_char(sysdate-1,'yyyymmdd'),IncrementFlag='3' where IncrementFlag='2' and InterestBalance>0 and ChangeDate=( select max(I.ChangeDate) from ECR_INTERESTDUE I  where I.CustomerID= ECR_INTERESTDUE.CustomerID and I.FinanceID = ECR_INTERESTDUE.FinanceID  and I.InterestType = ECR_INTERESTDUE.InterestType)");
	
			clearResource();
		}catch(Exception e){
			logger.fatal("更新欠息时发生错误",e);
			clearResource();
		return TaskConstants.ES_FAILED;
		}
		
		clearResource();
		return TaskConstants.ES_SUCCESSFUL;
   }

	
	/**
	 * 清理和释放运行过程中打开的资源，数据库连接、文件连接等
	 *
	 */
	private void clearResource(){
		if(stmt!=null){
			try {
				stmt.close();
			} catch (SQLException e) {
				logger.warn(e);
			}
			connection = null;
		}
		
		if(connection!=null){
			try {
				connection.close();
			} catch (SQLException e) {
				logger.warn(e);
			}
			connection = null;
		}
	}
}
