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
 *    同步担保业务发生日期
 */
public class SyncGuarantyDate extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmt=null;
	
	private HashMap bizStatements = null;
	private PreparedStatement pstmtUpdate = null;
	   
	   
   /*
    * 初始化
    */
   protected void init() throws ECRException
   {
		logger = ARE.getLog();
		//--------------------------------------------------数据库连接初始化
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
		//初始化，数据库连接和数据文件连接
		try {
			init();
		} catch (ECRException e) {
			logger.fatal("初始化失败",e);
			clearResource();
			return TaskConstants.ES_FAILED;
		}
		try {
			logger.info("开始更新担保合同...");
			updateContract("ECR_ASSURECONT"); //担保合同
			logger.info("开始更新抵押合同...");
			updateContract("ECR_GUARANTYCONT"); //抵押合同
			logger.info("开始更新保证合同...");
			updateContract("ECR_IMPAWNCONT"); //押合同
		} catch (SQLException e) {
			logger.fatal("更新担保日期失败！",e);
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
		   bizNo = rs.getString(1); //主合同号
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
			if(bizType.equals("1")){ //贷款业务
				sql="select EC.OccurDate as OccurDate,EC.IncrementFlag as IncrementFlag " +
						"from ECR_LOANCONTRACT EC " +
						"where incrementflag='2' and EC.Lcontractno=?  order by EC.OccurDate";
			}else if(bizType.equals("2")){ //保理业务
				sql="select OccurDate,IncrementFlag from ECR_FACTORING where incrementflag='2' and FactoringNo=?";
			}else if(bizType.equals("4")){ //贸易融资业务
				sql="select EC.OccurDate as OccurDate,EC.IncrementFlag as IncrementFlag " +
				"from ECR_FINAINFO EC " +
				"where incrementflag='2' and EC.FContractNo=?  order by EC.OccurDate";
			}else if(bizType.equals("5")){ //信用证业务
				sql="select OccurDate,IncrementFlag from ECR_CREDITLETTER where incrementflag='2' and CreditLetterNo=?";
			}else if(bizType.equals("6")){ //保函业务
				sql="select OccurDate,IncrementFlag from ECR_GUARANTEEBILL where incrementflag='2' and GuaranteeBillNo=?";
			}else{ //承兑汇票业务
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
	 * 清理和释放运行过程中打开的资源，数据库连接、文件连接等
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