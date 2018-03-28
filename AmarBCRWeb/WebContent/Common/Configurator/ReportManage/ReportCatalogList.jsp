<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: 财务模型目录列表
	 */
	ASObjectModel doTemp = new ASObjectModel("ReportCatalogList");
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(200);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","","Button","模型列表","查看/修改模型列表","viewAndEdit2()","","","",""},
		{"true","","Button","删除","删除所选中的记录","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		sReturn=popComp("ReportCatalogInfo","/Common/Configurator/ReportManage/ReportCatalogInfo.jsp","","");
		reloadSelf(); 
		//新增数据后刷新列表
		if (typeof(sReturn)!='undefined' && sReturn.length!=0){
			sReturnValues = sReturn.split("@");
			if (sReturnValues[0].length !=0 && sReturnValues[1]=="Y"){
				OpenPage("/Common/Configurator/ReportManage/ReportCatalogList.jsp","_self",""); 
			}
		}     
	}
	
	/*~[Describe=查看及修改详情;InputParam=无;OutPutParam=无;]~*/
	function viewAndEdit(){
		var sModelNo = getItemValue(0,getRow(),"MODELNO");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		//openObject("ReportCatalogView",sModelNo,"001");
		popComp("ReportCatalogView","/Common/Configurator/ReportManage/ReportCatalogView.jsp","ObjectNo="+sModelNo+"&ItemID=0010","");
	}
    
	/*~[Describe=查看及修改模型列表;InputParam=无;OutPutParam=无;]~*/
	function viewAndEdit2(){
		var sModelNo = getItemValue(0,getRow(),"MODELNO");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		//popComp("ReportModelList","/Common/Configurator/ReportManage/ReportModelList.jsp","ModelNo="+sModelNo,"");
		popComp("ReportCatalogView","/Common/Configurator/ReportManage/ReportCatalogView.jsp","ObjectNo="+sModelNo+"&ItemID=0020","");
	}

	function deleteRecord(){
		var sModelNo = getItemValue(0,getRow(),"MODELNO");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		if(confirm("将同时删除该报表的基本信息和模型信息，是否继续？")){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>