/***********************************************************************
 * Module:  DelCustomer.java
 * Author:  gdding
 * Modified: 
 * Purpose: Defines the Class DelCustomer.java ɾ������ͻ�
 ***********************************************************************/

package mybank;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;

/*
 *    ����update���ڣ��������ݸ���Ϊ9999/12/31,�������ݸ���Ϊ���ڵ�occurdate
 */
public class SyncUpdate extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmtq=null;
	protected Statement stmt=null;
	protected String allTables[][] = {
			{"HIS_CUSTOMERINFO","LOANCARDNO"}, //�ͻ��ſ���
			{"HIS_CUSTCAPIINFO","LOANCARDNO"}, //�ͻ��ʱ����ɱ�
			{"HIS_CUSTOMERLAW","LOANCARDNO"}, //�ͻ����߱�
			{"HIS_CUSTOMERFACT","LOANCARDNO"}, //�ͻ����¼Ǳ�
			{"HIS_LOANCONTRACT","LCONTRACTNO"},  //�ͻ�����ҵ���ͬ��Ϣ��
			{"HIS_LOANDUEBILL","LDUEBILLNO"},  //�ͻ���������Ϣ��
			{"HIS_LOANRETURN","LDUEBILLNO"},  //�ͻ�����ҵ�񻹿���Ϣ��
			{"HIS_LOANEXTENSION","LDUEBILLNO"},  //�ͻ�����ҵ��չ����Ϣ��
			{"HIS_FACTORING","FACTORINGNO"},  //�ͻ�����ҵ����Ϣ��
			{"HIS_DISCOUNT","BILLNO"},  //�ͻ�Ʊ������ҵ����Ϣ��
			{"HIS_FINAINFO","FCONTRACTNO"},  //�ͻ�ó������ҵ���ͬ��Ϣ��
			{"HIS_FINADUEBILL","FDUEBILLNO"},  //�ͻ�ó������ҵ������Ϣ��
			{"HIS_FINARETURN","FDUEBILLNO"},  //�ͻ�ó������ҵ�񻹿���Ϣ��
			{"HIS_FINAEXTENSION","FDUEBILLNO"},  //�ͻ�ó������ҵ��չ����Ϣ��
			{"HIS_CREDITLETTER","CREDITLETTERNO"},  //�ͻ�����֤ҵ����Ϣ��
			{"HIS_GUARANTEEBILL","GUARANTEEBILLNO"},  //�ͻ�����ҵ����Ϣ��
			{"HIS_ACCEPTANCE","ACCEPTNO"},  //�ͻ����гжһ�Ʊҵ����Ϣ��
			{"HIS_CUSTOMERCREDIT","CCONTRACTNO"},  //�ͻ�����������Ϣ��
			{"HIS_ASSURECONT","CONTRACTNO"},  //�ͻ�ҵ��֤��ͬ��Ϣ��
			{"HIS_GUARANTYCONT","CONTRACTNO"},  //�ͻ�ҵ���Ѻ��ͬ��Ϣ��
			{"HIS_IMPAWNCONT","CONTRACTNO"},  //�ͻ�ҵ����Ѻ��ͬ��Ϣ��
			{"HIS_FLOORFUND","FLOORFUNDNO"},  //�ͻ������Ϣ��
			{"HIS_INTERESTDUE","LOANCARDNO"}  //�ͻ�ǷϢ��Ϣ��
			};
	
	
	public SyncUpdate(){
		//��ʼ�������ݿ����Ӻ������ļ�����
		try {
			init();
		} catch (ECRException e) {
			logger.fatal("��ʼ��ʧ��",e);
			clearResource();
		}
	}
	
   /*
    * ��ʼ��
    */
   protected void init() throws ECRException
   {
	   if(logger==null)
		   logger = ARE.getLog();
		try {
			if(connection==null) {
				connection = ARE.getDBConnection("ecr");}
			stmt = connection.createStatement();
			stmtq = connection.createStatement();
		} catch (SQLException e) {
			logger.debug("�õ����ݿ�����ʱ��������:",e);
			throw new ECRException("�õ����ݿ�����ʱ��������!",e);
		}
   }
   
   
   /*
    * ɾ��ҵ�������
    */
   public void SyncOldUpdate() throws ECRException {
	   String sqlQuery="";
	   String sOcurdate="";
		String sqlUpdate="";
		String sMainbusinessno="";
	   for (int i = 0; i < allTables.length; i++) { // �����ӱ�����Ӧ�ĸı�30.
			try {
				sqlQuery = "select occurdate as occurdate,"+allTables[i][1]+" as mainbusinessno from "+ allTables[i][0] + " where sessionid='0000000000'";
				ResultSet rs = stmtq.executeQuery(sqlQuery);
				logger.debug(sqlQuery);
				//System.out.println("sqlQuery:"+sqlQuery);
				 while(rs.next()){
				    sOcurdate=rs.getString(1);
					sMainbusinessno=rs.getString(2);
					logger.debug(sMainbusinessno);
					System.out.println(sMainbusinessno);
					sqlUpdate="update "
						+ allTables[i][0]
						+ " set updatedate= '"
						+sOcurdate
						+"' where " 
						+allTables[i][1]
						+" ='"+sMainbusinessno
						+"' and updatedate='9999/12/31' and sessionid<>'0000000000' ";
					logger.debug("OldUpdate"+sqlUpdate);
					//System.out.println("sqlUpdate:"+sqlUpdate);
					stmt.executeUpdate(sqlUpdate);
					logger.trace("���±���" + allTables[i]);
				 }
			} catch (SQLException e) {
				logger.debug("�������ݱ�"+allTables[i][0]+"����", e);
				//throw new ECRException("ɾ�����ݱ�"+allTables[i]+"����");
			}
		}
	}
   public void SyncNewUpdate() throws ECRException {
	   String sUpdateNowTable="";
	   for (int i = 0; i < allTables.length; i++) { // �����ӱ�����Ӧ�ĸı�30.
			try {
				sUpdateNowTable="update "
					+ allTables[i][0]
					+ " set updatedate= '9999/12/31'"
					+" where sessionid='0000000000'";
				logger.debug("newupdate"+sUpdateNowTable);
				//System.out.println("sUpdateNowTable:"+sUpdateNowTable);
				stmt.executeUpdate(sUpdateNowTable);
			    logger.trace("���±���" + allTables[i]);
			} catch (SQLException e) {
				logger.debug("�������ݱ�"+allTables[i][0]+"����", e);
				//throw new ECRException("ɾ�����ݱ�"+allTables[i]+"����");
			}
		}
	}
   
   public int execute()
   {
	//��ʼ�������ݿ����Ӻ������ļ�����
	  try {
			init();			
			SyncOldUpdate();
			SyncNewUpdate();
		} catch (ECRException e) {
			logger.fatal("�������ڳ���"+e.getMessage());
			return TaskConstants.ES_FAILED;
		}
		clearResource();
		logger.info("����������Ϣ��ɣ�");
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
			stmt = null;
		}
		if(stmtq!=null){
			try {
				stmtq.close();
			} catch (SQLException e) {
				logger.warn(e);
			}
			stmtq = null;
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