<%@page import="com.amarsoft.awe.res.AppManager"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��:������������Mainҳ��
	 */
	String PG_TITLE = AppManager.getAppName(CurPage.getParameter("AppID")); // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = null;// "&nbsp;&nbsp;��ϵͳ��ҳ��&nbsp;&nbsp;"; //Ĭ�ϵ����������� Ϊnull����ʾ������
	String PG_CONTNET_TEXT = "";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript">
	AsControl.OpenView("/AppMain/CommonWelcome.jsp","","right");
</script>
<%@ include file="/IncludeEnd.jsp"%>