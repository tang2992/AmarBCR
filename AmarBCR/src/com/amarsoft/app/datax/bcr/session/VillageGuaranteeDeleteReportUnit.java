package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.bizmanage.GuaranteeBatchDeleteFax;
import com.amarsoft.app.datax.bcr.common.Tools;
import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.Connection;
import com.amarsoft.are.sql.DataSourceURI;
import com.amarsoft.are.sql.TabularReader;
import com.amarsoft.task.ExecuteUnit;

import java.io.File;
import java.net.URISyntaxException;
import java.sql.*;
import java.util.*;

public class VillageGuaranteeDeleteReportUnit extends ExecuteUnit
{

	private static String splitStr = "`";
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
	private Statement stat;
	private String deleteNumber;

	public VillageGuaranteeDeleteReportUnit()
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
		stat = null;
		deleteNumber = "1000";
	}

	private MessageProcessSession createSession()
		throws BCRException
	{
		ReportSession sess = ReportSession.getSession("17", false);
		sess.setMultiOrg(true);
		return sess;
	}

	public final int execute()
	{		
		transferUnitProperties();	
		try
		{
			connection = ARE.getDBConnection("bcr");
			connection.setAutoCommit(false);
			stat = connection.createStatement();
		}
		catch (SQLException e3)
		{
			e3.printStackTrace();
		}
		try
		{				
			session = createSession();
			session.setFinanceId(ARE.getProperty("baseFinanceId"));
		}
		catch (BCRException e1)
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
		catch (BCRException e)
		{
			logger.fatal((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("失败").toString(), e);
			sessionFailed(session);
			return 2;
		}
		int st = session.getStatus();
		if (st == 100)
		{
			logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("成功！").toString());
			try {
				sessionSuccessful(session);
			} catch (ECRException e) {
				e.printStackTrace();
			}
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
		
		clearResource();
		return 1;
	}
	

	protected void sessionSuccessful(MessageProcessSession session) throws ECRException
	{
		if ((session instanceof ReportSession) && session.getMessageSetType().equals("17"))
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
	private void deleteBusiness(ReportSession session){		
		TabularReader tr=null;
		int totalBusiness = 0;
		int totalRecord = 0;
		try {
			for (tr = new TabularReader(new DataSourceURI(ReportSession.getDatabase(), (new StringBuilder("select * from BCR_GUARANTEEDELETE where SessionID='")).append(session.getSessionId()).append("'").toString())); tr.next();){
				totalBusiness++;
				String sFinanceCode = tr.getString("FINANCECODE");
				String sGbusinessno = tr.getString("GBUSINESSNO");
				String sDeletetype = tr.getString("DELETETYPE");
				String sUpdateDate = tr.getString("UPDATEDATE");
				String bcrTables[] = {
						"BCR_GUARANTEECONT", "BCR_INSUREDS", "BCR_CREDITORINFO", "BCR_COUNTERGUARANTOR", "BCR_GUARANTEEDUTY", "BCR_COMPENSATORYINFO", "BCR_COMPENSATORYDETAIL", "BCR_RECOVERYDETAIL", "BCR_PREMIUMINFO", "BCR_PREMIUMDETAIL" 
					};
				String hisTables[] = {
						"HIS_GUARANTEECONT", "HIS_INSUREDS", "HIS_CREDITORINFO", "HIS_COUNTERGUARANTOR", "HIS_GUARANTEEDUTY", "HIS_COMPENSATORYINFO", "HIS_COMPENSATORYDETAIL", "HIS_RECOVERYDETAIL", "HIS_PREMIUMINFO", "HIS_PREMIUMDETAIL" 
					};
				String where = (new StringBuilder(" where GBUSINESSNO='")).append(sGbusinessno).append("2012/01/01".equals(sUpdateDate) ? "'" : (new StringBuilder("'  and OCCURDATE<='")).append(sUpdateDate).append("'").toString()).toString();
				if ("1".equals(sDeletetype)){
					
					for (int i = 0; i < hisTables.length; i++)
					{
						String table = hisTables[i];
						totalRecord += deleteData(table, where);
					}
					totalRecord += deleteData("HIS_GUARANTEEINFO", where);
					for (int i = 0; i < bcrTables.length; i++)
					{
						String table = bcrTables[i];
						totalRecord += deleteData(table, where);
					}
					totalRecord += deleteData("BCR_GUARANTEEINFO", where);
	
				}else if("2".equals(sDeletetype)){
					totalRecord += deleteData("HIS_GUARANTEEDUTY", where);	
					totalRecord += deleteData("BCR_GUARANTEEDUTY", where);									
				}else if("3".equals(sDeletetype)){
					totalRecord += deleteData("HIS_COMPENSATORYINFO", where);
					totalRecord += deleteData("HIS_COMPENSATORYDETAIL", where);	
					totalRecord += deleteData("HIS_RECOVERYDETAIL", where);	
					totalRecord += deleteData("BCR_COMPENSATORYINFO", where);
					totalRecord += deleteData("BCR_COMPENSATORYDETAIL", where);	
					totalRecord += deleteData("BCR_RECOVERYDETAIL", where);					
				}else if("4".equals(sDeletetype)){
					totalRecord += deleteData("HIS_PREMIUMINFO", where);	
					totalRecord += deleteData("HIS_PREMIUMDETAIL", where);	
					totalRecord += deleteData("BCR_PREMIUMINFO", where);
					totalRecord += deleteData("BCR_PREMIUMDETAIL", where);	
				}else{
					logger.error("担保业务:删除类型不正确!!!");
				}
				String sql = (new StringBuilder("delete from BCR_FEEDBACK where  MainBusinessNo='")).append(sGbusinessno).append("' ").toString();
				logger.debug((new StringBuilder("Purge Sql: ")).append(sql).toString());	
			}
			
			connection.commit();
			logger.info((new StringBuilder("删除担保业务信息成功！共删除担保业务数：")).append(totalBusiness).append(",共删除实际记录数：").append(totalRecord).toString());
		} catch (Exception ex) {
			try{
				connection.rollback();
			}catch (Exception exception) { }
			logger.warn("删除业务数据出错！", ex);
		}finally{
			if (tr != null){
				tr.close();
				tr=null;
			}
		}			
	}
	
	private int deleteData(String table, String where)
			throws SQLException
		{
			int x = 0;
			String sql = (new StringBuilder("delete from ")).append(table).append(" ").append(where).toString();
			logger.debug((new StringBuilder("Purge Sql: ")).append(sql).toString());
			x += stat.executeUpdate(sql);
			return x;
		}
	
	private void exportFaxFile(ReportSession session) throws ECRException{
		
		GuaranteeBatchDeleteFax fax = new GuaranteeBatchDeleteFax(session);
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
		catch (BCRException ex)
		{
			logger.warn("输出批量删除申请传真文件出错", ex);
		}		
	}
	
	private void clearResource()
	{
		try
		{
			if (stat != null)
			{
				stat.close();
				stat = null;
			}
			if (connection != null)
			{
				connection.close();
				connection = null;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	protected void sessionFailed(MessageProcessSession messageprocesssession)
	{
	}

	protected void sessionWarning(MessageProcessSession messageprocesssession)
	{
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
