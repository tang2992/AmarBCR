// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   LogicChecker.java

package com.amarsoft.app.datax.ecr.validate.validator;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.OrganizeCodeChecker;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.app.datax.ecr.validate.ValidateRule;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.math.BigDecimal;
import java.sql.*;
import java.util.Vector;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate.validator:
//			AbstractFieldChecker, DKKChecker, PersonIDChecker

public class LogicChecker extends AbstractFieldChecker
{

	protected Log logger;
	private Connection connection;
	private Vector stmtList;
	private Vector rsList;

	public LogicChecker(Connection conn)
	{
		logger = ARE.getLog();
		connection = null;
		stmtList = new Vector();
		rsList = new Vector();
		connection = conn;
	}

	public boolean getCheckResult()
	{
label0:
		{
			String checkType;
label1:
			{
				String checkedValue = checkRule.getCheckedValue();
				String dataList = checkRule.getDataList();
				checkType = checkRule.getCheckType();
				if (dataList != null && !checkedValue.equals(dataList))
					break label0;
				try
				{
					if (connection != null && !connection.isClosed())
						break label1;
					logger.warn("数据库连接未打开！");
				}
				catch (SQLException e)
				{
					return false;
				}
				return false;
			}
			return checkResult(checkRule, checkType);
		}
		return true;
	}

	protected void clearResource()
	{
		for (int i = 0; i < stmtList.size(); i++)
		{
			Statement stmt = (Statement)stmtList.get(i);
			closeStatement(stmt);
		}

		for (int i = 0; i < rsList.size(); i++)
		{
			ResultSet rs = (ResultSet)rsList.get(i);
			closeResultSet(rs);
		}

	}

	private void closeStatement(Statement stmt)
	{
		if (stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
			stmt = null;
		}
	}

	private void closeResultSet(ResultSet rs)
	{
		if (rs != null)
		{
			try
			{
				rs.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
			rs = null;
		}
	}

	public boolean checkResult(ValidateRule checkRule, String sCheckType)
	{
		if (sCheckType.equalsIgnoreCase("check3004_1"))
			return check3004_1(checkRule);
		if (sCheckType.equalsIgnoreCase("check3004_2"))
			return check3004_2(checkRule);
		if (sCheckType.equalsIgnoreCase("check3004_4"))
			return check3004_4(checkRule);
		if (sCheckType.equalsIgnoreCase("check3004_5"))
			return check3004_5(checkRule);
		if (sCheckType.equalsIgnoreCase("check3004_6"))
			return check3004_6(checkRule);
		if (sCheckType.equalsIgnoreCase("check3004_7"))
			return check3004_7(checkRule);
		if (sCheckType.equalsIgnoreCase("check3005_1"))
			return check3005_1(checkRule);
		if (sCheckType.equalsIgnoreCase("check3005_2"))
			return check3005_2(checkRule);
		if (sCheckType.equalsIgnoreCase("check3005_4"))
			return check3005_4(checkRule);
		if (sCheckType.equalsIgnoreCase("check3005_5"))
			return check3005_5(checkRule);
		if (sCheckType.equalsIgnoreCase("check3005_6"))
			return check3005_6(checkRule);
		if (sCheckType.equalsIgnoreCase("check3005_7"))
			return check3005_7(checkRule);
		if (sCheckType.equalsIgnoreCase("check3006"))
			return check3006(checkRule);
		if (sCheckType.equalsIgnoreCase("check3008"))
			return check3008(checkRule);
		if (sCheckType.equalsIgnoreCase("check3010"))
			return check3010(checkRule);
		if (sCheckType.equalsIgnoreCase("check3012_1"))
			return check3012_1(checkRule);
		if (sCheckType.equalsIgnoreCase("check3012_2"))
			return check3012_2(checkRule);
		if (sCheckType.equalsIgnoreCase("check4172"))
			return check4172(checkRule);
		if (sCheckType.equalsIgnoreCase("check4212"))
			return check4212(checkRule);
		if (sCheckType.equalsIgnoreCase("check4214"))
			return check4214(checkRule);
		if (sCheckType.equalsIgnoreCase("check4184"))
			return check4184(checkRule);
		if (sCheckType.equalsIgnoreCase("check4188"))
			return check4188(checkRule);
		if (sCheckType.equalsIgnoreCase("check4216"))
			return check4216(checkRule);
		if (sCheckType.equalsIgnoreCase("check4232"))
			return check4232(checkRule);
		if (sCheckType.equalsIgnoreCase("check4186"))
			return check4186(checkRule);
		if (sCheckType.equalsIgnoreCase("check4234"))
			return check4234(checkRule);
		if (sCheckType.equalsIgnoreCase("check4180"))
			return check4180(checkRule);
		if (sCheckType.equalsIgnoreCase("check4183"))
			return check4183(checkRule);
		if (sCheckType.equalsIgnoreCase("check4178"))
			return check4178(checkRule);
		if (sCheckType.equalsIgnoreCase("check4240"))
			return check4240(checkRule);
		if (sCheckType.equalsIgnoreCase("check4242"))
			return check4242(checkRule);
		if (sCheckType.equalsIgnoreCase("check4244"))
			return check4244(checkRule);
		if (sCheckType.equalsIgnoreCase("check4246"))
			return check4246(checkRule);
		if (sCheckType.equalsIgnoreCase("check4248"))
			return check4248(checkRule);
		if (sCheckType.equalsIgnoreCase("check4250"))
			return check4250(checkRule);
		if (sCheckType.equalsIgnoreCase("check4252"))
			return check4252(checkRule);
		if (sCheckType.equalsIgnoreCase("check4274"))
			return check4274(checkRule);
		if (sCheckType.equalsIgnoreCase("check4276"))
			return check4276(checkRule);
		if (sCheckType.equalsIgnoreCase("check4278"))
			return check4278(checkRule);
		if (sCheckType.equalsIgnoreCase("check9038_1"))
			return check9038_1(checkRule);
		if (sCheckType.equalsIgnoreCase("check9038_2"))
			return check9038_2(checkRule);
		if (sCheckType.equalsIgnoreCase("check9038_4"))
			return check9038_4(checkRule);
		if (sCheckType.equalsIgnoreCase("check9038_5"))
			return check9038_5(checkRule);
		if (sCheckType.equalsIgnoreCase("check9038_6"))
			return check9038_6(checkRule);
		if (sCheckType.equalsIgnoreCase("check9038_7"))
			return check9038_7(checkRule);
		if (sCheckType.equalsIgnoreCase("check4038"))
			return check4038(checkRule);
		if (sCheckType.equalsIgnoreCase("check4174"))
			return check4174(checkRule);
		if (sCheckType.equalsIgnoreCase("check4176"))
			return check4176(checkRule);
		if (sCheckType.equalsIgnoreCase("check4236"))
			return check4236(checkRule);
		if (sCheckType.equalsIgnoreCase("check4238"))
			return check4238(checkRule);
		if (sCheckType.equalsIgnoreCase("check9998"))
			return check9998(checkRule);
		if (sCheckType.equalsIgnoreCase("check9999"))
			return check9999(checkRule);
		if (sCheckType.equalsIgnoreCase("check0001"))
			return check0001(checkRule);
		if (sCheckType.equalsIgnoreCase("check4050"))
			return check4050(checkRule);
		if (sCheckType.equalsIgnoreCase("check4060"))
			return check4060(checkRule);
		if (sCheckType.equalsIgnoreCase("check4058"))
			return check4058(checkRule);
		if (sCheckType.equalsIgnoreCase("check1031"))
			return check1031(checkRule);
		else
			return true;
	}

	public boolean check1031(ValidateRule checkRule)
	{
		String sqlStockHodingRatio;
		String sCIFCustomerID;
		sqlStockHodingRatio = "SELECT sum(STOCKHODINGRATIO) as RatioSum FROM ECR_ORGANSTOCKHOLDER where cifcustomerid=? ";
		PreparedStatement psStockHodingRatio = null;
		ResultSet rsStockHodingRatio = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the B segment");
			return false;
		}
		sCIFCustomerID = "";
		try
		{
			sCIFCustomerID = segnebtB[0].getField("CIFCustomerId").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check1031: 获取客户号出错", e);
			return false;
		}
		double sum = 0.0D;
		boolean flag;
		PreparedStatement psStockHodingRatio = connection.prepareStatement(sqlStockHodingRatio);
		psStockHodingRatio.setString(1, sCIFCustomerID);
		ResultSet rsStockHodingRatio = psStockHodingRatio.executeQuery();
		stmtList.add(psStockHodingRatio);
		rsList.add(rsStockHodingRatio);
		if (!rsStockHodingRatio.next())
			break MISSING_BLOCK_LABEL_226;
		double sum = rsStockHodingRatio.getDouble("RatioSum");
		flag = (new BigDecimal(sum)).compareTo(new BigDecimal(100D)) != 1;
		clearResource();
		return flag;
		SQLException e;
		e;
		e.printStackTrace();
		clearResource();
		break MISSING_BLOCK_LABEL_230;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check3004_1(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sContractNo;
		SQLException e;
		sqlAssurecont = "select Contractno from ECR_ASSURECONT where  businesstype='1' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where  gc.businesstype='1' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where ic.businesstype='1' and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtD[] = checkRule.getRecord().getSegments("D");
		if (segnebtD == null || segnebtD.length < 1)
		{
			logger.fatal("can not find the D segment");
			return false;
		}
		String sStatus = "";
		try
		{
			sStatus = segnebtD[0].getField("AvailabStatus").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3004_1: 合同有效状态错", e);
		}
		if (!sStatus.equalsIgnoreCase("1"))
			break MISSING_BLOCK_LABEL_437;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sContractNo = "";
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3004_1: 合同号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sContractNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_271;
_L1:
		clearResource();
		return true;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sContractNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sContractNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_431;
		}
		  goto _L1
		e;
		logger.debug("check3004_1错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return false;
		return true;
	}

	public boolean check3004_2(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sFactoringNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='2' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where   gc.businesstype='2' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where  ic.businesstype='2' and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sFactoringNo = "";
		try
		{
			sFactoringNo = segnebtB[0].getField("FactoringNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3004_2: 保理业务号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sFactoringNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_180;
_L1:
		clearResource();
		return true;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sFactoringNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sFactoringNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_340;
		}
		  goto _L1
		e;
		logger.debug("check3004_2错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return false;
	}

	public boolean check3004_4(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		ResultSet rsAssurecont;
		ResultSet rsGuarantycont;
		ResultSet rsImpawncont;
		String sContractNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='4' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where  gc.businesstype='4' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where ic.businesstype='4'  and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		rsAssurecont = null;
		rsGuarantycont = null;
		rsImpawncont = null;
		Segment segnebtD[] = checkRule.getRecord().getSegments("D");
		if (segnebtD == null || segnebtD.length < 1)
		{
			logger.fatal("can not find the D segment");
			return false;
		}
		String sStatus = "";
		try
		{
			sStatus = segnebtD[0].getField("AvailabStatus").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3004_4: 协议有效状态", e);
			return false;
		}
		if (!sStatus.equalsIgnoreCase("1"))
			break MISSING_BLOCK_LABEL_439;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sContractNo = "";
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3004_4: 融资协议编号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sContractNo);
		rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next()) goto _L2; else goto _L1
_L1:
		clearResource();
		return true;
_L2:
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sContractNo);
		rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next()) goto _L3; else goto _L1
_L3:
		PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
		psImpawncont.setString(1, sContractNo);
		rsImpawncont = psImpawncont.executeQuery();
		stmtList.add(psImpawncont);
		rsList.add(rsImpawncont);
		if (!rsImpawncont.next())
		{
			clearResource();
			return false;
		}
		  goto _L1
		e;
		logger.debug("check3004_4错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		return true;
	}

