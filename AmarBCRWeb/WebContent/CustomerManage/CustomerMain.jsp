<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
	Content: 案例客户管理主界面,只展示大型企业客户
	 */
	String PG_TITLE = "客户管理"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;"+PG_TITLE+"&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "1";//默认的treeview宽度
	
	//获得组件参数	
	String sCustomerType = CurPage.getParameter("CustomerType");
	String sCustomerListTemplet = CurPage.getParameter("CustomerListTemplet");
	if(sCustomerType == null) sCustomerType = "";
	if(sCustomerListTemplet == null) sCustomerListTemplet = "";
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	AsControl.OpenComp("/CustomerManage/CustomerList.jsp","CustomerType=<%=sCustomerType%>&CustomerListTemplet=<%=sCustomerListTemplet%>","right");
</script>
<%@ include file="/IncludeEnd.jsp"%>