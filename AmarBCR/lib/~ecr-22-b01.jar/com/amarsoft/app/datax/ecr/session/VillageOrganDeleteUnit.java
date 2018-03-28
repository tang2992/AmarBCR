// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   VillageOrganDeleteUnit.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.bizmanage.OrganBatchDeleteFax;
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

public class VillageOrganDeleteUnit extends ExecuteUnit
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
	private Statement stat;
	private String deleteNumber;

	public VillageOrganDeleteUnit()
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
		ReportSession sess = ReportSession.getSession("32", false);
		sess.setMultiOrg(true);
		return sess;
	}

	public int execute()
	{
		transferUnitProperties();
		try
		{
			connection = ARE.getDBConnection("ecr");
			connection.setAutoCommit(false);
		}
		catch (SQLException e3)
		{
			e3.printStackTrace();
		}
		String fidList[] = getOrgList();
		if (fidList == null || fidList.length <= 0)
		{
			logger.fatal("金融机构列表获取失败!");
			return 2;
		}
		for (int i = 0; i < fidList.length; i++)
		{
			ResultSet rs = null;
			String Sql = (new StringBuilder("select count(*) from HIS_batchDeleteOrgan where SessionID = '0000000000' and financeID='")).append(fidList[i]).append("'").toString();
			String Sql2 = (new StringBuilder("select count(*) from HIS_batchDeleteFamily where SessionID = '0000000000' and financeID='")).append(fidList[i]).append("'").toString();
			int iCount = 0;
			int iCount2 = 0;
			try
			{
				if (ARE.getProperty("deleteNumber") != null)
					deleteNumber = ARE.getProperty("deleteNumber");
				RecordNumberInMessage = Integer.parseInt(deleteNumber);
				stat = connection.createStatement();
				rs = stat.executeQuery(Sql);
				if (rs.next())
					iCount = rs.getInt(1);
				rs.close();
				rs = stat.executeQuery(Sql2);
				if (rs.next())
					iCount2 = rs.getInt(1);
				rs.close();
			}
			catch (SQLException e2)
			{
				ARE.getLog().fatal("连接HIS_batchDeleteOrgan/HIS_batchDeleteFamily表失败", e2);
				e2.printStackTrace();
				return 2;
			}
			for (int j = 0; j < (RecordNumberInMessage > 0 ? Math.max(iCount, iCount2) / RecordNumberInMessage : 1) + 1; j++)
			{
				try
				{
					session = createSession();
					session.setFinanceId(fidList[i]);
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
						logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("成功！").toString());
						sessionSuccessful(session);
					}
				}
				catch (ECRException e)
				{
					logger.error(e);
					sessionFailed(session);
					return 2;
				}
				if (st == 10)
				{
					logger.info((new StringBuilder("运行处理过程")).append(session.getSessionId()).append("条件不具备！").toString());
					sessionWarning(session);
				}
				sessionFailed(session);
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
		throws ECRException
	{
		if ((session instanceof ReportSession) && session.getMessageSetType().equals("32"))
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
		TabularReader tr2;
		int totalBusiness;
		int totalRecord;
		tr = null;
		tr2 = null;
		totalBusiness = 0;
		totalRecord = 0;
		try
		{
			for (tr = new TabularReader(new DataSourceURI(ReportSession.getDatabase(), (new StringBuilder("select * from HIS_batchDeleteFamily where SessionID='")).append(session.getSessionId()).append("'").toString())); tr.next();)
			{
				totalBusiness++;
				String CIFCustomerID = tr.getString("CIFCustomerID");
				String ManagerCertType = tr.getString("ManagerCertType");
				String ManagerCertId = tr.getString("ManagerCertId");
				String MemberRelaType = tr.getString("MemberRelaType");
				String MemberCertType = tr.getString("MemberCertType");
				String MemberCertId = tr.getString("MemberCertId");
				String updateDate = tr.getString("UpdateDate");
				String where = (new StringBuilder(" where CIFCustomerId='")).append(CIFCustomerID).append("' and  ManagerCertType='").append(ManagerCertType).append("' and ManagerCertId='").append(ManagerCertId).append("' and MemberRelaType='").append(MemberRelaType).append("' and MemberCertType='").append(MemberCertType).append("' and MemberCertId='").append(MemberCertId).append("' and (updateDate<='").append(updateDate).append("')").toString();
				totalRecord += deleteData("ECR_ORGANFAMILY", where);
				totalRecord += deleteData("HIS_ORGANFAMILY", where);
				String sql = (new StringBuilder("delete from ECR_FEEDBACK where MainBusinessNo='")).append(CIFCustomerID).append("' and RecordKey like '").append(CIFCustomerID).append("@").append(ManagerCertType).append("@").append(ManagerCertId).append("@").append(MemberRelaType).append("@").append(MemberCertType).append("@").append(MemberCertId).append("%' and Recordtype in ('").append(72).append("','").append(74).append("') ").toString();
				logger.debug((new StringBuilder("Purge Sql: ")).append(sql).toString());
				totalRecord += stat.executeUpdate(sql);
			}

			connection.commit();
			logger.info((new StringBuilder("删除家族成员信息成功！共删除家族成员信息业务数：")).append(totalBusiness).append(",共删除实际记录数：").append(totalRecord).toString());
			int organTotalBusiness = 0;
			int organTotalRecord = 0;
			for (tr2 = new TabularReader(new DataSourceURI(ReportSession.getDatabase(), (new StringBuilder("select * from HIS_batchDeleteOrgan where SessionID='")).append(session.getSessionId()).append("'").toString())); tr2.next();)
			{
				organTotalBusiness++;
				String CIFCustomerId = tr2.getString("CIFCustomerId");
				String SegmentType = tr2.getString("SegmentType");
				String ManagerType = tr2.getString("ManagerType");
				String UpdateDate = tr2.getString("UpdateDate");
				String ecrTables[] = {
					"ECR_ORGANATTRIBUTE", "ECR_ORGANSTATUS", "ECR_ORGANCONTACT", "ECR_ORGANKEEPER", "ECR_ORGANSTOCKHOLDER", "ECR_ORGANRELATED", "ECR_ORGANSUPERIOR"
				};
				String hisTables[] = {
					"HIS_ORGANATTRIBUTE", "HIS_ORGANSTATUS", "HIS_ORGANCONTACT", "HIS_ORGANKEEPER", "HIS_ORGANSTOCKHOLDER", "HIS_ORGANRELATED", "HIS_ORGANSUPERIOR"
				};
				String where = (new StringBuilder(" where CIFCustomerID='")).append(CIFCustomerId).append("2012/01/01".equals(UpdateDate) ? "'" : (new StringBuilder("'  and UpdateDate<='")).append(UpdateDate).append("'").toString()).toString();
				if ("B".equals(SegmentType))
				{
					for (int i = 0; i < hisTables.length; i++)
					{
						String table = hisTables[i];
						organTotalRecord += deleteData(table, where);
					}

					organTotalRecord += deleteData("HIS_ORGANINFO", (new StringBuilder(" where CIFCustomerID='")).append(CIFCustomerId).append("2012/01/01".equals(UpdateDate) ? "'" : (new StringBuilder("'  and GATHERDATE<='")).append(UpdateDate).append("'").toString()).toString());
					for (int i = 0; i < ecrTables.length; i++)
					{
						String table = ecrTables[i];
						organTotalRecord += deleteData(table, where);
					}

					organTotalRecord += deleteData("ECR_ORGANINFO", (new StringBuilder(" where CIFCustomerID='")).append(CIFCustomerId).append("2012/01/01".equals(UpdateDate) ? "'" : (new StringBuilder("'  and GATHERDATE<='")).append(UpdateDate).append("'").toString()).toString());
				} else
				if ("C".compareTo(SegmentType) <= 0 && "I".compareTo(SegmentType) >= 0)
					if ("F".equals(SegmentType) && ManagerType != null && ManagerType.length() > 0)
					{
						organTotalRecord += deleteData("ECR_ORGANKEEPER", (new StringBuilder(String.valueOf(where))).append(" and MANAGERTYPE='").append(ManagerType).append("'").toString());
						organTotalRecord += deleteData("HIS_ORGANKEEPER", (new StringBuilder(String.valueOf(where))).append(" and MANAGERTYPE='").append(ManagerType).append("'").toString());
					} else
					{
						int index = SegmentType.getBytes()[0] - 67;
						organTotalRecord += deleteData(ecrTables[index], where);
						organTotalRecord += deleteData(hisTables[index], where);
					}
				String sql = (new StringBuilder("delete from ECR_FEEDBACK where  MainBusinessNo='")).append(CIFCustomerId).append("'  and ").append(" ( Recordtype  ='").append(71).append("'  or ").append(" ( Recordtype= '").append(73).append("'  and  RecordKey like '").append(CIFCustomerId).append("@").append(SegmentType).append("%'  ))").toString();
				logger.debug((new StringBuilder("Purge Sql: ")).append(sql).toString());
				organTotalRecord += stat.executeUpdate(sql);
			}

			connection.commit();
			logger.info((new StringBuilder("删除机构信息成功！共删除机构信息业务数：")).append(organTotalBusiness).append(",共删除实际记录数：").append(organTotalRecord).toString());
			break MISSING_BLOCK_LABEL_1369;
		}
		catch (Exception ex)
		{
			try
			{
				connection.rollback();
			}
			catch (Exception exception) { }
			logger.warn("删除业务数据出错！", ex);
		}
		if (tr != null)
			tr.close();
		if (tr2 != null)
			tr2.close();
		break MISSING_BLOCK_LABEL_1385;
		Exception exception1;
		exception1;
		if (tr != null)
			tr.close();
		if (tr2 != null)
			tr2.close();
		throw exception1;
		if (tr != null)
			tr.close();
		if (tr2 != null)
			tr2.close();
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

	private void exportFaxFile(ReportSession session)
		throws ECRException
	{
		OrganBatchDeleteFax fax = new OrganBatchDeleteFax(session);
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
