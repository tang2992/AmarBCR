<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		页面说明:菜单详情页面
	*/
	//获得参数	
	String sMenuID =  CurPage.getParameter("MenuID");
	if(sMenuID==null) sMenuID="";

	ASObjectModel doTemp = new ASObjectModel("MenuInfo");
	//如果不为新增页面，则参数的ID不可修改
	if(sMenuID.length() != 0 ){
		doTemp.setReadOnly("MenuID",true);
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.setRightType(); //设置权限
	dwTemp.genHTMLObjectWindow(sMenuID);

	String sButtons[][] = {
		{"true","All","Button","保存","","saveRecord()","","","",""},
		{"true","All","Button","配置可见角色","","selectMenuRoles()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		as_save("myiframe0","afterOpen()"); //刷新tree使用
	}
	
	function afterOpen(){
		parent.OpenMenuTree(getItemValue(0,0,"SortNo"));
	}
	
	<%/*~[Describe=选择菜单可见角色;InputParam=无;OutPutParam=无;]~*/%>
	function selectMenuRoles(){
		var sMenuID=getItemValue(0,0,"MenuID");
		var sMenuName=getItemValue(0,0,"MenuName");
		AsControl.PopView("/AppConfig/MenuManage/SelectMenuRoleTree.jsp","MenuID="+sMenuID+"&MenuName="+sMenuName,"dialogWidth=440px;dialogHeight=500px;center:yes;resizable:no;scrollbars:no;status:no;help:no");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>