<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: 对象类型属性列表
	 */
    //获得页面参数	
	String sObjectType = CurPage.getParameter("ObjectType");
	if (sObjectType == null) sObjectType = "";

	ASObjectModel doTemp = new ASObjectModel("ObjTypeAttributeList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sObjectType);
	
	String sButtons[][] = {
		{"true","","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	setDialogTitle("对象类型属性列表");
	function newRecord(){
		AsControl.PopComp("/AppConfig/ObjectManage/ObjectTypeAttrInfo.jsp","ObjectType=<%=sObjectType%>","");
        reloadSelf();
	}
	
	function viewAndEdit(){
		var sObjectType = getItemValue(0,getRow(),"ObjectType");
		var sAttributeID = getItemValue(0,getRow(),"AttributeID");
		if(typeof(sAttributeID)=="undefined" || sAttributeID.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		AsControl.PopComp("/AppConfig/ObjectManage/ObjectTypeAttrInfo.jsp","ObjectType="+sObjectType+"&AttributeID="+sAttributeID,"");
		reloadSelf();
	}

	function deleteRecord(){
		var sAttributeID = getItemValue(0,getRow(),"AttributeID");
		if(typeof(sAttributeID)=="undefined" || sAttributeID.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		if(confirm(getHtmlMessage('2'))){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>