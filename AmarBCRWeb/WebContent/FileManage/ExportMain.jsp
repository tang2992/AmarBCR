<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.are.ARE"
%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main00;Describe=注释区;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content: 文件管理主页面
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>
<%
	String dataHome = ARE.getProperty("ECR_HOME")+"/export";
	//管理项目，文件夹路径，文件后缀过滤，可进行的操作
	String sRight="";
	boolean bRight = false;
	
	bRight = CurUser.hasRole("400");//判断该用户是否拥有“400”这个角色
	if(bRight==true)    
		sRight="delete,download,view";
	else{
		bRight = CurUser.hasRole("400");
		if(bRight==true)    sRight="view";
	}
	
	String[][] directoryDefine = {
		{"原始报文文件",dataHome,".*\\.txt",sRight}, //报文文件
		{"加密报文文件",dataHome,".*\\.enc",sRight}, //加密后的文件
		{"压缩报文文件",dataHome,".*\\.zip",sRight}, //压缩后的文件
	};
	
	session.setAttribute("DirectoryDefine",directoryDefine);
%>
<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "输出文件管理主页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;输出文件管理主页面&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main03;Describe=定义树图;]~*/%>
	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"输出文件管理","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

	//定义树图结构
	tviTemp.insertPage("root","原始报文文件","",1);
	tviTemp.insertPage("root","加密报文文件","",2);
	tviTemp.insertPage("root","压缩报文文件","",3);
	
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
		if(sCurItemname=='原始报文文件'){
			OpenPage("/FileManage/GeneralFileManage.jsp?Flag=0","right","");
		}else if(sCurItemname=='加密报文文件'){
			OpenPage("/FileManage/GeneralFileManage.jsp?Flag=1","right","");
		}else if(sCurItemname=='压缩报文文件'){
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