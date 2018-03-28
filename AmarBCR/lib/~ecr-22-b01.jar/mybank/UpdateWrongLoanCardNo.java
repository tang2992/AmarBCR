// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   UpdateWrongLoanCardNo.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.app.datax.ecr.validate.validator.DKKChecker;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class UpdateWrongLoanCardNo extends ExecuteUnit
{

	protected Connection connection;
	private PreparedStatement pstmtSelectGuarantyContract;
	private PreparedStatement pstmtSelectLoanCardNoChange;
	private PreparedStatement pstmtUpdateCustomerInfo;
	private PreparedStatement pstmtSelectHISBatchDelete;
	private Statement stmt;
	private String sqlSelectGuarantyContract;
	private String sqlSelectLoanCardNoChange;
	private String sqlUpdateCustomerInfo;
	private String sqlSelectHISBatchDelete;
	private String customerID;
	private String oldLoanCardNo;
	private String newLoanCardNo;
	private String yesterday;
	private int iCount;
	private String tables[][] = {
		{
			"ECR_LOANCONTRACT", "LCONTRACTNO", "01", "1"
		}, {
			"ECR_FACTORING", "FACTORINGNO", "02", "2"
		}, {
			"ECR_DISCOUNT", "BILLNO", "03", "3"
		}, {
			"ECR_FINAINFO", "FCONTRACTNO", "04", "4"
		}, {
			"ECR_CREDITLETTER", "CREDITLETTERNO", "05", "5"
		}, {
			"ECR_GUARANTEEBILL", "GUARANTEEBILLNO", "06", "6"
		}, {
			"ECR_ACCEPTANCE", "ACCEPTNO", "07", "7"
		}, {
			"ECR_CUSTOMERCREDIT", "CCONTRACTNO", "08", "8"
		}, {
			"ECR_FLOORFUND", "FLOORFUNDNO", "09", "N"
		}, {
			"ECR_INTERESTDUE", "LOANCARDNO", "10", "N"
		}
	};

	public UpdateWrongLoanCardNo()
	{
		connection = null;
		pstmtSelectGuarantyContract = null;
		pstmtSelectLoanCardNoChange = null;
		pstmtUpdateCustomerInfo = null;
		pstmtSelectHISBatchDelete = null;
		stmt = null;
		sqlSelectGuarantyContract = " Select distinct ContractNo,BusinessType from ECR_AssureCont where ALoanCardNo=?  union Select distinct ContractNo,BusinessType from ECR_GuarantyCont where GLoanCardNo=?  union Select distinct ContractNo,BusinessType from ECR_ImpawnCont where ILoanCardNo=? ";
		sqlSelectLoanCardNoChange = " Select CustomerID,OldLoanCardNo,NewLoanCardNo FROM LoanCardNo_Change where ChangeDate=?";
		sqlUpdateCustomerInfo = " Update ECR_CustomerInfo set LoanCardNo=? where CustomerID=?";
		sqlSelectHISBatchDelete = " Select Count(*) from HIS_BATCHDELETE where OccurDate=? and ContractNo=? and BusinessType=?";
		customerID = "";
		oldLoanCardNo = "";
		newLoanCardNo = "";
		yesterday = Tools.getLastDay("1");
		iCount = 0;
	}

	protected void init()
		throws ECRException
	{
		String database = "ecr";
		try
		{
			connection = ARE.getDBConnection(database);
			pstmtSelectGuarantyContract = connection.prepareStatement(sqlSelectGuarantyContract);
			pstmtSelectLoanCardNoChange = connection.prepareStatement(sqlSelectLoanCardNoChange);
			pstmtUpdateCustomerInfo = connection.prepareStatement(sqlUpdateCustomerInfo);
			pstmtSelectHISBatchDelete = connection.prepareStatement(sqlSelectHISBatchDelete);
			stmt = connection.createStatement();
		}
		catch (SQLException e)
		{
			throw new ECRException((new StringBuilder("���ݿ������쳣��")).append(e).toString());
		}
	}

	public int execute()
	{
		try
		{
			init();
		}
		catch (ECRException e)
		{
			logger.fatal("��ʼ��ʧ��", e);
			clearResource();
			return 2;
		}
		try
		{
			logger.info("��ʼ��ȡҵ�������������Ϣ...");
			updateBusinessLoanCardNo();
			logger.info("��ʼ��ȡ����������������Ϣ...");
			updateGuarantyLoanCardNo();
			logger.info((new StringBuilder("����������ɣ�һ��������")).append(iCount).append("������").toString());
		}
		catch (SQLException e)
		{
			logger.fatal("���´����Ϣʧ�ܣ�", e);
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void updateBusinessLoanCardNo()
		throws SQLException
	{
		pstmtSelectLoanCardNoChange.setString(1, "2008/05/13");
		ResultSet rs;
		for (rs = pstmtSelectLoanCardNoChange.executeQuery(); rs.next();)
		{
			customerID = rs.getString("CustomerID");
			oldLoanCardNo = rs.getString("OldLoanCardNo");
			newLoanCardNo = rs.getString("NewLoanCardNo");
			if (customerID == null)
				customerID = "";
			if (oldLoanCardNo == null)
				oldLoanCardNo = "";
			if (newLoanCardNo == null)
				newLoanCardNo = "";
			iCount++;
			logger.info((new StringBuilder("��ʼ����CustomerIDΪ")).append(customerID).append(",OldLoanCardNoΪ").append(oldLoanCardNo).append(",NewLoanCardNoΪ").append(newLoanCardNo).toString());
			if (newLoanCardNo.equals("") || newLoanCardNo.length() != 16 || !DKKChecker.checkDKK(newLoanCardNo.getBytes()))
				logger.debug((new StringBuilder("CustomerIDΪ")).append(customerID).append(",NewLoanCardNoΪ").append(newLoanCardNo).append(",���������й���").toString());
			else
			if (newLoanCardNo.equals(oldLoanCardNo))
			{
				logger.debug((new StringBuilder("CustomerIDΪ")).append(customerID).append(",NewLoanCardNoΪ").append(newLoanCardNo).append(",�¾ɴ��������ͬ,û�и��µı�Ҫ").toString());
			} else
			{
				pstmtUpdateCustomerInfo.setString(1, newLoanCardNo);
				pstmtUpdateCustomerInfo.setString(2, customerID);
				pstmtUpdateCustomerInfo.execute();
				String sSql = "";
				for (int i = 0; i < tables.length; i++)
				{
					sSql = (new StringBuilder(" Insert Into HIS_BATCHDELETE (OccurDate,ContractNo,BusinessType,LoanCardNo,FinanceID,IncrementFlag,RecordFlag,SessionID) Select '")).append(yesterday).append("',").append(tables[i][1]).append(",'").append(tables[i][2]).append("',LoanCardNo,FinanceID,'1','40','0000000000' FROM ").append(tables[i][0]).append(" where CustomerID='").append(customerID).append("'").toString();
					logger.debug((new StringBuilder("�������˴����������Ӧ����ҵ����Ϣ����:")).append(sSql).toString());
					stmt.execute(sSql);
				}

			}
		}

		rs.close();
	}

	private void updateGuarantyLoanCardNo()
		throws SQLException
	{
		pstmtSelectLoanCardNoChange.setString(1, "2008/05/13");
		ResultSet rs;
		for (rs = pstmtSelectLoanCardNoChange.executeQuery(); rs.next();)
		{
			customerID = rs.getString("CustomerID");
			oldLoanCardNo = rs.getString("OldLoanCardNo");
			newLoanCardNo = rs.getString("NewLoanCardNo");
			if (customerID == null)
				customerID = "";
			if (oldLoanCardNo == null)
				oldLoanCardNo = "";
			if (newLoanCardNo == null)
				newLoanCardNo = "";
			if (oldLoanCardNo.equals("") || oldLoanCardNo.length() != 16 || !DKKChecker.checkDKK(oldLoanCardNo.getBytes()))
			{
				logger.debug((new StringBuilder("CustomerIDΪ")).append(customerID).append(",oldLoanCardNo").append(oldLoanCardNo).append(",���������й���").toString());
			} else
			{
				pstmtSelectGuarantyContract.setString(1, oldLoanCardNo);
				pstmtSelectGuarantyContract.setString(2, oldLoanCardNo);
				pstmtSelectGuarantyContract.setString(3, oldLoanCardNo);
				ResultSet rs1;
				for (rs1 = pstmtSelectGuarantyContract.executeQuery(); rs1.next();)
				{
					String contractNo = rs1.getString("ContractNo");
					String businessType = rs1.getString("BusinessType");
					if (businessType == null)
						businessType = "";
					pstmtSelectHISBatchDelete.setString(1, yesterday);
					pstmtSelectHISBatchDelete.setString(2, contractNo);
					pstmtSelectHISBatchDelete.setString(3, businessType);
					int i = 0;
					ResultSet rs2 = pstmtSelectHISBatchDelete.executeQuery();
					if (rs2.next())
						i = rs2.getInt(1);
					rs2.close();
					if (i != 0)
					{
						String sSql = "";
						for (int j = 0; j < tables.length; j++)
							if (businessType.equals(tables[j][3]))
							{
								sSql = (new StringBuilder(" Insert Into HIS_BATCHDELETE (OccurDate,ContractNo,BusinessType,LoanCardNo,FinanceID,IncrementFlag,RecordFlag,SessionID) Select '")).append(yesterday).append("',").append(tables[j][1]).append(",'").append(tables[j][2]).append("',LoanCardNo,FinanceID,'1','40','0000000000' FROM ").append(tables[j][0]).append(" where ").append(tables[j][1]).append("='").append(contractNo).append("'").toString();
								logger.debug((new StringBuilder("���뵣���˴����������Ӧ����ҵ����Ϣ����:")).append(sSql).toString());
								stmt.execute(sSql);
							}

					}
				}

				rs1.close();
			}
		}

		rs.close();
	}

	private void clearResource()
	{
		if (pstmtSelectGuarantyContract != null)
		{
			try
			{
				pstmtSelectGuarantyContract.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtSelectGuarantyContract = null;
		}
		if (pstmtSelectLoanCardNoChange != null)
		{
			try
			{
				pstmtSelectLoanCardNoChange.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtSelectLoanCardNoChange = null;
		}
		if (pstmtUpdateCustomerInfo != null)
		{
			try
			{
				pstmtUpdateCustomerInfo.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtUpdateCustomerInfo = null;
		}
		if (pstmtSelectHISBatchDelete != null)
		{
			try
			{
				pstmtSelectHISBatchDelete.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			pstmtSelectHISBatchDelete = null;
		}
		if (stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			stmt = null;
		}
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			connection = null;
		}
	}
}
