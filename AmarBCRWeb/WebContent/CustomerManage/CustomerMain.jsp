<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
	Content: �����ͻ�����������,ֻչʾ������ҵ�ͻ�
	 */
	String PG_TITLE = "�ͻ�����"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;"+PG_TITLE+"&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���
	
	//����������	
	String sCustomerType = CurPage.getParameter("CustomerType");
	String sCustomerListTemplet = CurPage.getParameter("CustomerListTemplet");
	if(sCustomerType == null) sCustomerType = "";
	if(sCustomerListTemplet == null) sCustomerListTemplet = "";
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	AsControl.OpenComp("/CustomerManage/CustomerList.jsp","CustomerType=<%=sCustomerType%>&CustomerListTemplet=<%=sCustomerListTemplet%>","right");
</script>
<%@ include file="/IncludeEnd.jsp"%>