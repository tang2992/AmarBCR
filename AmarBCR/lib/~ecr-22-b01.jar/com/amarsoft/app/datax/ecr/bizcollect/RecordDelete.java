// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   RecordDelete.java

package com.amarsoft.app.datax.ecr.bizcollect;

import com.amarsoft.app.datax.ecr.common.RecordDBReflector;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.log.Log;
import java.sql.*;

public class RecordDelete
{

	private static String database = "ecr";
	private static String deleteMessage = null;
	private static Log logger = ARE.getLog();
	private static RecordDBReflector reflector = null;

	public RecordDelete()
	{
	}

	public static int deleteRecord(int recordType, Field recordKey[])
	{
		Connection conn;
		Statement stmt;
		conn = null;
		stmt = null;
		deleteMessage = null;
		try
		{
			conn = ARE.getDBConnection(database);
			int isolation = ARE.getProperty("connection.ecr.isolation", -1);
			if (isolation != -1)
			{
				logger.debug((new StringBuilder("JDBC transactionIsolation set to ")).append(isolation).toString());
				conn.setTransactionIsolation(isolation);
			}
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
		}
		catch (SQLException e)
		{
			logger.debug(e);
			deleteMessage = (new StringBuilder("连接征信数据库失败。(")).append(e.getMessage()).append(")").toString();
			if (conn != null)
				try
				{
					conn.close();
				}
				catch (SQLException ex)
				{
					logger.debug(ex);
				}
			return -1;
		}
		if (!checkParameter(recordType, recordKey))
		{
			if (conn != null)
				try
				{
					conn.close();
				}
				catch (SQLException ex)
				{
					logger.debug(ex);
				}
			return -1;
		}
		if (checkUnreportedRecord(stmt, recordType, recordKey))
			break MISSING_BLOCK_LABEL_217;
		if (conn != null)
			try
			{
				conn.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
		return -1;
		String lastOccurDate;
		lastOccurDate = getLastOccurDate(stmt, recordType, recordKey);
		if (lastOccurDate != null)
			break MISSING_BLOCK_LABEL_257;
		if (conn != null)
			try
			{
				conn.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
		return -1;
		if (checkRelativeRecord(stmt, recordType, recordKey, lastOccurDate))
			break MISSING_BLOCK_LABEL_295;
		if (conn != null)
			try
			{
				conn.close();
			}
			catch (SQLException ex)
			{
				logger.debug(ex);
			}
		return -1;
		try
		{
			deleteMainRecord(stmt, recordType, recordKey, lastOccurDate);
			conn.commit();
			if (conn != null)
				try
				{
					conn.close();
				}
				catch (SQLException ex)
				{
					logger.debug(ex);
				}
			deleteMessage = "删除记录成功！";
		}
		catch (SQLException e1)
		{
			logger.debug(e1);
			deleteMessage = (new StringBuilder("处理过程出现数据库错误。(")).append(e1.getMessage()).append(")").toString();
			if (conn != null)
				try
				{
					conn.rollback();
					conn.close();
				}
				catch (SQLException ex)
				{
					logger.debug(ex);
				}
			return -1;
		}
		return 0;
	}

	private static boolean checkParameter(int recordType, Field recordKey[])
	{
		reflector = RecordDBReflector.getReflector(recordType);
		if (reflector == null)
		{
			deleteMessage = (new StringBuilder("无效的删除记录类型参数：")).append(recordType).toString();
			return false;
		}
		Field rk[] = reflector.getMainKeyColumn();
		if (rk.length != recordKey.length)
		{
			deleteMessage = (new StringBuilder("记录标识字段个数不一致。正确需要：")).append(rk.length).append("实际给出了：").append(recordKey.length).toString();
			return false;
		}
		Field ek = null;
		for (int i = 0; i < rk.length; i++)
		{
			int j;
			for (j = 0; j < recordKey.length; j++)
				if (rk[i].equals(recordKey[j]))
					break;

			if (j != recordKey.length)
				continue;
			ek = rk[i];
			break;
		}

		if (ek != null)
		{
			deleteMessage = (new StringBuilder("必须的关键字段参数未提供：")).append(ek.getName()).toString();
			return false;
		}
		for (int i = 0; i < recordKey.length; i++)
			if (recordKey[i].isNull())
			{
				deleteMessage = (new StringBuilder("关键字段参数不能为空值：")).append(recordKey[i].getName()).toString();
				return false;
			}

		return true;
	}

	private static boolean checkUnreportedRecord(Statement stmt, int recordType, Field recordKey[])
		throws SQLException
	{
		StringBuffer sb = new StringBuffer();
		sb.append("select count(*) as recordCount from HIS_").append(reflector.getMainTable());
		sb.append(" where (SessionID='").append("0000000000").append("' or SessionID='").append("1111111111").append("')");
		for (int i = 0; i < recordKey.length; i++)
		{
			sb.append(" and ");
			sb.append(recordKey[i].getName()).append("=");
			if (recordKey[i].getType() == 1)
			{
				sb.append(recordKey[i].getInt());
			} else
			{
				sb.append("'");
				sb.append(recordKey[i].getString());
				sb.append("'");
			}
		}

		String sql = sb.toString();
		logger.debug((new StringBuilder("Check Unreported Record: ")).append(sql).toString());
		ResultSet rs = stmt.executeQuery(sql);
		int k = 0;
		if (rs.next())
		{
			k = rs.getInt(1);
			if (rs.wasNull())
				k = 0;
		}
		rs.close();
		if (k > 0)
		{
			deleteMessage = "此业务有正待生成报文的记录，不能上报删除！";
			return false;
		} else
		{
			return true;
		}
	}

	private static String getLastOccurDate(Statement stmt, int recordType, Field recordKey[])
		throws SQLException
	{
		StringBuffer sb = new StringBuffer();
		sb.append("select max(OccurDate) as OccurDate from HIS_").append(reflector.getMainTable());
		sb.append(" where ");
		for (int i = 0; i < recordKey.length; i++)
		{
			sb.append(recordKey[i].getName()).append("=");
			if (recordKey[i].getType() == 1)
			{
				sb.append(recordKey[i].getInt());
			} else
			{
				sb.append("'");
				sb.append(recordKey[i].getString());
				sb.append("'");
			}
			sb.append(" and ");
		}

		sb.append("IncrementFlag<>'").append("4").append("'");
		String occurDate = null;
		String sql = sb.toString();
		logger.debug((new StringBuilder("Get Last Occur Date: ")).append(sql).toString());
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next())
		{
			occurDate = rs.getString("OccurDate");
			if (rs.wasNull())
			{
				occurDate = null;
				deleteMessage = "记录没有上报历史，无法删除！";
			}
		} else
		{
			deleteMessage = "记录没有上报历史，无法删除！";
		}
		rs.close();
		return occurDate;
	}

	private static boolean checkRelativeRecord(Statement stmt, int recordType, Field recordKey[], String lastOccurDate)
		throws SQLException
	{
		String bt = reflector.getLoanBusinessType();
		if (bt == null)
			return true;
		if (reflector.isRootRecord())
		{
			String sql = (new StringBuilder("select count(*) as GuarantyNumber from HIS_ASSURECONT where ContractNo='")).append(recordKey[0].getString()).append("' and BusinessType='").append(bt).append("' and OccurDate>'").append(lastOccurDate).append("'").append("union select count(*) as GuarantyNumber from HIS_GUARANTYCONT where ContractNo='").append(recordKey[0].getString()).append("' and BusinessType='").append(bt).append("' and OccurDate>'").append(lastOccurDate).append("'").append("union select count(*) as GuarantyNumber from HIS_IMPAWNCONT where ContractNo='").append(recordKey[0].getString()).append("' and BusinessType='").append(bt).append("' and OccurDate>'").append(lastOccurDate).append("'").toString();
			logger.debug(sql);
			ResultSet rs = stmt.executeQuery(sql);
			int n;
			for (n = 0; rs.next(); n += rs.getInt(1));
			rs.close();
			if (n > 0)
			{
				deleteMessage = (new StringBuilder("主业务")).append(recordKey[0].getString()).append("在").append(lastOccurDate).append("后，有新发生的担保信息，不能进行删除！").toString();
				return false;
			}
		}
		if (bt.equals("1"))
		{
			String maxDate = getMaxOccurDateOfLoan(stmt, recordType, recordKey);
			if (maxDate != null && maxDate.compareTo(lastOccurDate) > 0)
			{
				deleteMessage = "贷款业务必须从整个合同下最后发生的记录开始删除！";
				return false;
			}
		}
		if (bt.equals("4"))
		{
			String maxDate = getMaxOccurDateOfFinancing(stmt, recordType, recordKey);
			if (maxDate != null && maxDate.compareTo(lastOccurDate) > 0)
			{
				deleteMessage = "贸易融资业务必须从整个合同下最后发生的记录开始删除！";
				return false;
			}
		}
		return true;
	}

	private static String getMaxOccurDateOfLoan(Statement stmt, int recordType, Field recordKey[])
		throws SQLException
	{
		String maxOccurDate = "";
		if (recordType == 8)
		{
			String sql = (new StringBuilder("select max(OccurDate) from HIS_LOANDUEBILL where LContractNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_LOANRETURN where LDuebillNo in(select LDuebillNo from HIS_LOANDUEBILL where LContractNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_LOANEXTENSION where LDuebillNo in(select LDuebillNo from HIS_LOANDUEBILL where LContractNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
		}
		if (recordType == 9)
		{
			String sql = (new StringBuilder("select max(OccurDate) from HIS_LOANCONTRACT where LContractNo in(select LContractNo from HIS_LOANDUEBILL where LDuebillNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_LOANEXTENSION where LDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_LOANRETURN where LDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
		}
		if (recordType == 10)
		{
			String sql = (new StringBuilder("select max(OccurDate) from HIS_LOANCONTRACT where LContractNo in(select LContractNo from HIS_LOANDUEBILL where LDuebillNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_LOANDUEBILL where LDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_LOANEXTENSION where LDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
		}
		if (recordType == 11)
		{
			String sql = (new StringBuilder("select max(OccurDate) from HIS_LOANCONTRACT where LContractNo in(select LContractNo from HIS_LOANDUEBILL where LDuebillNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_LOANDUEBILL where LDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_LOANRETURN where LDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Loan Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
		}
		return maxOccurDate;
	}

	private static String getMaxOccurDateOfFinancing(Statement stmt, int recordType, Field recordKey[])
		throws SQLException
	{
		String maxOccurDate = "";
		if (recordType == 14)
		{
			String sql = (new StringBuilder("select max(OccurDate) from HIS_FINADUEBILL where FContractNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_FINARETURN where FDuebillNo in(select FDuebillNo from HIS_FINADUEBILL where FContractNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_FINAEXTENSION where FDuebillNo in(select FDuebillNo from HIS_FINADUEBILL where FContractNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
		}
		if (recordType == 15)
		{
			String sql = (new StringBuilder("select max(OccurDate) from HIS_FINAINFO where FContractNo in(select FContractNo from HIS_FINADUEBILL where FDuebillNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_FINAEXTENSION where FDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_FINARETURN where FDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
		}
		if (recordType == 16)
		{
			String sql = (new StringBuilder("select max(OccurDate) from HIS_FINAINFO where FContractNo in(select FContractNo from HIS_FINADUEBILL where FDuebillNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_FINADUEBILL where FDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_FINAEXTENSION where FDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
		}
		if (recordType == 17)
		{
			String sql = (new StringBuilder("select max(OccurDate) from HIS_FINAINFO where FContractNo in(select FContractNo from HIS_FINADUEBILL where FDuebillNo='")).append(recordKey[0].getString()).append("') and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_FINADUEBILL where FDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
			sql = (new StringBuilder("select max(OccurDate) from HIS_FINARETURN where FDuebillNo='")).append(recordKey[0].getString()).append("' and IncrementFlag<>'").append("4").append("'").toString();
			logger.debug((new StringBuilder("Get Financing Max OccurDate: ")).append(sql).toString());
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				String d = rs.getString(1);
				if (d != null && d.compareTo(maxOccurDate) > 0)
					maxOccurDate = d;
			}
			rs.close();
		}
		return maxOccurDate;
	}

	private static void deleteMainRecord(Statement stmt, int recordType, Field recordKey[], String lastOccurDate)
		throws SQLException
	{
		StringBuffer sb = new StringBuffer(" where ");
		for (int i = 0; i < recordKey.length; i++)
		{
			sb.append(recordKey[i].getName()).append("=");
			if (recordKey[i].getType() == 1)
			{
				sb.append(recordKey[i].getInt());
			} else
			{
				sb.append("'");
				sb.append(recordKey[i].getString());
				sb.append("'");
			}
			sb.append(" and ");
		}

		sb.append("OccurDate='").append(lastOccurDate).append("'");
		String sql = (new StringBuilder("update HIS_")).append(reflector.getMainTable()).append(" set SessionID='").append("0000000000").append("'").append(", IncrementFlag='").append("4").append("'").append(sb.toString()).toString();
		logger.debug((new StringBuilder("Delete main table: ")).append(sql).toString());
		stmt.executeUpdate(sql);
		String rt[] = reflector.getRelativeTables();
		for (int i = 0; i < rt.length; i++)
		{
			String rsql = (new StringBuilder("update HIS_")).append(rt[i]).append(" set SessionID='").append("0000000000").append("'").append(", IncrementFlag='").append("4").append("'").append(sb.toString()).toString();
			logger.debug((new StringBuilder("Delete relative table: ")).append(rsql).toString());
			stmt.executeUpdate(rsql);
		}

	}

	public static String getMessage()
	{
		return deleteMessage;
	}

	public static void setDatabase(String ecrDatabase)
	{
		database = ecrDatabase;
	}

}
