<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	//取系统名称
	String sProductName = CurConfig.getConfigure("ProductName");
	if (sProductName == null) sProductName = "";
	String sImplementationVersion = CurConfig.getConfigure("ImplementationVersion");
	if (sImplementationVersion == null) sImplementationVersion = "";

	String PG_TITLE = sProductName+"V"+sImplementationVersion; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = null; //默认的内容区标题
	String PG_CONTNET_TEXT = "";//默认的内容区文字
	String PG_LEFT_WIDTH = "1";//默认的treeview宽度
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript">
	AsControl.OpenView("/AppMain/Welcome.jsp","","right");
</script>
<%@ include file="/IncludeEnd.jsp"%>