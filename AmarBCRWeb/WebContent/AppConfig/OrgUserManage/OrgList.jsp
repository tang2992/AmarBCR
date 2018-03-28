<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		页面说明: 机构管理列表
	 */
	//获取组件参数
	String sOrgID = CurPage.getParameter("OrgID");
	if(sOrgID == null) sOrgID = "";
	String sSortNo = (new ASOrg(sOrgID, Sqlca)).getSortNo();
	if(sSortNo==null) sSortNo="";

	//通过显示模版产生ASDataObject对象doTemp
	ASObjectModel doTemp = new ASObjectModel("OrgList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
    dwTemp.setPageSize(20);
	
	//生成HTMLDataWindow
	dwTemp.genHTMLObjectWindow(sSortNo+"%");

	String sButtons[][] = {
		{"true","","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","","Button","删除","删除所选中的记录","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
        OpenPage("/AppConfig/OrgUserManage/OrgInfo.jsp","_self","");            
	}
	
	function viewAndEdit(){
        var sOrgID = getItemValue(0,getRow(),"OrgID");
        if(typeof(sOrgID)=="undefined" || sOrgID.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
            return ;
		}
		
		OpenPage("/AppConfig/OrgUserManage/OrgInfo.jsp?CurOrgID="+sOrgID,"_self","");        
	}
    
	function deleteRecord(){
		var sOrgID = getItemValue(0,getRow(),"OrgID");
        if(typeof(sOrgID) == "undefined" || sOrgID.length == 0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
            return ;
		}
		
		if(confirm(getHtmlMessage('2'))){ //您真的想删除该信息吗？
			as_delete("myiframe0","reload()");
		}
	}
	function reload(){
		if(parent.reloadView){
			parent.reloadView();
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>