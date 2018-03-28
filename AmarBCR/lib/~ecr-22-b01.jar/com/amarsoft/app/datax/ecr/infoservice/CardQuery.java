// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   CardQuery.java

package com.amarsoft.app.datax.ecr.infoservice;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

// Referenced classes of package com.amarsoft.app.datax.ecr.infoservice:
//			LoanCard

public class CardQuery
{

	private int queryCode;
	protected Log logger;
	protected static Connection connection = null;
	protected Statement stmt;
	public static final String PROPERTY_DATABASE = "database";
	public static final int QUERY_OK = 0;
	public static final int QUERY_ERROR = 1;
	public static final int QUERY_FORWARD = 2;

	public CardQuery()
	{
		stmt = null;
		logger = ARE.getLog();
		String database = ARE.getProperty("database");
		try
		{
			if (connection != null)
				connection = ARE.getDBConnection(database);
		}
		catch (Exception e)
		{
			queryCode = 1;
			logger.warn(e);
		}
	}

	public boolean update(LoanCard card)
		throws ECRException
	{
		try
		{
			Date date = new Date();
			String today = (new java.sql.Date(date.getTime())).toString();
			stmt = connection.createStatement();
			String sSql = (new StringBuilder("update ecr_loancard status='")).append(card.getStatus()).append("', ").append("countryCode='").append(card.getCountryCode()).append("', ").append("chineseName='").append(card.getChineseName()).append("', ").append("englishName='").append(card.getEnglishName()).append("', ").append("organizationCode='").append(card.getOrganizationCode()).append("', ").append("licenceCode='").append(card.getLicenceCode()).append("', ").append("licenceRegisterDate='").append(card.getLicenceRegisterDate()).append("', ").append("kind='").append(card.getKind()).append("', ").append("areaCode='").append(card.getAreaCode()).append("', ").append("licenceExpireDate='").append(card.getLicenceExpireDate()).append("', ").append("updatetime='").append(today).append("' ").append(" where cardcode='").append(card.getCardcode()).append("'").toString();
			stmt.executeUpdate(sSql);
		}
		catch (Exception e)
		{
			throw new ECRException((new StringBuilder("更新贷款卡信息到本地数据库发生错误:")).append(e.toString()).toString());
		}
		return true;
	}

	public LoanCard query(LoanCard card, boolean isLocal)
	{
		ResultSet rs1;
		stmt = connection.createStatement();
		String sSql = null;
		if (!isLocal)
			break MISSING_BLOCK_LABEL_236;
		sSql = (new StringBuilder(" select password,status,countryCode,chineseName,englishName,organizationCode,licenceCode,licenceRegisterDate,kind,areaCode,licenceExpireDate,updatetime from ecr_loancard  where cardcode='")).append(card.getCardcode()).append("' ").toString();
		rs1 = stmt.executeQuery(sSql);
		if (!rs1.next())
			break MISSING_BLOCK_LABEL_227;
		if (rs1.getString("password").equals(card.getPasssword()))
			break MISSING_BLOCK_LABEL_91;
		queryCode = 1;
		return card;
		card.setStatus(rs1.getInt("status"));
		card.setCountryCode(rs1.getString("countryCode"));
		card.setChineseName(rs1.getString("chineseName"));
		card.setEnglishName(rs1.getString("englishName"));
		card.setOrganizationCode(rs1.getString("organizationCode"));
		card.setLicenceCode(rs1.getString("licenceCode"));
		card.setLicenceRegisterDate(rs1.getString("licenceRegisterDate"));
		card.setKind(rs1.getInt("kind"));
		card.setAreaCode(rs1.getString("areaCode"));
		card.setLicenceExpireDate(rs1.getString("licenceExpireDate"));
		break MISSING_BLOCK_LABEL_229;
		isLocal = false;
		rs1.close();
		if (!isLocal)
		{
			queryCode = 2;
			String sSql = (new StringBuilder(" insert into ecr_loancard(cardcode,password)  values('")).append(card.getCardcode()).append("','").append(card.getPasssword()).append("')").toString();
			stmt.executeUpdate(sSql);
		}
		stmt.close();
		connection.close();
		break MISSING_BLOCK_LABEL_334;
		SQLException e;
		e;
		queryCode = 1;
		logger.warn(e);
		return card;
		queryCode = 0;
		return card;
	}

	public int getQueryCode()
	{
		return queryCode;
	}

	public LoanCard query(LoanCard card)
	{
		return query(card, true);
	}

	public LoanCard query(String code, String passwd)
	{
		return query(code, passwd, true);
	}

	public LoanCard query(String code, String passwd, boolean isLocal)
	{
		LoanCard newCard = new LoanCard(code, passwd);
		return query(newCard, isLocal);
	}

}
