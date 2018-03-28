<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		页面说明: 文档管理主页面
	 */
	String PG_TITLE = "文档管理主页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;详细信息&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度

	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"文档管理","right");
	tviTemp.TriggerClickEvent = true; //是否自动触发选中事件

	//定义树图结构
	tviTemp.insertPage("010","root","客户相关文档", "Customer","",1);
	tviTemp.insertPage("020","root","其它文档", "Other","",2);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	function TreeViewOnClick(){
		var sObjectType = getCurTVItem().value;
		AsControl.OpenComp("/AppConfig/Document/DocumentFrame.jsp","ObjectType="+sObjectType,"right");
		setTitle(getCurTVItem().name);
	}
	
	function initTreeView() {
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItem("010");
	}

	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>