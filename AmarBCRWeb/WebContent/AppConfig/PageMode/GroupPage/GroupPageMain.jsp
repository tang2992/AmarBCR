<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	String PG_TITLE = "���ҳ������"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;"+PG_TITLE+"&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���,����ʾ��ͼ
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript">
	//myleft.width=1;
	AsControl.OpenView("/AppConfig/PageMode/GroupPage/GroupPageMainFrame.jsp","","right");
</script>
<%@ include file="/IncludeEnd.jsp"%>