<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	//获得组件参数
	String sRoleID = CurPage.getParameter("RoleID");
	if(sRoleID == null) sRoleID = "";
	
	ASObjectModel doTemp = new ASObjectModel("ViewAllUserList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sRoleID);

	String sButtons[][] = {
		{"true","","Button","导出Excel","导出Excel","exportAll()","","","",""},
	};
%> <%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	setDialogTitle("角色下用户列表");
	<%/*~[Describe=导出;InputParam=无;OutPutParam=无;]~*/%>
	function exportAll(){
		as_defaultExport();
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>