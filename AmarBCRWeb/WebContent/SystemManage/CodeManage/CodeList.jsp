<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: shhu
		Tester:
		Content: 代码维护列表页面
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "代码维护列表页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List03;Describe=定义数据对象;]~*/%>
<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_CODEMAP");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(" 1=1 ");
	doTemp.setJboOrder(" O.Colname ");
	
	//doTemp.setHTMLStyle("Note"," style={width:150px;}");
	//双击事件
	//doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	doTemp.setColumnAttribute("ColName,CTCode,Note","IsFilter","1");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);
	
	dwTemp.genHTMLObjectWindow("");
	
%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List04;Describe=定义按钮;]~*/%>
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
		{"true","","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
		};
	%> 
<%/*~END~*/%>

<%/*~BEGIN~不可编辑区~[Editable=false;CodeAreaID=List05;Describe=主体页面;]~*/%>
	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
	<script type="text/javascript">

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=新增记录;InputParam=无;OutPutParam=无;]~*/
	function newRecord()
	{
		OpenPage("/SystemManage/CodeManage/CodeInfo.jsp","frameright");
	}
	
	function mySelectRow(){
		var sColName = getItemValue(0,getRow(),"ColName");
		var sCTCode = getItemValue(0,getRow(),"CTCode");
		var sPBCode = getItemValue(0,getRow(),"PBCode");
		if (typeof(sColName)=="undefined" || sColName.length==0)
		{
			AsControl.OpenView("/Blank.jsp","TextToShow=请先选择相应的信息!","rightdown","");
			return;
		}
		OpenPage("/SystemManage/CodeManage/CodeInfo.jsp?ColName="+sColName+"&CTCode="+sCTCode+"&PBCode="+sPBCode,"frameright"); 
	}
	
	/*~[Describe=删除记录;InputParam=无;OutPutParam=无;]~*/
	function deleteRecord()
	{
		sColName = getItemValue(0,getRow(),"ColName");
		
		if (typeof(sColName)=="undefined" || sColName.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		
		if(confirm("您真的想删除该信息吗？")) 
		{
			as_delete('myiframe0');
		}
		//reload();
	}

	/*~[Describe=查看及修改详情;InputParam=无;OutPutParam=无;]~*/
	function viewAndEdit()
	{
		var sColName = getItemValue(0,getRow(),"ColName");
		var sCTCode = getItemValue(0,getRow(),"CTCode");
		var sPBCode = getItemValue(0,getRow(),"PBCode");
		if (typeof(sColName)=="undefined" || sColName.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		popComp("CodeInfo","/SystemManage/CodeManage/CodeInfo.jsp","ColName="+sColName+"&CTCode="+sCTCode+"&PBCode="+sPBCode,"dialogWidth=600px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
	
	mySelectRow();
	
	</script>
<%/*~END~*/%>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
