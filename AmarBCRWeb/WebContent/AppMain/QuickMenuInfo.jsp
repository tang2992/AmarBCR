<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<head><title>�����������</title></head>
<%
	String sQuickId = CurPage.getParameter("QuickId");
	if(sQuickId == null) sQuickId = "";

	ASObjectModel doTemp = new ASObjectModel("QuickMenuInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style = "2";
	dwTemp.ReadOnly = "0";
	
	dwTemp.genHTMLObjectWindow(sQuickId);
	
	String sButtons[][] = {
		{"true","","Button","����","���������޸�","saveRecord()","","","",""},
	};
	
	sButtonPosition = "south";
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		as_save("myiframe0","setReturn()");
	}
	
	function setReturn(){
		var sQuickId = getItemValue(0, 0, "QuickId");
		var sQuickName = getItemValue(0, 0, "QuickName");
		var sQuickParams = getItemValue(0, 0, "QuickParams");
		var sRemark = getItemValue(0, 0, "Remark");
		top.returnValue = sQuickId+"@"+sQuickName+"@"+sQuickParams+"@"+sRemark;
	}
	
	function selectMenu(){
		var sMenuName = getItemValue(0, 0, "MenuName");
		var sQuickName = getItemValue(0, 0, "QuickName");
		
		var sMenuId = getItemValue(0, 0, "QuickParams");
		var sParam = "SelectDialogUrl=/AppMain/SelectMenuDialog.jsp&SelectDialogTitle=�˵�ѡ�񴰿�";
		if(sMenuId) sParam += "&MenuId="+sMenuId;
		var sReturn = AsControl.PopPage("/Frame/page/tools/SelectDialog.jsp", sParam, "dialogWidth:350px;dialogHeight:400px;resizable:no;maximize:no;help:no;menubar:no;status:no;");
		if(!sReturn) return;
		if(sReturn == "_CLEAR_") sReturn = ["", ""];
		else sReturn = sReturn.split("@");
		setItemValue(0, 0, "QuickParams", sReturn[0]);
		setItemValue(0, 0, "MenuName", sReturn[1]);
		
		if(!sQuickName || sQuickName == sMenuName)
			setItemValue(0, 0, "QuickName", sReturn[1]);
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>