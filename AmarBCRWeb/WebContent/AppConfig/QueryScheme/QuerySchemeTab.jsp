<%@ page contentType="text/html; charset=GBK"%><%@
include file="/IncludeBegin.jsp"%><%
	/* 
	ҳ��˵���� ͨ�����鶨������Tab���ҳ��
	*/
	//����tab���飺
	//������0.�Ƿ���ʾ, 1.���⣬2.URL��3��������
	String sTabStrip[][] = {
		{"true", "��ѯ��������", "/AppConfig/QueryScheme/QuerySchemeFrame.jsp", ""},
		{"true", "�߼�", "/AppConfig/QueryScheme/JBOQueryDialog.jsp", ""},
	};
%><%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>