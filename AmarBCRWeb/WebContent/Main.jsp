<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	//ȡϵͳ����
	String sProductName = CurConfig.getConfigure("ProductName");
	if (sProductName == null) sProductName = "";
	String sImplementationVersion = CurConfig.getConfigure("ImplementationVersion");
	if (sImplementationVersion == null) sImplementationVersion = "";

	String PG_TITLE = sProductName+"V"+sImplementationVersion; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = null; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript">
	AsControl.OpenView("/AppMain/Welcome.jsp","","right");
</script>
<%@ include file="/IncludeEnd.jsp"%>