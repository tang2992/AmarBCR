// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   BatchDeleteUnit.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizmanage.BatchDeleteFax;
import com.amarsoft.app.datax.ecr.bizmanage.DeletedBusiness;
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

public class BatchDeleteUnit extends ExecuteUnit
{

	private boolean exportFax;
	private boolean deleteBusiness;
	private String faxBankName;
	private String faxBankCode;
	private String faxContact;
	private String faxProposer;
	private String faxFileFormat;
	private int RecordNumberInMessage;
	private MessageProcessSession session;
	private Connection connection;
	private Statement ps;
	private String deleteNumber;

	public BatchDeleteUnit()
	{
		exportFax = true;
		deleteBusiness = true;
		faxBankName = null;
		faxBankCode = null;
		faxContact = null;
		faxProposer = null;
		faxFileFormat = "HTML";
		RecordNumberInMessage = 1000;
		session = null;
		connection = null;
		ps = null;
		deleteNumber = "1000";
	}

	public String getFaxFileFormat()
	{
		return faxFileFormat;
	}

	public void setFaxFileFormat(String faxFileFormat)
	{
		this.faxFileFormat = faxFileFormat;
	}

	protected MessageProcessSession createSession()
		throws ECRException
	{
		ReportSession sess = ReportSession.getSession("31", false);
		return sess;
	}

	public int execute()
	{
		transferUnitProperties();
		ResultSet rs = null;
		String Sql = "select count(*) from HIS_BATCHDELETE where SessionID = '0000000000'";
		int iCount = 0;
		try
		{
			connection = ARE.getDBConnection("ecr");
			if (ARE.getProperty("deleteNumber") != null)
				deleteNumber = ARE.getProperty("deleteNumber");
			RecordNumberInMessage = Integer.parseInt(deleteNumber);
			ps = connection.createStatement();
			rs = ps.executeQuery(Sql);
			if (rs.next())
				iCount = rs.getInt(1);
			rs.close();
		}
		catch (SQLException e2)
		{
			ARE.getLog().fatal("连接HIS_BATCHDELETE表失败", e2);
			e2.printStackTrace();
			return 2;
		}
		for (int i = 0; i < (RecordNumberInMessage > 0 ? iCount / RecordNumberInMessage : 1) + 1; i++)
		{
			try
			{
				session = createSession();
			}
			catch (ECRException e1)
			{
				ARE.getLog().fatal("创建报文处理过程失败", e1);
				return 2;
			}
			if (session == null)
			{
				ARE.getLog().fatal("创建报文处理过程失败！");
				return 2;
			}
			String p;
			for (Iterator it = extendProperties.keySet().iterator(); it.hasNext(); ObjectX.setPropertyX(session, p, getProperty(p), true))
				p = (String)it.next();

			try
			{
				session.start();
			}
			catch (Exception e)
			{
				return 2;
			}
			int st = session.getStatus();
			try
			{
				if (st == 100)
				{
					session.logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("成功！").toString());
					sessionSuccessful(session);
				}
			}
			catch (ECRException e)
			{
				logger.error((new StringBuilder()).append(e).toString());
				sessionFailed(session);
				return 2;
			}
			if (st == 10)
			{
				session.logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("条件不具备！").toString());
				sessionWarning(session);
				return 3;
			}
			sessionFailed(session);
		}

		clearResource();
		return 1;
	}

	protected void sessionSuccessful(MessageProcessSession session)
		throws ECRException
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
		throws ECRException
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
			throw ex;
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

	public void setRecordNumberInMessage(int recordNumberInMessage)
	{
		RecordNumberInMessage = recordNumberInMessage;
	}

	public int getRecordNumberInMessage()
	{
		return RecordNumberInMessage;
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