	public boolean check3004_5(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sLCNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='5' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where gc.businesstype='5' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where  ic.businesstype='5' and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sLCNo = "";
		try
		{
			sLCNo = segnebtB[0].getField("LCNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3004_5: 信用证业务号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sLCNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_180;
_L1:
		clearResource();
		return true;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sLCNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sLCNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_340;
		}
		  goto _L1
		e;
		logger.debug("check3004_5错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return false;
	}

	public boolean check3004_6(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sGuaranteeNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='6' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where   gc.businesstype='6' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where ic.businesstype='6' and  ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sGuaranteeNo = "";
		try
		{
			sGuaranteeNo = segnebtB[0].getField("guaranteebillno").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3004_6: 保函业务号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sGuaranteeNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_180;
_L1:
		clearResource();
		return true;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sGuaranteeNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sGuaranteeNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_340;
		}
		  goto _L1
		e;
		logger.debug("check3004_6错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return false;
	}

	public boolean check3004_7(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sAccepNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='7' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where  gc.businesstype='7' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where   ic.businesstype='7' and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sAccepNo = "";
		try
		{
			sAccepNo = segnebtB[0].getField("AcceptNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3004_7: 银行承兑汇票号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sAccepNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_180;
_L1:
		clearResource();
		return true;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sAccepNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sAccepNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_340;
		}
		  goto _L1
		e;
		logger.debug("check3004_7错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return false;
	}

	public boolean check3005_1(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sContractNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='1' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where  gc.businesstype='1' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where  ic.businesstype='1' and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtD[] = checkRule.getRecord().getSegments("D");
		if (segnebtD == null || segnebtD.length < 1)
		{
			logger.fatal("can not find the D segment");
			return false;
		}
		String sStatus = "";
		String sGuarntyFlag = "";
		try
		{
			sStatus = segnebtD[0].getField("AvailabStatus").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3005_1: 合同有效状态错", e);
			return false;
		}
		try
		{
			sGuarntyFlag = segnebtD[0].getField("GuarantyFlag").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3005_1: 担保标志错", e);
			return false;
		}
		if (!sStatus.equalsIgnoreCase("1") || !sGuarntyFlag.equalsIgnoreCase("2"))
			break MISSING_BLOCK_LABEL_492;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sContractNo = "";
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3005_1: 合同号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sContractNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_328;
_L1:
		clearResource();
		return false;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sContractNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sContractNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_488;
		}
		  goto _L1
		e;
		logger.debug("check3005_1错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check3005_2(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sFactoringNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='2' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where  gc.businesstype='2' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where ic.businesstype='2'  and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtD[] = checkRule.getRecord().getSegments("D");
		if (segnebtD == null || segnebtD.length < 1)
		{
			logger.fatal("can not find the D segment");
			return false;
		}
		String sGuarntyFlag = "";
		try
		{
			sGuarntyFlag = segnebtD[0].getField("GuarantyFlag").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3005_2: 担保标志错", e);
			return false;
		}
		if (!sGuarntyFlag.equalsIgnoreCase("2"))
			break MISSING_BLOCK_LABEL_437;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sFactoringNo = "";
		try
		{
			sFactoringNo = segnebtB[0].getField("FactoringNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3005_2: 保理业务号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sFactoringNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_273;
_L1:
		clearResource();
		return false;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sFactoringNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sFactoringNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_433;
		}
		  goto _L1
		e;
		logger.debug("check3005_2错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check3005_4(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sContractNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='4' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where gc.businesstype='4' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where  ic.businesstype='4' and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtD[] = checkRule.getRecord().getSegments("D");
		if (segnebtD == null || segnebtD.length < 1)
		{
			logger.fatal("can not find the D segment");
			return false;
		}
		String sStatus = "";
		String sGuarntyFlag = "";
		try
		{
			sStatus = segnebtD[0].getField("AvailabStatus").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3005_4: 合同有效状态错", e);
			return false;
		}
		try
		{
			sGuarntyFlag = segnebtD[0].getField("GuarantyFlag").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3005_4: 担保标志错", e);
			return false;
		}
		if (!sStatus.equalsIgnoreCase("1") || !sGuarntyFlag.equalsIgnoreCase("2"))
			break MISSING_BLOCK_LABEL_492;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sContractNo = "";
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3005_4: 贸易融资业务号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sContractNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_328;
_L1:
		clearResource();
		return false;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sContractNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sContractNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_488;
		}
		  goto _L1
		e;
		logger.debug("check3005_4错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check3005_5(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sLCNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='5' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where  gc.businesstype='5' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where ic.businesstype='5'  and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtD[] = checkRule.getRecord().getSegments("D");
		if (segnebtD == null || segnebtD.length < 1)
		{
			logger.fatal("can not find contract the D segment");
			return false;
		}
		String sGuarntyFlag = "";
		try
		{
			sGuarntyFlag = segnebtD[0].getField("GuarantyFlag").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3005_5: 担保标志错", e);
			return false;
		}
		if (!sGuarntyFlag.equalsIgnoreCase("2"))
			break MISSING_BLOCK_LABEL_437;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sLCNo = "";
		try
		{
			sLCNo = segnebtB[0].getField("LCNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3005_5: 信用证业务号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sLCNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_273;
_L1:
		clearResource();
		return false;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sLCNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sLCNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_433;
		}
		  goto _L1
		e;
		logger.debug("check3005_5错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check3005_6(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sGuaranteeNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='6' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC where  gc.businesstype='6' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where ic.businesstype='6' and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtD[] = checkRule.getRecord().getSegments("D");
		if (segnebtD == null || segnebtD.length < 1)
		{
			logger.fatal("can not find contract the D segment");
			return false;
		}
		String sGuarntyFlag = "";
		try
		{
			sGuarntyFlag = segnebtD[0].getField("GuarantyFlag").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3005_6: 担保标志错", e);
			return false;
		}
		if (!sGuarntyFlag.equalsIgnoreCase("2"))
			break MISSING_BLOCK_LABEL_437;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sGuaranteeNo = "";
		try
		{
			sGuaranteeNo = segnebtB[0].getField("guaranteebillno").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3005_6: 保函业务号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sGuaranteeNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_273;
_L1:
		clearResource();
		return false;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sGuaranteeNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sGuaranteeNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_433;
		}
		  goto _L1
		e;
		logger.debug("check3005_6错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check3005_7(ValidateRule checkRule)
	{
		String sqlAssurecont;
		String sqlGuarantycont;
		String sqlImpawncont;
		String sAccepNo;
		SQLException e;
		sqlAssurecont = "select contractno from ECR_ASSURECONT where  businesstype='7' and contractno=? and AVAILABSTATUS='1'";
		sqlGuarantycont = "select GC.contractno from ECR_GUARANTYCONT GC  where  gc.businesstype='7' and GC.contractno=? and GC.AVAILABSTATUS='1'";
		sqlImpawncont = "select ic.contractno from ECR_IMPAWNCONT ic  where  ic.businesstype='7' and ic.contractno=? and ic.AVAILABSTATUS='1'";
		PreparedStatement psAssurecont = null;
		PreparedStatement psGuarantycont = null;
		PreparedStatement psImpawncont = null;
		ResultSet rsAssurecont = null;
		ResultSet rsGuarantycont = null;
		ResultSet rsImpawncont = null;
		Segment segnebtD[] = checkRule.getRecord().getSegments("D");
		if (segnebtD == null || segnebtD.length < 1)
		{
			logger.fatal("can not find the D segment");
			return false;
		}
		String sGuarntyFlag = "";
		try
		{
			sGuarntyFlag = segnebtD[0].getField("GuarantyFlag").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3005_7: 担保标志错", e);
			return false;
		}
		if (!sGuarntyFlag.equalsIgnoreCase("2"))
			break MISSING_BLOCK_LABEL_437;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sAccepNo = "";
		try
		{
			sAccepNo = segnebtB[0].getField("AcceptNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3005_7: 银行承兑汇票业务号错", e);
			return false;
		}
		PreparedStatement psAssurecont = connection.prepareStatement(sqlAssurecont);
		psAssurecont.setString(1, sAccepNo);
		ResultSet rsAssurecont = psAssurecont.executeQuery();
		stmtList.add(psAssurecont);
		rsList.add(rsAssurecont);
		if (!rsAssurecont.next())
			break MISSING_BLOCK_LABEL_273;
_L1:
		clearResource();
		return false;
		PreparedStatement psGuarantycont = connection.prepareStatement(sqlGuarantycont);
		psGuarantycont.setString(1, sAccepNo);
		ResultSet rsGuarantycont = psGuarantycont.executeQuery();
		stmtList.add(psGuarantycont);
		rsList.add(rsGuarantycont);
		if (!rsGuarantycont.next())
		{
			PreparedStatement psImpawncont = connection.prepareStatement(sqlImpawncont);
			psImpawncont.setString(1, sAccepNo);
			ResultSet rsImpawncont = psImpawncont.executeQuery();
			stmtList.add(psImpawncont);
			rsList.add(rsImpawncont);
			if (!rsImpawncont.next())
				break MISSING_BLOCK_LABEL_433;
		}
		  goto _L1
		e;
		logger.debug("check3005_7错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check3006(ValidateRule checkRule)
	{
		return true;
	}

	public boolean check3008(ValidateRule checkRule)
	{
		return true;
	}

	public boolean check3010(ValidateRule checkRule)
	{
		return true;
	}

	public boolean check3012_1(ValidateRule checkRule)
	{
		String sqlExten;
		ResultSet rsExten;
		String sDuebillNo;
		String sOccurDate;
		SQLException e;
		sqlExten = "select LDuebillNo from ECR_LOANEXTENSION where LDuebillNo=? and OccurDate <= ?";
		PreparedStatement psExten = null;
		rsExten = null;
		Segment segnebtF[] = checkRule.getRecord().getSegments("F");
		if (segnebtF == null || segnebtF.length < 1)
		{
			logger.fatal("can not find the F segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtF[0].getField("DuebillNo").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3012_1: 借据号错", e);
			return false;
		}
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the B segment");
			return false;
		}
		sOccurDate = "";
		try
		{
			sOccurDate = segnebtB[0].getField("OccurDate").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3012_1: 业务发生日期错", e);
			return false;
		}
		PreparedStatement psExten = connection.prepareStatement(sqlExten);
		psExten.setString(1, sDuebillNo);
		psExten.setString(2, Tools.handleDate(sOccurDate, "0"));
		rsExten = psExten.executeQuery();
		stmtList.add(psExten);
		rsList.add(rsExten);
		Exception exception;
		if (rsExten.next())
		{
			clearResource();
			return false;
		} else
		{
			clearResource();
			return true;
		}
		e;
		logger.debug("check3012_1错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check3012_2(ValidateRule checkRule)
	{
		String sqlExten;
		ResultSet rsExten;
		String sDuebillNo;
		String sOccurDate;
		SQLException e;
		sqlExten = "select FDuebillNo from ECR_FINAEXTENSION where FDuebillNo=? and OccurDate <= ?";
		PreparedStatement psExten = null;
		rsExten = null;
		Segment segnebtF[] = checkRule.getRecord().getSegments("F");
		if (segnebtF == null || segnebtF.length < 1)
		{
			logger.fatal("can not find contract the F segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtF[0].getField("DuebillNo").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check3012_2: 融资业务号错", e);
			return false;
		}
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find contract the B segment");
			return false;
		}
		sOccurDate = "";
		try
		{
			sOccurDate = segnebtB[0].getField("OccurDate").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check3012_2: 业务发生日期错", e);
			return false;
		}
		PreparedStatement psExten = connection.prepareStatement(sqlExten);
		psExten.setString(1, sDuebillNo);
		psExten.setString(2, Tools.handleDate(sOccurDate, "0"));
		rsExten = psExten.executeQuery();
		stmtList.add(psExten);
		rsList.add(rsExten);
		Exception exception;
		if (rsExten.next())
		{
			clearResource();
			return false;
		} else
		{
			clearResource();
			return true;
		}
		e;
		logger.debug("check3012_2错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4172(ValidateRule checkRule)
	{
		String sqlLoanReturn;
		String sReturnDate;
		String sDuebillNo;
		double dBusinessSum;
		double dBalance;
		double dReturn;
		sqlLoanReturn = "select sum(ReturnSum) from ECR_LOANRETURN where LDuebillNo=? and ReturnDate<=?";
		PreparedStatement psLoanReturn = null;
		ResultSet rsLoanReturn = null;
		Segment segnebtF[] = checkRule.getRecord().getSegments("F");
		if (segnebtF == null || segnebtF.length < 1)
		{
			logger.fatal("can not find the F segment");
			return false;
		}
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		sReturnDate = "";
		try
		{
			sReturnDate = segnebtB[0].getField("OccurDate").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check4172: 业务发生日期错", e);
			return false;
		}
		sDuebillNo = "";
		dBusinessSum = 0.0D;
		dBalance = 0.0D;
		dReturn = 0.0D;
		int iResult = 0;
		try
		{
			sDuebillNo = segnebtF[0].getField("DuebillNo").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check4172: 借据号错", e);
			return false;
		}
		try
		{
			dBusinessSum = (new Double(segnebtF[0].getField("BusinessSum").getTextValue().trim())).doubleValue();
		}
		catch (ECRException e)
		{
			logger.debug("check4172: 发放金额错", e);
			return false;
		}
		try
		{
			dBalance = (new Double(segnebtF[0].getField("Balance").getTextValue().trim())).doubleValue();
		}
		catch (ECRException e)
		{
			logger.debug("check4172: 借据余额错", e);
			return false;
		}
		try
		{
			PreparedStatement psLoanReturn = connection.prepareStatement(sqlLoanReturn);
			psLoanReturn.setString(1, sDuebillNo);
			psLoanReturn.setString(2, Tools.handleDate(sReturnDate, "0"));
			ResultSet rsLoanReturn = psLoanReturn.executeQuery();
			stmtList.add(psLoanReturn);
			rsList.add(rsLoanReturn);
			if (rsLoanReturn.next())
				dReturn = rsLoanReturn.getDouble(1);
			break MISSING_BLOCK_LABEL_399;
		}
		catch (SQLException e)
		{
			logger.debug("check4172错", e);
		}
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		int iResult = Tools.MoneyCompare(dBusinessSum, dBalance + dReturn);
		return iResult == 0;
	}

	public boolean check4212(ValidateRule checkRule)
	{
		String sqlContract;
		ResultSet rsContract;
		String sContractNo;
		SQLException e;
		sqlContract = "select LContractNo from ECR_LOANCONTRACT where LContractNo=?";
		PreparedStatement psContract = null;
		rsContract = null;
		sContractNo = "";
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4212: 合同号错", e);
			return false;
		}
		if (sContractNo == null || sContractNo.equals(""))
			return false;
		PreparedStatement psContract = connection.prepareStatement(sqlContract);
		psContract.setString(1, sContractNo);
		rsContract = psContract.executeQuery();
		stmtList.add(psContract);
		rsList.add(rsContract);
		Exception exception;
		if (rsContract.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check4212错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4214(ValidateRule checkRule)
	{
		String sqlDuebill;
		ResultSet rsDuebill;
		String sDuebillNo;
		SQLException e;
		sqlDuebill = "select LDuebillNo from ECR_LOANDUEBILL where LDuebillNo=?";
		PreparedStatement psDuebill = null;
		rsDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("G");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the G segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4214: 借据号错", e);
			return false;
		}
		if (sDuebillNo == null || sDuebillNo.equals(""))
			return false;
		PreparedStatement psDuebill = connection.prepareStatement(sqlDuebill);
		psDuebill.setString(1, sDuebillNo);
		rsDuebill = psDuebill.executeQuery();
		stmtList.add(psDuebill);
		rsList.add(rsDuebill);
		Exception exception;
		if (rsDuebill.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check4214错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4184(ValidateRule checkRule)
	{
		String sqlDuebill;
		String sDuebillNo;
		double dBusinessSum;
		SQLException e;
		sqlDuebill = "select PUTOUTAMOUNT from ECR_LOANDUEBILL where LDUEBILLNO=?";
		PreparedStatement psDuebill = null;
		ResultSet rsDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("H");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the H segment");
			return false;
		}
		sDuebillNo = "";
		dBusinessSum = 0.0D;
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4184: 借据号错", e);
			return false;
		}
		PreparedStatement psDuebill = connection.prepareStatement(sqlDuebill);
		psDuebill.setString(1, sDuebillNo);
		ResultSet rsDuebill = psDuebill.executeQuery();
		stmtList.add(psDuebill);
		rsList.add(rsDuebill);
		if (!rsDuebill.next())
			break MISSING_BLOCK_LABEL_221;
		dBusinessSum = rsDuebill.getDouble(1);
		if (dBusinessSum < (new Double(checkRule.getCheckedValue().trim())).doubleValue())
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_221;
		e;
		logger.debug("check4184:应为数字型", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4188(ValidateRule checkRule)
	{
		String sqlLoanReturn;
		ResultSet rsLoanReturn;
		String sqlDuebill;
		String sDuebillNo;
		double dBalance;
		double dExtenSum;
		ECRException e;
		sqlLoanReturn = "select sum(ReturnSum) as ReturnSum from ECR_LOANRETURN where LDUEBILLNO=?";
		PreparedStatement psLoanReturn = null;
		rsLoanReturn = null;
		sqlDuebill = "select BALANCE from ECR_LOANDUEBILL where LDUEBILLNO=?";
		PreparedStatement psDuebill = null;
		ResultSet rsDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("H");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the H segment");
			return false;
		}
		sDuebillNo = "";
		dBalance = 0.0D;
		dExtenSum = 0.0D;
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (ECRException e)
		{
			logger.debug("check4188: 借据号错", e);
			return false;
		}
		try
		{
			dExtenSum = (new Double(segnebtB[0].getField("ExtenSum").getTextValue().trim())).doubleValue();
		}
		// Misplaced declaration of an exception variable
		catch (ECRException e)
		{
			logger.debug("check4188: 展期金额错");
			return false;
		}
		PreparedStatement psLoanReturn = connection.prepareStatement(sqlLoanReturn);
		psLoanReturn.setString(1, sDuebillNo);
		rsLoanReturn = psLoanReturn.executeQuery();
		stmtList.add(psLoanReturn);
		rsList.add(rsLoanReturn);
		if (rsLoanReturn.next() && rsLoanReturn.getDouble("ReturnSum") > 0.0D)
		{
			clearResource();
			return true;
		}
		PreparedStatement psDuebill = connection.prepareStatement(sqlDuebill);
		psDuebill.setString(1, sDuebillNo);
		ResultSet rsDuebill = psDuebill.executeQuery();
		stmtList.add(psDuebill);
		rsList.add(rsDuebill);
		if (!rsDuebill.next())
			break MISSING_BLOCK_LABEL_352;
		dBalance = rsDuebill.getDouble("BALANCE");
		if (dBalance != dExtenSum)
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_352;
		e;
		logger.debug("check4188错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4216(ValidateRule checkRule)
	{
		String sqlDuebill;
		ResultSet rsDuebill;
		String sDuebillNo;
		SQLException e;
		sqlDuebill = "select LDUEBILLNO from ECR_LOANDUEBILL where LDUEBILLNO=?";
		PreparedStatement psDuebill = null;
		rsDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("H");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the H segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4216: 借据号错", e);
			return false;
		}
		if (sDuebillNo == null || sDuebillNo.equals(""))
			return false;
		PreparedStatement psDuebill = connection.prepareStatement(sqlDuebill);
		psDuebill.setString(1, sDuebillNo);
		rsDuebill = psDuebill.executeQuery();
		stmtList.add(psDuebill);
		rsList.add(rsDuebill);
		Exception exception;
		if (rsDuebill.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check4216错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4232(ValidateRule checkRule)
	{
		String sqlFinanceReturn;
		String sDuebillNo;
		double dReturnSum;
		SQLException e;
		sqlFinanceReturn = "select sum(ReturnSum) as ReturnSum from ECR_FINARETURN where FDUEBILLNO=?";
		PreparedStatement psFinanceReturn = null;
		ResultSet rsFinanceReturn = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("F");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the F segment");
			return false;
		}
		sDuebillNo = "";
		dReturnSum = 0.0D;
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4232: 融资借据号错", e);
			return false;
		}
		PreparedStatement psFinanceReturn = connection.prepareStatement(sqlFinanceReturn);
		psFinanceReturn.setString(1, sDuebillNo);
		ResultSet rsFinanceReturn = psFinanceReturn.executeQuery();
		stmtList.add(psFinanceReturn);
		rsList.add(rsFinanceReturn);
		if (!rsFinanceReturn.next())
			break MISSING_BLOCK_LABEL_223;
		dReturnSum = rsFinanceReturn.getDouble("ReturnSum");
		if (dReturnSum > (new Double(checkRule.getCheckedValue().trim())).doubleValue())
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_223;
		e;
		logger.debug("check4232错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4186(ValidateRule checkRule)
	{
		String sqlDuebill;
		ResultSet rsDuebill;
		String sDuebillNo;
		SQLException e;
		sqlDuebill = "select PUTOUTDATE from ECR_LOANDUEBILL where LDUEBILLNO=?";
		PreparedStatement psDuebill = null;
		rsDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("H");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the H segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4186: 借据号错", e);
			return false;
		}
		if (sDuebillNo == null || sDuebillNo.equals(""))
			return false;
		PreparedStatement psDuebill = connection.prepareStatement(sqlDuebill);
		psDuebill.setString(1, sDuebillNo);
		rsDuebill = psDuebill.executeQuery();
		stmtList.add(psDuebill);
		rsList.add(rsDuebill);
		Exception exception;
		if (rsDuebill.next() && Tools.handleDate(rsDuebill.getString("PUTOUTDATE"), "1").compareToIgnoreCase(checkRule.getCheckedValue().trim()) > 0)
		{
			clearResource();
			return false;
		} else
		{
			clearResource();
			return true;
		}
		e;
		logger.debug("check4186错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4234(ValidateRule checkRule)
	{
		String sqlLoanReturn;
		String sReturnDate;
		String sDuebillNo;
		double dBusinessSum;
		double dBalance;
		double dReturn;
		sqlLoanReturn = "select sum(ReturnSum) from ECR_FINARETURN where FDUEBILLNO=? and returndate<=?";
		PreparedStatement psLoanReturn = null;
		ResultSet rsLoanReturn = null;
		Segment segnebtF[] = checkRule.getRecord().getSegments("F");
		if (segnebtF == null || segnebtF.length < 1)
		{
			logger.fatal("can not find the F segment");
			return false;
		}
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		sReturnDate = "";
		try
		{
			sReturnDate = segnebtB[0].getField("OccurDate").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check4234: 业务发生日期错", e);
			return false;
		}
		sDuebillNo = "";
		dBusinessSum = 0.0D;
		dBalance = 0.0D;
		int iResult = 0;
		dReturn = 0.0D;
		try
		{
			sDuebillNo = segnebtF[0].getField("DuebillNo").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check4234: 融资借据号错", e);
			return false;
		}
		try
		{
			dBusinessSum = (new Double(segnebtF[0].getField("BusinessSum").getTextValue().trim())).doubleValue();
		}
		catch (ECRException e)
		{
			logger.debug("check4234: 融资发放金额错", e);
			return false;
		}
		try
		{
			dBalance = (new Double(segnebtF[0].getField("Balance").getTextValue().trim())).doubleValue();
		}
		catch (ECRException e)
		{
			logger.debug("check4234: 融资借据余额错", e);
			return false;
		}
		try
		{
			PreparedStatement psLoanReturn = connection.prepareStatement(sqlLoanReturn);
			psLoanReturn.setString(1, sDuebillNo);
			psLoanReturn.setString(2, Tools.handleDate(sReturnDate, "0"));
			ResultSet rsLoanReturn = psLoanReturn.executeQuery();
			stmtList.add(psLoanReturn);
			rsList.add(rsLoanReturn);
			if (rsLoanReturn.next())
				dReturn = rsLoanReturn.getDouble(1);
			break MISSING_BLOCK_LABEL_399;
		}
		catch (SQLException e)
		{
			logger.debug("check4234错", e);
		}
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		int iResult = Tools.MoneyCompare(dBusinessSum, dBalance + dReturn);
		return iResult == 0;
	}

	public boolean check4180(ValidateRule checkRule)
	{
		String sqlDuebill;
		ResultSet rsDuebill;
		String sDuebillNo;
		SQLException e;
		sqlDuebill = "select PUTOUTDATE from ECR_LOANDUEBILL where LDUEBILLNO=?";
		PreparedStatement psDuebill = null;
		rsDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("G");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the G segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4180: 借据号错", e);
			return false;
		}
		if (sDuebillNo == null || sDuebillNo.equals(""))
			return false;
		PreparedStatement psDuebill = connection.prepareStatement(sqlDuebill);
		psDuebill.setString(1, sDuebillNo);
		rsDuebill = psDuebill.executeQuery();
		stmtList.add(psDuebill);
		rsList.add(rsDuebill);
		Exception exception;
		if (rsDuebill.next() && Tools.handleDate(rsDuebill.getString("PUTOUTDATE"), "1").compareToIgnoreCase(checkRule.getCheckedValue().trim()) > 0)
		{
			clearResource();
			return false;
		} else
		{
			clearResource();
			return true;
		}
		e;
		logger.debug("check4180错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4183(ValidateRule checkRule)
	{
		String sqlDuebill;
		String sContractNo;
		double dBusinessSum;
		SQLException e;
		sqlDuebill = "select sum(PutoutAmount) as BusinessSum from ECR_LOANDUEBILL where LDUEBILLNO=?";
		PreparedStatement psDuebill = null;
		ResultSet rsDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		sContractNo = "";
		dBusinessSum = 0.0D;
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4183: 合同号错", e);
			return false;
		}
		PreparedStatement psDuebill = connection.prepareStatement(sqlDuebill);
		psDuebill.setString(1, sContractNo);
		ResultSet rsDuebill = psDuebill.executeQuery();
		stmtList.add(psDuebill);
		rsList.add(rsDuebill);
		if (!rsDuebill.next())
			break MISSING_BLOCK_LABEL_223;
		dBusinessSum = rsDuebill.getDouble("BusinessSum");
		if (dBusinessSum > (new Double(checkRule.getCheckedValue().trim())).doubleValue())
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_223;
		e;
		logger.debug("check4183错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4178(ValidateRule checkRule)
	{
		String sqlDuebill;
		ResultSet rsDuebill;
		String sContractNo;
		String sPutOutDate;
		String sPutOutEndDate;
		SQLException e;
		sqlDuebill = "select PutOutDate,PutOutEndDate from ECR_LOANDUEBILL where LCONTRACTNO=?";
		PreparedStatement psDuebill = null;
		rsDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		sContractNo = "";
		sPutOutDate = "";
		sPutOutEndDate = "";
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4178: 合同号错", e);
			return false;
		}
		PreparedStatement psDuebill = connection.prepareStatement(sqlDuebill);
		psDuebill.setString(1, sContractNo);
		rsDuebill = psDuebill.executeQuery();
		stmtList.add(psDuebill);
		rsList.add(rsDuebill);
		  goto _L1
_L3:
		sPutOutDate = rsDuebill.getString("PutOutDate");
		sPutOutEndDate = rsDuebill.getString("PutOutEndDate");
		if (Tools.handleDate(sPutOutDate, "1").compareToIgnoreCase(checkRule.getCheckedValue().trim()) < 0 || sPutOutEndDate.compareToIgnoreCase(sPutOutDate) < 0)
		{
			clearResource();
			return false;
		}
_L1:
		if (rsDuebill.next()) goto _L3; else goto _L2
_L2:
		break MISSING_BLOCK_LABEL_256;
		e;
		logger.debug("check4178错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4240(ValidateRule checkRule)
	{
		String sqlFinaDuebill;
		String sDuebillNo;
		String sFinaStartDate;
		SQLException e;
		sqlFinaDuebill = "select PutoutDate from ECR_FINADUEBILL where FCONTRACTNO=?";
		PreparedStatement psFinaDuebill = null;
		ResultSet rsFinaDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("G");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the G segment");
			return false;
		}
		sDuebillNo = "";
		sFinaStartDate = "";
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4240: 融资业务编号错", e);
			return false;
		}
		PreparedStatement psFinaDuebill = connection.prepareStatement(sqlFinaDuebill);
		psFinaDuebill.setString(1, sDuebillNo);
		ResultSet rsFinaDuebill = psFinaDuebill.executeQuery();
		stmtList.add(psFinaDuebill);
		rsList.add(rsFinaDuebill);
		if (!rsFinaDuebill.next())
			break MISSING_BLOCK_LABEL_223;
		sFinaStartDate = rsFinaDuebill.getString("PutOutDate");
		if (Tools.handleDate(sFinaStartDate, "1").compareToIgnoreCase(checkRule.getCheckedValue().trim()) > 0)
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_223;
		e;
		logger.debug("check4240错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4242(ValidateRule checkRule)
	{
		String sqlFinaExtension;
		String sDuebillNo;
		String sExtenStartDate;
		String sExtenEndDate;
		SQLException e;
		sqlFinaExtension = "select ExtenStartDate,ExtenEndDate from ECR_FINAEXTENSION where FDUEBILLNO=?";
		PreparedStatement psFinaExtension = null;
		ResultSet rsFinaExtension = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("F");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the F segment");
			return false;
		}
		sDuebillNo = "";
		sExtenStartDate = "";
		sExtenEndDate = "";
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4242: 融资业务编号错", e);
			return false;
		}
		PreparedStatement psFinaExtension = connection.prepareStatement(sqlFinaExtension);
		psFinaExtension.setString(1, sDuebillNo);
		ResultSet rsFinaExtension = psFinaExtension.executeQuery();
		stmtList.add(psFinaExtension);
		rsList.add(rsFinaExtension);
		if (!rsFinaExtension.next())
			break MISSING_BLOCK_LABEL_250;
		sExtenStartDate = rsFinaExtension.getString("ExtenStartDate");
		sExtenEndDate = rsFinaExtension.getString("ExtenEndDate");
		if (Tools.handleDate(sExtenStartDate, "1").compareToIgnoreCase(checkRule.getCheckedValue().trim()) < 0 || sExtenEndDate.compareToIgnoreCase(sExtenStartDate) < 0)
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_250;
		e;
		logger.debug("check4242错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4244(ValidateRule checkRule)
	{
		String sqlFinaDuebill;
		ResultSet rsFinaDuebill;
		String sDuebillNo;
		SQLException e;
		sqlFinaDuebill = "select PutoutAmount from ECR_FINADUEBILL where FDUEBILLNO=?";
		PreparedStatement psFinaDuebill = null;
		rsFinaDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("H");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the H segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4244: 融资业务编号错", e);
			return false;
		}
		PreparedStatement psFinaDuebill = connection.prepareStatement(sqlFinaDuebill);
		psFinaDuebill.setString(1, sDuebillNo);
		rsFinaDuebill = psFinaDuebill.executeQuery();
		stmtList.add(psFinaDuebill);
		rsList.add(rsFinaDuebill);
		Exception exception;
		if (rsFinaDuebill.next() && rsFinaDuebill.getDouble(1) < (new Double(checkRule.getCheckedValue().trim())).doubleValue())
		{
			clearResource();
			return false;
		} else
		{
			clearResource();
			return true;
		}
		e;
		logger.debug("check4244错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4246(ValidateRule checkRule)
	{
		String sqlFinaDuebill;
		ResultSet rsFinaDuebill;
		Segment segnebtE[];
		String sContractNo;
		String sCurrency;
		ECRException e;
		sqlFinaDuebill = "select sum(PutoutAmount),CURRENCY from ECR_FINADUEBILL where FCONTRACTNO=? GROUP BY CURRENCY";
		PreparedStatement psFinaDuebill = null;
		rsFinaDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		segnebtE = checkRule.getRecord().getSegments("E");
		if (segnebtE == null || segnebtE.length < 1)
		{
			logger.fatal("can not find the E segment");
			return false;
		}
		sContractNo = "";
		sCurrency = "";
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (ECRException e)
		{
			logger.debug("check4246: 融资协议编号错", e);
			return false;
		}
		PreparedStatement psFinaDuebill = connection.prepareStatement(sqlFinaDuebill);
		psFinaDuebill.setString(1, sContractNo);
		rsFinaDuebill = psFinaDuebill.executeQuery();
		stmtList.add(psFinaDuebill);
		rsList.add(rsFinaDuebill);
		if (!rsFinaDuebill.next())
			break MISSING_BLOCK_LABEL_306;
		sCurrency = rsFinaDuebill.getString("currency");
		if (rsFinaDuebill.getDouble(1) <= (new Double(checkRule.getCheckedValue().trim())).doubleValue()) goto _L2; else goto _L1
_L1:
		clearResource();
		return false;
_L2:
		if (sCurrency.equals(segnebtE[0].getField("Currency").getTextValue().trim())) goto _L3; else goto _L1
_L3:
		break MISSING_BLOCK_LABEL_306;
		e;
		e.printStackTrace();
		break MISSING_BLOCK_LABEL_306;
		e;
		logger.debug("check4246错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4248(ValidateRule checkRule)
	{
		String sqlFinaDuebill;
		ResultSet rsFinaDuebill;
		String sContractNo;
		SQLException e;
		sqlFinaDuebill = "select PutoutDate from ECR_FINADUEBILL where FCONTRACTNO=? order by PutoutDate asc";
		PreparedStatement psFinaDuebill = null;
		rsFinaDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		sContractNo = "";
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4246: 融资协议编号错", e);
			return false;
		}
		PreparedStatement psFinaDuebill = connection.prepareStatement(sqlFinaDuebill);
		psFinaDuebill.setString(1, sContractNo);
		rsFinaDuebill = psFinaDuebill.executeQuery();
		stmtList.add(psFinaDuebill);
		rsList.add(rsFinaDuebill);
		Exception exception;
		if (rsFinaDuebill.next() && Tools.handleDate(rsFinaDuebill.getString("PutoutDate"), "1").compareToIgnoreCase(checkRule.getCheckedValue().trim()) < 0)
		{
			clearResource();
			return false;
		} else
		{
			clearResource();
			return true;
		}
		e;
		logger.debug("check4246错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4250(ValidateRule checkRule)
	{
		String sqlFinanceReturn;
		ResultSet rsFinanceReturn;
		String sqlFinaDuebill;
		String sDuebillNo;
		double dFinaBalance;
		double dFinaExtenSum;
		ECRException e;
		sqlFinanceReturn = "select sum(ReturnSum) as ReturnSum from ECR_FINARETURN where FDuebillNo=?";
		PreparedStatement psFinanceReturn = null;
		rsFinanceReturn = null;
		sqlFinaDuebill = "select Balance from ECR_FINADUEBILL where FDuebillNo=?";
		PreparedStatement psFinaDuebill = null;
		ResultSet rsFinaDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("H");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the H segment");
			return false;
		}
		sDuebillNo = "";
		dFinaBalance = 0.0D;
		dFinaExtenSum = 0.0D;
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (ECRException e)
		{
			logger.debug("check4250: 融资业务借据号错", e);
			return false;
		}
		try
		{
			dFinaExtenSum = (new Double(segnebtB[0].getField("ExtenSum").getTextValue().trim())).doubleValue();
		}
		// Misplaced declaration of an exception variable
		catch (ECRException e)
		{
			logger.debug("check4250: 融资业务展期金额错", e);
			return false;
		}
		PreparedStatement psFinanceReturn = connection.prepareStatement(sqlFinanceReturn);
		psFinanceReturn.setString(1, sDuebillNo);
		rsFinanceReturn = psFinanceReturn.executeQuery();
		stmtList.add(psFinanceReturn);
		rsList.add(rsFinanceReturn);
		if (rsFinanceReturn.next() && rsFinanceReturn.getDouble("ReturnSum") > 0.0D)
		{
			clearResource();
			return true;
		}
		PreparedStatement psFinaDuebill = connection.prepareStatement(sqlFinaDuebill);
		psFinaDuebill.setString(1, sDuebillNo);
		ResultSet rsFinaDuebill = psFinaDuebill.executeQuery();
		stmtList.add(psFinaDuebill);
		rsList.add(rsFinaDuebill);
		if (!rsFinaDuebill.next())
			break MISSING_BLOCK_LABEL_354;
		dFinaBalance = rsFinaDuebill.getDouble("FinaBalance");
		if (dFinaBalance != dFinaExtenSum)
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_354;
		e;
		logger.debug("check4250错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4252(ValidateRule checkRule)
	{
		return true;
	}

	public boolean check4274(ValidateRule checkRule)
	{
		String sqlFinaInfo;
		ResultSet rsFinaInfo;
		String sContractNo;
		SQLException e;
		sqlFinaInfo = "select FContractNo from ECR_FINAINFO where FContractNo=?";
		PreparedStatement psFinaInfo = null;
		rsFinaInfo = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sContractNo = "";
		try
		{
			sContractNo = segnebtB[0].getField("ContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4274: 融资协议号错", e);
			return false;
		}
		if (sContractNo == null || sContractNo.equals(""))
			return false;
		PreparedStatement psFinaInfo = connection.prepareStatement(sqlFinaInfo);
		psFinaInfo.setString(1, sContractNo);
		rsFinaInfo = psFinaInfo.executeQuery();
		stmtList.add(psFinaInfo);
		rsList.add(rsFinaInfo);
		Exception exception;
		if (rsFinaInfo.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check4274错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4276(ValidateRule checkRule)
	{
		String sqlFinaDuebill;
		ResultSet rsFinaDuebill;
		String sDuebillNo;
		SQLException e;
		sqlFinaDuebill = "select FDuebillNo from ECR_FINADUEBILL where FDuebillNo=?";
		PreparedStatement psFinaDuebill = null;
		rsFinaDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("G");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the G segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4276: 融资业务号错", e);
			return false;
		}
		if (sDuebillNo == null || sDuebillNo.equals(""))
			return false;
		PreparedStatement psFinaDuebill = connection.prepareStatement(sqlFinaDuebill);
		psFinaDuebill.setString(1, sDuebillNo);
		rsFinaDuebill = psFinaDuebill.executeQuery();
		stmtList.add(psFinaDuebill);
		rsList.add(rsFinaDuebill);
		Exception exception;
		if (rsFinaDuebill.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check4276错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4278(ValidateRule checkRule)
	{
		String sqlFinaDuebill;
		ResultSet rsFinaDuebill;
		String sDuebillNo;
		SQLException e;
		sqlFinaDuebill = "select FDuebillNo from ECR_FINADUEBILL where FDuebillNo=?";
		PreparedStatement psFinaDuebill = null;
		rsFinaDuebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("H");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the H segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4278: 融资业务号错", e);
			return false;
		}
		if (sDuebillNo == null || sDuebillNo.equals(""))
			return false;
		PreparedStatement psFinaDuebill = connection.prepareStatement(sqlFinaDuebill);
		psFinaDuebill.setString(1, sDuebillNo);
		rsFinaDuebill = psFinaDuebill.executeQuery();
		stmtList.add(psFinaDuebill);
		rsList.add(rsFinaDuebill);
		Exception exception;
		if (rsFinaDuebill.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check4278错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check9038_1(ValidateRule checkRule)
	{
		String sqlContract;
		ResultSet rsContract;
		String sMContractNo;
		SQLException e;
		sqlContract = "select LContractNo from ECR_LOANCONTRACT where LContractNo=?";
		PreparedStatement psContract = null;
		rsContract = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sMContractNo = "";
		try
		{
			sMContractNo = segnebtB[0].getField("MContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check9038_1: 贷款合同号错", e);
			return false;
		}
		if (sMContractNo == null || sMContractNo.equals(""))
			return false;
		PreparedStatement psContract = connection.prepareStatement(sqlContract);
		psContract.setString(1, sMContractNo);
		rsContract = psContract.executeQuery();
		stmtList.add(psContract);
		rsList.add(rsContract);
		Exception exception;
		if (rsContract.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check9038_1错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check9038_2(ValidateRule checkRule)
	{
		String sqlFactoring;
		ResultSet rsFactoring;
		String sMContractNo;
		SQLException e;
		sqlFactoring = "select Factoringno from ECR_FACTORING where Factoringno=?";
		PreparedStatement psFactoring = null;
		rsFactoring = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sMContractNo = "";
		try
		{
			sMContractNo = segnebtB[0].getField("MContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check9038_2: 保理号错", e);
			return false;
		}
		if (sMContractNo == null || sMContractNo.equals(""))
			return false;
		PreparedStatement psFactoring = connection.prepareStatement(sqlFactoring);
		psFactoring.setString(1, sMContractNo);
		rsFactoring = psFactoring.executeQuery();
		stmtList.add(psFactoring);
		rsList.add(rsFactoring);
		Exception exception;
		if (rsFactoring.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check9038_2错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check9038_4(ValidateRule checkRule)
	{
		String sqlFinaInfo;
		ResultSet rsFinaInfo;
		String sMContractNo;
		SQLException e;
		sqlFinaInfo = "select FContractNo from ECR_FINAINFO where FContractNo=?";
		PreparedStatement psFinaInfo = null;
		rsFinaInfo = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sMContractNo = "";
		try
		{
			sMContractNo = segnebtB[0].getField("MContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check9038_4: 融资协议合同号错", e);
			return false;
		}
		if (sMContractNo == null || sMContractNo.equals(""))
			return false;
		PreparedStatement psFinaInfo = connection.prepareStatement(sqlFinaInfo);
		psFinaInfo.setString(1, sMContractNo);
		rsFinaInfo = psFinaInfo.executeQuery();
		stmtList.add(psFinaInfo);
		rsList.add(rsFinaInfo);
		Exception exception;
		if (rsFinaInfo.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check9038_4错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check9038_5(ValidateRule checkRule)
	{
		String sqlCreditLetter;
		ResultSet rsCreditLetter;
		String sMContractNo;
		SQLException e;
		sqlCreditLetter = "select CreditletterNo from ECR_CREDITLETTER where CreditletterNo=?";
		PreparedStatement psCreditLetter = null;
		rsCreditLetter = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sMContractNo = "";
		try
		{
			sMContractNo = segnebtB[0].getField("MContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check9038_5: 信用证业务号错", e);
			return false;
		}
		if (sMContractNo == null || sMContractNo.equals(""))
			return false;
		PreparedStatement psCreditLetter = connection.prepareStatement(sqlCreditLetter);
		psCreditLetter.setString(1, sMContractNo);
		rsCreditLetter = psCreditLetter.executeQuery();
		stmtList.add(psCreditLetter);
		rsList.add(rsCreditLetter);
		Exception exception;
		if (rsCreditLetter.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check9038_5错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check9038_6(ValidateRule checkRule)
	{
		String sqlGuaranteebill;
		ResultSet rsGuaranteebill;
		String sMContractNo;
		SQLException e;
		sqlGuaranteebill = "select GuaranteebillNo from ECR_GUARANTEEBILL where GuaranteebillNo=?";
		PreparedStatement psGuaranteebill = null;
		rsGuaranteebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sMContractNo = "";
		try
		{
			sMContractNo = segnebtB[0].getField("MContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check9038_6: 保函号错", e);
			return false;
		}
		if (sMContractNo == null || sMContractNo.equals(""))
			return false;
		PreparedStatement psGuaranteebill = connection.prepareStatement(sqlGuaranteebill);
		psGuaranteebill.setString(1, sMContractNo);
		rsGuaranteebill = psGuaranteebill.executeQuery();
		stmtList.add(psGuaranteebill);
		rsList.add(rsGuaranteebill);
		Exception exception;
		if (rsGuaranteebill.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check9038_6错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check9038_7(ValidateRule checkRule)
	{
		String sqlGuaranteebill;
		ResultSet rsGuaranteebill;
		String sMContractNo;
		SQLException e;
		sqlGuaranteebill = "select AcceptNo from ECR_ACCEPTANCE where AcceptNo=?";
		PreparedStatement psGuaranteebill = null;
		rsGuaranteebill = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the base segment");
			return false;
		}
		sMContractNo = "";
		try
		{
			sMContractNo = segnebtB[0].getField("MContractNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check9038_7: 承兑汇票号错", e);
			return false;
		}
		if (sMContractNo == null || sMContractNo.equals(""))
			return false;
		PreparedStatement psGuaranteebill = connection.prepareStatement(sqlGuaranteebill);
		psGuaranteebill.setString(1, sMContractNo);
		rsGuaranteebill = psGuaranteebill.executeQuery();
		stmtList.add(psGuaranteebill);
		rsList.add(rsGuaranteebill);
		Exception exception;
		if (rsGuaranteebill.next())
		{
			clearResource();
			return true;
		} else
		{
			clearResource();
			return false;
		}
		e;
		logger.debug("check9038_7错", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4038(ValidateRule checkRule)
	{
		return true;
	}

	public boolean check4174(ValidateRule checkRule)
	{
		int iExtTimes;
		String sqlExtenBak;
		ResultSet rsExtenBak;
		String sDuebillNo;
		String sOccurDate;
		Exception e;
		iExtTimes = 0;
		try
		{
			iExtTimes = (new Double(checkRule.getCheckedValue().trim())).intValue();
		}
		catch (Exception e)
		{
			logger.debug("check4174: 数据转换错", e);
			return false;
		}
		if (iExtTimes <= 1)
			return true;
		sqlExtenBak = "select ExtenTimes from ecr_LOANEXTENSION where LDuebillNo = ? and ExtenTimes <> ? and OccurDate <= ? order by ExtenTimes desc ";
		PreparedStatement psExtenBak = null;
		rsExtenBak = null;
		Segment segnebtH[] = checkRule.getRecord().getSegments("H");
		if (segnebtH == null || segnebtH.length < 1)
		{
			logger.fatal("can not find the H segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtH[0].getField("LDuebillNo").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check4174: 借据号错", e);
			return false;
		}
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		sOccurDate = "";
		try
		{
			sOccurDate = segnebtB[0].getField("OccurDate").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (Exception e)
		{
			logger.debug("check4174: 发生日期错", e);
			return false;
		}
		PreparedStatement psExtenBak = connection.prepareStatement(sqlExtenBak);
		psExtenBak.setString(1, sDuebillNo);
		psExtenBak.setString(2, (new StringBuilder()).append(iExtTimes).toString());
		psExtenBak.setString(3, Tools.handleDate(sOccurDate, "0"));
		rsExtenBak = psExtenBak.executeQuery();
		stmtList.add(psExtenBak);
		rsList.add(rsExtenBak);
		if (!rsExtenBak.next())
			break MISSING_BLOCK_LABEL_405;
		if (iExtTimes == (new Double(rsExtenBak.getString(1).trim())).intValue() + 1)
		{
			clearResource();
			return true;
		}
		break MISSING_BLOCK_LABEL_405;
		e;
		logger.debug("check4174: 数据转换错", e);
		clearResource();
		return false;
		e;
		logger.debug("check4174错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return false;
	}

	public boolean check4176(ValidateRule checkRule)
	{
		String sqlLoanReturnBak;
		ResultSet rsLoanReturnBak;
		String sDuebillNo;
		sqlLoanReturnBak = "select max(ReturnTimes) from ecr_LOANRETURN where LDuebillNo=? and returnsum <> 0 order by ReturnTimes desc ";
		PreparedStatement psLoanReturnBak = null;
		rsLoanReturnBak = null;
		Segment segnebtG[] = checkRule.getRecord().getSegments("G");
		if (segnebtG == null || segnebtG.length < 1)
		{
			logger.fatal("can not find the G segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtG[0].getField("DuebillNo").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check4176: 借据号错", e);
			return false;
		}
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		PreparedStatement psLoanReturnBak = connection.prepareStatement(sqlLoanReturnBak);
		psLoanReturnBak.setString(1, sDuebillNo);
		rsLoanReturnBak = psLoanReturnBak.executeQuery();
		stmtList.add(psLoanReturnBak);
		rsList.add(rsLoanReturnBak);
		if (!rsLoanReturnBak.next())
			break MISSING_BLOCK_LABEL_286;
		if ((new Double(checkRule.getCheckedValue().trim())).intValue() < (new Double(rsLoanReturnBak.getString(1).trim())).intValue())
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_286;
		Exception e;
		e;
		logger.debug("check4176: 数据转换错", e);
		clearResource();
		return false;
		e;
		logger.debug("check4176错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4236(ValidateRule checkRule)
	{
		int iExtTimes;
		String sqlFinaExtenBak;
		ResultSet rsFinaExtenBak;
		String sDuebillNo;
		String sOccurDate;
		Exception e;
		iExtTimes = 0;
		try
		{
			iExtTimes = (new Double(checkRule.getCheckedValue().trim())).intValue();
		}
		catch (Exception e)
		{
			e.printStackTrace();
			logger.debug("check4236: 数据转换错");
		}
		if (iExtTimes <= 1)
			return true;
		sqlFinaExtenBak = "select ExtenTimes from Ecr_FINAEXTENSION where FDuebillNo=? and  ExtenTimes <> ? and OccurDate <= ? order by ExtenTimes desc ";
		PreparedStatement psFinaExtenBak = null;
		rsFinaExtenBak = null;
		Segment segnebtH[] = checkRule.getRecord().getSegments("H");
		if (segnebtH == null || segnebtH.length < 1)
		{
			logger.fatal("can not find the H segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtH[0].getField("DuebillNo").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check4236: 融资业务借据号错", e);
			return false;
		}
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		sOccurDate = "";
		try
		{
			sOccurDate = segnebtB[0].getField("OccurDate").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (Exception e)
		{
			logger.debug("check4236: 发生日期错", e);
			return false;
		}
		PreparedStatement psFinaExtenBak = connection.prepareStatement(sqlFinaExtenBak);
		psFinaExtenBak.setString(1, sDuebillNo);
		psFinaExtenBak.setString(2, (new StringBuilder()).append(iExtTimes).toString());
		psFinaExtenBak.setString(3, Tools.handleDate(sOccurDate, "0"));
		rsFinaExtenBak = psFinaExtenBak.executeQuery();
		stmtList.add(psFinaExtenBak);
		rsList.add(rsFinaExtenBak);
		if (!rsFinaExtenBak.next())
			break MISSING_BLOCK_LABEL_408;
		if (iExtTimes == (new Double(rsFinaExtenBak.getString("ExtenTimes").trim())).intValue() + 1)
		{
			clearResource();
			return true;
		}
		break MISSING_BLOCK_LABEL_408;
		e;
		logger.debug("check4236: 数据转换错", e);
		clearResource();
		return false;
		e;
		logger.debug("check4236错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return false;
	}

	public boolean check4238(ValidateRule checkRule)
	{
		String sqlFinaReturnBak;
		ResultSet rsFinaReturnBak;
		String sDuebillNo;
		String sOccurDate;
		Exception e;
		sqlFinaReturnBak = "select ReturnTimes from ECR_FINARETURN where FDuebillNo=? and OccurDate <= ? and ReturnSum <>0 order by ReturnTimes desc ";
		PreparedStatement psFinaReturnBak = null;
		rsFinaReturnBak = null;
		Segment segmentG[] = checkRule.getRecord().getSegments("G");
		if (segmentG == null || segmentG.length < 1)
		{
			logger.fatal("can not find the G segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segmentG[0].getField("DuebillNo").getTextValue().trim();
		}
		catch (ECRException e)
		{
			logger.debug("check4238: 融资业务借据号错", e);
			return false;
		}
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		sOccurDate = "";
		try
		{
			sOccurDate = segnebtB[0].getField("OccurDate").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (Exception e)
		{
			logger.debug("check4238: 融资业务发生日期错", e);
			return false;
		}
		PreparedStatement psFinaReturnBak = connection.prepareStatement(sqlFinaReturnBak);
		psFinaReturnBak.setString(1, sDuebillNo);
		psFinaReturnBak.setString(2, Tools.handleDate(sOccurDate, "0"));
		rsFinaReturnBak = psFinaReturnBak.executeQuery();
		stmtList.add(psFinaReturnBak);
		rsList.add(rsFinaReturnBak);
		if (!rsFinaReturnBak.next())
			break MISSING_BLOCK_LABEL_347;
		if ((new Double(checkRule.getCheckedValue().trim())).intValue() < (new Double(rsFinaReturnBak.getString("ReturnTimes").trim())).intValue())
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_347;
		e;
		logger.debug("check4238: 数据转换错", e);
		clearResource();
		return false;
		e;
		logger.debug("check4238错", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check9998(ValidateRule checkRule)
	{
		String sqlloanduebillno;
		ResultSet rsloanduebillno;
		String sDuebillNo;
		SQLException e;
		sqlloanduebillno = "select LContractNo from ecr_Loanduebill where LDuebillNo=?  group by LContractNo having count(LContractNo)>1";
		PreparedStatement psloanduebillno = null;
		rsloanduebillno = null;
		Segment segnebtF[] = checkRule.getRecord().getSegments("F");
		if (segnebtF == null || segnebtF.length < 1)
		{
			logger.fatal("can not find the BASE segment");
			return false;
		}
		sDuebillNo = "";
		try
		{
			sDuebillNo = segnebtF[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check9998: 贷款合同号码错误", e);
			return false;
		}
		PreparedStatement psloanduebillno = connection.prepareStatement(sqlloanduebillno);
		psloanduebillno.setString(1, sDuebillNo);
		rsloanduebillno = psloanduebillno.executeQuery();
		stmtList.add(psloanduebillno);
		rsList.add(rsloanduebillno);
		Exception exception;
		if (rsloanduebillno.next())
		{
			clearResource();
			return false;
		} else
		{
			clearResource();
			return true;
		}
		e;
		logger.debug("check9998错,同一借据有不同主合同号", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check9999(ValidateRule checkRule)
	{
		String sqlloanduebillno;
		ResultSet rsloanduebillno;
		String sContractNo;
		SQLException e;
		sqlloanduebillno = "select FContractNo from ecr_finaduebill where FDuebillNo=? group by FContractNo having count(FContractNo)>1";
		PreparedStatement psloanduebillno = null;
		rsloanduebillno = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the B segment");
			return false;
		}
		sContractNo = "";
		try
		{
			sContractNo = segnebtB[0].getField("DuebillNo").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check9999: 贸易融资协议号码错误", e);
			return false;
		}
		PreparedStatement psloanduebillno = connection.prepareStatement(sqlloanduebillno);
		psloanduebillno.setString(1, sContractNo);
		rsloanduebillno = psloanduebillno.executeQuery();
		stmtList.add(psloanduebillno);
		rsList.add(rsloanduebillno);
		Exception exception;
		if (rsloanduebillno.next())
		{
			clearResource();
			return false;
		} else
		{
			clearResource();
			return true;
		}
		e;
		logger.debug("check9999错,同一借据有不同主合同号", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}

	public boolean check4050(ValidateRule checkRule)
	{
		String sqlForeignName;
		String sForeignName;
		String sLoancardno;
		SQLException e;
		sqlForeignName = "select ForeignName from ecr_customerinfo where Loancardno=? and CountryCode<>'CHN'";
		PreparedStatement psForeignName = null;
		ResultSet rsForeignName = null;
		sForeignName = "";
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the B segment");
			return false;
		}
		sLoancardno = "";
		try
		{
			sLoancardno = segnebtB[0].getField("Loancardno").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check4050: 贷款卡号码错误", e);
			return false;
		}
		PreparedStatement psForeignName = connection.prepareStatement(sqlForeignName);
		psForeignName.setString(1, sLoancardno);
		ResultSet rsForeignName = psForeignName.executeQuery();
		stmtList.add(psForeignName);
		rsList.add(rsForeignName);
		if (!rsForeignName.next())
			break MISSING_BLOCK_LABEL_218;
		sForeignName = rsForeignName.getString("ForeignName");
		if (sForeignName == null || sForeignName.trim().length() == 0)
		{
			clearResource();
			return false;
		}
		break MISSING_BLOCK_LABEL_218;
		e;
		logger.debug("check4050错,外文名称为空", e);
		clearResource();
		return false;
		Exception exception;
		exception;
		clearResource();
		throw exception;
		clearResource();
		return true;
	}

	public boolean check4058(ValidateRule checkRule)
	{
		Segment curSeg;
		String sLoanCardNo;
		String sOrgNo;
		String sLicenseNo;
		String sCertNo;
		String sCertType;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the B segment");
			return false;
		}
		Segment segnebtE[] = checkRule.getRecord().getSegments("E");
		if (segnebtE == null || segnebtE.length < 1)
		{
			logger.fatal("can not find the E segment");
			return false;
		}
		curSeg = checkRule.getRuleSegment();
		sLoanCardNo = "";
		sOrgNo = "";
		sLicenseNo = "";
		String sCname = "";
		sCertNo = "";
		sCertType = "";
		String sCname = curSeg.getField("CapitalProfile").getTextValue().trim();
		sLoanCardNo = curSeg.getField("LoanCardNo").getTextValue().trim();
		sOrgNo = curSeg.getField("OrgNo").getTextValue().trim();
		sLicenseNo = curSeg.getField("LicenseNo").getTextValue().trim();
		sCertNo = curSeg.getField("CertNo").getTextValue().trim();
		sCertType = curSeg.getField("CertType").getTextValue().trim();
		if ((sLoanCardNo == null || sLoanCardNo.trim().equals("")) && (sOrgNo == null || sOrgNo.trim().equals("")) && (sLicenseNo == null || sLicenseNo.trim().equals("")) && (sCertType == null || sCertType.trim().equals("")) && (sCertNo == null || sCertNo.trim().equals("")))
			return false;
		if (sLoanCardNo != null && sLoanCardNo.length() > 1 && (sLoanCardNo.trim().length() < 16 || !DKKChecker.checkDKK(sLoanCardNo.getBytes())))
			return false;
		if (sOrgNo != null && sOrgNo.length() > 1 && !OrganizeCodeChecker.organizeCodeCheck(sOrgNo))
			return false;
		if ((sCertType == null || sCertType.trim().equals("")) && !sCertNo.trim().equals("") || !sCertType.trim().equals("") && (sCertNo == null || sCertNo.trim().equals("")))
			return false;
		if (sCertType.trim().equals("0") && !PersonIDChecker.personIDChecker(sCertNo))
			return false;
		break MISSING_BLOCK_LABEL_462;
		ECRException e;
		e;
		e.printStackTrace();
		return true;
	}

	public boolean check4060(ValidateRule checkRule)
	{
		Segment segnebtF[];
		String sILoancardno;
		String sIOrgCode;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the B segment");
			return false;
		}
		segnebtF = checkRule.getRecord().getSegments("F");
		if (segnebtF == null || segnebtF.length < 1)
		{
			logger.fatal("can not find the F segment");
			return false;
		}
		sILoancardno = "";
		sIOrgCode = "";
		sILoancardno = segnebtF[0].getField("Loancardno").getTextValue().trim();
		sIOrgCode = segnebtF[0].getField("OrgNo").getTextValue().trim();
		if ((sILoancardno == null || sILoancardno.trim().equals("")) && (sIOrgCode == null || sIOrgCode.trim().equals("")))
			return false;
		if (sILoancardno != null && sILoancardno.length() > 1 && (sILoancardno.trim().length() < 16 || !DKKChecker.checkDKK(sILoancardno.getBytes())))
			return false;
		if (sIOrgCode != null && sIOrgCode.length() > 1 && !OrganizeCodeChecker.organizeCodeCheck(sIOrgCode))
			return false;
		break MISSING_BLOCK_LABEL_225;
		ECRException e;
		e;
		e.printStackTrace();
		return true;
	}

	public boolean check0001(ValidateRule checkRule)
	{
		String sqlloancardno;
		ResultSet rsloancardno;
		String sLoancardno;
		SQLException e;
		sqlloancardno = "select loancardno from ecr_customerinfo where loancardno=? group by loancardno having count(loancardno)>1";
		PreparedStatement psloancardno = null;
		rsloancardno = null;
		Segment segnebtB[] = checkRule.getRecord().getSegments("B");
		if (segnebtB == null || segnebtB.length < 1)
		{
			logger.fatal("can not find the B segment");
			return false;
		}
		sLoancardno = "";
		try
		{
			sLoancardno = segnebtB[0].getField("Loancardno").getTextValue().trim();
		}
		// Misplaced declaration of an exception variable
		catch (SQLException e)
		{
			logger.debug("check0001: 贷款卡号码错误", e);
			return false;
		}
		PreparedStatement psloancardno = connection.prepareStatement(sqlloancardno);
		psloancardno.setString(1, sLoancardno);
		rsloancardno = psloancardno.executeQuery();
		stmtList.add(psloancardno);
		rsList.add(rsloancardno);
		Exception exception;
		if (rsloancardno.next())
		{
			clearResource();
			return false;
		} else
		{
			clearResource();
			return true;
		}
		e;
		logger.debug("check0001错,同一贷款卡不能属于俩个客户", e);
		clearResource();
		return false;
		exception;
		clearResource();
		throw exception;
	}
}
