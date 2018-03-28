<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main00;Describe=注释区;]~*/%>
	<%
	/*
		Author:hywang
		Tester:
		Content: 任务运行界面
		Input Param:
		Output param:
		History Log: 
	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "任务运行管理"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;任务运行管理&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main02;Describe=定义变量，获取参数;]~*/%>
	<%
	//定义变量
	//获得组件参数	
	//获得页面参数	
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main03;Describe=定义树图;]~*/%>
	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"任务列表","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数
	
	String taskName = CurPage.getParameter("taskName");
	if(taskName==null) taskName = "" ;
	String selectItem = "3";
	if(taskName.contains("feedback"))
		selectItem = "11";

	//定义树图结构
	String sReport = tviTemp.insertFolder("root","核心取数单元","核心取数单元","",1);//返回sortNo
	tviTemp.insertPage(sReport,"INIT-导入数据","initTaskFile","",1);
	tviTemp.insertPage(sReport,"PREPARE-数据抽取","prepareTaskFile","",2);
	tviTemp.insertPage(sReport,"VALIDATE-数据校验","validateTaskFile","",3);
	tviTemp.insertPage(sReport,"TRANSFER-数据迁移","transferTaskFile","",4);
	String sReport1 = tviTemp.insertFolder("root","生成报文单元","生成报文单元","",2);
	tviTemp.insertPage(sReport1,"REPORT-正常采集报文","reportTaskFile","",1);
	tviTemp.insertPage(sReport1,"REPORT-业务变更报文","changeTaskFile","",2);
	tviTemp.insertPage(sReport1,"REPORT-批量删除报文","batchdelTaskFile","",3);
	String sOther =  tviTemp.insertFolder("root","反馈处理单元","反馈处理单元","",3);//返回sortNo	
	//tviTemp.insertPage(sOther,"BATCHDEL-批量删除","batchdelTaskFile","",1);
	tviTemp.insertPage(sOther,"FEEDBACK-反馈处理","feedbackTaskFile","",1);
	
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
		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数
		var sCurItemValue = getCurTVItem().value;
		var sCurItemName = getCurTVItem().name;		
		if(sCurItemValue=='feedbackTaskFile'||sCurItemValue=='transferTaskFile'||sCurItemValue=='initTaskFile'||sCurItemValue=='prepareTaskFile'||sCurItemValue=='validateTaskFile'){
			OpenComp("ECRTaskUnit","/WebTask/ECRTaskUnit.jsp","taskName="+sCurItemValue,"right");
		}else if(sCurItemValue=='reportTaskFile'||sCurItemValue=='changeTaskFile'||sCurItemValue=='batchdelTaskFile'){
			OpenComp("ECRTaskUnit","/WebTask/ECRTaskUnit.jsp","taskName="+sCurItemValue,"right");
		}
		setTitle(sCurItemName);
	}

	/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>;
	}
	
	</script> 
<%/*~END~*/%>


<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main06;Describe=在页面装载时执行,初始化;]~*/%>
	<script type="text/javascript">
	startMenu();
	expandNode('root');	
	expandNode(<%=sReport%>);
	expandNode(<%=sReport1%>);
	expandNode(<%=sOther%>);
	selectItem(<%=selectItem%>);
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>
