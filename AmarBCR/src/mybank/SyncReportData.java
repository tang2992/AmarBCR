/***********************************************************************
 * Module:  SyncReportDate.java
 * Author:  gdding
 * Modified: 
 * Purpose: Defines the Class SycnReportData.java 同步当期报表数据
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
 *    同步当期报表数据
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
			{"CUSTOMERINFO","1","01"}, //客户概况表
			{"CUSTCAPIINFO","1","02"}, //客户资本构成表
			{"CUSTOMERLAW","1","06"}, //客户涉诉表
			{"CUSTOMERFACT","1","07"}, //客户大事记表
			{"LOANCONTRACT","businesssum","08"},  //客户贷款业务合同信息表
			{"LOANDUEBILL","balance","09"},  //客户贷款借据信息表
			{"LOANRETURN","returnsum","10"},  //客户贷款业务还款信息表
			{"LOANEXTENSION","extensum","11"},  //客户贷款业务展期信息表
			{"FACTORING","Balance","12"},  //客户保理业务信息表
			{"DISCOUNT","discountsum","13"},  //客户票据贴现业务信息表
			{"FINAINFO","businesssum","14"},  //客户贸易融资业务合同信息表
			{"FINADUEBILL","balance","15"},  //客户贸易融资业务借据信息表
			{"FINARETURN","returnsum","16"},  //客户贸易融资业务还款信息表
			{"FINAEXTENSION","extensum","17"},  //客户贸易融资业务展期信息表
			{"CREDITLETTER","balance","18"},  //客户信用证业务信息表
			{"GUARANTEEBILL","GuaranteeSum","19"},  //客户保函业务信息表
			{"ACCEPTANCE","AccepSum","20"},  //客户银行承兑汇票业务信息表
			{"CUSTOMERCREDIT","CreditLimit","21"},  //客户公开授信信息表
			{"ASSURECONT","AssureSum","22"},  //客户业务保证合同信息表
			{"GUARANTYCONT","GuarantySum","23"},  //客户业务抵押合同信息表
			{"IMPAWNCONT","ImpawnSum","24"},  //客户业务质押合同信息表
			{"FLOORFUND","FloorBalance","25"},  //客户垫款信息表
			{"INTERESTDUE","InterestBalance","26"}  //客户欠息信息表
			};
	
	
	public SyncReportData(){
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
		} catch (SQLException e) {
			logger.debug("得到数据库连接时发生错误:",e);
			throw new ECRException("得到数据库连接时发生错误!",e);
		}
   }
   
   
   /*
    * 插入数据表ecr_amoutreport
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
	   for (int i = 0; i < allTables.length; i++) { // 若增加表，则相应的改变30
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
				//删除表中已有数据
				ptmtdel.setString(1,sSessionid);
				ptmtdel.executeUpdate();
				//总数
				ResultSet rs1 = pstmAmountno.executeQuery();
				if(rs1.next()){
					sAmountNo=rs1.getString(1);
				}
				//总余额
				ResultSet rs2 = pstmAmountsum.executeQuery();
				if(rs2.next()){
					AmountSum = rs2.getDouble(1);
				}
				//新增总数
				pstmNAmountno.setString(1,sSessionid);
				ResultSet rs3 = pstmNAmountno.executeQuery();
				if(rs3.next()){
					sNAmountNo = rs3.getString(1);
				}
				//新增总余额
				pstmNAmountsum.setString(1,sSessionid);
				ResultSet rs4 = pstmNAmountsum.executeQuery();
				if(rs4.next()){
					NAmountSum =  rs4.getDouble(1);
				}
				//变更数
				pstmCAmountno.setString(1,sSessionid);
				ResultSet rs5 = pstmCAmountno.executeQuery();
				if(rs5.next()){
					sCAmountNo =  rs5.getString(1);
				}
				//变更总余额
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
				logger.debug("插入数据表ecr_amoutreport出错！", e);
			}
			  
	   }
	}
  
   
   public int execute()
   {
	//初始化，数据库连接和数据文件连接
	  try {
			init();			
			InsertReport();
		} catch (ECRException e) {
			logger.fatal("插入报表数据出错！"+e.getMessage());
			return TaskConstants.ES_FAILED;
		}
		clearResource();
		logger.info("插入报表数据完成！");
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