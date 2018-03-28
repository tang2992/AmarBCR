// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncErrCustomerInfo.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.io.PrintStream;
import java.sql.*;

public class SyncErrCustomerInfo extends ExecuteUnit
{

	public static final String PROPERTY_DATABASE = "database";
	private static PreparedStatement pstmSelect = null;
	protected Log logger;
	protected static Connection connection = null;
	protected Statement stmt;
	protected static String tables[][] = {
		{
			"ECR_CUSTOMERinfo", "LoanCardNo"
		}, {
			"ECR_CUSTOMERKEEPER", "LoanCardNo"
		}, {
			"ECRP_FINANCEBS", "LoanCardNo"
		}, {
			"ECRP_FINANCEPS", "LoanCardNo"
		}, {
			"ECRP_FINANCECF", "LoanCardNo"
		}, {
			"ECRP_FINANCECF", "LoanCardNo"
		}, {
			"ECR_CUSTOMERLAW", "LoanCardNo"
		}, {
			"ECR_CUSTOMERFACT", "LoanCardNo"
		}, {
			"ECR_CONTRACT", "LoanCardID"
		}, {
			"ECR_DUEBILL", "LoanCardID"
		}, {
			"ECR_LOANRETURN", "LoanCardID"
		}, {
			"ECR_EXTENSION", "LoanCardID"
		}, {
			"ECR_GUARANTEEBILL", "LoanCardID"
		}, {
			"ECR_FACTORING", "LoanCardID"
		}, {
			"ECR_FLOORFUND", "LoanCardID"
		}, {
			"ECR_CUSTOMERCREDIT", "LoanCardID"
		}, {
			"ECR_FINANCEINFO", "LoanCardID"
		}, {
			"ECR_FINADUEBILL", "LoanCardID"
		}, {
			"ECR_FINANCERETURN", "LoanCardID"
		}, {
			"ECR_FINAEXTENSION", "LoanCardID"
		}, {
			"ECR_DISCOUNT", "LoanCardID"
		}, {
			"ECR_INTERESTDUE", "LoanCardID"
		}, {
			"ECR_CREDITLETTER", "LoanCardID"
		}, {
			"ECR_ACCEPTANCE", "LoanCardID"
		}, {
			"ECR_ASSURECONT", "LoanCardID"
		}, {
			"ECR_GUARANTYCONT", "LoanCardID"
		}, {
			"ECR_GUARANTYINFO", "LoanCardID"
		}, {
			"ECR_IMPAWNCONT", "LoanCardID"
		}, {
			"ECR_IMPAWNINFO", "LoanCardID"
		}, {
			"ECR_CUSTOMERCREDIT", "LoanCardID"
		}, {
			"ECR_R01SB", "B7503"
		}, {
			"ECR_R02SB", "B7503"
		}, {
			"ECR_R03SB", "B7503"
		}, {
			"ECR_R04SB", "B7503"
		}, {
			"ECR_R05SB", "B7503"
		}, {
			"ECR_R06SB", "B7503"
		}, {
			"ECR_R07SB", "B7503"
		}, {
			"ECR_R08SB", "B7503"
		}, {
			"ECR_R09SB", "B7503"
		}, {
			"ECR_R10SB", "B7503"
		}, {
			"ECR_R11SB", "B7503"
		}, {
			"ECR_R14SB", "B7503"
		}, {
			"ECR_R15SB", "B7503"
		}, {
			"ECR_R16SB", "B7503"
		}, {
			"ECR_R17SB", "B7503"
		}, {
			"ECR_R22SB", "B7503"
		}, {
			"ECR_R23SB", "B7503"
		}, {
			"ECR_R24SB", "B7503"
		}, {
			"ECR_R26SB", "B7503"
		}
	};
	protected String tablesbak[][] = {
		{
			"ECR_R12SB", "ECR_R12SD"
		}, {
			"ECR_R13SB", "ECR_R13SD"
		}, {
			"ECR_R18SB", "ECR_R18SD"
		}, {
			"ECR_R19SB", "ECR_R19SD"
		}, {
			"ECR_R20SB", "ECR_R20SD"
		}, {
			"ECR_R21SB", "ECR_R21SD"
		}, {
			"ECR_R25SB", "ECR_R25SD"
		}
	};

