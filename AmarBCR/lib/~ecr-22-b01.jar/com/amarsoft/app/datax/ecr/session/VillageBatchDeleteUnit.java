// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   VillageBatchDeleteUnit.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizmanage.BatchDeleteFax;
import com.amarsoft.app.datax.ecr.bizmanage.DeletedBusiness;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.DataSourceURI;
import com.amarsoft.are.sql.TabularReader;
import com.amarsoft.task.ExecuteUnit;
import java.io.File;
import java.sql.*;
import java.util.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			ReportSession, MessageProcessSession

public class VillageBatchDeleteUnit extends ExecuteUnit
{

	private boolean exportFax;
	private boolean deleteBusiness;
	private String faxBankName;
	private String faxBankCode;
	private String faxContact;
	private String faxProposer;
	private String faxFileFormat;
	private int recordNumberInMessage;
	private MessageProcessSession session;
	private Connection connection;
	private Statement ps;

	public VillageBatchDeleteUnit()
	{
		exportFax = true;
		deleteBusiness = true;
		faxBankName = null;
		faxBankCode = null;
		faxContact = null;
		faxProposer = null;
		faxFileFormat = "HTML";
		recordNumberInMessage = 1000;
		session = null;
		connection = null;
		ps = null;
	}

	protected MessageProcessSession createSession()
		throws ECRException
	{
		ReportSession sess = ReportSession.getSession("31", false);
		sess.setMultiOrg(true);
		return sess;
	}

	public int execute()
	{
		transferUnitProperties();
		try
		{
			connection = ARE.getDBConnection("ecr");
			ps = connection.createStatement();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		String fidList[] = getOrgList();
		if (fidList == null || fidList.length <= 0)
		{
			logger.fatal("金融机构列表获取失败!");
			return 2;
		}
		recordNumberInMessage = Integer.parseInt(ARE.getProperty("deleteNumber"));
		for (int i = 0; i < fidList.length; i++)
		{
			String totalRecordNumSql = (new StringBuilder("select count(*) from HIS_BATCHDELETE where SessionID = '0000000000' and financeID in(select OrgID from ORG_TASK_INFO where OrgCode= '")).append(fidList[i]).append("')").toString();
			int iCount = 0;
			ResultSet rs = null;
			try
			{
				rs = ps.executeQuery(totalRecordNumSql);
				if (rs.next())
					iCount = rs.getInt(1);
				rs.close();
			}
			catch (SQLException e2)
			{
				ARE.getLog().fatal("连接HIS_BATCHDELETE表失败", e2);
				return 2;
			}
			for (int j = 0; j < (recordNumberInMessage > 0 ? iCount / recordNumberInMessage : 1) + 1; j++)
			{
				try
				{
					session = createSession();
					session.setFinanceId(fidList[i]);
				}
				catch (ECRException e1)
				{
					logger.fatal("创建报文处理过程失败", e1);
					return 2;
				}
				if (session == null)
				{
					logger.fatal("创建报文处理过程失败！");
					return 2;
				}
				String p;
				for (Iterator it = extendProperties.keySet().iterator(); it.hasNext(); ObjectX.setPropertyX(session, p, getProperty(p), true))
					p = (String)it.next();

				try
				{
					session.start();
				}
				catch (ECRException e)
				{
					logger.fatal((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("失败").toString(), e);
					sessionFailed(session);
					return 2;
				}
				int st = session.getStatus();
				if (st == 100)
				{
					logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("成功！").toString());
					sessionSuccessful(session);
				} else
				if (st == 10)
				{
					logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("条件不具备！").toString());
					sessionWarning(session);
				} else
				{
					logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("出错！").toString());
					sessionFailed(session);
					return 2;
				}
			}

		}

