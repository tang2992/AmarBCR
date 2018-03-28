<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Tree00;Describe=注释区;]~*/%>
	<%
	/*
		Author:     qhhui
		Tester:
		Content:    信息类型选择
		Input Param:
		Output param:
		History Log: 
	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Tree01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "信息类型选择视图"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;信息类型选择&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Tree03;Describe=定义树图;]~*/%>
	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"信息类型列表","right");
    tviTemp.TriggerClickEvent=true;
	
	String sSqlTreeView = " from CODE_LIBRARY where CodeNo='ReportType' and IsInUse = '1'";
	//参数从左至右依次为：
	//ID字段(必须),Name字段(必须),Value字段,Script字段,Picture字段,From子句(必须),OrderBy子句,Sqlca
    tviTemp.initWithSql("ItemNo","ItemName","ItemNo","","",sSqlTreeView,"Order By ItemNo",Sqlca);

	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否自动触发选中事件
	%>
<%/*~END~*/%>


<%/*~BEGIN~不可编辑区[Editable=false;CodeAreaID=Tree04;Describe=主体页面]~*/%>
	<%@include file="/Resources/CodeParts/Tree04.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Tree05;]~*/%>
	<script type="text/javascript"> 

    //treeview单击选中事件
	function TreeViewOnClick()
	{
		var ItemValue = getCurTVItem().value;
		//根节点不能选择
		if(ItemValue=='root'){
			top.returnValue="";
			return;
		}else{
			top.returnValue = getCurTVItem().value+"@"+getCurTVItem().name;
		}
		if(confirm("您选择了\n\n信息类型: ["+getCurTVItem().name+"]\n\n确认吗?")){
			top.close();
		}else{
		    top.returnValue="";
		}
	}

	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
	
	</script> 
<%/*~END~*/%>

<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Tree06;Describe=在页面装载时执行,初始化]~*/%>
	<script type="text/javascript">
	startMenu();
	expandNode('root');
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>
