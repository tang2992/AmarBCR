<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
        Author: #{author} #{createddate}
        Content: ������������Mainҳ��
        History Log: 
    */
	String PG_TITLE = "������������Mainҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;������������Mainҳ��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���

	//���ҳ�����
	//String sInputUser =  CurPage.getParameter("InputUser");
	//if(sInputUser==null) sInputUser="";
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript">
	AsControl.OpenView("/FrameCase/ExampleList.jsp","","right","");
</script>
<%@ include file="/IncludeEnd.jsp"%>