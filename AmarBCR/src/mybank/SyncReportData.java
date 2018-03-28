/***********************************************************************
 * Module:  SyncReportDate.java
 * Author:  gdding
 * Modified: 
 * Purpose: Defines the Class SycnReportData.java ͬ�����ڱ�������
 ***********************************************************************/

package mybank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;

/*
 *    ͬ�����ڱ�������
 */
public class SyncReportData extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected PreparedStatement stmt=null;
	protected PreparedStatement ptmtdel=null;
	private PreparedStatement pstmAmountno = null;
	private PreparedStatement pstmAmountsum = null;
	private PreparedStatement pstmNAmountno = null;
	private PreparedStatement pstmNAmountsum = null;
	private PreparedStatement pstmCAmountno = null;
	private PreparedStatement pstmCAmountsum = null;
	private PreparedStatement pstmInsert = null;
	protected String allTables[][] = {
			{"CUSTOMERINFO","1","01"}, //�ͻ��ſ���
			{"CUSTCAPIINFO","1","02"}, //�ͻ��ʱ����ɱ�
			{"CUSTOMERLAW","1","06"}, //�ͻ����߱�
			{"CUSTOMERFACT","1","07"}, //�ͻ����¼Ǳ�
			{"LOANCONTRACT","businesssum","08"},  //�ͻ�����ҵ���ͬ��Ϣ��
			{"LOANDUEBILL","balance","09"},  //�ͻ���������Ϣ��
			{"LOANRETURN","returnsum","10"},  //�ͻ�����ҵ�񻹿���Ϣ��
			{"LOANEXTENSION","extensum","11"},  //�ͻ�����ҵ��չ����Ϣ��
			{"FACTORING","Balance","12"},  //�ͻ�����ҵ����Ϣ��
			{"DISCOUNT","discountsum","13"},  //�ͻ�Ʊ������ҵ����Ϣ��
			{"FINAINFO","businesssum","14"},  //�ͻ�ó������ҵ���ͬ��Ϣ��
			{"FINADUEBILL","balance","15"},  //�ͻ�ó������ҵ������Ϣ��
			{"FINARETURN","returnsum","16"},  //�ͻ�ó������ҵ�񻹿���Ϣ��
			{"FINAEXTENSION","extensum","17"},  //�ͻ�ó������ҵ��չ����Ϣ��
			{"CREDITLETTER","balance","18"},  //�ͻ�����֤ҵ����Ϣ��
			{"GUARANTEEBILL","GuaranteeSum","19"},  //�ͻ�����ҵ����Ϣ��
			{"ACCEPTANCE","AccepSum","20"},  //�ͻ����гжһ�Ʊҵ����Ϣ��
			{"CUSTOMERCREDIT","CreditLimit","21"},  //�ͻ�����������Ϣ��
			{"ASSURECONT","AssureSum","22"},  //�ͻ�ҵ��֤��ͬ��Ϣ��
			{"GUARANTYCONT","GuarantySum","23"},  //�ͻ�ҵ���Ѻ��ͬ��Ϣ��
			{"IMPAWNCONT","ImpawnSum","24"},  //�ͻ�ҵ����Ѻ��ͬ��Ϣ��
			{"FLOORFUND","FloorBalance","25"},  //�ͻ������Ϣ��
			{"INTERESTDUE","InterestBalance","26"}  //�ͻ�ǷϢ��Ϣ��
			};
	
	
	public SyncReportData(){
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
		} catch (SQLException e) {
			logger.debug("�õ����ݿ�����ʱ��������:",e);
			throw new ECRException("�õ����ݿ�����ʱ��������!",e);
		}
   }
   
   
   /*
    * �������ݱ�ecr_amoutreport
    */
   public  void InsertReport() throws ECRException {
	   String sqlQuery="select max(sessionid) as sessionid from ecr_session";
	   String sqlDelete="delete from ecr_amoutreport where sessionid=?";
	   String sSessionid = "";
	   String sBusinessType = "";
	   String sAmountNo = "";
	   double AmountSum = 0;
	   String sNAmountNo = "";
	   double NAmountSum = 0;
	   String sCAmountNo = "";
	   double CAmountSum = 0;
		String sqlInsert="insert into ecr_amoutreport(sessionid,businesstype,amoutno,amoutsum,newamoutno,newamoutsum,changeamoutno,changeamoutsum) values(?,?,?,?,?,?,?,?)";
		try {
			stmt = connection.prepareStatement(sqlQuery);
			pstmInsert = connection.prepareStatement(sqlInsert);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	   for (int i = 0; i < allTables.length; i++) { // �����ӱ�����Ӧ�ĸı�30
		   String sqlAmountNo="select count(loancardno) from ecr_"+ allTables[i][0];
		   String sqlAmountSum="select sum("+allTables[i][1]+") from ecr_"+ allTables[i][0];
		   String sqlNAmountno="select count(loancardno) from his_"+ allTables[i][0] +" where incrementflag='1' and sessionid=?";
		   String sqlNAmountSum="select sum("+allTables[i][1]+") from his_"+ allTables[i][0] +" where incrementflag='1' and sessionid=?";
		   String sqlCAmountNo="select count(loancardno) from his_"+ allTables[i][0] +" where incrementflag='2' and sessionid=?";
		   String sqlCAmountSum="select sum("+allTables[i][1]+") from his_"+ allTables[i][0]+" where incrementflag='2' and sessionid=?";
		   try {
			pstmAmountno = connection.prepareStatement(sqlAmountNo);
			pstmAmountsum = connection.prepareStatement(sqlAmountSum);
			pstmNAmountno = connection.prepareStatement(sqlNAmountno);
			pstmNAmountsum = connection.prepareStatement(sqlNAmountSum);
			pstmCAmountno = connection.prepareStatement(sqlCAmountNo);
			pstmCAmountsum = connection.prepareStatement(sqlCAmountSum);
			ptmtdel = connection.prepareStatement(sqlDelete);
			ResultSet rs = stmt.executeQuery(sqlQuery);
			logger.debug(sqlQuery);
			if(rs.next()){
				sSessionid=rs.getString(1);
				sBusinessType = allTables[i][2];
				logger.debug(sSessionid);
				//ɾ��������������
				ptmtdel.setString(1,sSessionid);
				ptmtdel.executeUpdate();
				//����
				ResultSet rs1 = pstmAmountno.executeQuery();
				if(rs1.next()){
					sAmountNo=rs1.getString(1);
				}
				//�����
				ResultSet rs2 = pstmAmountsum.executeQuery();
				if(rs2.next()){
					AmountSum = rs2.getDouble(1);
				}
				//��������
				pstmNAmountno.setString(1,sSessionid);
				ResultSet rs3 = pstmNAmountno.executeQuery();
				if(rs3.next()){
					sNAmountNo = rs3.getString(1);
				}
				//���������
				pstmNAmountsum.setString(1,sSessionid);
				ResultSet rs4 = pstmNAmountsum.executeQuery();
				if(rs4.next()){
					NAmountSum =  rs4.getDouble(1);
				}
				//�����
				pstmCAmountno.setString(1,sSessionid);
				ResultSet rs5 = pstmCAmountno.executeQuery();
				if(rs5.next()){
					sCAmountNo =  rs5.getString(1);
				}
				//��������
				pstmCAmountsum.setString(1,sSessionid);
				ResultSet rs6 = pstmCAmountsum.executeQuery();
				if(rs6.next()){
					CAmountSum =  rs6.getDouble(1);
				}
				if(sBusinessType.equals("1")||sBusinessType.equals("2")||sBusinessType.equals("6")||sBusinessType.equals("7")) {
					AmountSum = 0;
					NAmountSum = 0;
					CAmountSum = 0;
				}
				pstmInsert.setString(1, sSessionid);
				pstmInsert.setString(2, sBusinessType);
				pstmInsert.setString(3, sAmountNo);
				pstmInsert.setDouble(4, AmountSum);
				pstmInsert.setString(5, sNAmountNo);
				pstmInsert.setDouble(6, NAmountSum);
				pstmInsert.setString(7, sCAmountNo);
				pstmInsert.setDouble(8, CAmountSum);
				pstmInsert.addBatch();
				pstmInsert.executeBatch();
			}
			} catch (SQLException e) {
				logger.debug("�������ݱ�ecr_amoutreport����", e);
			}
			  
	   }
	}
  
   
   public int execute()
   {
	//��ʼ�������ݿ����Ӻ������ļ�����
	  try {
			init();			
			InsertReport();
		} catch (ECRException e) {
			logger.fatal("���뱨�����ݳ���"+e.getMessage());
			return TaskConstants.ES_FAILED;
		}
		clearResource();
		logger.info("���뱨��������ɣ�");
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
		if (pstmInsert != null) {
			try {
				pstmInsert.close();
			} catch (SQLException e) {
				logger.warn("pstmInsert.close()", e);
			}
			pstmInsert =  null;
		}
		if (pstmAmountno != null) {
			try {
				pstmAmountno.close();
			} catch (SQLException e) {
				logger.warn("pstmAmountno.close()", e);
			}
			pstmAmountno = null;
		}
		if (pstmAmountsum != null) {
			try {
				pstmAmountsum.close();
			} catch (SQLException e) {
				logger.warn("pstmAmountsum.close()", e);
			}
			pstmAmountsum = null;
		}
		if (pstmNAmountno != null) {
			try {
				pstmNAmountno.close();
			} catch (SQLException e) {
				logger.warn("pstmNAmountno.close()", e);
			}
			pstmNAmountno = null;
		}
		if (pstmNAmountsum != null) {
			try {
				pstmNAmountsum.close();
			} catch (SQLException e) {
				logger.warn("pstmNAmountsum.close()", e);
			}
			pstmNAmountsum = null;
		}
		if (pstmCAmountno != null) {
			try {
				pstmCAmountno.close();
			} catch (SQLException e) {
				logger.warn("pstmCAmountno.close()", e);
			}
			pstmCAmountno = null;
		}
		if (pstmCAmountsum != null) {
			try {
				pstmCAmountsum.close();
			} catch (SQLException e) {
				logger.warn("pstmCAmountsum.close()", e);
			}
			pstmCAmountsum = null;
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