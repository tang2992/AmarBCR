// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   BatchDeleteFax.java

package com.amarsoft.app.datax.ecr.bizmanage;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.session.ReportSession;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.DataSourceURI;
import com.amarsoft.are.sql.TabularReader;
import java.io.*;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.text.DecimalFormat;

public class BatchDeleteFax
{

	public static final int EXPORT_FORMAT_TXT = 0;
	public static final int EXPORT_FORMAT_HTML = 1;
	public static final int EXPORT_FORMAT_PDF = 2;
	public static final int EXPORT_FORMAT_RTF = 3;
	public static final int EXPORT_FORMAT_XLS = 4;
	private String bankName;
	private String bankCode;
	private String contact;
	private String proposer;
	private String deleteCause;
	private String isRetryReport;
	private int recordCount[];
	private String businessType[] = {
		"合计", "01贷款", "02保理", "03票据贴现", "04贸易融资", "05信用证", "06保函", "07银行承兑汇票", "08公开授信", "09垫款", 
		"10欠息"
	};
	private ReportSession session;
	private String messageFileName;

	public BatchDeleteFax(String sessionId)
		throws ECRException
	{
		bankName = null;
		bankCode = null;
		contact = null;
		proposer = null;
		deleteCause = null;
		isRetryReport = null;
		recordCount = null;
		session = null;
		messageFileName = null;
		session = new ReportSession();
		session.setSessionId(sessionId);
		session.load();
	}

	public BatchDeleteFax(ReportSession session)
	{
		bankName = null;
		bankCode = null;
		contact = null;
		proposer = null;
		deleteCause = null;
		isRetryReport = null;
		recordCount = null;
		this.session = null;
		messageFileName = null;
		this.session = session;
	}

	public File exportFile(int fileFormat)
		throws ECRException
	{
		if (recordCount == null)
			loadRecordCount();
		File f = null;
		switch (fileFormat)
		{
		case 0: // '\0'
			f = new File(session.getExportFolder(), (new StringBuilder(String.valueOf(getMessageFileName()))).append("_fax.txt").toString());
			ARE.getLog().debug((new StringBuilder("Export Fax File: ")).append(f.getPath()).toString());
			exportTxt(f);
			break;

		case 1: // '\001'
			f = new File(session.getExportFolder(), (new StringBuilder(String.valueOf(getMessageFileName()))).append("_fax.html").toString());
			ARE.getLog().debug((new StringBuilder("Export Fax File: ")).append(f.getPath()).toString());
			exportHtml(f);
			break;

		case 2: // '\002'
			f = new File(session.getExportFolder(), (new StringBuilder(String.valueOf(getMessageFileName()))).append("_fax.pdf").toString());
			ARE.getLog().debug((new StringBuilder("Export Fax File: ")).append(f.getPath()).toString());
			exportPdf(f);
			break;

		case 3: // '\003'
			f = new File(session.getExportFolder(), (new StringBuilder(String.valueOf(getMessageFileName()))).append("_fax.rtf").toString());
			ARE.getLog().debug((new StringBuilder("Export Fax File: ")).append(f.getPath()).toString());
			exportRtf(f);
			break;

		case 4: // '\004'
			f = new File(session.getExportFolder(), (new StringBuilder(String.valueOf(getMessageFileName()))).append("_fax.xls").toString());
			ARE.getLog().debug((new StringBuilder("Export Fax File: ")).append(f.getPath()).toString());
			exportXls(f);
			break;

		default:
			f = new File(session.getExportFolder(), (new StringBuilder(String.valueOf(getMessageFileName()))).append("_fax.html").toString());
			ARE.getLog().debug((new StringBuilder("Export Fax File: ")).append(f.getPath()).toString());
			exportHtml(f);
			break;
		}
		return f;
	}

	private String getMessageFileName()
	{
		if (messageFileName == null)
		{
			StringBuffer sb = new StringBuffer();
			sb.append("11");
			sb.append(session.getFinanceId());
			for (; sb.length() < 13; sb.append('0'));
			sb.append(session.getSessionId().substring(0, 6));
			sb.append("31");
			sb.append('1');
			sb.append(session.getSessionId().substring(6));
			sb.append("00");
			messageFileName = sb.toString();
		}
		return messageFileName;
	}

