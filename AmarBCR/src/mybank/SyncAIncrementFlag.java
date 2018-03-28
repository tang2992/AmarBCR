/***********************************************************************
 * Module:  SyncGuarantyFlag.java
 * Author:  gdding
 * Modified: 
 * Purpose: Defines the Class 
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
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;

/*
 *    把业务表的担保标志重置
 */
public class SyncAIncrementFlag extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmt=null;
	
	private HashMap bizStatements = null;
	private PreparedStatement pstmtUpdate = null;
	
	protected String tables[][]={
			{"ECR_LOANCONTRACT","Lcontractno","1"},
			{"ECR_FACTORING","FactoringNo","2"},
			{"ECR_FINAINFO","FContractNo","4"},
			{"ECR_CREDITLETTER","CreditLetterNo","5"},
			{"ECR_GUARANTEEBILL","GuaranteeBillNo","6"},
			{"ECR_ACCEPTANCE","AcceptNo","7"}
	};
	
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
		for(int i=0;i<tables.length;i++)
			try {
				updateAssureTable(tables[i][0],tables[i][1],tables[i][2]);
				updateGuarantyTable(tables[i][0],tables[i][1],tables[i][2]);
				updateImpawnTable(tables[i][0],tables[i][1],tables[i][2]);
			} catch (SQLException e) {
				logger.fatal("更新担保标志失败！",e);
				clearResource();
				return TaskConstants.ES_FAILED;
			}
		
		clearResource();
		return TaskConstants.ES_SUCCESSFUL;
   }

   private void updateAssureTable(String updateTable,String updateGuarantyFlag,String businessType) throws SQLException{
//解决一种情况，担保新增，合同新增，
	   StringBuffer sql = new StringBuffer("update ecr_assurecont ");
	   sql.append(" set ")
	   .append(" incrementflag='2', occurdate='")
	   .append(Tools.getLastDay("1"))
	   .append("' where contractno in(select ")
	   .append(updateGuarantyFlag)
	   .append(" from ")
	   .append(updateTable)
	    .append(" where incrementflag ='2') and businesstype='")
	    .append(businessType)
	     .append("' and incrementflag='8'");
	   logger.trace(sql.toString());
	   stmt.executeUpdate(sql.toString());
   }

   private void updateGuarantyTable(String updateTable,String updateGuarantyFlag,String businessType) throws SQLException{
//解决一种情况，担保新增，合同新增，
	   StringBuffer sql = new StringBuffer("update ecr_guarantycont ");
	   sql.append(" set ")
	   .append(" incrementflag='2', occurdate='")
	   .append(Tools.getLastDay("1"))
	   .append("' where contractno in(select ")
	   .append(updateGuarantyFlag)
	   .append(" from ")
	   .append(updateTable)
	    .append(" where incrementflag ='2') and businesstype='")
	    .append(businessType)
	     .append("' and incrementflag='8'");
	   
	   logger.trace(sql.toString());
	   stmt.executeUpdate(sql.toString());
   }

   private void updateImpawnTable(String updateTable,String updateGuarantyFlag,String businessType) throws SQLException{
//解决一种情况，担保新增，合同新增，
	   StringBuffer sql = new StringBuffer("update ecr_impawncont ");
	   sql.append(" set ")
	   .append(" incrementflag='2',occurdate='")
	   .append(Tools.getLastDay("1"))
	   .append("' where contractno in(select ")
	   .append(updateGuarantyFlag)
	   .append(" from ")
	   .append(updateTable)
	    .append(" where incrementflag ='2') and businesstype='")
	    .append(businessType)
	     .append("' and incrementflag='8'");
	   //System.out.println(Tools.getLastDay("1"));
	   logger.trace(sql.toString());
	   stmt.executeUpdate(sql.toString());
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