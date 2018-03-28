<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "校验错误信息列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%	
	String sRecordType = CurPage.getParameter("recordType");
	if(sRecordType == null) sRecordType = "";
	/* BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.ECR_ERRHISTORY");
	ASObjectModel doTemp = new ASObjectModel(boManager); */
	ASObjectModel doTemp = new ASObjectModel("BCRERRHISTORY");
	String where = "1=1" ;
	if(!StringX.isEmpty(sRecordType))
		where = "recordType=:recordType" ;
    /* if(!CurUser.getUserID().equals("system")){
    	where  = where+" and O.FINANCEID IN (select UO.Orgid from jbo.ecr.ORG_TASK_INFO UO where UO.OrgCode='"+CurUser.getRelativeOrgID()+"')";
	}  */ 
	doTemp.setJboWhere(where);
	//双击事件
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewDetail()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	//设置单页显示20行 
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sRecordType);

%>

	<%
	String sButtons[][] = {
		{"true","","Button","详情","进入修改界面","viewDetail()","","","",""},
		{"true","","Button","删除","确认已修改,删除该记录","deleteRecord()","","","",""},
		{"true","","Button","导出EXCEL","导出EXCEL","exportAll()","","","",""}
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">

	//---------------------定义按钮事件------------------------------------
	
	/*~[Describe=查看/修改详情;InputParam=无;OutPutParam=无;]~*/
	function viewDetail()
	{
		var sMAINBUSINESSNO = getItemValue(0,getRow(),"MAINBUSINESSNO");
		var sRECORDTYPE = getItemValue(0,getRow(),"RECORDTYPE");
		var sCUSTOMERID = getItemValue(0,getRow(),"CUSTOMERID");
		var sCompName,sCompPath,sDBTableName,sKeyNameMain,sKeyValueMain;

		if (typeof(sMAINBUSINESSNO) == "undefined" || sMAINBUSINESSNO.length == 0){
			alert("请选择一条记录！");
			return;
			
		}else if(sMAINBUSINESSNO=="MAIN_BUSINESS_NO_NOT_ALLOW_NULL"){
			alert("不存在对应的主业务信息！");	
			return;		
		}
		//获取访问参数
		var sReturnValue = AsControl.RunJsp("/ErrorManage/ValidateErrorManage/GetDBTableName.jsp","RECORDTYPE="+sRECORDTYPE+"&MAINBUSINESSNO="+sMAINBUSINESSNO+"&CUSTOMERID="+sCUSTOMERID);
		if(typeof(sReturnValue)=="undefined" || sReturnValue.length==0){
			alert("查无数据表");
			return;
		}else{
			var sSplitValue = sReturnValue.split(",");
			sCompName = sSplitValue[0];
			sCompPath = sSplitValue[1];
			sTableName = sSplitValue[2];
			sKeyNameMain = sSplitValue[3];
			sKeyValueMain = sSplitValue[4];
		}

		//客户特殊处理
		if(typeof(sTableName)=="undefined" || sTableName.length==0){
			alert("无业务记录对应此校验错误!");
			return;
		}else if(sTableName == "ECR_CUSTOMERINFO"){
			var sReturn = popComp(sCompName,sCompPath,"CustomerID="+sKeyValueMain+"&QueryType=ERROR","");
		}else if(sTableName =="ECR_ORGANINFO"){
			var sReturn = popComp(sCompName,sCompPath,"sCIFCustomerID="+sKeyValueMain+"&QueryType=ERROR&sTableName="+sTableName,"");
		}else if(sTableName =="ECR_ORGANFAMILY"){
			var sReturn = popComp(sCompName,sCompPath,"sCIFCustomerID="+sKeyValueMain+"&QueryType=ERROR&sTableName="+sTableName,"");
		}else if(sTableName =="BCR_GUARANTEEINFO"){
			var sReturn = popComp(sCompName,sCompPath,"GBusinessNo="+sKeyValueMain+"&QueryType=ERROR","");
		}else{
			var sReturn =  popComp(sCompName,sCompPath,"sTableName="+sTableName+"&KeyName="+sKeyNameMain+"&KeyValue="+sKeyValueMain+"&QueryType=ERROR","");
		}
		if(sReturn=="false"){
			alert("这条校验错误信息对应的业务信息已经不存在,请删除这条记录!");
		}
		reloadSelf();
	}
	//删除记录
	function deleteRecord()
	{
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		if(confirm("确认已修改,要删除该记录吗?")) 
		{
			as_delete("myiframe0","reload()");
		}
	}
	/*~[Describe=导出EXCEL;InputParam=无;OutPutParam=无;]~*/
	function exportAll()
	{
		//amarExport("myiframe0");
		as_defaultExport();
	}
	
	</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>