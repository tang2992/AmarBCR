<%@ page contentType="text/html; charset=GBK"
		 import="com.amarsoft.are.ARE"
%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main00;Describe=注释区;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content:文件管理主页面
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>
<%
	String dataHome = ARE.getProperty("ECR_HOME")+"/feedback";

	//管理项目，文件夹路径，文件后缀过滤，可进行的操作
	String sRight="";
	boolean bRight = false;
	
	bRight = CurUser.hasRole("400");
	if(bRight==true)    
		sRight="delete,download,view,upload";
	else{
		bRight = CurUser.hasRole("400");
		if(bRight==true)    sRight="view";
	}
	
	String[][] directoryDefine = {
		{"数据采集反馈",dataHome+"/guaranteefeedback",".*\\.[Eet][Nnx][Cct]",sRight},		
		{"批量删除结果",dataHome+"/deleteresult",".*\\.[Eet][Nnx][Cct]",sRight},
		{"机构信息反馈",dataHome+"/organfeedback",".*\\.[Eet][Nnx][Cct]",sRight}
	};

	session.setAttribute("DirectoryDefine",directoryDefine);

%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "接收报文管理主页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;接收报文管理主页面&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main03;Describe=定义树图;]~*/%>
	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"接收报文管理","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

	//定义树图结构
	tviTemp.insertPage("root","数据采集反馈","",1);	
	//tviTemp.insertPage("root","批量删除结果","",2);
	//tviTemp.insertPage("root","机构信息反馈","",3);
	
	%>
<%/*~END~*/%>


<%/*~BEGIN~不可编辑区[Editable=false;CodeAreaID=Main04;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/Main04.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main05;Describe=树图事件;]~*/%>
	<script type="text/javascript"> 
	
	/*~[Describe=treeview单击选中事件;InputParam=无;OutPutParam=无;]~*/
	function TreeViewOnClick()
	{
		var sCurItemname = getCurTVItem().name;
		if(sCurItemname=='数据采集反馈'){
			OpenPage("/FileManage/GeneralFileManage.jsp?Flag=0","right","");
		}else if(sCurItemname=='批量删除结果'){
			OpenPage("/FileManage/GeneralFileManage.jsp?Flag=1","right","");
		}else if(sCurItemname=='机构信息反馈'){
			OpenPage("/FileManage/GeneralFileManage.jsp?Flag=2","right","");
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
<%/*~END~*/%>


<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main06;Describe=在页面装载时执行,初始化;]~*/%>
	<script type="text/javascript">
	startMenu();
	expandNode('root');		
	selectItem("1");
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>