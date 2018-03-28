/***********************************************************************
 * Module:  DelCustomer.java
 * Author:  gdding
 * Modified: 
 * Purpose: Defines the Class DelCustomer.java 删除多余客户
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
 *    更新update日期，当期数据更新为9999/12/31,上期数据更新为当期的occurdate
 */
public class SyncUpdate extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmtq=null;
	protected Statement stmt=null;
	protected String allTables[][] = {
			{"HIS_CUSTOMERINFO","LOANCARDNO"}, //客户概况表
			{"HIS_CUSTCAPIINFO","LOANCARDNO"}, //客户资本构成表
			{"HIS_CUSTOMERLAW","LOANCARDNO"}, //客户涉诉表
			{"HIS_CUSTOMERFACT","LOANCARDNO"}, //客户大事记表
			{"HIS_LOANCONTRACT","LCONTRACTNO"},  //客户贷款业务合同信息表
			{"HIS_LOANDUEBILL","LDUEBILLNO"},  //客户贷款借据信息表
			{"HIS_LOANRETURN","LDUEBILLNO"},  //客户贷款业务还款信息表
			{"HIS_LOANEXTENSION","LDUEBILLNO"},  //客户贷款业务展期信息表
			{"HIS_FACTORING","FACTORINGNO"},  //客户保理业务信息表
			{"HIS_DISCOUNT","BILLNO"},  //客户票据贴现业务信息表
			{"HIS_FINAINFO","FCONTRACTNO"},  //客户贸易融资业务合同信息表
			{"HIS_FINADUEBILL","FDUEBILLNO"},  //客户贸易融资业务借据信息表
			{"HIS_FINARETURN","FDUEBILLNO"},  //客户贸易融资业务还款信息表
			{"HIS_FINAEXTENSION","FDUEBILLNO"},  //客户贸易融资业务展期信息表
			{"HIS_CREDITLETTER","CREDITLETTERNO"},  //客户信用证业务信息表
			{"HIS_GUARANTEEBILL","GUARANTEEBILLNO"},  //客户保函业务信息表
			{"HIS_ACCEPTANCE","ACCEPTNO"},  //客户银行承兑汇票业务信息表
			{"HIS_CUSTOMERCREDIT","CCONTRACTNO"},  //客户公开授信信息表
			{"HIS_ASSURECONT","CONTRACTNO"},  //客户业务保证合同信息表
			{"HIS_GUARANTYCONT","CONTRACTNO"},  //客户业务抵押合同信息表
			{"HIS_IMPAWNCONT","CONTRACTNO"},  //客户业务质押合同信息表
			{"HIS_FLOORFUND","FLOORFUNDNO"},  //客户垫款信息表
			{"HIS_INTERESTDUE","LOANCARDNO"}  //客户欠息信息表
			};
	
	
	public SyncUpdate(){
		//初始化，数据库连接和数据文件连接
		try {
			init();
		} catch (ECRException e) {
			logger.fatal("初始化失败",e);
			clearResource();
		}
	}
	
   /*
    * 初始化
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
			logger.debug("得到数据库连接时发生错误:",e);
			throw new ECRException("得到数据库连接时发生错误!",e);
		}
   }
   
   
   /*
    * 删除业务表数据
    */
   public void SyncOldUpdate() throws ECRException {
	   String sqlQuery="";
	   String sOcurdate="";
		String sqlUpdate="";
		String sMainbusinessno="";
	   for (int i = 0; i < allTables.length; i++) { // 若增加表，则相应的改变30.
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
					logger.trace("更新表名" + allTables[i]);
				 }
			} catch (SQLException e) {
				logger.debug("更新数据表"+allTables[i][0]+"出错！", e);
				//throw new ECRException("删除数据表"+allTables[i]+"出错！");
			}
		}
	}
   public void SyncNewUpdate() throws ECRException {
	   String sUpdateNowTable="";
	   for (int i = 0; i < allTables.length; i++) { // 若增加表，则相应的改变30.
			try {
				sUpdateNowTable="update "
					+ allTables[i][0]
					+ " set updatedate= '9999/12/31'"
					+" where sessionid='0000000000'";
				logger.debug("newupdate"+sUpdateNowTable);
				//System.out.println("sUpdateNowTable:"+sUpdateNowTable);
				stmt.executeUpdate(sUpdateNowTable);
			    logger.trace("更新表名" + allTables[i]);
			} catch (SQLException e) {
				logger.debug("更新数据表"+allTables[i][0]+"出错！", e);
				//throw new ECRException("删除数据表"+allTables[i]+"出错！");
			}
		}
	}
   
   public int execute()
   {
	//初始化，数据库连接和数据文件连接
	  try {
			init();			
			SyncOldUpdate();
			SyncNewUpdate();
		} catch (ECRException e) {
			logger.fatal("更新日期出错！"+e.getMessage());
			return TaskConstants.ES_FAILED;
		}
		clearResource();
		logger.info("更新日期信息完成！");
      return TaskConstants.ES_SUCCESSFUL;
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