package mybank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.app.datax.ecr.validate.validator.DKKChecker;
import com.amarsoft.are.ARE;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;

/*
 *    �Ӵ�����������г�ȡ��������Ϣ
 *    ���ݿͻ��źʹ����������ҳ����д���ҵ����Ϣ,�����뵽����ɾ������
 *    ���ݴ����������ҳ��ÿͻ���������ҵ����Ϣ����������뵽����ɾ������
 *    LoanCardNo_ChangeΪ��������,ChangeStatus  I ��ʼ��״̬  F ����ʧ��״̬ B ҵ����³ɹ� G �������³ɹ�  
 *    
 */
public class UpdateWrongLoanCardNo extends ExecuteUnit
{
	protected Connection connection=null;
	
	private PreparedStatement pstmtSelectGuarantyContract = null;
	private PreparedStatement pstmtSelectLoanCardNoChange = null;   
	private PreparedStatement pstmtUpdateCustomerInfo = null;
	private PreparedStatement pstmtSelectHISBatchDelete = null;
	
	private Statement stmt = null;
	
	
	private String sqlSelectGuarantyContract = " Select distinct ContractNo,BusinessType from ECR_AssureCont where ALoanCardNo=? "+
											 " union"+
											 " Select distinct ContractNo,BusinessType from ECR_GuarantyCont where GLoanCardNo=? "+
											 " union"+
											 " Select distinct ContractNo,BusinessType from ECR_ImpawnCont where ILoanCardNo=? ";
	private String sqlSelectLoanCardNoChange = " Select CustomerID,OldLoanCardNo,NewLoanCardNo FROM LoanCardNo_Change where ChangeDate=?";
	private String sqlUpdateCustomerInfo = " Update ECR_CustomerInfo set LoanCardNo=? where CustomerID=?";
	private String sqlSelectHISBatchDelete = " Select Count(*) from HIS_BATCHDELETE where OccurDate=? and ContractNo=? and BusinessType=?";
	//private String sqlUpdateLoanCardNoChange = "Update "
	
	private String customerID = "";
	private String oldLoanCardNo = "";
	private String newLoanCardNo = "";
	private String yesterday = Tools.getLastDay("1");
	
	private int iCount=0;
	
