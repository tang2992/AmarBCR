<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	String PG_TITLE = "web���Ʋ�ѯ";
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;"+PG_TITLE+"&nbsp;&nbsp;";
	String PG_CONTNET_TEXT = "";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript">
	//myleft.width=1;
	AsControl.OpenView("/AppConfig/QueryScheme/QuerySchemeTab.jsp","","right","");
</script>
<%@ include file="/IncludeEnd.jsp"%>