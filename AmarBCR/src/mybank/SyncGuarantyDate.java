/***********************************************************************
 * Module:  SyncGuarantyDate.java
 * Author:  tzhai
 * Modified: 
 * Purpose: 
 ***********************************************************************/

package mybank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Iterator;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;

/*
 *    ͬ������ҵ��������
 */
public class SyncGuarantyDate extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmt=null;
	
	private HashMap bizStatements = null;
	private PreparedStatement pstmtUpdate = null;
	   
	   
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
			stmt = connection.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_UPDATABLE);
		} catch (SQLException e) {
			throw new ECRException(e);
		}
		bizStatements = new HashMap();
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
			logger.info("��ʼ���µ�����ͬ...");
			updateContract("ECR_ASSURECONT"); //������ͬ
			logger.info("��ʼ���µ�Ѻ��ͬ...");
			updateContract("ECR_GUARANTYCONT"); //��Ѻ��ͬ
			logger.info("��ʼ���±�֤��ͬ...");
			updateContract("ECR_IMPAWNCONT"); //Ѻ��ͬ
		} catch (SQLException e) {
			logger.fatal("���µ�������ʧ�ܣ�",e);
			clearResource();
			return TaskConstants.ES_FAILED;
		}
		
		clearResource();
		return TaskConstants.ES_SUCCESSFUL;
   }
   
   private void updateContract(String table) throws SQLException{
	   String sqlQuery = "select ContractNo,BusinessType from "+ table + " where  incrementflag='2'";
	   String sqlUpdate = "update " + table + " set OccurDate=? where ContractNo=?";
	   String bizType=null,bizNo=null,occurDate=null;
	   logger.debug(sqlQuery);
	   logger.debug(sqlUpdate);
	   pstmtUpdate = connection.prepareStatement(sqlUpdate);
	   ResultSet rs = stmt.executeQuery(sqlQuery);
	   
	   while(rs.next()){
		   bizType = rs.getString(2);
		   bizNo = rs.getString(1); //����ͬ��
		   occurDate = getOccurDate(bizType,bizNo);
		   pstmtUpdate.setString(1,occurDate);
		   pstmtUpdate.setString(2,bizNo);
		   pstmtUpdate.executeUpdate();
	   }
	   rs.close();
	   pstmtUpdate.close();
	   pstmtUpdate = null;
   }
   
	private String getOccurDate(String bizType,String bizNo) throws SQLException{
		PreparedStatement pstmt = (PreparedStatement)bizStatements.get(bizType);
		String occurDate = null;
		if(pstmt==null){
			String sql = null;
			if(bizType.equals("1")){ //����ҵ��
				sql="select EC.OccurDate as OccurDate,EC.IncrementFlag as IncrementFlag " +
						"from ECR_LOANCONTRACT EC " +
						"where incrementflag='2' and EC.Lcontractno=?  order by EC.OccurDate";
			}else if(bizType.equals("2")){ //����ҵ��
				sql="select OccurDate,IncrementFlag from ECR_FACTORING where incrementflag='2' and FactoringNo=?";
			}else if(bizType.equals("4")){ //ó������ҵ��
				sql="select EC.OccurDate as OccurDate,EC.IncrementFlag as IncrementFlag " +
				"from ECR_FINAINFO EC " +
				"where incrementflag='2' and EC.FContractNo=?  order by EC.OccurDate";
			}else if(bizType.equals("5")){ //����֤ҵ��
				sql="select OccurDate,IncrementFlag from ECR_CREDITLETTER where incrementflag='2' and CreditLetterNo=?";
			}else if(bizType.equals("6")){ //����ҵ��
				sql="select OccurDate,IncrementFlag from ECR_GUARANTEEBILL where incrementflag='2' and GuaranteeBillNo=?";
			}else{ //�жһ�Ʊҵ��
				sql="select OccurDate,IncrementFlag from ECR_ACCEPTANCE where incrementflag='2' and AcceptNo=?";
			}
			pstmt = connection.prepareStatement(sql);
			bizStatements.put(bizType,pstmt);
		}
		pstmt.setString(1,bizNo);
		ResultSet rs = pstmt.executeQuery();

		if(rs.next()){
			occurDate = rs.getString("OccurDate");
		}
		rs.close();
		return occurDate;
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
				logger.debug(e);
			}
			stmt = null;
		}
		
		if(pstmtUpdate!=null){
			try {
				pstmtUpdate.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			pstmtUpdate = null;
		}
		
		
		if (bizStatements != null) {
			Iterator it = bizStatements.values().iterator();
			while (it.hasNext())
				try{
					((PreparedStatement)it.next()).close();
				}catch(SQLException e){
					logger.debug(e);
				}
			bizStatements.clear();
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