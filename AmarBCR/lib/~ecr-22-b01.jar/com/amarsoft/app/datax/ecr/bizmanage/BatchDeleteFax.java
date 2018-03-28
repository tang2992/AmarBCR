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
		"�ϼ�", "01����", "02����", "03Ʊ������", "04ó������", "05����֤", "06����", "07���гжһ�Ʊ", "08��������", "09���", 
		"10ǷϢ"
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
		sb.append("���ڻ�����ҵ����ϵͳ����ҵ��ɾ�������").append("\n\n");
		sb.append("���ڻ������ƣ�").append(bankName != null ? bankName : "").append("\n");
		sb.append("���ڻ������룺").append(bankCode != null ? bankCode : session.getFinanceId()).append("\n");
		sb.append("����ҵ��ɾ���������ļ�����").append((new StringBuilder(String.valueOf(getMessageFileName()))).append(".txt").toString()).append("\n");
		sb.append("ɾ��ҵ������\t����ɾ����¼��").append("\n");
		for (int i = 1; i < businessType.length; i++)
		{
			sb.append(businessType[i]).append("\t");
			sb.append(recordCount[i] <= 0 ? "" : df.format(recordCount[1])).append("\n");
		}

		sb.append(businessType[0]).append("\t");
		sb.append(recordCount[0] <= 0 ? "" : df.format(recordCount[1])).append("\n");
		sb.append(isRetryReport != null ? isRetryReport : "").append("\n");
		sb.append(deleteCause != null ? deleteCause : "").append("\n");
		sb.append("�����ˣ����£���").append(proposer != null ? proposer : "");
		sb.append("��ϵ��ʽ��").append(contact != null ? contact : "").append("\n");
		sb.append("�������ڣ�").append(session.getCreateTime("yyyy��M��d��")).append("\n");
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
		StringBuffer sb = new StringBuffer("<html><head><title>���ڻ�����ҵ����ϵͳ����ҵ��ɾ�������</title></head>");
		sb.append("<body topmargin=60><center>");
		sb.append("<h2>���ڻ�����ҵ����ϵͳ����ҵ��ɾ�������<h2>").append("\n");
		sb.append("<table border=1 cellpadding=3 cellspacing=0 width=600>").append("\n");
		sb.append("<tr><td colspan=2>").append("<b>���ڻ������ƣ�</b>").append(bankName != null ? bankName : "").append("</td></tr>").append("\n");
		sb.append("<tr><td colspan=2>").append("<b>���ڻ������룺</b>").append(bankCode != null ? bankCode : session.getFinanceId()).append("</td></tr>").append("\n");
		sb.append("<tr><td colspan=2>").append("<b>����ҵ��ɾ���������ļ�����</b>").append((new StringBuilder(String.valueOf(getMessageFileName()))).append(".txt").toString()).append("</td></tr>").append("\n");
		sb.append("<tr>").append("<td width=30%><b>").append("ɾ��ҵ������").append("</b></td>").append("<td><b>").append("����ɾ����¼��").append("</b></td>").append("</tr>").append("\n");
		for (int i = 1; i < businessType.length; i++)
			sb.append("<tr>").append("<td>").append(businessType[i]).append("</td>").append("<td>").append(recordCount[i] <= 0 ? "&nbsp;" : df.format(recordCount[i])).append("</td>").append("</tr>").append("\n");

		sb.append("<tr>").append("<td><b>").append(businessType[0]).append("</b></td>").append("<td><b>").append(recordCount[0] <= 0 ? "&nbsp;" : df.format(recordCount[0])).append("</b></td>").append("</tr>").append("\n");
		sb.append("<tr><td colspan=2 width=100% height=100 valign=top>ɾ��ԭ��").append(deleteCause != null ? deleteCause : "&nbsp;").append("</td>").append("</tr>").append("\n");
		sb.append("<tr><td colspan=2>").append("<table cellspacing=0  width=100%>");
		sb.append("<tr><td width=100% height=120 valign=top>��Ҫ�ر�/���ر���").append(isRetryReport != null ? isRetryReport : "&nbsp;").append("<td></tr>").append("\n");
		sb.append("<tr><td><table>");
		sb.append("<tr>").append("<td>").append("&nbsp;").append("</td>").append("<td width=40% nowrap>").append("�����ˣ�").append(proposer != null ? proposer : "").append("</td>").append("</tr>").append("\n");
		sb.append("<tr>").append("<td>").append("&nbsp;").append("</td>").append("<td nowrap>").append("��ϵ��ʽ��").append(contact != null ? contact : "").append("</td>").append("</tr>").append("\n");
		sb.append("<tr>").append("<td>").append("&nbsp;").append("</td>").append("<td nowrap>").append("�������ڣ�").append(session.getCreateTime("yyyy��M��d��")).append("</td>").append("</tr>").append("\n");
		sb.append("<tr>").append("<td>").append("&nbsp;").append("</td>").append("<td nowrap>").append("���£�").append("").append("</td>").append("</tr>").append("\n");
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
		ARE.getLog().trace((new StringBuilder("��ѯɾ������:")).append(sql).toString());
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
		ARE.getLog().error("��ѯɾ������ʧ�ܣ�", ex);
		if (tr != null)
			tr.close();
		break MISSING_BLOCK_LABEL_245;
		ex;
		ARE.getLog().error("��ѯɾ������ʧ�ܣ�", ex);
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
