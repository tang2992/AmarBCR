<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	/*
		页面说明: 示例列表页面
	 */
	String PG_TITLE = "无需上报数据列表页面";
	//获得页面参数
	
	ASObjectModel doTemp = new ASObjectModel("UnReportBusList");
	String jboWhere = doTemp.getJboWhere();
	doTemp.setJboWhere(jboWhere);
	
    doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(13);

	//生成HTMLDataWindow
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
			{"true","","Button","新增","新增","my_add()","","","",""},
			{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
			{"true","","Button","删除","删除","deleteRecord()","","","",""},
			{"true","","Button","批量导入","批量导入","batchImport()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

	function my_add(){
		OpenPage("/DataMaintain/GuaranteeMaintain/UnReportBusInfo.jsp","_self","");
	}


	function viewAndEdit(){
		var sMainBusinessNo = getItemValue(0,getRow(),"MAINBUSINESSNO");
		if (typeof(sMainBusinessNo)=="undefined" || sMainBusinessNo.length==0){
			alert("请选择一条记录！");
			return;
		}
		//OpenPage("/AppConfig/OrgUserManage/UserInfo.jsp?UserID="+sUserID,"_self","");
     	OpenPage("/DataMaintain/GuaranteeMaintain/UnReportBusInfo.jsp?MainBusinessNo="+sMainBusinessNo,"_self","");  
		reloadSelf();
	}
	/*~[Describe=删除记录;InputParam=无;OutPutParam=无;]~*/
	function deleteRecord()
	{
		var sMainBusinessNo = getItemValue(0,getRow(),"MAINBUSINESSNO");
		
		if (typeof(sMainBusinessNo)=="undefined" || sMainBusinessNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		
		if(confirm("您真的想删除该信息吗？")) 
		{
			as_delete('myiframe0');
		}
		reloadSelf();
	}
	/*~[Describe=批量导入还款计划;InputParam=无;OutPutParam=无;]~*/
	function batchImport(){
		var pageURL = "/AppConfig/FileImport/FileSelector.jsp";
	    var parameter = "clazz=jbo.imports.excel.BCR_UNREPORTBUSINESSNO"; //导入模板
	    var dialogStyle = "dialogWidth=650px;dialogHeight=350px;resizable=1;scrollbars=0;status:y;maximize:0;help:0;";
	    var sReturn = AsControl.PopComp(pageURL, parameter, dialogStyle);
		reloadSelf();
	}
	
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
