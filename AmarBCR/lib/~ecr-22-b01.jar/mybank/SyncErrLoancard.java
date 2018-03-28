// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   SyncErrLoancard.java

package mybank;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;

public class SyncErrLoancard extends ExecuteUnit
{

	protected Log logger;
	protected Connection connection;
	protected Statement stmt;
	protected PreparedStatement pstmtQuery;
	private PreparedStatement psInsert;
	private PreparedStatement psSearch;
	private PreparedStatement psDelete;
	protected String tables[][] = {
		{
			"ecr_loancontract", "01", "LCONTRACTNO"
		}, {
			"ecr_discount", "03", "BILLNO"
		}, {
			"ecr_factoring", "02", "FACTORINGNO"
		}, {
			"ecr_finainfo", "04", "FCONTRACTNO"
		}, {
			"ecr_creditletter", "05", "CREDITLETTERNO"
		}, {
			"ecr_guaranteebill", "06", "GUARANTEEBILLNO"
		}, {
			"ecr_acceptance", "07", "ACCEPTNO"
		}, {
			"ecr_customercredit", "08", "CCONTRACTNO"
		}, {
			"ecr_interestdue", "10", "LOANCARDNO"
		}, {
			"ecr_floorfund", "09", "FLOORFUNDNO"
		}
	};
	public static final String PROPERTY_DATABASE = "database";

	public SyncErrLoancard()
	{
		connection = null;
		stmt = null;
		pstmtQuery = null;
		psInsert = null;
		psSearch = null;
		psDelete = null;
	}

	protected void init()
		throws ECRException
	{
		logger = ARE.getLog();
		String database = "ecr";
		try
		{
			connection = ARE.getDBConnection(database);
		}
		catch (SQLException e)
		{
			throw new ECRException(e);
		}
	}

	public int execute()
	{
		try
		{
			init();
			try
			{
				SearchData();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
		catch (ECRException e)
		{
			logger.fatal("初始化失败", e);
			clearResource();
			return 2;
		}
		clearResource();
		return 1;
	}

	private void SearchData()
		throws SQLException
	{
		String sqlQuery = "select oldcode[1,16] from ecr_updaterecord where incrementflag='1'  and (length(nvl(oldcode,'1'))=16 or length(nvl(oldcode,'1'))=18)";
		String sqlinsert = "insert into his_batchdelete(sessionid,occurdate,businesstype,financeid,loancardno,contractno,incrementflag) values(?,?,?,?,?,?,?) ";
		String sqldelete = "delete from his_batchdelete where incrementflag='1' and contractno=? ";
		String ErrLoanCardNo = "";
		String ContractNo = "";
		String delbusinesstype = "";
		String createdate = "";
		String sessionid = "0000000000";
		String FinanceID = "";
		String Incrementflag = "1";
		stmt = connection.createStatement();
		psInsert = connection.prepareStatement(sqlinsert);
		psDelete = connection.prepareStatement(sqldelete);
		ResultSet rs = stmt.executeQuery(sqlQuery);
		logger.debug(sqlQuery);
		while (rs.next()) 
		{
			ErrLoanCardNo = rs.getString("oldcode");
			logger.debug(ErrLoanCardNo);
			for (int i = 0; i < tables.length; i++)
				try
				{
					StringBuffer SearchSql = new StringBuffer(" ");
					String businesstype = tables[i][1];
					SearchSql.append((new StringBuilder("select '")).append(businesstype).toString()).append("' as businesstype,financeid,").append("loancardno,").append(tables[i][2]).append(" as contractno from ").append(tables[i][0]).append(" where loancardno=?");
					psSearch = connection.prepareStatement(SearchSql.toString());
					logger.debug(SearchSql.toString());
					psSearch.setString(1, ErrLoanCardNo);
					for (ResultSet rs1 = psSearch.executeQuery(); rs1.next(); psInsert.execute())
					{
						delbusinesstype = rs1.getString("businesstype");
						ErrLoanCardNo = rs1.getString("loancardno");
						FinanceID = rs1.getString("financeid");
						ContractNo = rs1.getString("contractno");
						createdate = Tools.getLastDay("1");
						logger.debug((new StringBuilder("主合同号：")).append(ContractNo).append("@业务类型：").append(delbusinesstype).toString());
						try
						{
							psDelete.setString(1, ContractNo);
							logger.debug((new StringBuilder("sqldelete：")).append(sqldelete).toString());
							psDelete.execute();
						}
						catch (SQLException e)
						{
							logger.fatal("删除已存在数据失败！", e);
							clearResource();
						}
						psInsert.setString(1, sessionid);
						psInsert.setString(2, createdate);
						psInsert.setString(3, delbusinesstype);
						psInsert.setString(4, FinanceID);
						psInsert.setString(5, ErrLoanCardNo);
						psInsert.setString(6, ContractNo);
						psInsert.setString(7, Incrementflag);
					}

				}
				catch (SQLException e)
				{
					logger.fatal("更新批量删除表失败！", e);
					clearResource();
				}

		}
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
