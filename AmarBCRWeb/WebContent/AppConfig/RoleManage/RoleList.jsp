<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*角色列表*/
	//通过显示模版产生ASDataObject对象doTemp
	ASObjectModel doTemp = new ASObjectModel("RoleList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{(CurUser.hasRole("099")?"true":"false"),"","Button","新增角色","新增一种角色","newRecord()","","","",""},
		{"true","","Button","详情","查看角色情况","viewAndEdit()","","","",""},
		{(CurUser.hasRole("099")?"true":"false"),"","Button","删除","删除该角色","deleteRecord()","","","",""},
		{"true","","Button","角色下用户","查看该角色所有用户","viewUser()","","","",""},
		{"true","","Button","主菜单授权","给角色授权主菜单","my_AddMenu()","","","",""},
		{"true","","Button","多角色菜单授权","给多个角色授权主菜单","much_AddMenu()","","","",""},
		{(CurUser.hasRole("099")?"true":"false"),"","Button","变更生效","同步缓存中数据使数据库变更生效","reloadCacheRole()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		sReturn=popComp("RoleInfo","/AppConfig/RoleManage/RoleInfo.jsp","","");
		if (typeof(sReturn)!='undefined' && sReturn.length!=0) {
			reloadSelf();
		}
	}
	
	function viewAndEdit(){
		var sRoleID = getItemValue(0,getRow(),"RoleID");
		if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}
	
		sReturn=popComp("RoleInfo","/AppConfig/RoleManage/RoleInfo.jsp","RoleID="+sRoleID,"");
		//修改数据后刷新列表
		if (typeof(sReturn)!='undefined' && sReturn.length!=0){
			reloadSelf();
		}
	}
	
	function deleteRecord(){
		var sRoleID = getItemValue(0,getRow(),"RoleID");
		if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}
		if(confirm(getMessageText("ALS70902"))){ //删除该角色的同时将删除该角色对应的权限，确定删除该角色吗？
			as_delete("myiframe0");
		}
	}
	
	<%/*~[Describe=给角色授权主菜单;]~*/%>
	function my_AddMenu(){
		var sRoleID = getItemValue(0,getRow(),"RoleID");
		if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}
		PopPage("/AppConfig/RoleManage/AddRoleMenu.jsp?RoleID="+sRoleID,"","400px;dialogHeight=540px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;");       	
	}
	
	<%/*[Describe=给多角色授权主菜单;]*/%>
	function much_AddMenu(){
		PopPage("/AppConfig/RoleManage/AddMuchRoleMenus.jsp","","dialogWidth=550px;dialogHeight=600px;center:yes;resizable:yes;scrollbars:no;status:no;help:no");
	}
	
	<%/*[Describe=查看该角色所有用户;]*/%>
	function viewUser(){
		var sRoleID = getItemValue(0,getRow(),"RoleID");
		if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
			alert(getMessageText('AWEW1001'));//请选择一条信息！
			return;
		}
//		PopPage("/AppConfig/RoleManage/ViewAllUserList.jsp?RoleID="+sRoleID,"","dialogWidth=700px;dialogHeight=540px;center:yes;resizable:yes;scrollbars:no;status:no;help:no");
		AsControl.PopView("/AppConfig/RoleManage/ViewAllUserList.jsp","RoleID="+sRoleID,"dialogWidth=700px;dialogHeight=540px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}
	
	<%/*~[Describe=生效变更;]~*/%>
	function reloadCacheRole(){
		AsDebug.reloadCacheAll();
	}		
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>