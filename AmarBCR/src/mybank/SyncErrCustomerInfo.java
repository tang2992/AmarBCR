/***********************************************************************
 * Module:  UpdateCustomerInfo.java
 * Author:  binsy
 * Modified: 2005骞?1?7?1?7鏃?1?7 10:50:32
 * Purpose: Defines the Class UpdateCustomerInfo 把所有中间表中的贷款卡和企业名称为空的,全部填上
 ***********************************************************************/

package mybank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class SyncErrCustomerInfo extends ExecuteUnit
{
	/**
	 * 数据导入的目标数据库
	 */
	public static final String PROPERTY_DATABASE = "database";
	private static PreparedStatement pstmSelect = null;
	protected Log logger;
	protected static Connection connection=null;
	protected Statement stmt=null;
//	定义要更新的表
	protected static String tables[][]={	
		{"ECR_CUSTOMERinfo","LoanCardNo"},	
		{"ECR_CUSTOMERKEEPER","LoanCardNo"},		//高管
		{"ECRP_FINANCEBS","LoanCardNo"},			//资产负载表
		{"ECRP_FINANCEPS","LoanCardNo"},			//利润表
		{"ECRP_FINANCECF","LoanCardNo"},			//现金流量表
		{"ECRP_FINANCECF","LoanCardNo"},			//现金流量表
		{"ECR_CUSTOMERLAW","LoanCardNo"},			//诉讼记表
		{"ECR_CUSTOMERFACT","LoanCardNo"},			//其他大事表
		{"ECR_CONTRACT","LoanCardID"},				//贷款业务		
		{"ECR_DUEBILL","LoanCardID"},			
		{"ECR_LOANRETURN","LoanCardID"},		
		{"ECR_EXTENSION","LoanCardID"},			
		{"ECR_GUARANTEEBILL","LoanCardID"},		//保函
		{"ECR_FACTORING","LoanCardID"},		//保理业务
		{"ECR_FLOORFUND","LoanCardID"},		//垫款业务
		{"ECR_CUSTOMERCREDIT","LoanCardID"},		//公开授信
		{"ECR_FINANCEINFO","LoanCardID"},			//贸易融资	
		{"ECR_FINADUEBILL","LoanCardID"},			
		{"ECR_FINANCERETURN","LoanCardID"},		
		{"ECR_FINAEXTENSION","LoanCardID"},		
		{"ECR_DISCOUNT","LoanCardID"},		//票据贴现
		{"ECR_INTERESTDUE","LoanCardID"},		//欠息
		{"ECR_CREDITLETTER","LoanCardID"},		//信用证业务
		{"ECR_ACCEPTANCE","LoanCardID"},		//承兑汇票业务
		{"ECR_ASSURECONT","LoanCardID"},		//保证合同
		{"ECR_GUARANTYCONT","LoanCardID"},		//抵押合同
		{"ECR_GUARANTYINFO","LoanCardID"},
		{"ECR_IMPAWNCONT","LoanCardID"},		//质押合同
		{"ECR_IMPAWNINFO","LoanCardID"},
		{"ECR_CUSTOMERCREDIT","LoanCardID"},		//公开授信
		//备份表
		{"ECR_R01SB","B7503"},
		{"ECR_R02SB","B7503"},
		{"ECR_R03SB","B7503"},
		{"ECR_R04SB","B7503"},
		{"ECR_R05SB","B7503"},
		{"ECR_R06SB","B7503"},
		{"ECR_R07SB","B7503"},
		{"ECR_R08SB","B7503"},
		{"ECR_R09SB","B7503"},
		{"ECR_R10SB","B7503"},
		{"ECR_R11SB","B7503"},
		{"ECR_R14SB","B7503"},
		{"ECR_R15SB","B7503"},
		{"ECR_R16SB","B7503"},
		{"ECR_R17SB","B7503"},
		{"ECR_R22SB","B7503"},
		{"ECR_R23SB","B7503"},
		{"ECR_R24SB","B7503"},
		{"ECR_R26SB","B7503"}
	};
	protected String tablesbak[][]={	
			//备份表
		{"ECR_R12SB","ECR_R12SD"},
		{"ECR_R13SB","ECR_R13SD"},
		{"ECR_R18SB","ECR_R18SD"},
		{"ECR_R19SB","ECR_R19SD"},
		{"ECR_R20SB","ECR_R20SD"},
		{"ECR_R21SB","ECR_R21SD"},
		{"ECR_R25SB","ECR_R25SD"}
	};
		
	public int execute()
		   {
			String sqlSelect="select * from ecr_syncerrcard ";
			String newloancardno="";
			String oldloancardno="";
				//初始化，数据库连接和数据文件连接
				try {
					init();
				} catch (ECRException e) {
					logger.fatal("初始化失败",e);
					clearResource();
					return TaskConstants.ES_FAILED;
				}

				try {
					pstmSelect = connection.prepareStatement(sqlSelect);
					ResultSet	rs0 = pstmSelect.executeQuery();
					if (rs0.next()) {
						newloancardno=rs0.getString("newloancarno");
						oldloancardno=rs0.getString("oldloancarno");
						updateTable(newloancardno,oldloancardno);
						updateBakTable(newloancardno,oldloancardno);
						logger.info("loancardno:"+newloancardno);
					} 	
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				clearResource();
				return TaskConstants.ES_SUCCESSFUL;
		   }
   /*
    * 初始化
    */
   protected  void init() throws ECRException
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
   

   private   int updateTable(String newLoancardNo,String oldLoancardNo) throws SQLException{
	   	
//		初始化，数据库连接和数据文件连接

			for(int i=0;i<tables.length;i++){	
					StringBuffer sql = new StringBuffer("");		
					try {
			   	sql.append("update ")
			   .append(tables[i][0])
			   .append(" set ")
			   .append(tables[i][1])
			   .append("='")
			   .append(newLoancardNo)
			   .append("',modflag='2' where ")
			   .append(tables[i][1])
			   .append("='")
			   .append(oldLoancardNo)
			   .append("'");
			   
			   logger.trace(sql.toString());
			   System.out.println(sql.toString());
			   stmt.executeUpdate(sql.toString());
				} catch (SQLException e) {
					logger.fatal("修正错误贷款卡失败！",e);
					clearResource();
					return TaskConstants.ES_FAILED;
				}
		}
		return TaskConstants.ES_SUCCESSFUL;
   }
	private  int updateBakTable(String newLoancardNo,String oldLoancardNo) throws SQLException{
		
//		初始化，数据库连接和数据文件连接

		for(int i=0;i<tablesbak.length;i++){	
			StringBuffer sqlbakcardno = new StringBuffer("");		
			StringBuffer sqlbakmod = new StringBuffer("");	
				try {
		   sqlbakcardno.append("update ")
		   .append(tablesbak[i][1])
		   .append(" set D7503='")
			 .append(newLoancardNo)
		   .append("' where D7503='")
		   .append(oldLoancardNo).append("'");
		   

		   logger.trace(sqlbakcardno.toString());

		   System.out.println(sqlbakmod.toString());
		   stmt.executeUpdate(sqlbakcardno.toString());

		   	sqlbakmod.append("update ")
			   .append(tablesbak[i][0])
			   .append(" set modflag='2'")
			   .append(" where recordkey =(select recordkey from ")
			   .append(tablesbak[i][1])
			   .append(" where ")
			   .append(tablesbak[i][1])
			   .append(".recordkey=")
			   .append(tablesbak[i][0])
			   .append(".recordkey)") 
			   .append("' and D7503='")
			   .append(newLoancardNo).append("'");
			   System.out.println(sqlbakcardno.toString());
			   stmt.executeUpdate(sqlbakmod.toString());
			} catch (SQLException e) {
				logger.fatal("修正备份表错误贷款卡失败！",e);
				clearResource();
				return TaskConstants.ES_FAILED;
			}
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