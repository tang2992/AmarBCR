<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
        Author: #{author} #{createddate}
        Content: 隐藏左侧区域的Main页面
        History Log: 
    */
	String PG_TITLE = "隐藏左侧区域的Main页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;隐藏左侧区域的Main页面&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "1";//默认的treeview宽度

	//获得页面参数
	//String sInputUser =  CurPage.getParameter("InputUser");
	//if(sInputUser==null) sInputUser="";
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript">
	AsControl.OpenView("/FrameCase/ExampleList.jsp","","right","");
</script>
<%@ include file="/IncludeEnd.jsp"%>