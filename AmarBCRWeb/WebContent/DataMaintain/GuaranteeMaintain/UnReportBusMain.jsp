<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	/*
		ҳ��˵��:ʾ��ģ����ҳ��
	 */
 	String PG_TITLE="";
 	String PG_CONTENT_TITLE="";
    PG_TITLE = "�����ϱ�����ά��"; // ��������ڱ��� <title> PG_TITLE </title>
    PG_CONTENT_TITLE = "&nbsp;&nbsp;�����ϱ�����ά��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���

	//���ҳ�����

%><%@include file="/Resources/CodeParts/Main04.jsp"%>

<script type="text/javascript">
myleft.width=1;
AsControl.OpenView("/DataMaintain/GuaranteeMaintain/UnReportBusList.jsp","","right");
</script>

<%@ include file="/IncludeEnd.jsp"%>