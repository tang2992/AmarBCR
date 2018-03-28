// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncFinanceIDUnit.java

package com.amarsoft.app.datax.ecr.prepare.postprocess;

import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncFinanceIDUnit extends ExecuteUnit
{

	private Connection conn;
	private Statement smt;
	private String updateSql[];

	public SyncFinanceIDUnit()
	{
		conn = null;
		smt = null;
		updateSql = new String[24];
	}

	public int execute()
	{
		init();
		try
		{
			for (int i = 0; i < 24; i++)
			{
				logger.debug(updateSql[i]);
				smt.executeUpdate(updateSql[i]);
			}

		}
		catch (SQLException e)
		{
			logger.fatal((new StringBuilder()).append(e).append("同步金融机构代码失败!").toString());
			clearResource();
			e.printStackTrace();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void init()
	{
		try
		{
			conn = ARE.getDBConnection("ecr");
			smt = conn.createStatement();
			updateSql[0] = "update ECR_LOANDUEBILL ld set financeid=(select financeid from ecr_loancontract where lcontractNo=ld.lcontractNo) where lcontractNo in (select lcontractNo from ecr_loancontract)";
			updateSql[1] = "update ECR_LOANRETURN lr set financeid=(select financeid from ECR_LOANDUEBILL where lduebillNo=lr.lduebillNo) where lduebillNo in (select lduebillNo from ECR_LOANDUEBILL)";
			updateSql[2] = "update ECR_LOANEXTENSION le set financeid=(select financeid from ECR_LOANDUEBILL where lduebillNo=le.lduebillNo) where lduebillNo in (select lduebillNo from ECR_LOANDUEBILL)";
			updateSql[3] = "update ECR_FINADUEBILL fd set financeid=(select financeid from ecr_finainfo where fcontractNo=fd.fcontractNo) where fcontractNo in (select fcontractNo from ecr_finainfo)";
			updateSql[4] = "update ECR_FINARETURN fr set financeid=(select financeid from ECR_FINADUEBILL where fduebillNo=fr.fduebillNo) where fduebillNo in (select fduebillNo from ECR_FINADUEBILL)";
			updateSql[5] = "update ECR_FINAEXTENSION fe set financeid=(select financeid from ecr_finainfo where fduebillNo=fe.fduebillNo) where fduebillNo in (select fduebillNo from ECR_FINADUEBILL)";
			updateSql[6] = "update ECR_ASSURECONT ac set financeid=(select financeid from ECR_LOANCONTRACT where lcontractNo=ac.contractNo) where contractNo in (select lcontractNo from ECR_LOANCONTRACT) and  businesstype='1'";
			updateSql[7] = "update ECR_ASSURECONT ac set financeid=(select financeid from ECR_FACTORING where factoringNo=ac.contractNo) where contractNo in (select factoringNo from ECR_FACTORING) and businesstype='2'";
			updateSql[8] = "update ECR_ASSURECONT ac set financeid=(select financeid from ECR_FINAINFO where fcontractNo=ac.contractNo) where contractNo in (select fcontractNo from ECR_FINAINFO) and  businesstype='4'";
			updateSql[9] = "update ECR_ASSURECONT ac set financeid=(select financeid from ECR_CREDITLETTER where creditLetterNo=ac.contractNo) where contractNo in (select creditLetterNo from ECR_CREDITLETTER) and businesstype='5'";
			updateSql[10] = "update ECR_ASSURECONT ac set financeid=(select financeid from ECR_GUARANTEEBILL where guaranteeBillNo=ac.contractNo) where contractNo in (select guaranteeBillNo from ECR_GUARANTEEBILL) and businesstype='6'";
			updateSql[11] = "update ECR_ASSURECONT ac set financeid=(select financeid from ECR_ACCEPTANCE where acceptNo=ac.contractNo) where contractNo in (select acceptNo from ECR_ACCEPTANCE) and businesstype='7'";
			updateSql[12] = "update ECR_GUARANTYCONT gc set financeid=(select financeid from ECR_LOANCONTRACT where lcontractNo=gc.contractNo) where contractNo in (select lcontractNo from ECR_LOANCONTRACT) and  businesstype='1'";
			updateSql[13] = "update ECR_GUARANTYCONT gc set financeid=(select financeid from ECR_FACTORING where factoringNo=gc.contractNo) where contractNo in (select factoringNo from ECR_FACTORING) and businesstype='2'";
			updateSql[14] = "update ECR_GUARANTYCONT gc set financeid=(select financeid from ECR_FINAINFO where fcontractNo=gc.contractNo) where contractNo in (select fcontractNo from ECR_FINAINFO) and  businesstype='4'";
			updateSql[15] = "update ECR_GUARANTYCONT gc set financeid=(select financeid from ECR_CREDITLETTER where creditLetterNo=gc.contractNo) where contractNo in (select creditLetterNo from ECR_CREDITLETTER) and businesstype='5'";
			updateSql[16] = "update ECR_GUARANTYCONT gc set financeid=(select financeid from ECR_GUARANTEEBILL where guaranteeBillNo=gc.contractNo) where contractNo in (select guaranteeBillNo from ECR_GUARANTEEBILL) and businesstype='6'";
			updateSql[17] = "update ECR_GUARANTYCONT gc set financeid=(select financeid from ECR_ACCEPTANCE where acceptNo=gc.contractNo) where contractNo in (select acceptNo from ECR_ACCEPTANCE) and businesstype='7'";
			updateSql[18] = "update ECR_IMPAWNCONT ic set financeid=(select financeid from ECR_LOANCONTRACT where lcontractNo=ic.contractNo) where contractNo in (select lcontractNo from ECR_LOANCONTRACT) and  businesstype='1'";
			updateSql[19] = "update ECR_IMPAWNCONT ic set financeid=(select financeid from ECR_FACTORING where factoringNo=ic.contractNo) where contractNo in (select factoringNo from ECR_FACTORING) and businesstype='2'";
			updateSql[20] = "update ECR_IMPAWNCONT ic set financeid=(select financeid from ECR_FINAINFO where fcontractNo=ic.contractNo) where contractNo in (select fcontractNo from ECR_FINAINFO) and  businesstype='4'";
			updateSql[21] = "update ECR_IMPAWNCONT ic set financeid=(select financeid from ECR_CREDITLETTER where creditLetterNo=ic.contractNo) where contractNo in (select creditLetterNo from ECR_CREDITLETTER) and businesstype='5'";
			updateSql[22] = "update ECR_IMPAWNCONT ic set financeid=(select financeid from ECR_GUARANTEEBILL where guaranteeBillNo=ic.contractNo) where contractNo in (select guaranteeBillNo from ECR_GUARANTEEBILL) and businesstype='6'";
			updateSql[23] = "update ECR_IMPAWNCONT ic set financeid=(select financeid from ECR_ACCEPTANCE where acceptNo=ic.contractNo) where contractNo in (select acceptNo from ECR_ACCEPTANCE) and businesstype='7'";
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	private void clearResource()
	{
		try
		{
			smt.close();
		}
		catch (SQLException e)
		{
			if (smt != null)
				smt = null;
			e.printStackTrace();
		}
		try
		{
			conn.close();
		}
		catch (SQLException e)
		{
			if (conn != null)
				conn = null;
			e.printStackTrace();
		}
	}
}
