<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	/*
		Content: ȡ�ö�Ӧ�ı�������
	 */
    //�������
	String sReturnValue = "02";//--��ʾ�Ƿ�Ϊ��ϸ����
	
	//���ҳ�������������
	String sReportNo = CurPage.getParameter("ReportNo");

	//��ȡ���񱨱�����
	String sModelno = Sqlca.getString("select MODELNO from REPORT_RECORD  where  ReportNo  ='"+sReportNo+"' ");
	if(sModelno == null) sModelno = "";
	
	String sModelLabbr = Sqlca.getString("select MODELABBR from REPORT_CATALOG  where  ModelNo  ='"+sModelno+"' ");	
	if(sModelLabbr == null) sModelLabbr = "";
	
	if(sModelLabbr.equals("����˵��")){
		sReturnValue ="00";
	}else if(sModelLabbr.equals("�ͻ��ʲ��븺ծ��ϸ")){
		sReturnValue ="01";
	}else{
		sReturnValue = sModelno;
	}

	out.println(sReturnValue);
%><%@ include file="/IncludeEndAJAX.jsp"%>