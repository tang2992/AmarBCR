<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><% 
	/*
		Describe: 客户财务报表列表
	 */
	//获得组件参数，客户代码
	String sCustomerID =  CurPage.getParameter("CustomerID");

	ASObjectModel doTemp = new ASObjectModel("CustomerFSList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置为Grid风格
	dwTemp.ReadOnly = "1"; //设置为只读
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sCustomerID);
	
	String sButtons[][] = {
		{"true","","Button","新增报表","新增客户一期财务报表","AddNewFS()","","","",""},
		{"false","","Button","报表说明","修改客户一期财务报表基本信息","FSDescribe()","","","",""},
		{"true","","Button","报表详情","查看该期报表的详细信息","FSDetail()","","","",""},
		{"true","","Button","导出报表","导出该期报表","FSExport()","","","",""},
		{"true","","Button","导入报表","导入报表","FSImport()","","","",""},
		{"true","","Button","修改报表日期","修改报表日期","ModifyReportDate()","","","",""},
		{"true","","Button","删除报表","删除该期财务报表","DeleteFS()","","","",""},
		{"true","","Button","完成","设置报表为完成状态","FinishFS()","","","",""},//采用标志位来控制报表权限，新增完成按钮，实现财务报表由新增状态转换为完成状态。
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	var ObjectType = "CustomerFS";
	//新增一期财务报表
	function AddNewFS(){
   		//判断该客户信息中财务报表的类型是否选择
   		sModelClass = PopPageAjax("/CustomerManage/EntManage/FindFSTypeAjax.jsp?CustomerID=<%=sCustomerID%>&rand="+randomNumber(),"","");
   		if(sModelClass == "false"){
   			alert(getMessageText('ALS70162'));//客户概况信息输入不完整，请先输入客户概况信息！
   		}else{
   			sReturn = AsControl.PopView("/CustomerManage/EntManage/AddFSPre.jsp","CustomerID=<%=sCustomerID%>&ModelClass="+sModelClass,"dialogWidth=600px;dialogHeight=680px;resizable:yes;scrollbars:no;");
   			if(sReturn=="ok"){
   				reloadSelf();
	   			FSDetail();
   			}
   		}
	}
	
	function FSImport(){
		var sReportDate = getItemValue(0,getRow(),"ReportDate");
		if(!sReportDate){
			alert("请选择一条记录！");
			return;
		}
		var sObjectNo = getItemValue(0,getRow(),"CustomerID");
		var sReportScope = getItemValue(0,getRow(),"ReportScope");
		
		var o = document.forms["importfsform"];
		if(!o){
			$("<div style='position:absolute;top:0;left:0;width:100%;height:100%;'>"+
				"<iframe name='importfsframe' style='display:none;'></iframe>"+
				"<div style='position:absolute;top:0;left:0;width:100%;height:100%;background:#eee;filter:alpha(opacity=70);opacity:0.70;'></div>"+
				"<div style='position:absolute;top:10%;left:40%;margin-left:-100px;margin-top:-50px;padding:10px;border:1px solid #aaa;background:#eee;'>"+
					"<form name='importfsform' method='post' enctype='multipart/form-data' target='importfsframe'>"+
						"<input type=file name=importfsfile />"+
						"<input type=button value='导入' onclick='upload(this)' />"+
					"</form>"+
					"<a onclick='$(this).parent().parent().hide();' href='javascript:void(0);' style='position:absolute;top:0px;right:1px;display:block;color:red;'>x</a>"+
				"</div>"+
			"</div>").appendTo("body");
			o = document.forms["importfsform"];
		}
		$(o).parent().parent().show();
		o.action = "Common/FinanceReport/ExcelImport.jsp?CompClientID="+sCompClientID+"&ObjectType="+ObjectType+"&ObjectNo="+sObjectNo+"&ReportScope="+sReportScope+"&ReportDate="+sReportDate
	}
	
	function upload(btn){
		var form = btn.parentNode;
		var div = form.parentNode;
		var board = $(div).prev();
		board.insertAfter(div);
		form.submit();
	}
	
	function afterUpload(flag){
		var o = document.forms["importfsform"];
		var div = o.parentNode;
		var board = $(div).next();
		if(board.length != 1) return;
		
		board.insertBefore(div);
		if(flag==true) board.parent().hide();
	}
	
	function FSExport(){
		var sReportDate = getItemValue(0,getRow(),"ReportDate");
		if(!sReportDate){
			alert("请选择一条记录！");
			return;
		}
		var sObjectNo = getItemValue(0,getRow(),"CustomerID");
		var sReportScope = getItemValue(0,getRow(),"ReportScope");
		AsControl.ExportFinanceReport(ObjectType, sObjectNo, sReportScope, sReportDate);
	}
	
	//修改报表基本信息
	function FSDescribe(){
	    var srole = "has";
		var sEditable="true";
		var sUserID = getItemValue(0,getRow(),"UserID");
		var sRecordNo = getItemValue(0,getRow(),"RecordNo");
		if (typeof(sRecordNo) != "undefined" && sRecordNo != "" ){
			if(FSLockStatus())
				sEditable="false";
			if(sUserID!="<%=CurUser.getUserID()%>")
				sEditable="false";
			OpenComp("FinanceStatementInfo","/CustomerManage/EntManage/FinanceStatementInfo.jsp","Role="+srole+"&RecordNo="+sRecordNo+"&Editable="+sEditable,"_self",OpenStyle);
		}else{
			alert(getHtmlMessage('1'));//请选择一条信息！
		}
	}
	
	//报表详细信息
	function FSDetail(){
	    var srole = "has";
		var sCustomerID = getItemValue(0,getRow(),"CustomerID");
		var sReportDate = getItemValue(0,getRow(),"ReportDate");
		var sRecordNo = getItemValue(0,getRow(),"RecordNo");
		var sReportScope = getItemValue(0,getRow(),"ReportScope");
		var sUserID = getItemValue(0,getRow(),"UserID");
		if (typeof(sCustomerID) != "undefined" && sCustomerID != "" ){
			var sEditable="true";
			if(FSLockStatus())
				sEditable="false";
			if(sUserID!="<%=CurUser.getUserID()%>")
				sEditable="false";
			AsControl.OpenComp("/Common/FinanceReport/FinanceReportTab.jsp","Role="+srole+"&RecordNo="+sRecordNo+"&ObjectType="+ObjectType+"&CustomerID="+sCustomerID+"&ReportDate="+sReportDate+"&ReportScope="+sReportScope+"&Editable="+sEditable,"_blank",OpenStyle);
		    reloadSelf();
		}else{
			alert(getHtmlMessage('1'));//请选择一条信息！
		}
	}
	
	//修改报表日期
	function ModifyReportDate(){
		if(FSLockStatus()){
			alert("本期财务报表已锁定，不能修改!");
			return;
		}
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sReportScope = getItemValue(0,getRow(),"ReportScope");
		sRecordNo = getItemValue(0,getRow(),"RecordNo");
		if(typeof(sReportDate)!="undefined"&& sReportDate != "" ){
			//取得对应的报表月份
			sReturnMonth = PopPage("/Common/ToolsA/SelectMonth.jsp?rand="+randomNumber(),"","dialogWidth=250px;dialogHeight=170px;center:yes;status:no;statusbar:no");
			if(typeof(sReturnMonth) != "undefined" && sReturnMonth != ""){
				sToday = "<%=StringFunction.getToday()%>";//当前日期
				sToday = sToday.substring(0,7);//当前日期的年月
				if(sReturnMonth >= sToday){
					alert(getMessageText('ALS70163'));//报表截止日期必须早于当前日期！
					return;		    
				}
				
				if(confirm("你确认要将 "+sReportDate+"财务报表 更改为"+sReturnMonth+"吗？")){
					//如果需要可以进行保存前的权限判断
					sPassRight = PopPageAjax("/CustomerManage/EntManage/FinanceCanPassAjax.jsp?ReportDate="+sReturnMonth+"&ReportScope="+sReportScope,"","resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
					if(sPassRight == "pass"){
						//更改相关的财务报表
						sReturn = RunMethod("BusinessManage","InitFinanceReport","CustomerFS,<%=sCustomerID%>,"+sReportDate+","+sReportScope+","+sRecordNo+","+""+","+sReturnMonth+",ModifyReportDate,<%=CurOrg.getOrgID()%>,<%=CurUser.getUserID()%>");
						if(sReturn == "ok"){
							alert("该期财务报表已经更改为"+sReturnMonth);	
							reloadSelf();	
						}
					}else{
						alert(sReturnMonth +" 的财务报表已存在！");
					}
				}
			}
		}else{
			alert(getHtmlMessage('1'));//请选择一条信息！
		}
	}
	
	//删除一期财务报表
	function DeleteFS(){
		if(FSLockStatus()){
			alert("本期财务报表已锁定，不能删除!");//处于锁定状态的报表，不能删除！
			return;
		}
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sUserID = getItemValue(0,getRow(),"UserID");
		sReportScope = getItemValue(0,getRow(),"ReportScope");
		sRecordNo = getItemValue(0,getRow(),"RecordNo");
		if (typeof(sReportDate) != "undefined" && sReportDate != "" ){
			if(sUserID=='<%=CurUser.getUserID()%>'){
    			if(confirm(getHtmlMessage('2'))){
	    			as_delete('myiframe0');
    			}
			}else{
				alert(getHtmlMessage('3')); //对不起，您无权删除这条信息！
			}
		}else{
			alert(getHtmlMessage('1'));//请选择一条信息！
		}
	}

	//设置测算后的财务报表为完成状态
	function FinishFS(){
		if(FSLockStatus()){
			alert("本期财务报表已锁定，不能修改!");
			return;
		}
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sReportScope = getItemValue(0,getRow(),"ReportScope");
		if (typeof(sReportDate) != "undefined" && sReportDate != "" ){
			sReportStatus = '02';//01表示新增状态，02表示完成状态，03表示锁定状态
			sReturn = RunMethod("CustomerManage","UpdateFSStatus","<%=sCustomerID%>,"+sReportStatus+","+sReportDate+","+sReportScope);
			if(typeof(sReturn) != "undefined" && sReturn.length>=0){
				alert("财务报表已置为完成状态！");	
			}else{
				alert("操作失败！");	
			}
		}else{
			alert(getHtmlMessage('1'));//请选择一条信息！
		}
		reloadSelf();
	}
	
	//检测财务报表是否为锁定状态，如：查询结果为03即锁定状态，返回true，否则返回false
	//此方法就完全可以替代CheckFSinEvaluateRecord方法，因为所有处于03状态的报表都已用于信用等级评估了。
	function FSLockStatus(){
		sCustomerID = getItemValue(0,getRow(),"CustomerID");
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sReportScope = getItemValue(0,getRow(),"ReportScope");
		sReturn=RunMethod("CustomerManage","CheckFSStatus",sCustomerID+","+sReportDate+","+sReportScope);
		return sReturn == '03';
	}
</script>
<%@	include file="/Frame/resources/include/include_end.jspf"%>