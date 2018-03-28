/***********************************************************************
 * Module:  UpdateCustomerInfo.java
 * Author:  binsy
 * Modified: 2005骞?1?7?1?7鏃?1?7 10:50:32
 * Purpose: Defines the Class UpdateCustomerInfo 把所有中间表中的贷款卡和企业名称为空的,全部填上
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
 *    把所有中间表中的贷款卡和企业名称为空的,全部填上
 */
public class SyncErrFinance extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmt=null;
	//定义要更新的表
	protected String tables[][]={	
		{"ECR_CUSTOMERINFO"},		
		{"ECR_CUSTOMERKEEPER"},			//高管
		{"ECRP_FINANCEBS"},			//资产负载表
		{"ECRP_FINANCEPS"},			//利润表
		{"ECRP_FINANCECF"},			//现金流量表
		{"ECR_CUSTOMERLAW"},			//诉讼记表
		{"ECR_CUSTOMERFACT"},			//其他大事表
		{"ECR_CONTRACT"},			//贷款业务
		{"ECR_DUEBILL"},			
		{"ECR_LOANRETURN"},		
		{"ECR_EXTENSION"},			
		{"ECR_GUARANTEEBILL"},		//保函
		{"ECR_FACTORING"},		//保理业务
		{"ECR_FLOORFUND"},		//垫款业务
		{"ECR_CUSTOMERCREDIT"},		//公开授信
		{"ECR_FINANCEINFO"},			//贸易融资
		{"ECR_FINADUEBILL"},			
		{"ECR_FINANCERETURN"},		
		{"ECR_FINAEXTENSION"},			
		{"ECR_DISCOUNT"},		//票据贴现
		{"ECR_INTERESTDUE"},		//欠息
		{"ECR_CREDITLETTER"},		//信用证业务
		{"ECR_ACCEPTANCE"},		//承兑汇票业务
		{"ECR_ASSURECONT"},		//保证合同
		{"ECR_GUARANTYCONT"},		//抵押合同
		{"ECR_IMPAWNCONT"},		//质押合同
		{"ECR_CUSTOMERCREDIT"}		//公开授信
		
	};

	/**
	 * 数据导入的目标数据库
	 */
   public static final String PROPERTY_DATABASE = "database";

 
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
			stmt = connection.createStatement();
		} catch (SQLException e) {
			throw new ECRException(e);
		}
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
				updateTable(tables[i][0]);
			} catch (SQLException e) {
				logger.fatal("更新金融机构失败！",e);
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
	 * 清理和释放运行过程中打开的资源，数据库连接、文件连接等
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