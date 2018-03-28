<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Info00;Describe=注释区;]~*/%>
	<%
	/*
		Author: shhu
		Tester:
		Content: 代码详情页面
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Info01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "代码维护页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Info02;Describe=定义变量，获取参数;]~*/%>
<%

	//定义变量
	//获得组件参数
	//获得页面参数	
	String sColName =  CurPage.getParameter("ColName");
	if(sColName==null) sColName="";
	String sCTCode =  CurPage.getParameter("CTCode");
	if(sCTCode==null) sCTCode="";
	String sPBCode =  CurPage.getParameter("PBCode");
	if(sPBCode==null) sPBCode="";
	
	//System.out.println("----sColName=:"+sColName+",sCTCode=:"+sCTCode+",sPBCode=:"+sPBCode);
	
%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Info03;Describe=定义数据对象;]~*/%>
	<%
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_CODEMAP");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(" 1=1 ");
	
	doTemp.setRequired("ColName,CTCode,PBCode",true);
	
	doTemp.setEditStyle("Note","3");
	
	if((!sColName.equals(""))||(!sCTCode.equals("")))
	{	
		doTemp.setReadOnly("ColName",true);
		doTemp.setJboWhere(" ColName =:ColName and CTCode =:CTCode and PBCode =:PBCode ");
	}else{
		//doTemp.setJboWhere(" 1=2 ");
	}
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // 设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // 设置是否只读 1:只读 0:可写
	
	dwTemp.genHTMLObjectWindow(sColName+","+sCTCode+","+sPBCode);
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Info04;Describe=定义按钮;]~*/%>
	<%
	//依次为：
		//0.是否显示
		//1.注册目标组件号(为空则自动取当前组件)
		//2.类型(Button/ButtonWithNoAction/HyperLinkText/TreeviewItem/PlainText/Blank)
		//3.按钮文字
		//4.说明文字
		//5.事件
		//6.资源图片路径
	String sButtons[][] = {
		{"true","","Button","保存","保存所有修改","saveRecord()","","","",""},
		//{"true","","Button","返回","返回列表页面","goBack()","","","",""}
		};
	%> 
<%/*~END~*/%>

<%/*~BEGIN~不可编辑区~[Editable=false;CodeAreaID=Info05;Describe=主体页面;]~*/%>
	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=Info06;Describe=定义按钮事件;]~*/%>
	<script type="text/javascript">

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=保存;InputParam=后续事件;OutPutParam=无;]~*/
	function saveRecord(sPostEvents)
	{
		as_save("myiframe0",sPostEvents);		
	}
	
	/*~[Describe=返回列表页面;InputParam=无;OutPutParam=无;]~*/
	function goBack()
	{
		top.close();
	}

	</script>
<%/*~END~*/%>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