	public void exportTxt(File f)
		throws ECRException
	{
		DecimalFormat df = new DecimalFormat("#####");
		StringBuffer sb = new StringBuffer();
		sb.append("金融机构企业征信系统批量业务删除申请表").append("\n\n");
		sb.append("金融机构名称：").append(bankName != null ? bankName : "").append("\n");
		sb.append("金融机构代码：").append(bankCode != null ? bankCode : session.getFinanceId()).append("\n");
		sb.append("批量业务删除请求报文文件名：").append((new StringBuilder(String.valueOf(getMessageFileName()))).append(".txt").toString()).append("\n");
		sb.append("删除业务种类\t批量删除记录数").append("\n");
		for (int i = 1; i < businessType.length; i++)
		{
			sb.append(businessType[i]).append("\t");
			sb.append(recordCount[i] <= 0 ? "" : df.format(recordCount[1])).append("\n");
		}

		sb.append(businessType[0]).append("\t");
		sb.append(recordCount[0] <= 0 ? "" : df.format(recordCount[1])).append("\n");
		sb.append(isRetryReport != null ? isRetryReport : "").append("\n");
		sb.append(deleteCause != null ? deleteCause : "").append("\n");
		sb.append("申请人（盖章）：").append(proposer != null ? proposer : "");
		sb.append("联系方式：").append(contact != null ? contact : "").append("\n");
		sb.append("传真日期：").append(session.getCreateTime("yyyy年M月d日")).append("\n");
		try
		{
			FileWriter fw = new FileWriter(f);
			fw.write(sb.toString());
			fw.close();
		}
		catch (IOException ex)
		{
			throw new ECRException(ex);
		}
	}

	private void exportHtml(File f)
		throws ECRException
	{
		DecimalFormat df = new DecimalFormat("#####");
		StringBuffer sb = new StringBuffer("<html><head><title>金融机构企业征信系统批量业务删除申请表</title></head>");
		sb.append("<body topmargin=60><center>");
		sb.append("<h2>金融机构企业征信系统批量业务删除申请表<h2>").append("\n");
		sb.append("<table border=1 cellpadding=3 cellspacing=0 width=600>").append("\n");
		sb.append("<tr><td colspan=2>").append("<b>金融机构名称：</b>").append(bankName != null ? bankName : "").append("</td></tr>").append("\n");
		sb.append("<tr><td colspan=2>").append("<b>金融机构代码：</b>").append(bankCode != null ? bankCode : session.getFinanceId()).append("</td></tr>").append("\n");
		sb.append("<tr><td colspan=2>").append("<b>批量业务删除请求报文文件名：</b>").append((new StringBuilder(String.valueOf(getMessageFileName()))).append(".txt").toString()).append("</td></tr>").append("\n");
		sb.append("<tr>").append("<td width=30%><b>").append("删除业务种类").append("</b></td>").append("<td><b>").append("批量删除记录数").append("</b></td>").append("</tr>").append("\n");
		for (int i = 1; i < businessType.length; i++)
			sb.append("<tr>").append("<td>").append(businessType[i]).append("</td>").append("<td>").append(recordCount[i] <= 0 ? "&nbsp;" : df.format(recordCount[i])).append("</td>").append("</tr>").append("\n");

		sb.append("<tr>").append("<td><b>").append(businessType[0]).append("</b></td>").append("<td><b>").append(recordCount[0] <= 0 ? "&nbsp;" : df.format(recordCount[0])).append("</b></td>").append("</tr>").append("\n");
		sb.append("<tr><td colspan=2 width=100% height=100 valign=top>删除原因：").append(deleteCause != null ? deleteCause : "&nbsp;").append("</td>").append("</tr>").append("\n");
		sb.append("<tr><td colspan=2>").append("<table cellspacing=0  width=100%>");
		sb.append("<tr><td width=100% height=120 valign=top>需要重报/不重报：").append(isRetryReport != null ? isRetryReport : "&nbsp;").append("<td></tr>").append("\n");
		sb.append("<tr><td><table>");
		sb.append("<tr>").append("<td>").append("&nbsp;").append("</td>").append("<td width=40% nowrap>").append("申请人：").append(proposer != null ? proposer : "").append("</td>").append("</tr>").append("\n");
		sb.append("<tr>").append("<td>").append("&nbsp;").append("</td>").append("<td nowrap>").append("联系方式：").append(contact != null ? contact : "").append("</td>").append("</tr>").append("\n");
		sb.append("<tr>").append("<td>").append("&nbsp;").append("</td>").append("<td nowrap>").append("申请日期：").append(session.getCreateTime("yyyy年M月d日")).append("</td>").append("</tr>").append("\n");
		sb.append("<tr>").append("<td>").append("&nbsp;").append("</td>").append("<td nowrap>").append("盖章：").append("").append("</td>").append("</tr>").append("\n");
		sb.append("<tr><td colspan=2  width=100%>&nbsp;</td></tr>").append("\n");
		sb.append("</table></td></tr>");
		sb.append("</table>");
		sb.append("</td></tr></table>");
		sb.append("</center></body></html>");
		try
		{
			FileWriter fw = new FileWriter(f);
			fw.write(sb.toString());
			fw.close();
		}
		catch (IOException ex)
		{
			throw new ECRException(ex);
		}
	}

