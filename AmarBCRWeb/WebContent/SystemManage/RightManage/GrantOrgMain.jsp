<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main00;Describe=注释区;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: 机构维护主页面
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>



<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "机构维护主页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;机构维护主页面&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度
	%>
<%/*~END~*/%>
<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List02;Describe=定义变量，获取参数;]~*/%>
<%

	//定义变量
	String sSql;
	String sOrgLevel; 
	String sBelongOrg="";
	String sUserID="";
	
	//获得页面参数	
	sUserID = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("UserID")); 
	if(sUserID==null) sUserID="";
	
	String sSortNoLength = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("SortNoLength"));
	if(sSortNoLength==null) sSortNoLength="";
%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main03;Describe=定义树图;]~*/%>
	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"授权机构列表","right");
	tviTemp.ImageDirectory = sResourcesPath; //设置资源文件目录（图片、CSS）
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数
	
	String[] sSortLevel = sSortNoLength.split("@");
	String sLevel = "";
	
	
	sSql = "select SortNo,OrgName from ORG_INFO where length(SortNo)="+Integer.valueOf(sSortLevel[0]).intValue();
	String sSortNo="",sOrgName="";
	ASResultSet rs = Sqlca.getASResultSet(sSql);
	
	if(rs.next()) {
		sSortNo = rs.getString(1);
		sOrgName = rs.getString(2);
	}
	rs.getStatement().close();
	sLevel = "0";
	String sHQ="",sSubHQ="",sBranch="",sUnderBranch="";
	sHQ = tviTemp.insertFolder("root",sOrgName,sLevel,"",1);
	
	for(int i=1;i<sSortLevel.length;i++){
		if(i==1){
			 sSubHQ = tviTemp.insertFolder(sHQ,"分行",""+i,"",1);
		}
		if(i==2){
			sBranch = tviTemp.insertFolder(sSubHQ,"支行",""+i,"",1);
		}
		if(i==3){
			 sUnderBranch = tviTemp.insertFolder(sBranch,"下属机构",""+i,"",1);
		}		
	}
	
	
	%>
<%/*~END~*/%>


<%/*~BEGIN~不可编辑区[Editable=false;CodeAreaID=Main04;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/View06.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main05;Describe=树图事件;]~*/%>
	<script language=javascript> 
	
	OpenComp("GrantOrgList","/SystemManage/RightManage/GrantOrgList.jsp","OrgLevel=<%=sLevel%>&UserID=<%=sUserID%>&SortNo=<%=sSortNo%>&SortNoLength=<%=sSortNoLength%>","right");
	
	/*~[Describe=treeview单击选中事件;InputParam=无;OutPutParam=无;]~*/
	function TreeViewOnClick()
	{
		var sOrgLevel = getCurTVItem().value;
		if(sOrgLevel=="1"||sOrgLevel=="2"||sOrgLevel=="3"||sOrgLevel=="<%=sLevel%>")
			OpenComp("GrantOrgList","/SystemManage/RightManage/GrantOrgList.jsp","OrgLevel="+sOrgLevel+"&UserID=<%=sUserID%>&SortNo=<%=sSortNo%>&SortNoLength=<%=sSortNoLength%>","right");	
		
	}
	
	/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
		
	</script> 
<%/*~END~*/%>


<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main06;Describe=在页面装载时执行,初始化;]~*/%>
	<script language="javascript">
	startMenu();
	expandNode("root");	
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>
