<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Describe: 新增财务报表准备信息 本页面仅仅用于报表信息的新增操作
	 */
	String PG_TITLE = "报表说明"; // 浏览器窗口标题 <title> PG_TITLE </title>
	//获得组件参数，客户编号、模式类型
	String sCustomerID = CurPage.getParameter("CustomerID"); 
	String sModelClass = CurPage.getParameter("ModelClass"); 

	ASObjectModel doTemp = new ASObjectModel("AddFSPre");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request); 
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow("");
	
	//保存后进行财务报表的初始化操作
	//dwTemp.setEvent("AfterInsert","!BusinessManage.InitFinanceReport(CustomerFS,#CustomerID,#ReportDate,#ReportScope,#RecordNo,ModelClass^'"+sModelClass+"',,AddNew,"+CurOrg.getOrgID()+","+CurUser.getUserID()+")");

	String sButtons[][] = {
		{"true","","Button","确定","确定","doCreation()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("新增财务报表");
	/*~[Describe=保存;]~*/
	function saveRecord(sPostEvents){
		if (!ValidityCheck()) return;	
		sReportDate = getItemValue(0,0,"ReportDate");
		sReportScope = getItemValue(0,0,"ReportScope");
		if(sReportScope == '01')
			sReportScopeName = "合并";
		else if(sReportScope == '02')
			sReportScopeName = "本部";
		else
			sReportScopeName = "汇总";
		//如果需要可以进行保存前的权限判断
		sPassRight = AsControl.RunJsp("/CustomerManage/EntManage/FinanceCanPassAjax.jsp","ReportDate="+sReportDate+"&ReportScope="+sReportScope);
		if(sPassRight=="pass"){
			var sPrefix = "CFS";//前缀
			//获取流水号
			var sSerialNo = getSerialNo("CUSTOMER_FSRECORD","RecordNo",sPrefix);
			//将流水号置入对应字段
			setItemValue(0,0,"RecordNo",sSerialNo);
			as_save("myiframe0",sPostEvents);
		}else{
			alert(sReportDate +"月份的"+sReportScopeName+"口径财务报表已存在，请重新选择！");
		}
	}

	function doCreation(){
		saveRecord("goBack()");
	}
	
	function goBack(){
		top.returnValue= "ok";
		top.close();
	}
	
	/*~[Describe=日期选择;]~*/
	function getMonth(sObject){
		sReturnMonth = PopPage("/Common/ToolsA/SelectMonth.jsp?rand="+randomNumber(),"","dialogWidth=250px;dialogHeight=180px;center:yes;status:no;statusbar:no");
		if(typeof(sReturnMonth) != "undefined"){
			setItemValue(0,0,sObject,sReturnMonth);
		}
	}
	
	/*~[Describe=有效性检查;通过true,否则false;]~*/
	function ValidityCheck(){
		//校验报表截止日期是否大于当前日期
		var sReportDate = getItemValue(0,0,"ReportDate");//报表截止日期
		var sToday = "<%=StringFunction.getToday()%>";//当前日期
		sToday = sToday.substring(0,7);//当前日期的年月
		if(typeof(sReportDate) != "undefined" && sReportDate != "" ){
			if(sReportDate >= sToday){
				alert(getMessageText('ALS70163'));//报表截止日期必须早于当前日期！
				return false;		    
			}
		}
		return true;
	}
	
	function initRow(){
		if (getRowCount(0)==0){ //如果没有找到对应记录，则新增一条，并设置字段默认值
			as_add("myiframe0");//新增记录
			setItemValue(0,0,"CustomerID","<%=sCustomerID%>");
		}
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>