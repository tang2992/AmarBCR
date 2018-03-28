<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
     String isQuery = CurPage.getParameter("isQuery");
	 if(isQuery == null) isQuery = "1";
	 ASObjectModel doTemp = new ASObjectModel("CONTACT_INFO"); 
	 doTemp.setVisible("*", false);
	 doTemp.setVisible("OrgCode,ContactPerson,ContactPhone,InputDate", true);
	 if("0".equals(isQuery)){
		 doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:doSearch()\"");
	 }else{
	 	 doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	 }
	 
	 ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	 dwTemp.Style = "1";//freeform
	 dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	 dwTemp.genHTMLObjectWindow("%");
	 String sButtons[][] = {
		 {!"0".equals(isQuery)?"true":"false","","Button","详情","查看联系人信息","viewAndEdit()","","","","",""},
		 {!"0".equals(isQuery)?"true":"false","","Button","删除","删除联系人信息","deleteRecord()","","","","",""},
		 {"0".equals(isQuery)?"true":"false","","Button","确定","确定","doSearch()","","","",""},
		 {"0".equals(isQuery)?"true":"false","","Button","取消","取消","javascript:top.close();","","","",""},
	 };
	//sButtonPosition = "south";
%>

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

	function deleteRecord(){
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if (typeof(sOrgCode)=="undefined" || sOrgCode.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		if(confirm("您真的想删除该信息吗？")){
			as_delete("myiframe0");
		} 
	}
	
	function doSearch(){
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if(typeof(sOrgCode) == "undefined" || sOrgCode.length == 0)
		{
			alert("请选择一条业务信息!");//请选择一条信息！
			return;
		}else {
			top.returnValue = sOrgCode;
			top.close();
		}
	}
	
	function viewAndEdit(){
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if (typeof(sOrgCode)=="undefined" || sOrgCode.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
		}else{
			OpenPage("/WebTask/ContactPersons.jsp?OrgCode="+sOrgCode,"_self","");
		}
	}
	
</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