	//����,ɾ������ͬ��,ɾ��ҵ������,������Ӧ���Ŵ�ҵ������(N,��ʾû�е���)
	private String tables [][] = {
			{"ECR_LOANCONTRACT","LCONTRACTNO","01","1"},
			{"ECR_FACTORING","FACTORINGNO","02","2"},
			{"ECR_DISCOUNT","BILLNO","03","3"},
			{"ECR_FINAINFO","FCONTRACTNO","04","4"},			
			{"ECR_CREDITLETTER","CREDITLETTERNO","05","5"},
			{"ECR_GUARANTEEBILL","GUARANTEEBILLNO","06","6"},
			{"ECR_ACCEPTANCE","ACCEPTNO","07","7"},
			{"ECR_CUSTOMERCREDIT","CCONTRACTNO","08","8"},
			{"ECR_FLOORFUND","FLOORFUNDNO","09","N"},
			{"ECR_INTERESTDUE","LOANCARDNO","10","N"}
	};
	
	
   /*
    * ��ʼ��
    */
   protected void init() throws ECRException
   {
		//--------------------------------------------------���ݿ����ӳ�ʼ��
		String database = "ecr";//getProperty(PROPERTY_DATABASE);
		try {
				connection = ARE.getDBConnection(database);
				pstmtSelectGuarantyContract = connection.prepareStatement(sqlSelectGuarantyContract);
				pstmtSelectLoanCardNoChange = connection.prepareStatement(sqlSelectLoanCardNoChange);
				pstmtUpdateCustomerInfo = connection.prepareStatement(sqlUpdateCustomerInfo);
				pstmtSelectHISBatchDelete = connection.prepareStatement(sqlSelectHISBatchDelete);
				stmt = connection.createStatement();
		} catch (SQLException e) {
			throw new ECRException("���ݿ������쳣��"+e);
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
			logger.info("��ʼ��ȡҵ�������������Ϣ...");
			updateBusinessLoanCardNo(); 
			logger.info("��ʼ��ȡ����������������Ϣ...");
			updateGuarantyLoanCardNo();
			logger.info("����������ɣ�һ��������"+iCount+"������");
			
		} catch (SQLException e) {
			logger.fatal("���´����Ϣʧ�ܣ�",e);
			clearResource();
			return TaskConstants.ES_FAILED;
		}
		
		clearResource();
		return TaskConstants.ES_SUCCESSFUL;
   }
   //�������ص�ҵ����Ϣ
   private void updateBusinessLoanCardNo() throws SQLException{
	   
	   pstmtSelectLoanCardNoChange.setString(1, "2008/05/13");
	   ResultSet rs = pstmtSelectLoanCardNoChange.executeQuery();
	  
	   while(rs.next())
	   {
		   customerID = rs.getString("CustomerID");
		   oldLoanCardNo = rs.getString("OldLoanCardNo");
		   newLoanCardNo = rs.getString("NewLoanCardNo");
		   
		   if(customerID == null) customerID = "";
		   if(oldLoanCardNo == null) oldLoanCardNo = "";
		   if(newLoanCardNo == null) newLoanCardNo = "";
		   iCount++;
		   
		   logger.info("��ʼ����CustomerIDΪ"+customerID+",OldLoanCardNoΪ"+oldLoanCardNo+",NewLoanCardNoΪ"+newLoanCardNo);
		   
		   //��У���µĴ�������Ƿ���Ϲ���,���������ֱ������
		   if(newLoanCardNo.equals("") || newLoanCardNo.length()!=16 ||!DKKChecker.checkDKK(newLoanCardNo.getBytes()))
		   {
			   logger.debug("CustomerIDΪ"+customerID+",NewLoanCardNoΪ"+newLoanCardNo+",���������й���");
			   continue;
		   }
		   //�¾ɴ��������ͬ,û�и��µı�Ҫ
		   if(newLoanCardNo.equals(oldLoanCardNo))
		   {
			   logger.debug("CustomerIDΪ"+customerID+",NewLoanCardNoΪ"+newLoanCardNo+",�¾ɴ��������ͬ,û�и��µı�Ҫ");
			   continue;
		   }
		   //��ѯ�´�������Ƿ��Ѿ���ռ��,����Ѿ���ռ��,���棡����һ����������Ӧ����CustomerID���������
		   
		   
		   //���Ϲ����ȸ��¿ͻ���Ϣ��
		   pstmtUpdateCustomerInfo.setString(1, newLoanCardNo);
		   pstmtUpdateCustomerInfo.setString(2,customerID);
		   pstmtUpdateCustomerInfo.execute();
		   
		   //���Ÿ���CustomerID,��������ɾ������
		   String sSql = "";
		   for(int i = 0;i<tables.length;i++)
		   {
				sSql =  " Insert Into HIS_BATCHDELETE (OccurDate,ContractNo,BusinessType,LoanCardNo,FinanceID,IncrementFlag,RecordFlag,SessionID)"+
				 		" Select '"+yesterday+"',"+tables[i][1]+",'"+tables[i][2]+"',LoanCardNo,FinanceID,'1','40','0000000000' FROM "+tables[i][0]+
				 		" where CustomerID='"+customerID+"'";
				logger.debug("�������˴����������Ӧ����ҵ����Ϣ����:"+sSql);
				stmt.execute(sSql);
		   }
	   }
	   rs.close();
   }
   //�������صĵ�����Ϣ
   private void updateGuarantyLoanCardNo() throws SQLException
   {
	   
	   pstmtSelectLoanCardNoChange.setString(1, "2008/05/13");
	   ResultSet rs = pstmtSelectLoanCardNoChange.executeQuery();
	  
	   while(rs.next())
	   {
		   customerID = rs.getString("CustomerID");
		   oldLoanCardNo = rs.getString("OldLoanCardNo");
		   newLoanCardNo = rs.getString("NewLoanCardNo");
		   
		   if(customerID == null) customerID = "";
		   if(oldLoanCardNo == null) oldLoanCardNo = "";
		   if(newLoanCardNo == null) newLoanCardNo = "";
		   
		   //У��ɵĴ�������Ƿ���Ϲ������������ֱ��������������ݵ����˵Ĵ����ѯ����ҵ�񣬲������������ɾ����
		   if(oldLoanCardNo.equals("") || oldLoanCardNo.length()!=16 ||!DKKChecker.checkDKK(oldLoanCardNo.getBytes()))
		   {
			   logger.debug("CustomerIDΪ"+customerID+",oldLoanCardNo"+oldLoanCardNo+",���������й���");
			   continue;
		   }
		   pstmtSelectGuarantyContract.setString(1,oldLoanCardNo);
		   pstmtSelectGuarantyContract.setString(2,oldLoanCardNo);
		   pstmtSelectGuarantyContract.setString(3,oldLoanCardNo);
		   ResultSet rs1 = pstmtSelectGuarantyContract.executeQuery();
		   while(rs1.next())
		   {
			   String contractNo = rs1.getString("ContractNo");
			   String businessType = rs1.getString("BusinessType");
			   if(businessType == null) businessType = "";
			   pstmtSelectHISBatchDelete.setString(1, yesterday);
			   pstmtSelectHISBatchDelete.setString(2, contractNo);
			   pstmtSelectHISBatchDelete.setString(3, businessType);
			   int i = 0;
			   ResultSet rs2 = pstmtSelectHISBatchDelete.executeQuery();
			   if(rs2.next())
			   {
				   i = rs2.getInt(1);
			   }
			   rs2.close();
			   if(i==0) continue;
			   
			   String sSql = "";
			   for (int j=0;j<tables.length;j++)
			   {
				   if(businessType.equals(tables[j][3]))
				   {
					   sSql =  " Insert Into HIS_BATCHDELETE (OccurDate,ContractNo,BusinessType,LoanCardNo,FinanceID,IncrementFlag,RecordFlag,SessionID)"+
				 		" Select '"+yesterday+"',"+tables[j][1]+",'"+tables[j][2]+"',LoanCardNo,FinanceID,'1','40','0000000000' FROM "+tables[j][0]+
				 		" where "+tables[j][1]+"='"+contractNo+"'";
					   logger.debug("���뵣���˴����������Ӧ����ҵ����Ϣ����:"+sSql);
					   stmt.execute(sSql);
				   }
			   }
		   }
		   rs1.close();
	   }
	   rs.close();
   }  
	
	/**
	 * ������ͷ����й����д򿪵���Դ�����ݿ����ӡ��ļ����ӵ�
	 *
	 */
	private void clearResource(){
		if(pstmtSelectGuarantyContract!=null){
			try {
				pstmtSelectGuarantyContract.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			pstmtSelectGuarantyContract = null;
		}
		
		if(pstmtSelectLoanCardNoChange!=null){
			try {
				pstmtSelectLoanCardNoChange.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			pstmtSelectLoanCardNoChange = null;
		}
		if(pstmtUpdateCustomerInfo!=null){
			try {
				pstmtUpdateCustomerInfo.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			pstmtUpdateCustomerInfo = null;
		}
		if(pstmtSelectHISBatchDelete!=null){
			try {
				pstmtSelectHISBatchDelete.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			pstmtSelectHISBatchDelete = null;
		}
		if(stmt!=null){
			try {
				stmt.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			stmt = null;
		}		
		
		if(connection!=null){
			try {
				connection.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			connection = null;
		}
	}
}