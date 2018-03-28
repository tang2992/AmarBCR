/***********************************************************************
 * Module:  SyncErrLoancard.java
 * Author:  gdding
 * Modified: 
 * Purpose: Defines the Class SyncErrLoancard 
 ***********************************************************************/

package mybank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;

/*
 *    通过ecr_updaterecord搜索全部串户的老的贷款卡对应的业务数据
 */
public class SyncErrLoancard extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmt=null;
	protected PreparedStatement pstmtQuery = null;
	private PreparedStatement psInsert = null;
	private PreparedStatement psSearch = null;
	private PreparedStatement psDelete = null;
	//定义要更新的表
	protected String tables[][]={	
		{"ecr_loancontract","01","LCONTRACTNO"},	
		{"ecr_discount","03","BILLNO"},		
		{"ecr_factoring","02","FACTORINGNO"},	
		{"ecr_finainfo","04","FCONTRACTNO"},	
		{"ecr_creditletter","05","CREDITLETTERNO"},	
		{"ecr_guaranteebill","06","GUARANTEEBILLNO"},
		{"ecr_acceptance","07","ACCEPTNO"},
		{"ecr_customercredit","08","CCONTRACTNO"},
		{"ecr_interestdue","10","LOANCARDNO"},
		{"ecr_floorfund","09","FLOORFUNDNO"}
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
			
		} catch (SQLException e) {
			throw new ECRException(e);
		}
   }
   
   
   
   public int execute()
   {
		//初始化，数据库连接和数据文件连接
		try {
			init();
			try {
				SearchData();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ECRException e) {
			logger.fatal("初始化失败",e);
			clearResource();
			return TaskConstants.ES_FAILED;
		}
				
		clearResource();
		return TaskConstants.ES_SUCCESSFUL;
   }

   private void SearchData() throws SQLException{
	   String  sqlQuery = "select oldcode[1,16] from ecr_updaterecord where incrementflag='1' " +
	   		" and (length(nvl(oldcode,'1'))=16 or length(nvl(oldcode,'1'))=18)";
	   String  sqlinsert = "insert into his_batchdelete(sessionid,occurdate,businesstype,financeid,loancardno,contractno,incrementflag) values(?,?,?,?,?,?,?) ";
	   String  sqldelete = "delete from his_batchdelete where incrementflag='1' and contractno=? ";
	   String ErrLoanCardNo="";
	   String ContractNo="";
	   String delbusinesstype="";
	   String createdate="";
	   String sessionid="0000000000";
	   String FinanceID=""; 
	   String Incrementflag="1";
	   stmt = connection.createStatement();
	   psInsert = connection.prepareStatement(sqlinsert);
	   psDelete = connection.prepareStatement(sqldelete);
	   
		ResultSet rs = stmt.executeQuery(sqlQuery);
		logger.debug(sqlQuery);
		while(rs.next()){
			ErrLoanCardNo = rs.getString("oldcode");
			logger.debug(ErrLoanCardNo);
			for(int i=0;i<tables.length;i++){
				try {
					StringBuffer SearchSql=new StringBuffer(" ");
					String businesstype=tables[i][1];
					SearchSql.append("select '"+businesstype)
					.append("' as businesstype,financeid,")
					.append("loancardno,")
					.append(tables[i][2])
					.append(" as contractno from ")
					.append(tables[i][0])
					.append(" where loancardno=?");
					
					psSearch = connection.prepareStatement(SearchSql.toString());
					logger.debug(SearchSql.toString());
					psSearch.setString(1,ErrLoanCardNo);
					ResultSet rs1 = psSearch.executeQuery();
					while(rs1.next()){
						delbusinesstype=rs1.getString("businesstype");
						ErrLoanCardNo=rs1.getString("loancardno");
						FinanceID=rs1.getString("financeid");
						ContractNo=rs1.getString("contractno");
						createdate=Tools.getLastDay("1");
						logger.debug("主合同号："+ContractNo+"@业务类型："+delbusinesstype);
						try{
							psDelete.setString(1,ContractNo);
							logger.debug("sqldelete："+sqldelete);
							psDelete.execute();
						}
						catch(SQLException e){
							logger.fatal("删除已存在数据失败！",e);
							clearResource();
						}
						psInsert.setString(1,sessionid);
						psInsert.setString(2,createdate);
						psInsert.setString(3,delbusinesstype);
						psInsert.setString(4,FinanceID);
						psInsert.setString(5,ErrLoanCardNo);
						psInsert.setString(6,ContractNo);
						psInsert.setString(7,Incrementflag);
						psInsert.execute();
					}
				} catch (SQLException e) {
					logger.fatal("更新批量删除表失败！",e);
					clearResource();
				}
			}
		}
	   
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