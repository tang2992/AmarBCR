/***********************************************************************
 * Module:  UpdateCustomerInfo.java
 * Author:  binsy
 * Modified: 2005�?1?7?1?7�?1?7 10:50:32
 * Purpose: Defines the Class UpdateCustomerInfo �������м���еĴ������ҵ����Ϊ�յ�,ȫ������
 ***********************************************************************/

package mybank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class SyncErrCustomerInfo extends ExecuteUnit
{
	/**
	 * ���ݵ����Ŀ�����ݿ�
	 */
	public static final String PROPERTY_DATABASE = "database";
	private static PreparedStatement pstmSelect = null;
	protected Log logger;
	protected static Connection connection=null;
	protected Statement stmt=null;
//	����Ҫ���µı�
	protected static String tables[][]={	
		{"ECR_CUSTOMERinfo","LoanCardNo"},	
		{"ECR_CUSTOMERKEEPER","LoanCardNo"},		//�߹�
		{"ECRP_FINANCEBS","LoanCardNo"},			//�ʲ����ر�
		{"ECRP_FINANCEPS","LoanCardNo"},			//�����
		{"ECRP_FINANCECF","LoanCardNo"},			//�ֽ�������
		{"ECRP_FINANCECF","LoanCardNo"},			//�ֽ�������
		{"ECR_CUSTOMERLAW","LoanCardNo"},			//���ϼǱ�
		{"ECR_CUSTOMERFACT","LoanCardNo"},			//�������±�
		{"ECR_CONTRACT","LoanCardID"},				//����ҵ��		
		{"ECR_DUEBILL","LoanCardID"},			
		{"ECR_LOANRETURN","LoanCardID"},		
		{"ECR_EXTENSION","LoanCardID"},			
		{"ECR_GUARANTEEBILL","LoanCardID"},		//����
		{"ECR_FACTORING","LoanCardID"},		//����ҵ��
		{"ECR_FLOORFUND","LoanCardID"},		//���ҵ��
		{"ECR_CUSTOMERCREDIT","LoanCardID"},		//��������
		{"ECR_FINANCEINFO","LoanCardID"},			//ó������	
		{"ECR_FINADUEBILL","LoanCardID"},			
		{"ECR_FINANCERETURN","LoanCardID"},		
		{"ECR_FINAEXTENSION","LoanCardID"},		
		{"ECR_DISCOUNT","LoanCardID"},		//Ʊ������
		{"ECR_INTERESTDUE","LoanCardID"},		//ǷϢ
		{"ECR_CREDITLETTER","LoanCardID"},		//����֤ҵ��
		{"ECR_ACCEPTANCE","LoanCardID"},		//�жһ�Ʊҵ��
		{"ECR_ASSURECONT","LoanCardID"},		//��֤��ͬ
		{"ECR_GUARANTYCONT","LoanCardID"},		//��Ѻ��ͬ
		{"ECR_GUARANTYINFO","LoanCardID"},
		{"ECR_IMPAWNCONT","LoanCardID"},		//��Ѻ��ͬ
		{"ECR_IMPAWNINFO","LoanCardID"},
		{"ECR_CUSTOMERCREDIT","LoanCardID"},		//��������
		//���ݱ�
		{"ECR_R01SB","B7503"},
		{"ECR_R02SB","B7503"},
		{"ECR_R03SB","B7503"},
		{"ECR_R04SB","B7503"},
		{"ECR_R05SB","B7503"},
		{"ECR_R06SB","B7503"},
		{"ECR_R07SB","B7503"},
		{"ECR_R08SB","B7503"},
		{"ECR_R09SB","B7503"},
		{"ECR_R10SB","B7503"},
		{"ECR_R11SB","B7503"},
		{"ECR_R14SB","B7503"},
		{"ECR_R15SB","B7503"},
		{"ECR_R16SB","B7503"},
		{"ECR_R17SB","B7503"},
		{"ECR_R22SB","B7503"},
		{"ECR_R23SB","B7503"},
		{"ECR_R24SB","B7503"},
		{"ECR_R26SB","B7503"}
	};
	protected String tablesbak[][]={	
			//���ݱ�
		{"ECR_R12SB","ECR_R12SD"},
		{"ECR_R13SB","ECR_R13SD"},
		{"ECR_R18SB","ECR_R18SD"},
		{"ECR_R19SB","ECR_R19SD"},
		{"ECR_R20SB","ECR_R20SD"},
		{"ECR_R21SB","ECR_R21SD"},
		{"ECR_R25SB","ECR_R25SD"}
	};
		
	public int execute()
		   {
			String sqlSelect="select * from ecr_syncerrcard ";
			String newloancardno="";
			String oldloancardno="";
				//��ʼ�������ݿ����Ӻ������ļ�����
				try {
					init();
				} catch (ECRException e) {
					logger.fatal("��ʼ��ʧ��",e);
					clearResource();
					return TaskConstants.ES_FAILED;
				}

				try {
					pstmSelect = connection.prepareStatement(sqlSelect);
					ResultSet	rs0 = pstmSelect.executeQuery();
					if (rs0.next()) {
						newloancardno=rs0.getString("newloancarno");
						oldloancardno=rs0.getString("oldloancarno");
						updateTable(newloancardno,oldloancardno);
						updateBakTable(newloancardno,oldloancardno);
						logger.info("loancardno:"+newloancardno);
					} 	
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				clearResource();
				return TaskConstants.ES_SUCCESSFUL;
		   }
   /*
    * ��ʼ��
    */
   protected  void init() throws ECRException
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
   

   private   int updateTable(String newLoancardNo,String oldLoancardNo) throws SQLException{
	   	
//		��ʼ�������ݿ����Ӻ������ļ�����

			for(int i=0;i<tables.length;i++){	
					StringBuffer sql = new StringBuffer("");		
					try {
			   	sql.append("update ")
			   .append(tables[i][0])
			   .append(" set ")
			   .append(tables[i][1])
			   .append("='")
			   .append(newLoancardNo)
			   .append("',modflag='2' where ")
			   .append(tables[i][1])
			   .append("='")
			   .append(oldLoancardNo)
			   .append("'");
			   
			   logger.trace(sql.toString());
			   System.out.println(sql.toString());
			   stmt.executeUpdate(sql.toString());
				} catch (SQLException e) {
					logger.fatal("����������ʧ�ܣ�",e);
					clearResource();
					return TaskConstants.ES_FAILED;
				}
		}
		return TaskConstants.ES_SUCCESSFUL;
   }
	private  int updateBakTable(String newLoancardNo,String oldLoancardNo) throws SQLException{
		
//		��ʼ�������ݿ����Ӻ������ļ�����

		for(int i=0;i<tablesbak.length;i++){	
			StringBuffer sqlbakcardno = new StringBuffer("");		
			StringBuffer sqlbakmod = new StringBuffer("");	
				try {
		   sqlbakcardno.append("update ")
		   .append(tablesbak[i][1])
		   .append(" set D7503='")
			 .append(newLoancardNo)
		   .append("' where D7503='")
		   .append(oldLoancardNo).append("'");
		   

		   logger.trace(sqlbakcardno.toString());

		   System.out.println(sqlbakmod.toString());
		   stmt.executeUpdate(sqlbakcardno.toString());

		   	sqlbakmod.append("update ")
			   .append(tablesbak[i][0])
			   .append(" set modflag='2'")
			   .append(" where recordkey =(select recordkey from ")
			   .append(tablesbak[i][1])
			   .append(" where ")
			   .append(tablesbak[i][1])
			   .append(".recordkey=")
			   .append(tablesbak[i][0])
			   .append(".recordkey)") 
			   .append("' and D7503='")
			   .append(newLoancardNo).append("'");
			   System.out.println(sqlbakcardno.toString());
			   stmt.executeUpdate(sqlbakmod.toString());
			} catch (SQLException e) {
				logger.fatal("�������ݱ������ʧ�ܣ�",e);
				clearResource();
				return TaskConstants.ES_FAILED;
			}
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