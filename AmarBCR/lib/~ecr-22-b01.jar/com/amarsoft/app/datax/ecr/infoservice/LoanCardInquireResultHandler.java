// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   LoanCardInquireResultHandler.java

package com.amarsoft.app.datax.ecr.infoservice;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;

// Referenced classes of package com.amarsoft.app.datax.ecr.infoservice:
//			LoanCard, CardQuery

public class LoanCardInquireResultHandler
	implements Handler
{

	private int feedbackCount;

	public LoanCardInquireResultHandler()
	{
		feedbackCount = 0;
	}

	public void messageStart(Message message1)
	{
	}

	public void handleHeader(Message message, Record header)
		throws ECRException
	{
		if (header.getFirstSegment("messagehead").getField("8523").getInt() == 42)
		{
			if (header.getFirstSegment("messagehead").getField("8535").getInt() != 90)
				throw new ECRException("不是-90-正常读取");
			else
				return;
		} else
		{
			throw new ECRException("不是-42－贷款卡数据批量下载结果报文");
		}
	}

	public void handleRecord(Message message, Record record)
		throws ECRException
	{
		String cardno = record.getFirstSegment("").getField("7503").getString();
		String passwd = "";
		LoanCard lcard = new LoanCard(cardno, passwd);
		lcard.setStatus(record.getFirstSegment("loancardsegment").getField("7657").getInt());
		lcard.setCountryCode(record.getFirstSegment("loancardsegment").getField("5509").getString());
		lcard.setChineseName(record.getFirstSegment("loancardsegment").getField("5505").getString());
		lcard.setEnglishName(record.getFirstSegment("loancardsegment").getField("5507").getString());
		lcard.setOrganizationCode(record.getFirstSegment("loancardsegment").getField("6511").getString());
		lcard.setLicenceCode(record.getFirstSegment("loancardsegment").getField("5517").getString());
		lcard.setLicenceRegisterDate(record.getFirstSegment("loancardsegment").getField("2505").getString());
		lcard.setKind(record.getFirstSegment("loancardsegment").getField("5523").getInt());
		lcard.setAreaCode(record.getFirstSegment("loancardsegment").getField("5527").getString());
		lcard.setLicenceExpireDate(record.getFirstSegment("loancardsegment").getField("2507").getString());
		CardQuery ucard = new CardQuery();
		ucard.update(lcard);
	}

	public void handleFooter(Message message1, Record record)
	{
	}

	public void messageEnd(Message message1)
	{
	}

	public void end(MessageSet messageset)
	{
	}

	public void start(MessageSet messageset)
	{
	}

	public void setFeedbackCount(int feedbackCount)
	{
		this.feedbackCount = feedbackCount;
	}

	public int getFeedbackCount()
	{
		return feedbackCount;
	}
}