	private void exportPdf(File file)
		throws ECRException
	{
	}

	private void exportRtf(File file)
		throws ECRException
	{
	}

	private void exportXls(File f)
		throws ECRException
	{
		exportHtml(f);
	}

	private void loadRecordCount()
	{
		String sql;
		TabularReader tr;
		recordCount = new int[11];
		sql = (new StringBuilder("select BusinessType,count(*) as RecordCount from HIS_BATCHDELETE where SessionID='")).append(session.getSessionId()).append("' group by BusinessType order by BusinessType").toString();
		ARE.getLog().trace((new StringBuilder("查询删除数据:")).append(sql).toString());
		tr = null;
		DataSourceURI u = new DataSourceURI("ecr", sql);
		for (tr = new TabularReader(u); tr.next();)
		{
			String bt = tr.getString("BusinessType");
			int rc = tr.getInt("RecordCount");
			try
			{
				int k = Integer.parseInt(bt);
				if (k >= 0 && k <= 10)
				{
					recordCount[k] = rc;
					recordCount[0] += recordCount[k];
				}
			}
			catch (NumberFormatException ex)
			{
				ARE.getLog().debug(ex);
			}
		}

		break MISSING_BLOCK_LABEL_237;
		URISyntaxException ex;
		ex;
		ARE.getLog().error("查询删除数据失败！", ex);
		if (tr != null)
			tr.close();
		break MISSING_BLOCK_LABEL_245;
		ex;
		ARE.getLog().error("查询删除数据失败！", ex);
		if (tr != null)
			tr.close();
		break MISSING_BLOCK_LABEL_245;
		Exception exception;
		exception;
		if (tr != null)
			tr.close();
		throw exception;
		if (tr != null)
			tr.close();
	}

	public String getBankCode()
	{
		return bankCode;
	}

	public void setBankCode(String bankCode)
	{
		this.bankCode = bankCode;
	}

	public String getBankName()
	{
		return bankName;
	}

	public void setBankName(String bankName)
	{
		this.bankName = bankName;
	}

	public String getContact()
	{
		return contact;
	}

	public void setContact(String contact)
	{
		this.contact = contact;
	}

	public String getDeleteCause()
	{
		return deleteCause;
	}

	public void setDeleteCause(String deleteCause)
	{
		this.deleteCause = deleteCause;
	}

	public String getIsRetryReport()
	{
		return isRetryReport;
	}

	public void setIsRetryReport(String isRetryReport)
	{
		this.isRetryReport = isRetryReport;
	}

	public String getProposer()
	{
		return proposer;
	}

	public void setProposer(String proposer)
	{
		this.proposer = proposer;
	}
}
