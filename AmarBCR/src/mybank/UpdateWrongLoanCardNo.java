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
 *    从贷款卡编码变更表中抽取贷款卡变更信息
 *    根据客户号和错误贷款卡编码找出所有错误业务信息,并插入到批量删除表中
 *    根据错误贷款卡编码找出该客户担保的主业务信息，并将其插入到批量删除表中
 *    LoanCardNo_Change为贷款卡变更表,ChangeStatus  I 初始化状态  F 更新失败状态 B 业务更新成功 G 担保更新成功  
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
	
	//表名,删除主合同号,删除业务类型,担保对应的信贷业务种类(N,表示没有担保)
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
    * 初始化
    */
   protected void init() throws ECRException
   {
		//--------------------------------------------------数据库连接初始化
		String database = "ecr";//getProperty(PROPERTY_DATABASE);
		try {
				connection = ARE.getDBConnection(database);
				pstmtSelectGuarantyContract = connection.prepareStatement(sqlSelectGuarantyContract);
				pstmtSelectLoanCardNoChange = connection.prepareStatement(sqlSelectLoanCardNoChange);
				pstmtUpdateCustomerInfo = connection.prepareStatement(sqlUpdateCustomerInfo);
				pstmtSelectHISBatchDelete = connection.prepareStatement(sqlSelectHISBatchDelete);
				stmt = connection.createStatement();
		} catch (SQLException e) {
			throw new ECRException("数据库连接异常："+e);
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
			logger.info("开始获取业务错误贷款卡编码信息...");
			updateBusinessLoanCardNo(); 
			logger.info("开始获取担保错误贷款卡编码信息...");
			updateGuarantyLoanCardNo();
			logger.info("更新任务完成，一共更新了"+iCount+"条数据");
			
		} catch (SQLException e) {
			logger.fatal("更新贷款卡信息失败！",e);
			clearResource();
			return TaskConstants.ES_FAILED;
		}
		
		clearResource();
		return TaskConstants.ES_SUCCESSFUL;
   }
   //跟贷款卡相关的业务信息
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
		   
		   logger.info("开始处理CustomerID为"+customerID+",OldLoanCardNo为"+oldLoanCardNo+",NewLoanCardNo为"+newLoanCardNo);
		   
		   //先校验新的贷款卡编码是否符合规则,如果不符合直接跳过
		   if(newLoanCardNo.equals("") || newLoanCardNo.length()!=16 ||!DKKChecker.checkDKK(newLoanCardNo.getBytes()))
		   {
			   logger.debug("CustomerID为"+customerID+",NewLoanCardNo为"+newLoanCardNo+",不符合人行规则");
			   continue;
		   }
		   //新旧贷款卡编码相同,没有更新的必要
		   if(newLoanCardNo.equals(oldLoanCardNo))
		   {
			   logger.debug("CustomerID为"+customerID+",NewLoanCardNo为"+newLoanCardNo+",新旧贷款卡编码相同,没有更新的必要");
			   continue;
		   }
		   //查询新贷款卡编码是否已经被占用,如果已经被占用,警告！不让一个贷款卡编码对应两个CustomerID的情况发生
		   
		   
		   //符合规则，先更新客户信息表
		   pstmtUpdateCustomerInfo.setString(1, newLoanCardNo);
		   pstmtUpdateCustomerInfo.setString(2,customerID);
		   pstmtUpdateCustomerInfo.execute();
		   
		   //接着根据CustomerID,构造批量删除报文
		   String sSql = "";
		   for(int i = 0;i<tables.length;i++)
		   {
				sSql =  " Insert Into HIS_BATCHDELETE (OccurDate,ContractNo,BusinessType,LoanCardNo,FinanceID,IncrementFlag,RecordFlag,SessionID)"+
				 		" Select '"+yesterday+"',"+tables[i][1]+",'"+tables[i][2]+"',LoanCardNo,FinanceID,'1','40','0000000000' FROM "+tables[i][0]+
				 		" where CustomerID='"+customerID+"'";
				logger.debug("插入借款人贷款卡编码错误对应的主业务信息错误:"+sSql);
				stmt.execute(sSql);
		   }
	   }
	   rs.close();
   }
   //跟贷款卡相关的担保信息
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
		   
		   //校验旧的贷款卡编码是否符合规则，如果不符合直接跳过，否则根据担保人的贷款卡查询出主业务，并将其插入批量删除表
		   if(oldLoanCardNo.equals("") || oldLoanCardNo.length()!=16 ||!DKKChecker.checkDKK(oldLoanCardNo.getBytes()))
		   {
			   logger.debug("CustomerID为"+customerID+",oldLoanCardNo"+oldLoanCardNo+",不符合人行规则");
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
					   logger.debug("插入担保人贷款卡编码错误对应的主业务信息错误:"+sSql);
					   stmt.execute(sSql);
				   }
			   }
		   }
		   rs1.close();
	   }
	   rs.close();
   }  
	
	/**
	 * 清理和释放运行过程中打开的资源，数据库连接、文件连接等
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