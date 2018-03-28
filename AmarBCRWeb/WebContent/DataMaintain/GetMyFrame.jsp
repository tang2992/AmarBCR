<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Tree00;Describe=注释区;]~*/%>
	<%
	/*
		Tester:
		Content:    数据选择
		Input Param:
		Output param:
		History Log: 
	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Tree01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "数据选择视图"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;数据类型选择&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Tree03;Describe=定义树图;]~*/%>
	<%
	String sDataType  = CurPage.getParameter("DataType");
	String sIniteValue  = CurPage.getParameter("IniteValue");
	if(sIniteValue==null){
		sIniteValue = "";
	}
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"数据列表","right");
    tviTemp.TriggerClickEvent=true;
	
	String sSqlTreeView = " from WEB_CODEMAP where ColName='"+sDataType+"'";
	//参数从左至右依次为：
	//ID字段(必须),Name字段(必须),Value字段,Script字段,Picture字段,From子句(必须),OrderBy子句,Sqlca
    tviTemp.initWithSql("PbCode","Note","PbCode","","",sSqlTreeView,"Order By PbCode",Sqlca);

	//tviTemp.ImageDirectory = sResourcesPath; //设置资源文件目录（图片、CSS）
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否自动触发选中事件
	%>
<%/*~END~*/%>


<%/*~BEGIN~不可编辑区[Editable=false;CodeAreaID=Tree04;Describe=主体页面]~*/%>
	<%@include file="/Resources/CodeParts/Tree04.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Tree05;]~*/%>
	<script language=javascript> 

    //treeview单击选中事件
	function TreeViewOnClick()
	{
		var sCurItemValue = getCurTVItem().value;
		var sType = getCurTVItem().type;
		if(sCurItemValue != 'root'){
			if(sType == "page"){
				top.returnValue = getCurTVItem().value+"@"+getCurTVItem().name;
				if(confirm("您选择了\n\n类型: ["+getCurTVItem().name+"]\n\n确认吗?")){
					top.close();
				}else{
				    top.returnValue="";
				}
			}else{
				alert("页节点信息不能选择，请重新选择！");
			}
		}
	}

	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
	
	</script> 
<%/*~END~*/%>

<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Tree06;Describe=在页面装载时执行,初始化]~*/%>
	<script language="JavaScript">
	startMenu();
	expandNode('root');
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>