	public SyncErrCustomerInfo()
	{
		stmt = null;
	}

	public int execute()
	{
		String sqlSelect = "select * from ecr_syncerrcard ";
		String newloancardno = "";
		String oldloancardno = "";
		try
		{
			init();
		}
		catch (ECRException e)
		{
			logger.fatal("≥ı ºªØ ß∞‹", e);
			clearResource();
			return 2;
		}
		try
		{
			pstmSelect = connection.prepareStatement(sqlSelect);
			ResultSet rs0 = pstmSelect.executeQuery();
			if (rs0.next())
			{
				newloancardno = rs0.getString("newloancarno");
				oldloancardno = rs0.getString("oldloancarno");
				updateTable(newloancardno, oldloancardno);
				updateBakTable(newloancardno, oldloancardno);
				logger.info((new StringBuilder("loancardno:")).append(newloancardno).toString());
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		clearResource();
		return 1;
	}

	protected void init()
		throws ECRException
	{
		logger = ARE.getLog();
		String database = "ecr";
		try
		{
			connection = ARE.getDBConnection(database);
			stmt = connection.createStatement();
		}
		catch (SQLException e)
		{
			throw new ECRException(e);
		}
	}

	private int updateTable(String newLoancardNo, String oldLoancardNo)
		throws SQLException
	{
		for (int i = 0; i < tables.length; i++)
		{
			StringBuffer sql = new StringBuffer("");
			try
			{
				sql.append("update ").append(tables[i][0]).append(" set ").append(tables[i][1]).append("='").append(newLoancardNo).append("',modflag='2' where ").append(tables[i][1]).append("='").append(oldLoancardNo).append("'");
				logger.trace(sql.toString());
				System.out.println(sql.toString());
				stmt.executeUpdate(sql.toString());
			}
			catch (SQLException e)
			{
				logger.fatal("–ﬁ’˝¥ÌŒÛ¥˚øÓø® ß∞‹£°", e);
				clearResource();
				return 2;
			}
		}

		return 1;
	}

	private int updateBakTable(String newLoancardNo, String oldLoancardNo)
		throws SQLException
	{
		for (int i = 0; i < tablesbak.length; i++)
		{
			StringBuffer sqlbakcardno = new StringBuffer("");
			StringBuffer sqlbakmod = new StringBuffer("");
			try
			{
				sqlbakcardno.append("update ").append(tablesbak[i][1]).append(" set D7503='").append(newLoancardNo).append("' where D7503='").append(oldLoancardNo).append("'");
				logger.trace(sqlbakcardno.toString());
				System.out.println(sqlbakmod.toString());
				stmt.executeUpdate(sqlbakcardno.toString());
				sqlbakmod.append("update ").append(tablesbak[i][0]).append(" set modflag='2'").append(" where recordkey =(select recordkey from ").append(tablesbak[i][1]).append(" where ").append(tablesbak[i][1]).append(".recordkey=").append(tablesbak[i][0]).append(".recordkey)").append("' and D7503='").append(newLoancardNo).append("'");
				System.out.println(sqlbakcardno.toString());
				stmt.executeUpdate(sqlbakmod.toString());
			}
			catch (SQLException e)
			{
				logger.fatal("–ﬁ’˝±∏∑›±Ì¥ÌŒÛ¥˚øÓø® ß∞‹£°", e);
				clearResource();
				return 2;
			}
		}

		clearResource();
		return 1;
	}

	private void clearResource()
	{
		if (stmt != null)
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
		if (connection != null)
		{
			try
			{
				connection.close();
			}
			catch (SQLException e)
			{
				logger.warn(e);
			}
			connection = null;
		}
	}

}
