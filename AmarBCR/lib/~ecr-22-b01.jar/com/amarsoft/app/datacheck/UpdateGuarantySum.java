// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   UpdateGuarantySum.java

package com.amarsoft.app.datacheck;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class UpdateGuarantySum extends ExecuteUnit
{

	protected Connection connection;
	private PreparedStatement psUpdateDataCheck;
	private PreparedStatement psSelectDataCheck;
	private PreparedStatement psSelectAssureCont;
	private PreparedStatement psSelectGuarantyCont;
	private PreparedStatement psSelectImpawnCont;
	private PreparedStatement psUpdateDataCheck1;
	private PreparedStatement psSelectDataCheck1;
	private PreparedStatement psSelectAssureCont1;
	private PreparedStatement psSelectGuarantyCont1;
	private PreparedStatement psSelectImpawnCont1;
	private String sqlSelectDataCheck;
	private String sqlUpdateDataCheck;
	private String sqlSelectAssureCont;
	private String sqlSelectGuarantyCont;
	private String sqlSelectImpawnCont;
	private String sqlSelectDataCheck1;
	private String sqlUpdateDataCheck1;
	private String sqlSelectAssureCont1;
	private String sqlSelectGuarantyCont1;
	private String sqlSelectImpawnCont1;
	private String loanCardNo;
	private String CertType;
	private String CertID;

	public UpdateGuarantySum()
	{
		connection = null;
		psUpdateDataCheck = null;
		psSelectDataCheck = null;
		psSelectAssureCont = null;
		psSelectGuarantyCont = null;
		psSelectImpawnCont = null;
		psUpdateDataCheck1 = null;
		psSelectDataCheck1 = null;
		psSelectAssureCont1 = null;
		psSelectGuarantyCont1 = null;
		psSelectImpawnCont1 = null;
		sqlSelectDataCheck = " SELECT LoanCardNo from ECR_AlsDataCheck where (ImpawnContNum>0 or GuarantyContNum>0 or AssureContNum>0) and length(LoancardNo)=16";
		sqlUpdateDataCheck = " Update ECR_AlsDataCheck set AssureContOutSum=?,AssureContBalance=?, GuarantyContOutSum=?,GuarantyContBalance=?, ImpawnContOutSum=?,ImpawnContBalance=?  where LoanCardNo=?";
		sqlSelectAssureCont = "Select distinct AssureContNo,AssureSum from bank_assurecont where Aloancardno=? and AVAILABSTATUS =?";
		sqlSelectGuarantyCont = "Select GuarantyContNo,GuarantySerialNo,GuarantySum from bank_GuarantyCont where GLoanCardNo=? and AVAILABSTATUS =? group by GuarantyContNo,GuarantySerialNo,GuarantySum";
		sqlSelectImpawnCont = "Select ImpawnContNo,ImpawSerialNo,ImpawnSum from bank_impawnCont where ILoanCardNo=? and AVAILABSTATUS =? group by ImpawnContNo,ImpawSerialNo,ImpawnSum";
		sqlSelectDataCheck1 = " SELECT LoancardNo,CorpID from ECR_AlsDataCheck1 where (ImpawnContNum>0 or GuarantyContNum>0 or AssureContNum>0) and length(LoancardNO)<>16";
		sqlUpdateDataCheck1 = " Update ECR_AlsDataCheck1 set AssureContOutSum=?,AssureContBalance=?, GuarantyContOutSum=?,GuarantyContBalance=?, ImpawnContOutSum=?,ImpawnContBalance=?  where LoancardNo=? and CorpID=?";
		sqlSelectAssureCont1 = "Select distinct AssureContNo,AssureSum from bank_assurecont where CertType=? and CertID=? and AVAILABSTATUS =?";
		sqlSelectGuarantyCont1 = "Select GuarantyContNo,GuarantySerialNo,GuarantySum from bank_GuarantyCont where CertType=? and CertID=? and AVAILABSTATUS =? group by GuarantyContNo,GuarantySerialNo,GuarantySum";
		sqlSelectImpawnCont1 = "Select ImpawnContNo,ImpawSerialNo,ImpawnSum from bank_impawnCont where CertType=? and CertID=? and AVAILABSTATUS =? group by ImpawnContNo,ImpawSerialNo,ImpawnSum";
		loanCardNo = "";
		CertType = "";
		CertID = "";
	}

	protected void init()
		throws Exception
	{
		String database = getProperty("unit.database", "ecr");
		try
		{
			connection = ARE.getDBConnection(database);
			psSelectDataCheck = connection.prepareStatement(sqlSelectDataCheck);
			psUpdateDataCheck = connection.prepareStatement(sqlUpdateDataCheck);
			psSelectAssureCont = connection.prepareStatement(sqlSelectAssureCont);
			psSelectGuarantyCont = connection.prepareStatement(sqlSelectGuarantyCont);
			psSelectImpawnCont = connection.prepareStatement(sqlSelectImpawnCont);
			psSelectDataCheck1 = connection.prepareStatement(sqlSelectDataCheck1);
			psUpdateDataCheck1 = connection.prepareStatement(sqlUpdateDataCheck1);
			psSelectAssureCont1 = connection.prepareStatement(sqlSelectAssureCont1);
			psSelectGuarantyCont1 = connection.prepareStatement(sqlSelectGuarantyCont1);
			psSelectImpawnCont1 = connection.prepareStatement(sqlSelectImpawnCont1);
		}
		catch (SQLException e)
		{
			throw new Exception(e);
		}
	}

	public int execute()
	{
		try
		{
			init();
		}
		catch (Exception e)
		{
			logger.fatal("初始化失败", e);
			clearResource();
			return 2;
		}
		try
		{
			logger.info("开始计算企业担保发生额和余额信息");
			ResultSet rs;
			for (rs = psSelectDataCheck.executeQuery(); rs.next(); psUpdateDataCheck.execute())
			{
				loanCardNo = rs.getString("LoanCardNo");
				if (loanCardNo == null)
					loanCardNo = "";
				double assureSum = 0.0D;
				double guarantySum = 0.0D;
				double impawnSum = 0.0D;
				psSelectAssureCont.setString(1, loanCardNo);
				psSelectAssureCont.setString(2, "1");
				ResultSet rs1;
				for (rs1 = psSelectAssureCont.executeQuery(); rs1.next();)
					assureSum += rs1.getDouble(2);

				rs1.close();
				psSelectGuarantyCont.setString(1, loanCardNo);
				psSelectGuarantyCont.setString(2, "1");
				for (rs1 = psSelectGuarantyCont.executeQuery(); rs1.next();)
					guarantySum += rs1.getDouble(3);

				rs1.close();
				psSelectImpawnCont.setString(1, loanCardNo);
				psSelectImpawnCont.setString(2, "1");
				for (rs1 = psSelectImpawnCont.executeQuery(); rs1.next();)
					impawnSum += rs1.getDouble(3);

				rs1.close();
				logger.trace((new StringBuilder("LoanCardNo=")).append(loanCardNo).append("|CertType=").append(CertType).append("|CertID=").append(CertID).append("|AssureSum=").append(assureSum).append("|GuarantySum=").append(guarantySum).append("|ImpawnSum=").append(impawnSum).toString());
				psUpdateDataCheck.setDouble(1, assureSum);
				psUpdateDataCheck.setDouble(2, assureSum);
				psUpdateDataCheck.setDouble(3, guarantySum);
				psUpdateDataCheck.setDouble(4, guarantySum);
				psUpdateDataCheck.setDouble(5, impawnSum);
				psUpdateDataCheck.setDouble(6, impawnSum);
				psUpdateDataCheck.setString(7, loanCardNo);
			}

			logger.info("开始计算自然人担保发生额和余额信息");
			ResultSet rs2;
			for (rs2 = psSelectDataCheck1.executeQuery(); rs2.next(); psUpdateDataCheck1.execute())
			{
				CertType = rs2.getString("LoanCardNo");
				CertID = rs2.getString("CorpID");
				if (CertType == null)
					CertType = "";
				if (CertID == null)
					CertID = "";
				double assureSum = 0.0D;
				double guarantySum = 0.0D;
				double impawnSum = 0.0D;
				psSelectAssureCont1.setString(1, CertType);
				psSelectAssureCont1.setString(2, CertID);
				psSelectAssureCont1.setString(3, "1");
				ResultSet rs3;
				for (rs3 = psSelectAssureCont1.executeQuery(); rs3.next();)
					assureSum += rs3.getDouble(2);

				rs3.close();
				psSelectGuarantyCont1.setString(1, CertType);
				psSelectGuarantyCont1.setString(2, CertID);
				psSelectGuarantyCont1.setString(3, "1");
				for (rs3 = psSelectGuarantyCont1.executeQuery(); rs3.next();)
					guarantySum += rs3.getDouble(3);

				rs3.close();
				psSelectImpawnCont1.setString(1, CertType);
				psSelectImpawnCont1.setString(2, CertID);
				psSelectImpawnCont1.setString(3, "1");
				for (rs3 = psSelectImpawnCont1.executeQuery(); rs3.next();)
					impawnSum += rs3.getDouble(3);

				rs3.close();
				logger.trace((new StringBuilder("CertType=")).append(CertType).append("|CertID=").append(CertID).append("|AssureSum=").append(assureSum).append("|GuarantySum=").append(guarantySum).append("|ImpawnSum=").append(impawnSum).toString());
				psUpdateDataCheck1.setDouble(1, assureSum);
				psUpdateDataCheck1.setDouble(2, assureSum);
				psUpdateDataCheck1.setDouble(3, guarantySum);
				psUpdateDataCheck1.setDouble(4, guarantySum);
				psUpdateDataCheck1.setDouble(5, impawnSum);
				psUpdateDataCheck1.setDouble(6, impawnSum);
				psUpdateDataCheck1.setString(7, CertType);
				psUpdateDataCheck1.setString(8, CertID);
			}

			rs.close();
			rs2.close();
			clearResource();
		}
		catch (SQLException e)
		{
			logger.fatal("更新担保发生额和余额信息出错！", e);
			clearResource();
			return 2;
		}
		return 1;
	}

	private void clearResource()
	{
		if (psSelectDataCheck != null)
		{
			try
			{
				psSelectDataCheck.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectDataCheck = null;
		}
		if (psUpdateDataCheck != null)
		{
			try
			{
				psUpdateDataCheck.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psUpdateDataCheck = null;
		}
		if (psSelectAssureCont != null)
		{
			try
			{
				psSelectAssureCont.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectAssureCont = null;
		}
		if (psSelectGuarantyCont != null)
		{
			try
			{
				psSelectGuarantyCont.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectGuarantyCont = null;
		}
		if (psSelectImpawnCont != null)
		{
			try
			{
				psSelectImpawnCont.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectImpawnCont = null;
		}
		if (psSelectDataCheck1 != null)
		{
			try
			{
				psSelectDataCheck1.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectDataCheck1 = null;
		}
		if (psUpdateDataCheck1 != null)
		{
			try
			{
				psUpdateDataCheck1.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psUpdateDataCheck1 = null;
		}
		if (psSelectAssureCont1 != null)
		{
			try
			{
				psSelectAssureCont1.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectAssureCont1 = null;
		}
		if (psSelectGuarantyCont1 != null)
		{
			try
			{
				psSelectGuarantyCont1.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectGuarantyCont1 = null;
		}
		if (psSelectImpawnCont1 != null)
		{
			try
			{
				psSelectImpawnCont1.close();
			}
			catch (SQLException e)
			{
				logger.debug(e);
			}
			psSelectImpawnCont1 = null;
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
