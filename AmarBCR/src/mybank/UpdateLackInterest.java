package mybank;
/**
 * ����ǷϢ
 * ÿ����ҵ���ų�����ִ�д˵�Ԫ������ECR_INTERESTDUE�е�����
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
	 * ���ݵ����Ŀ�����ݿ�
	 */
   public static final String PROPERTY_DATABASE = "database";

 
   /*
    * ��ʼ��
    */
   protected void init() throws ECRException
   {
		logger = ARE.getLog();
		//--------------------------------------------------���ݿ����ӳ�ʼ��
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
		//��ʼ�������ݿ����Ӻ������ļ�����
		try {
			init();
		} catch (ECRException e) {
			logger.fatal("��ʼ��ʧ��",e);
			clearResource();
			return TaskConstants.ES_FAILED;
		}
		
		try{
			stmt = connection.createStatement();
			stmt.executeUpdate("Update ECR_INTERESTDUE set InterestBalance=0.00,ChangeDate=to_char(sysdate-1,'yyyymmdd'),UpdateDate=to_char(sysdate-1,'yyyymmdd'),IncrementFlag='3' where IncrementFlag='2' and InterestBalance>0 and ChangeDate=( select max(I.ChangeDate) from ECR_INTERESTDUE I  where I.CustomerID= ECR_INTERESTDUE.CustomerID and I.FinanceID = ECR_INTERESTDUE.FinanceID  and I.InterestType = ECR_INTERESTDUE.InterestType)");
	
			clearResource();
		}catch(Exception e){
			logger.fatal("����ǷϢʱ��������",e);
			clearResource();
		return TaskConstants.ES_FAILED;
		}
		
		clearResource();
		return TaskConstants.ES_SUCCESSFUL;
   }

	
	/**
	 * ������ͷ����й����д򿪵���Դ�����ݿ����ӡ��ļ����ӵ�
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