		clearResource();
		return 1;
	}

	public String[] getOrgList()
	{
		ArrayList list = new ArrayList();
		Connection conn = ARE.getDBConnection("ecr");
		Statement stmt = conn.createStatement();
		String sql = (new StringBuilder("select distinct OrgCode from Org_Task_Info where endtime is null and taskrundate='")).append(Tools.getCurrentDay("1")).append("'").toString();
		logger.debug(sql);
		ResultSet rs;
		for (rs = stmt.executeQuery(sql); rs.next(); list.add(rs.getString(1)));
		rs.close();
		stmt.close();
		if (list.size() == 0)
		{
			String sql2 = "select distinct OrgCode from Org_Task_Info";
			logger.debug(sql2);
			Statement stmt2 = conn.createStatement();
			ResultSet rs2;
			for (rs2 = stmt2.executeQuery(sql2); rs2.next(); list.add(rs2.getString(1)));
			rs2.close();
			stmt2.close();
		}
		conn.close();
		return (String[])list.toArray(new String[0]);
		SQLException e;
		e;
		new ECRException("获取报文生成机构列表出错!", e);
		return null;
	}

	protected void sessionSuccessful(MessageProcessSession session)
	{
		if ((session instanceof ReportSession) && session.getMessageSetType().equals("31"))
		{
			if (isExportFax())
				exportFaxFile((ReportSession)session);
			if (isDeleteBusiness())
				deleteBusiness((ReportSession)session);
		} else
		{
			logger.warn("不是删除报文生成期次，无法发送传真和删除数据！");
		}
	}

	private void deleteBusiness(ReportSession session)
	{
		TabularReader tr;
		int totalBusiness;
		int totalRecord;
		tr = null;
		totalBusiness = 0;
		totalRecord = 0;
		try
		{
			for (tr = new TabularReader(new DataSourceURI(ReportSession.getDatabase(), (new StringBuilder("select * from HIS_BATCHDELETE where SessionID='")).append(session.getSessionId()).append("'").toString())); tr.next();)
			{
				totalBusiness++;
				DeletedBusiness db = new DeletedBusiness();
				db.setDatabase(ReportSession.getDatabase());
				db.setBusinessType(tr.getString("BusinessType"));
				db.setContractNo(tr.getString("ContractNo"));
				db.setFinanceID(tr.getString("financeID"));
				db.setLoanCardNo(tr.getString("LoanCardNo"));
				db.setOccurDate(tr.getString("OccurDate"));
				logger.trace((new StringBuilder("delete data: ")).append(db.getFinanceID()).append(",").append(db.getContractNo()).append(",").append(db.getLoanCardNo()).toString());
				totalRecord += db.purgeData();
			}

			logger.info((new StringBuilder("删除业务数据成功！共删除业务数：")).append(totalBusiness).append(",共删除实际记录数：").append(totalRecord).toString());
			break MISSING_BLOCK_LABEL_289;
		}
		catch (Exception ex)
		{
			logger.warn("删除业务数据出错！", ex);
		}
		if (tr != null)
			tr.close();
		break MISSING_BLOCK_LABEL_297;
		Exception exception;
		exception;
		if (tr != null)
			tr.close();
		throw exception;
		if (tr != null)
			tr.close();
	}

	private void exportFaxFile(ReportSession session)
	{
		BatchDeleteFax fax = new BatchDeleteFax(session);
		if (faxBankName != null)
			fax.setBankName(faxBankName);
		if (faxBankCode != null)
			fax.setBankCode(session.getFinanceId());
		if (faxContact != null)
			fax.setContact(faxContact);
		if (faxProposer != null)
			fax.setProposer(faxProposer);
		int f;
		if (faxFileFormat.equalsIgnoreCase("xls"))
			f = 4;
		else
		if (faxFileFormat.equalsIgnoreCase("txt"))
			f = 0;
		else
			f = 1;
		try
		{
			File faxFile = fax.exportFile(f);
			logger.info((new StringBuilder("输出批量删除申请传真文件：")).append(faxFile.getPath()).toString());
		}
		catch (ECRException ex)
		{
			logger.warn("输出批量删除申请传真文件出错", ex);
		}
	}

	private void clearResource()
	{
		try
		{
			ps.close();
		}
		catch (SQLException e)
		{
			if (ps != null)
				ps = null;
			e.printStackTrace();
		}
		try
		{
			connection.close();
		}
		catch (SQLException e)
		{
			if (connection != null)
				connection = null;
			e.printStackTrace();
		}
	}

	protected void sessionFailed(MessageProcessSession messageprocesssession)
	{
	}

	protected void sessionWarning(MessageProcessSession messageprocesssession)
	{
	}

	public int getRecordNumberInMessage()
	{
		return recordNumberInMessage;
	}

	public void setRecordNumberInMessage(int recordNumberInMessage)
	{
		this.recordNumberInMessage = recordNumberInMessage;
	}

	public String getFaxFileFormat()
	{
		return faxFileFormat;
	}

	public void setFaxFileFormat(String faxFileFormat)
	{
		this.faxFileFormat = faxFileFormat;
	}

	public String getFaxContact()
	{
		return faxContact;
	}

	public void setFaxContact(String faxContact)
	{
		this.faxContact = faxContact;
	}

	public String getFaxProposer()
	{
		return faxProposer;
	}

	public void setFaxProposer(String faxProposer)
	{
		this.faxProposer = faxProposer;
	}

	public String getFaxBankCode()
	{
		return faxBankCode;
	}

	public void setFaxBankCode(String faxBankCode)
	{
		this.faxBankCode = faxBankCode;
	}

	public String getFaxBankName()
	{
		return faxBankName;
	}

	public void setFaxBankName(String faxBankName)
	{
		this.faxBankName = faxBankName;
	}

	public final boolean isExportFax()
	{
		return exportFax;
	}

	public final void setExportFax(boolean exportFax)
	{
		this.exportFax = exportFax;
	}

	public final boolean isDeleteBusiness()
	{
		return deleteBusiness;
	}

	public final void setDeleteBusiness(boolean deleteBusiness)
	{
		this.deleteBusiness = deleteBusiness;
	}
}
