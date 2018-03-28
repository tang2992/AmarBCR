<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Describe: 报表说明
		Input Param:
			--sRecordNo:	报表流水号
	 */
	//定义变量
	boolean isEditable=true;
	//获得组件参数,报表流水号
	String sRecordNo = CurPage.getParameter("RecordNo");
	String sEditable = CurPage.getParameter("Editable");
	if("false".equals(sEditable)) isEditable=false;

	ASObjectModel doTemp = new ASObjectModel("ReportDescribe");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request); 
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sRecordNo);

	String sButtons[][] = {
		{isEditable?"true":"false","","Button","保存","保存所有修改","saveRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	var bIsInsert = false; //标记DW是否处于“新增状态”
	/*~[Describe=保存;InputParam=后续事件;OutPutParam=无;]~*/
	function saveRecord(){
		//当前月份财务报表已存在
		if(checkFSMonth()){
			sReportDate = getItemValue(0,getRow(),"ReportDate");
			alert(sReportDate +" 的财务报表已存在！");
			return;
		}
		setItemValue(0,0,"UserID","<%=CurUser.getUserID()%>");
		setItemValue(0,0,"OrgID","<%=CurUser.getOrgID()%>");
		as_save("myiframe0");
	}
	
	/*~[Describe=获取月份;InputParam=后续事件;OutPutParam=无;]~*/
	function getMonth(sObject){
		sReturnMonth = PopPage("/Common/ToolsA/SelectMonth.jsp?rand="+randomNumber(),"","dialogWidth=18;dialogHeight=12;center:yes;status:no;statusbar:no");
		if(typeof(sReturnMonth) != "undefined"){
			setItemValue(0,0,sObject,sReturnMonth);
		}
	}
	/*~[Describe=检测报表月份是否已存在;InputParam=后续事件;OutPutParam=无;]~*/
	function checkFSMonth(){
		sCustomerID = getItemValue(0,getRow(),"CustomerID");
		sRecordNo = getItemValue(0,getRow(),"RecordNo");
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sReturn=RunMethod("CustomerManage","CheckFSRecord",sCustomerID+","+sRecordNo+","+sReportDate);
		if(sReturn>0)return true;
		return false;
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>