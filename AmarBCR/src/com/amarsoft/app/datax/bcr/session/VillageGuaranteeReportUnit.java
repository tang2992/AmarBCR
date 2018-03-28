package com.amarsoft.app.datax.bcr.session;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.Connection;
import com.amarsoft.are.sql.DataSourceURI;
import com.amarsoft.are.sql.TabularReader;
import com.amarsoft.task.ExecuteUnit;

import java.net.URISyntaxException;
import java.sql.*;
import java.util.*;

public class VillageGuaranteeReportUnit extends ExecuteUnit
{

	private static String splitStr = "`";
	private MessageProcessSession session;

	public VillageGuaranteeReportUnit()
	{
		session = null;
	}

	private MessageProcessSession createSession()
		throws BCRException
	{
		String msgs = getProperty("com.amarsoft.app.datax.bcr.session.ReportSession.messageSetType", "15");
		boolean retry = getProperty("com.amarsoft.app.datax.bcr.session.ReportSession.retryMessage", false);
		ReportSession sess = ReportSession.getSession(msgs, retry);
		sess.setMultiOrg(false);
		return sess;
	}

	public final int execute()
	{
		transferUnitProperties();		
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

		return 1;
	}
	
	public List getOrgList()
	{
		ArrayList list = new ArrayList();
		Connection conn = null;
		try
		{
			conn = ARE.getDBConnection("bcr");
			Statement stmt = conn.createStatement();
			String sql = (new StringBuilder("select distinct ot.OrgCode,ci.ContactPerson,ci.ContactPhone from Org_Task_Info ot left join CONTACT_INFO ci on ot.orgcode=ci.orgcode where ot.endtime is null and ot.taskrundate='")).append(Tools.getCurrentDay("1")).append("'").toString();
			logger.debug(sql);
			ResultSet rs;
			for (rs = stmt.executeQuery(sql); rs.next(); list.add((new StringBuilder(String.valueOf(rs.getString(1)))).append(splitStr).append(StringX.isEmpty(rs.getString(2)) ? "***" : rs.getString(2)).append(splitStr).append(StringX.isEmpty(rs.getString(3)) ? "*******" : rs.getString(3)).toString()));
			rs.close();
			stmt.close();
			if (list.size() == 0)
			{
				String sql2 = "select distinct ot.OrgCode,ci.ContactPerson,ci.ContactPhone from Org_Task_Info ot left join CONTACT_INFO ci on ot.orgcode=ci.orgcode";
				logger.debug(sql2);
				Statement stmt2 = conn.createStatement();
				ResultSet rs2;
				for (rs2 = stmt2.executeQuery(sql2); rs2.next(); list.add((new StringBuilder(String.valueOf(rs2.getString(1)))).append(splitStr).append(StringX.isEmpty(rs2.getString(2)) ? "***" : rs2.getString(2)).append(splitStr).append(StringX.isEmpty(rs2.getString(3)) ? "*******" : rs2.getString(3)).toString()));
				rs2.close();
				stmt2.close();
			}
		}
		catch (SQLException e)
		{
			new BCRException("获取报文生成机构列表出错!", e);
		}
		if (conn != null)
			try
			{
				conn.close();
				conn = null;
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
			}
		return list;
	}

	protected void sessionSuccessful(MessageProcessSession messageprocesssession)
	{
	}

	protected void sessionFailed(MessageProcessSession messageprocesssession)
	{
	}

	protected void sessionWarning(MessageProcessSession messageprocesssession)
	{
	}

}
