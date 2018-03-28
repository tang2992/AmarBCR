<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	String PG_TITLE = "反馈信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;反馈信息维护&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "1";//默认的treeview宽度
	%>

	<%
	//定义变量
	
	//获得组件参数	
	//获得页面参数	
	String sRecordType = CurComp.getParameter("recordType");
	if(sRecordType == null) sRecordType = "";
	%>

	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"反馈信息维护","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

	//定义树图结构
	//String sFolder1=tviTemp.insertFolder("root","业务信息维护","",0);
	tviTemp.insertPage("root","反馈信息维护","反馈信息维护","",1);
	%>

	<%@include file="/Resources/CodeParts/Main04.jsp"%>

	<script language=javascript> 
	
	/*~[Describe=treeview单击选中事件;InputParam=无;OutPutParam=无;]~*/
	OpenComp("FeedBackList","/ErrorManage/FeedBackManage/FeedBackList.jsp","recordType=<%=sRecordType%>","right");
	
	function TreeViewOnClick()
	{
		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数

		var sCurItemname = getCurTVItem().name;
		var sTableName = getCurTVItem().value;
		if(!sTableName==''){
			OpenComp("FeedBackList","/ErrorManage/FeedBackManage/FeedBackList.jsp","recordType=<%=sRecordType%>","right");
		}else{
			return;							
		}
		setTitle(getCurTVItem().name);
	}

	
	/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
		
	</script> 

	<script language="javascript">
	startMenu();
	expandNode('root');	
	selectItem("1");
	</script>
<%@ include file="/IncludeEnd.jsp"%>