// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   VillageReportUnit.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.common.Tools;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.Connection;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;
import java.util.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			ReportSession, MessageProcessSession

public class VillageReportUnit extends ExecuteUnit
{

	private static String splitStr = "`";
	private MessageProcessSession session;

	public VillageReportUnit()
	{
		session = null;
	}

	private MessageProcessSession createSession()
		throws ECRException
	{
		String msgs = getProperty("com.amarsoft.app.datax.ecr.session.ReportSession.messageSetType", "11");
		boolean retry = getProperty("com.amarsoft.app.datax.ecr.session.ReportSession.retryMessage", false);
		ReportSession sess = ReportSession.getSession(msgs, retry);
		sess.setMultiOrg(true);
		return sess;
	}

	public final int execute()
	{
		transferUnitProperties();
		List fidList = getOrgList();
		if (fidList == null || fidList.size() <= 0)
		{
			logger.fatal("金融机构列表获取失败!");
			return 2;
		}
		for (int i = 0; i < fidList.size(); i++)
		{
			try
			{
				session = createSession();
				session.setFinanceId(((String)fidList.get(i)).split(splitStr, 3)[0]);
				session.setContactPerson(((String)fidList.get(i)).split(splitStr, 3)[1]);
				session.setContactPhone(((String)fidList.get(i)).split(splitStr, 3)[2]);
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

		return 1;
	}

	public List getOrgList()
	{
		ArrayList list = new ArrayList();
		Connection conn = null;
		try
		{
			conn = ARE.getDBConnection("ecr");
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
			new ECRException("获取报文生成机构列表出错!", e);
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
