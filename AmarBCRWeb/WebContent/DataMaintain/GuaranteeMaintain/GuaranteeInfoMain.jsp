<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	/*
		页面说明:示例模块主页面
	 */
	String sTitle=CurPage.getParameter("IsQuery");  
 	String PG_TITLE="";
 	String PG_CONTENT_TITLE="";
    if("true".equals(sTitle)){
    	PG_TITLE = "担保信息查询"; // 浏览器窗口标题 <title> PG_TITLE </title>
    	PG_CONTENT_TITLE = "&nbsp;&nbsp;担保信息查询&nbsp;&nbsp;"; //默认的内容区标题
    }else{
    	PG_TITLE = "担保信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
    	PG_CONTENT_TITLE = "&nbsp;&nbsp;担保信息维护&nbsp;&nbsp;"; //默认的内容区标题
    }
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度

	//获得页面参数
    	String IsQuery=CurPage.getParameter("IsQuery");
       if(IsQuery==null) IsQuery="";

%><%@include file="/Resources/CodeParts/Main04.jsp"%>

<script type="text/javascript">
myleft.width=1;
AsControl.OpenView("/DataMaintain/GuaranteeMaintain/GuaranteeInfoList.jsp","IsQuery=<%=IsQuery%>","right");
</script>

<%@ include file="/IncludeEnd.jsp"%>