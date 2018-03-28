// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   VillageOrganReportUnit.java

package com.amarsoft.app.datax.ecr.session;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.ObjectX;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.Connection;
import com.amarsoft.are.util.StringFunction;
import com.amarsoft.task.ExecuteUnit;
import java.sql.*;
import java.util.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.session:
//			ReportSession, MessageProcessSession

public class VillageOrganReportUnit extends ExecuteUnit
{

	private MessageProcessSession session;

	public VillageOrganReportUnit()
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
		String fidList[][] = getOrgList();
		if (fidList == null || fidList.length <= 0)
		{
			logger.fatal("金融机构列表获取失败!");
			return 2;
		}
		for (int i = 0; i < fidList.length; i++)
		{
			try
			{
				session = createSession();
				session.setFinanceId(fidList[i][0]);
				session.setContactPerson(fidList[i][1]);
				session.setContactPhone(fidList[i][2]);
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

	public String[][] getOrgList()
	{
		String orgContract[][];
		int count;
		orgContract = null;
		count = 0;
		Connection conn = ARE.getDBConnection("ecr");
		Statement countStmt = conn.createStatement();
		String countSql = (new StringBuilder("select count(distinct OrgCode) from Org_Task_Info where endtime is null and taskrundate='")).append(StringFunction.getToday()).append("'").toString();
		logger.debug(countSql);
		ResultSet rs;
		for (rs = countStmt.executeQuery(countSql); rs.next();)
			count = rs.getInt(1);

		rs.close();
		countStmt.close();
		orgContract = new String[count][3];
		Statement stmt = conn.createStatement();
		String sql = (new StringBuilder("select distinct ot.OrgCode,ci.ContactPerson,ci.ContactPhone from Org_Task_Info ot,CONTACT_INFO ci where ot.orgcode=ci.orgcode and endtime is null and taskrundate='")).append(StringFunction.getToday()).append("'").toString();
		logger.debug(sql);
		ResultSet rs1 = stmt.executeQuery(sql);
		for (int i = 0; rs1.next(); i++)
		{
			orgContract[i][0] = rs1.getString(1);
			orgContract[i][1] = rs1.getString(2);
			orgContract[i][2] = rs1.getString(3);
		}

		rs1.close();
		stmt.close();
		if (count == 0)
		{
			Statement countStmt2 = conn.createStatement();
			String countSql2 = "select count(distinct OrgCode) from Org_Task_Info";
			logger.debug(countSql2);
			ResultSet rs2;
			for (rs2 = countStmt2.executeQuery(countSql2); rs2.next();)
				count = rs2.getInt(1);

			rs2.close();
			countStmt2.close();
			orgContract = new String[count][3];
			Statement stmt2 = conn.createStatement();
			String sql2 = "select distinct ot.OrgCode,ci.ContactPerson,ci.ContactPhone from Org_Task_Info ot,CONTACT_INFO ci where ot.orgcode=ci.orgcode";
			logger.debug(sql2);
			ResultSet rs3 = stmt2.executeQuery(sql2);
			for (int j = 0; rs3.next(); j++)
			{
				orgContract[j][0] = rs3.getString(1);
				orgContract[j][1] = rs3.getString(2);
				orgContract[j][2] = rs3.getString(3);
			}

			rs3.close();
			stmt2.close();
		}
		conn.close();
		return orgContract;
		SQLException e;
		e;
		new ECRException("获取报文生成机构列表出错!", e);
		return null;
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
