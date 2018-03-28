/***********************************************************************
 * Module:  UpdateCustomerInfo.java
 * Author:  binsy
 * Modified: 2005�?1?7?1?7�?1?7 10:50:32
 * Purpose: Defines the Class UpdateCustomerInfo �������м���еĴ������ҵ����Ϊ�յ�,ȫ������
 ***********************************************************************/

package mybank;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;

/*
 *    �������м���еĴ����Ӧ��customerid����ȷ
 */
public class SyncData extends ExecuteUnit
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
		try {
			connection = ARE.getDBConnection(database);
			stmt = connection.createStatement();
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
		try {
				String sSql1="{call DeleteECRCustomer()}";
				stmt.executeUpdate(sSql1);
				
			} catch (SQLException e) {
				logger.fatal("ɾ���ظ��ͻ�ʧ�ܣ�",e);
				clearResource();
				return TaskConstants.ES_FAILED;
			}
			try {
				String	sSql2="{call UpdateGuarantyFlag()}";
				stmt.executeUpdate(sSql2);
				
			} catch (SQLException e) {
				logger.fatal("���µ�����־ʧ�ܣ�",e);
				clearResource();
				return TaskConstants.ES_FAILED;
			}
			try {
				String	sSql3="{call UpdateECRFloorFlag()}";
				stmt.executeUpdate(sSql3);

			} catch (SQLException e) {
				logger.fatal("���µ���־ʧ�ܣ�",e);
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