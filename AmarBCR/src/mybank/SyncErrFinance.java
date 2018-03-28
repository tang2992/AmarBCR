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
 *    �������м���еĴ������ҵ����Ϊ�յ�,ȫ������
 */
public class SyncErrFinance extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmt=null;
	//����Ҫ���µı�
	protected String tables[][]={	
		{"ECR_CUSTOMERINFO"},		
		{"ECR_CUSTOMERKEEPER"},			//�߹�
		{"ECRP_FINANCEBS"},			//�ʲ����ر�
		{"ECRP_FINANCEPS"},			//�����
		{"ECRP_FINANCECF"},			//�ֽ�������
		{"ECR_CUSTOMERLAW"},			//���ϼǱ�
		{"ECR_CUSTOMERFACT"},			//�������±�
		{"ECR_CONTRACT"},			//����ҵ��
		{"ECR_DUEBILL"},			
		{"ECR_LOANRETURN"},		
		{"ECR_EXTENSION"},			
		{"ECR_GUARANTEEBILL"},		//����
		{"ECR_FACTORING"},		//����ҵ��
		{"ECR_FLOORFUND"},		//���ҵ��
		{"ECR_CUSTOMERCREDIT"},		//��������
		{"ECR_FINANCEINFO"},			//ó������
		{"ECR_FINADUEBILL"},			
		{"ECR_FINANCERETURN"},		
		{"ECR_FINAEXTENSION"},			
		{"ECR_DISCOUNT"},		//Ʊ������
		{"ECR_INTERESTDUE"},		//ǷϢ
		{"ECR_CREDITLETTER"},		//����֤ҵ��
		{"ECR_ACCEPTANCE"},		//�жһ�Ʊҵ��
		{"ECR_ASSURECONT"},		//��֤��ͬ
		{"ECR_GUARANTYCONT"},		//��Ѻ��ͬ
		{"ECR_IMPAWNCONT"},		//��Ѻ��ͬ
		{"ECR_CUSTOMERCREDIT"}		//��������
		
	};

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
		for(int i=0;i<tables.length;i++)
			try {
				updateTable(tables[i][0]);
			} catch (SQLException e) {
				logger.fatal("���½��ڻ���ʧ�ܣ�",e);
				clearResource();
				return TaskConstants.ES_FAILED;
			}
		
		clearResource();
		return TaskConstants.ES_SUCCESSFUL;
   }

   private void updateTable(String updateTable) throws SQLException{
	    StringBuffer sql = new StringBuffer("update ");
	   sql.append(updateTable)
	   .append(" set Financeid='29003090004' where len(financeid)<5")
	  ;
	   
	   logger.trace(sql.toString());
	   stmt.executeUpdate(sql.toString());
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