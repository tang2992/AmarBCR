<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%>
 <%
	//ȡϵͳ����
	String sImplementationName = CurConfig.getConfigure("ImplementationName");
	if (sImplementationName == null) sImplementationName = "";
	String PG_TITLE = sImplementationName; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = null; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "0";//Ĭ�ϵ�treeview���
	
	String sTitle = CurPage.getParameter("Title");
	String sUrl = CurPage.getParameter("Url");
	String sParas = CurPage.getParameter("Paras");
	if(sParas == null) sParas = "";
%>
<%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript">
<%if(sUrl != null){%>
	AsControl.OpenView("/AppMain/MenuTabContainer.jsp", "Title=<%=sTitle%>&Url=<%=sUrl%>&Paras=<%=sParas%>", "right");
<%}%>
</script>
<%@ include file="/IncludeEnd.jsp"%>