<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    财务报表目录信息详情
	 */
	String sModelNo =  CurPage.getParameter("ModelNo"); //报表记录编号
	if(sModelNo==null) sModelNo="";

	ASObjectModel doTemp = new ASObjectModel("ReportCatalogInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sModelNo);
	
	String sButtons[][] = {
		{"true","","Button","保存","保存修改","saveRecord()","","","",""},
		{"false","","Button","保存并新增","保存修改并新增另一条记录","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		as_save("myiframe0","");       
	}

	function saveRecordAndBack(){
		as_save("myiframe0","doReturn('N');");
	}

	function saveRecordAndAdd(){
		as_save("myiframe0","newRecord()");     
	}
	function doReturn(sIsRefresh){
		sObjectNo = getItemValue(0,getRow(),"MODELNO");
		parent.sObjectInfo = sObjectNo+"@"+sIsRefresh;
		parent.closeAndReturn();
	}

	function newRecord(){
		OpenComp("ReportCatalogInfo","/Common/Configurator/ReportManage/ReportCatalogInfo.jsp","","_self","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>