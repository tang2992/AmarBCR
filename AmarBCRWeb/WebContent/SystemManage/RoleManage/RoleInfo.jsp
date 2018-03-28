<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content: 角色管理页面
		Input Param:
		Output param:
		History Log: 
            
	 */
	%>
<%/*~END~*/%>




<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "角色管理"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%/*~END~*/%>




<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List02;Describe=定义变量，获取参数;]~*/%>
<%

	//定义变量
	String sSql;
	String sSortNo; //排序编号
	
	//获得组件参数	
	String sRoleID =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("RoleID"));
	
	if(sRoleID==null) sRoleID="";
	
	//获得页面参数	
	//sCustomerID =  DataConvert.toRealString(iPostChange,(String)request.getParameter("CustomerID"));
%>
<%/*~END~*/%>




<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List03;Describe=定义数据对象;]~*/%>
<%	

	//通过显示模版产生ASDataObject对象doTemp
	String sHeaders[][] = {
						   {"ROLEID","角色ID"},
						   {"ROLENAME","角色名称"},
		                   {"ROLEATTRIBUTE","角色属性"},
					       {"ROLEDESCRIBE","角色描述"},
					       {"ROLESTATUS","角色状态"},
					       {"INPUTUSER","备注"}
						  };
	sSql = "select ROLEID,ROLENAME,ROLEATTRIBUTE,ROLEDESCRIBE,ROLESTATUS,INPUTUSER from  AWE_ROLE_INFO where 1=1 and ROLEID='" + sRoleID+"'";
	       
	ASDataObject doTemp = new ASDataObject(sSql);
	doTemp.setHeader(sHeaders);
	doTemp.UpdateTable="AWE_ROLE_INFO";
    doTemp.setKey("ROLEID",true);  
    
    doTemp.setDDDWSql("ROLESTATUS","select ItemNo,ItemName from CODE_LIBRARY where CodeNo='IsInUse'");
    
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写

	//定义后续事件
	
	//生成HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	session.setAttribute(dwTemp.Name,dwTemp);

	String sCriteriaAreaHTML = ""; 
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
		{"true","","Button","保存","保存修改","saveRecord()",sResourcesPath},
		};
	%> 
<%/*~END~*/%>




<%/*~BEGIN~不可编辑区~[Editable=false;CodeAreaID=List05;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>




<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
	<script language=javascript>
    var sCurRoleID=""; //记录当前所选择行的代码号

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=保存;InputParam=后续事件;OutPutParam=无;]~*/
	function saveRecord()
	{
	        setItemValue(0,0,"UpdateUser","<%=CurUser.getUserID()%>");
            setItemValue(0,0,"UpdateTime","<%=StringFunction.getToday()%>");
            as_save("myiframe0");
        
	}
    
    /*~[Describe=返回;InputParam=无;OutPutParam=无;]~*/
    function doReturn(sIsRefresh){
		sObjectNo = getItemValue(0,getRow(),"RoleID");
        parent.sObjectInfo = sObjectNo+"@"+sIsRefresh;
		parent.closeAndReturn();
	}

	</script>
<%/*~END~*/%>




<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
	<script language=javascript>
	function initRow(){
		if (getRowCount(0)==0) //如果没有找到对应记录，则新增一条，并设置字段默认值
		{
			as_add("myiframe0");//新增记录
            setItemValue(0,0,"InputUser","<%=CurUser.getUserID()%>");
            setItemValue(0,0,"InputOrg","<%=CurUser.getOrgID()%>");
            setItemValue(0,0,"InputTime","<%=StringFunction.getToday()%>");
            setItemValue(0,0,"UpdateUser","<%=CurUser.getUserID()%>");
            setItemValue(0,0,"UpdateTime","<%=StringFunction.getToday()%>");
            bIsInsert = true;
		}
	}

	</script>
<%/*~END~*/%>




<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List07;Describe=页面装载时，进行初始化;]~*/%>
<script language=javascript>	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
	initRow();
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>
