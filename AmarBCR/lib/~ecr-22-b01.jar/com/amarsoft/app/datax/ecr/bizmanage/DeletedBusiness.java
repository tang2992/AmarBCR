// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DeletedBusiness.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.DeleteBusinessTypeDBReflector;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class DeletedBusiness
{

	private String financeID;
	private String contractNo;
	private String loanCardNo;
	private String businessType;
	private String occurDate;
	private String database;
	private Log logger;

	public DeletedBusiness()
	{
		financeID = null;
		contractNo = null;
		loanCardNo = null;
		businessType = null;
		occurDate = null;
		database = "ecr";
		logger = ARE.getLog();
	}

	public DeletedBusiness(String financeID, String contractNo, String loanCardNo, String businessType, String occurDate)
	{
		this.financeID = null;
		this.contractNo = null;
		this.loanCardNo = null;
		this.businessType = null;
		this.occurDate = null;
		database = "ecr";
		logger = ARE.getLog();
		this.financeID = financeID;
		this.contractNo = contractNo;
		this.loanCardNo = loanCardNo;
		this.businessType = businessType;
		this.occurDate = occurDate;
	}

	public int purgeData()
		throws ECRException
	{
		Connection conn = null;
		int deleteCount = 0;
		try
		{
			conn = ARE.getDBConnection(database);
			conn.setAutoCommit(false);
		}
		catch (SQLException ex)
		{
			throw new ECRException(ex);
		}
		try
		{
			Statement stmt = conn.createStatement();
			DeleteBusinessTypeDBReflector rf = DeleteBusinessTypeDBReflector.getReflector(businessType);
			if (businessType.equals("10"))
				deleteCount += deleteData(stmt, rf.getMainTable(), (new StringBuilder(" where (LoanCardNo='")).append(loanCardNo).append("' and FinanceID='").append(financeID).append("')").toString());
			else
			if (businessType.equals("01"))
			{
				String where = (new StringBuilder(" where (LDuebillNo in(select LDuebillNo from ECR_LOANDUEBILL where LContractNo='")).append(contractNo).append("'))").toString();
				deleteCount += deleteData(stmt, "LOANRETURN", where);
				deleteCount += deleteData(stmt, "LOANEXTENSION", where);
				deleteCount += deleteData(stmt, "LOANDUEBILL", (new StringBuilder(" where (LContractNo='")).append(contractNo).append("')").toString());
				deleteCount += deleteData(stmt, rf.getMainTable(), (new StringBuilder(" where (LContractNo='")).append(contractNo).append("')").toString());
				deleteCount += deleteGuaranty(stmt);
			} else
			if (businessType.equals("04"))
			{
				String where = (new StringBuilder(" where (FDuebillNo in(select FDuebillNo from ECR_FINADUEBILL where FContractNo='")).append(contractNo).append("'))").toString();
				deleteCount += deleteData(stmt, "FINARETURN", where);
				deleteCount += deleteData(stmt, "FINAEXTENSION", where);
				deleteCount += deleteData(stmt, "FINADUEBILL", (new StringBuilder(" where (FContractNo='")).append(contractNo).append("')").toString());
				deleteCount += deleteData(stmt, rf.getMainTable(), (new StringBuilder(" where (FContractNo='")).append(contractNo).append("')").toString());
				deleteCount += deleteGuaranty(stmt);
			} else
			if (businessType.equals("09"))
			{
				deleteCount += deleteData(stmt, rf.getMainTable(), (new StringBuilder(" where (FloorFundNo='")).append(contractNo).append("')").toString());
			} else
			{
				String s[] = rf.getRelativeTables();
				for (int i = 0; i < s.length; i++)
					deleteCount += deleteData(stmt, s[i], (new StringBuilder(" where (")).append(rf.getContactNoColumn()).append("'").append(contractNo).append("')").toString());

				deleteCount += deleteData(stmt, rf.getMainTable(), (new StringBuilder(" where (")).append(rf.getContactNoColumn()).append("='").append(contractNo).append("')").toString());
				deleteCount += deleteGuaranty(stmt);
			}
			deleteFeedBack(stmt);
			conn.commit();
			stmt.close();
			conn.close();
		}
		catch (SQLException ex)
		{
			throw new ECRException("删除数据数据库错误！", ex);
		}
		return deleteCount;
	}

	private void deleteFeedBack(Statement stmt)
		throws SQLException
	{
		String type = null;
		if (businessType.equals("01"))
			type = "'8','9','10','11','22','23','24'";
		else
		if (businessType.equals("02"))
			type = "'12','22','23','24'";
		else
		if (businessType.equals("03"))
			type = "'13'";
		else
		if (businessType.equals("04"))
			type = "'14','15','16','17','22','23','24'";
		else
		if (businessType.equals("05"))
			type = "'18','22','23','24'";
		else
		if (businessType.equals("06"))
			type = "'19','22','23','24'";
		else
		if (businessType.equals("07"))
			type = "'20','22','23','24'";
		else
		if (businessType.equals("08"))
			type = "'21'";
		else
		if (businessType.equals("09"))
			type = "'25'";
		else
		if (businessType.equals("10"))
			type = "'26'";
		String sql = (new StringBuilder("delete from ECR_FEEDBACK where MainBusinessNo='")).append(contractNo).append("' and FinanceID='").append(financeID).append("' and Recordtype in (").append(type).append(") and LoanCardNo='").append(loanCardNo).append("'").toString();
		logger.debug((new StringBuilder("Purge Sql: ")).append(sql).toString());
		stmt.executeUpdate(sql);
	}

	private int deleteGuaranty(Statement stmt)
		throws SQLException
	{
		int x = 0;
		String creditBusinessType = getCreditBusinessType(businessType);
		x += deleteData(stmt, "ASSURECONT", (new StringBuilder(" where (ContractNo='")).append(contractNo).append("' and BusinessType='").append(creditBusinessType).append("')").toString());
		x += deleteData(stmt, "GUARANTYCONT", (new StringBuilder(" where (ContractNo='")).append(contractNo).append("' and BusinessType='").append(creditBusinessType).append("')").toString());
		x += deleteData(stmt, "IMPAWNCONT", (new StringBuilder(" where (ContractNo='")).append(contractNo).append("' and BusinessType='").append(creditBusinessType).append("')").toString());
		return x;
	}

	private int deleteData(Statement stmt, String table, String where)
		throws SQLException
	{
		String sql = (new StringBuilder("delete from HIS_")).append(table).append(where).append(" and (OccurDate<='").append(occurDate).append("')").toString();
		logger.debug((new StringBuilder("Purge Sql: ")).append(sql).toString());
		int x = stmt.executeUpdate(sql);
		sql = (new StringBuilder("delete from ECR_")).append(table).append(where).append(" and (OccurDate<='").append(occurDate).append("')").toString();
		logger.debug((new StringBuilder("Purge Sql: ")).append(sql).toString());
		x += stmt.executeUpdate(sql);
		return x;
	}

	public String getBusinessType()
	{
		return businessType;
	}

	public void setBusinessType(String businessType)
	{
		this.businessType = businessType;
	}

	public String getCreditBusinessType(String deleteBusinessType)
	{
		String creditBusinessType = null;
		if (deleteBusinessType.equals("01"))
			creditBusinessType = "1";
		else
		if (deleteBusinessType.equals("02"))
			creditBusinessType = "2";
		else
		if (deleteBusinessType.equals("03"))
			creditBusinessType = "3";
		else
		if (deleteBusinessType.equals("04"))
			creditBusinessType = "4";
		else
		if (deleteBusinessType.equals("05"))
			creditBusinessType = "5";
		else
		if (deleteBusinessType.equals("06"))
			creditBusinessType = "6";
		else
		if (deleteBusinessType.equals("07"))
			creditBusinessType = "7";
		else
		if (deleteBusinessType.equals("08"))
			creditBusinessType = "8";
		else
			creditBusinessType = null;
		return creditBusinessType;
	}

	public String getContractNo()
	{
		return contractNo;
	}

	public void setContractNo(String contractNo)
	{
		this.contractNo = contractNo;
	}

	public String getFinanceID()
	{
		return financeID;
	}

	public void setFinanceID(String financeID)
	{
		this.financeID = financeID;
	}

	public String getLoanCardNo()
	{
		return loanCardNo;
	}

	public void setLoanCardNo(String loanCardNo)
	{
		this.loanCardNo = loanCardNo;
	}

	public String getOccurDate()
	{
		return occurDate;
	}

	public void setOccurDate(String occurDate)
	{
		this.occurDate = occurDate;
	}

	public String getDatabase()
	{
		return database;
	}

	public void setDatabase(String database)
	{
		this.database = database;
	}
}
