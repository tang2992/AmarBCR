<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	/*
		Content: �ж϶�Ӧ�ı��������Ƿ����
	 */
    //�������
	String sSql = "",sReturnValue = "pass";
	ASResultSet rs = null;
	//���ҳ�����
	//������ ��ʱΪ�ͻ���
	String sObjectNo = CurPage.getParameter("CustomerID");
	String sReportDate = CurPage.getParameter("ReportDate");
	String sReportScope = CurPage.getParameter("ReportScope");
	//����ֵת��Ϊ���ַ���
	if(sObjectNo == null) sObjectNo = "";
	if(sReportScope == null) sReportScope = "";
	if(sReportDate == null)	sReportDate = "";
	
	//��ѯ��ǰ�����Ĳ��񱨱��Ƿ��ظ�
	sSql = " select RecordNo from CUSTOMER_FSRECORD "+
			" where CustomerID = :CustomerID and ReportDate = :ReportDate and ReportScope = :ReportScope ";
	rs = Sqlca.getResultSet(new SqlObject(sSql).setParameter("CustomerID",sObjectNo).setParameter("ReportDate",sReportDate).setParameter("ReportScope",sReportScope));
	if(rs.next()){
		sReturnValue = "refuse";
	}
	rs.getStatement().close();
	out.println(sReturnValue);
%><%@ include file="/IncludeEndAJAX.jsp"%>