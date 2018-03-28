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
 *    把所有中间表中的贷款卡对应的customerid置正确
 */
public class SyncData extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmt=null;

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
		try {
				String sSql1="{call DeleteECRCustomer()}";
				stmt.executeUpdate(sSql1);
				
			} catch (SQLException e) {
				logger.fatal("删除重复客户失败！",e);
				clearResource();
				return TaskConstants.ES_FAILED;
			}
			try {
				String	sSql2="{call UpdateGuarantyFlag()}";
				stmt.executeUpdate(sSql2);
				
			} catch (SQLException e) {
				logger.fatal("更新担保标志失败！",e);
				clearResource();
				return TaskConstants.ES_FAILED;
			}
			try {
				String	sSql3="{call UpdateECRFloorFlag()}";
				stmt.executeUpdate(sSql3);

			} catch (SQLException e) {
				logger.fatal("更新垫款标志失败！",e);
				clearResource();
				return TaskConstants.ES_FAILED;
			}
		clearResource();
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