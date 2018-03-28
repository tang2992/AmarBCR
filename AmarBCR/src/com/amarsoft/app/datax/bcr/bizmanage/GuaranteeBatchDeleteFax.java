package com.amarsoft.app.datax.bcr.bizmanage;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.session.ReportSession;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.sql.DataSourceURI;
import com.amarsoft.are.sql.TabularReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.text.DecimalFormat;

public class GuaranteeBatchDeleteFax 
	{
		  public static final int EXPORT_FORMAT_TXT = 0;
		  public static final int EXPORT_FORMAT_HTML = 1;
		  public static final int EXPORT_FORMAT_PDF = 2;
		  public static final int EXPORT_FORMAT_RTF = 3;
		  public static final int EXPORT_FORMAT_XLS = 4;
		  private String bankName = null;
		  private String bankCode = null;
		  private String contact = null;
		  private String proposer = null;
		  private String deleteCause = null;
		  private String isRetryReport = null;
		  private int[] recordCount = null;
		  private String[] businessType = { 
		    "����ҵ��ɾ��", 
		    "�ڱ���������������Ϣɾ��", 
		    "������Ϣɾ��",
		    "���ѽ�����Ϣɾ��"};
		  private ReportSession session = null;
		  private String messageFileName = null;

		  public GuaranteeBatchDeleteFax(String sessionId)
		    throws BCRException
		  {
		    this.session = new ReportSession();
		    this.session.setSessionId(sessionId);
		    this.session.load();
		  }

		  public GuaranteeBatchDeleteFax(ReportSession session) {
		    this.session = session;
		  }

		  public File exportFile(int fileFormat) throws BCRException {
		    if (this.recordCount == null) loadRecordCount();
		    File f = null;
		    switch (fileFormat)
		    {
		    case 0:
		      f = new File(this.session.getExportFolder(), getMessageFileName() + "_fax.txt");
		      ARE.getLog().debug("Export Fax File: " + f.getPath());
		      exportTxt(f);
		      break;
		    case 1:
		      f = new File(this.session.getExportFolder(), getMessageFileName() + "_fax.html");
		      ARE.getLog().debug("Export Fax File: " + f.getPath());
		      exportHtml(f);
		      break;
		    case 2:
		      f = new File(this.session.getExportFolder(), getMessageFileName() + "_fax.pdf");
		      ARE.getLog().debug("Export Fax File: " + f.getPath());
		      exportPdf(f);
		      break;
		    case 3:
		      f = new File(this.session.getExportFolder(), getMessageFileName() + "_fax.rtf");
		      ARE.getLog().debug("Export Fax File: " + f.getPath());
		      exportRtf(f);
		      break;
		    case 4:
		      f = new File(this.session.getExportFolder(), getMessageFileName() + "_fax.xls");
		      ARE.getLog().debug("Export Fax File: " + f.getPath());
		      exportXls(f);
		      break;
		    default:
		      f = new File(this.session.getExportFolder(), getMessageFileName() + "_fax.html");
		      ARE.getLog().debug("Export Fax File: " + f.getPath());
		      exportHtml(f);
		    }

		    return f;
		  }

		  private String getMessageFileName()
		  {
		    if (this.messageFileName == null) {
		      StringBuffer sBuf = new StringBuffer();
		      sBuf.append("11");
		      sBuf.append("000000000");
		      sBuf.append(this.session.getFinanceId());
		      for (; sBuf.length() < 22; sBuf.append('0'));
		      sBuf.append(this.session.getSessionId().substring(0, 6));
		      sBuf.append("32");

		      sBuf.append('1');
		      sBuf.append(this.session.getSessionId().substring(6));
		      sBuf.append("00");
		      this.messageFileName = sBuf.toString();
		    }
		    return this.messageFileName;
		  }

		  public void exportTxt(File f) throws BCRException {
		    DecimalFormat df = new DecimalFormat("#####");
		    StringBuffer sb = new StringBuffer();
		    sb.append("���ڻ�����ҵ����ϵͳ����ҵ��ɾ�������").append("\n\n");
		    sb.append("���ڻ������ƣ�").append((this.bankName == null) ? "" : this.bankName).append("\n");
		    sb.append("���ڻ������룺").append((this.bankCode == null) ? this.session.getFinanceId() : this.bankCode).append("\n");
		    sb.append("����ҵ��ɾ���������ļ�����").append(getMessageFileName() + ".txt").append("\n");
		    sb.append("ɾ��ҵ������\t����ɾ����¼��").append("\n");
		    for (int i = 0; i < this.businessType.length; ++i) {
		      sb.append(this.businessType[i]).append("\t");
		      sb.append((this.recordCount[i] > 0) ? df.format(this.recordCount[1]) : "").append("\n");
		    }

		    sb.append(this.businessType[0]).append("\t");
		    sb.append((this.recordCount[0] > 0) ? df.format(this.recordCount[1]) : "").append("\n");
		    sb.append((this.isRetryReport == null) ? "" : this.isRetryReport).append("\n");
		    sb.append((this.deleteCause == null) ? "" : this.deleteCause).append("\n");
		    sb.append("�����ˣ����£���").append((this.proposer == null) ? "" : this.proposer);
		    sb.append("��ϵ��ʽ��").append((this.contact == null) ? "" : this.contact).append("\n");
		    sb.append("�������ڣ�").append(this.session.getCreateTime("yyyy��M��d��")).append("\n");
		    try {
		      FileWriter fw = new FileWriter(f);
		      fw.write(sb.toString());
		      fw.close();
		    } catch (IOException ex) {
		      throw new BCRException(ex);
		    }
		  }

		  private void exportHtml(File f)
		    throws BCRException
		  {
		    DecimalFormat df = new DecimalFormat("#####");
		    StringBuffer sb = new StringBuffer("<html><head><title>���ڻ�����ҵ����ϵͳ����ҵ��ɾ�������</title></head>");
		    sb.append("<body topmargin=60><center>");
		    sb.append("<h2>���ڻ�����ҵ����ϵͳ����ҵ��ɾ�������<h2>").append("\n");
		    sb.append("<table border=1 cellpadding=3 cellspacing=0 width=600>").append("\n");
		    sb.append("<tr><td colspan=2>").append
		      ("<b>���ڻ������ƣ�</b>").append((this.bankName == null) ? "" : this.bankName).append
		      ("</td></tr>").append("\n");
		    sb.append("<tr><td colspan=2>").append
		      ("<b>���ڻ������룺</b>").append((this.bankCode == null) ? this.session.getFinanceId() : this.bankCode).append
		      ("</td></tr>").append("\n");
		    sb.append("<tr><td colspan=2>").append
		      ("<b>����ҵ��ɾ���������ļ�����</b>").append(getMessageFileName() + ".txt").append
		      ("</td></tr>").append("\n");

		    sb.append("<tr>").append
		      ("<td width=30%><b>").append("ɾ��ҵ������").append("</b></td>").append
		      ("<td><b>").append("����ɾ����¼��").append("</b></td>").append
		      ("</tr>").append("\n");

		    for (int i = 0; i < this.businessType.length; ++i) {
		      sb.append("<tr>").append
		        ("<td>").append(this.businessType[i]).append("</td>").append
		        ("<td>").append((this.recordCount[i] > 0) ? df.format(this.recordCount[i]) : "&nbsp;").append("</td>").append
		        ("</tr>").append("\n");
		    }

		    sb.append("<tr>").append
		      ("<td><b>").append(this.businessType[0]).append("</b></td>").append
		      ("<td><b>").append((this.recordCount[0] > 0) ? df.format(this.recordCount[0]) : "&nbsp;").append("</b></td>").append
		      ("</tr>").append("\n");

		    sb.append("<tr><td colspan=2 width=100% height=100 valign=top>ɾ��ԭ��").append
		      ((this.deleteCause == null) ? "&nbsp;" : this.deleteCause).append("</td>").append
		      ("</tr>").append("\n");

		    sb.append("<tr><td colspan=2>").append("<table cellspacing=0  width=100%>");
		    sb.append("<tr><td width=100% height=120 valign=top>��Ҫ�ر�/���ر���").append
		      ((this.isRetryReport == null) ? "&nbsp;" : this.isRetryReport).append
		      ("<td></tr>").append("\n");

		    sb.append("<tr><td><table>");
		    sb.append("<tr>").append
		      ("<td>").append("&nbsp;").append("</td>").append
		      ("<td width=40% nowrap>").append("�����ˣ�").append((this.proposer == null) ? "" : this.proposer).append("</td>").append
		      ("</tr>").append("\n");

		    sb.append("<tr>").append
		      ("<td>").append("&nbsp;").append("</td>").append
		      ("<td nowrap>").append("��ϵ��ʽ��").append((this.contact == null) ? "" : this.contact).append("</td>").append
		      ("</tr>").append("\n");

		    sb.append("<tr>").append
		      ("<td>").append("&nbsp;").append("</td>").append
		      ("<td nowrap>").append("�������ڣ�").append(this.session.getCreateTime("yyyy��M��d��")).append("</td>").append
		      ("</tr>").append("\n");
		    sb.append("<tr>").append
		      ("<td>").append("&nbsp;").append("</td>").append
		      ("<td nowrap>").append("���£�").append("").append("</td>").append
		      ("</tr>").append("\n");
		    sb.append("<tr><td colspan=2  width=100%>&nbsp;</td></tr>").append("\n");
		    sb.append("</table></td></tr>");

		    sb.append("</table>");
		    sb.append("</td></tr></table>");
		    sb.append("</center></body></html>");
		    try {
		      FileWriter fw = new FileWriter(f);
		      fw.write(sb.toString());
		      fw.close();
		    } catch (IOException ex) {
		      throw new BCRException(ex);
		    }
		  }

		  private void exportPdf(File f) throws BCRException
		  {
		  }

		  private void exportRtf(File f) throws BCRException
		  {
		  }

		  private void exportXls(File f) throws BCRException {
		    exportHtml(f);
		  }

		  private void loadRecordCount() {
		    this.recordCount = new int[this.businessType.length];
		    TabularReader organTR = null;
		    try
		    {
		      String sql = "select 'organ' as name, count(*) as RecordCount from BCR_GUARANTEEDELETE  where sessionID='" + this.session.getSessionId() + "'";
		      ARE.getLog().trace("��ѯ����ҵ����Ϣɾ������:" + sql);
		      DataSourceURI organURI = new DataSourceURI("bcr", sql);
		      organTR = new TabularReader(organURI);
		      while (organTR.next()) {
		        String name = organTR.getString("name");
		        int count = organTR.getInt("RecordCount");
		        if ("organ".equalsIgnoreCase(name))
		          this.recordCount[1] = count;
		        else
		          this.recordCount[2] = count;
		      }
		      this.recordCount[0] = (this.recordCount[1] + this.recordCount[2]);
		    } catch (URISyntaxException ex) {
		      ARE.getLog().error("����ҵ����Ϣɾ������ʧ�ܣ�", ex);

		      if (organTR == null) return; organTR.close();
		    }
		    catch (SQLException ex)
		    {
		      ARE.getLog().error("����ҵ����Ϣɾ������ʧ�ܣ�", ex);

		      if (organTR == null) return; organTR.close(); } finally { if (organTR != null) organTR.close();
		    }
		  }

		  public String getBankCode()
		  {
		    return this.bankCode;
		  }

		  public void setBankCode(String bankCode)
		  {
		    this.bankCode = bankCode;
		  }

		  public String getBankName()
		  {
		    return this.bankName;
		  }

		  public void setBankName(String bankName)
		  {
		    this.bankName = bankName;
		  }

		  public String getContact()
		  {
		    return this.contact;
		  }

		  public void setContact(String contact)
		  {
		    this.contact = contact;
		  }

		  public String getDeleteCause()
		  {
		    return this.deleteCause;
		  }

		  public void setDeleteCause(String deleteCause)
		  {
		    this.deleteCause = deleteCause;
		  }

		  public String getIsRetryReport() {
		    return this.isRetryReport;
		  }

		  public void setIsRetryReport(String isRetryReport) {
		    this.isRetryReport = isRetryReport;
		  }

		  public String getProposer()
		  {
		    return this.proposer;
		  }

		  public void setProposer(String proposer)
		  {
		    this.proposer = proposer;
		  }
		}
