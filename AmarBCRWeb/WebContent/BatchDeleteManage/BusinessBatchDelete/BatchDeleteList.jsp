<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%	
	String PG_TITLE = "批量删除数据维护列表页面"; // 浏览器窗口标题 <title> PG_TITLE </title>

	String isReport = CurPage.getParameter("isReport");	//0-未上报，1-已上报，2-批删结果,3-不再上报
	if(isReport == null) isReport = "";
	String where = null;
	if("0".equals(isReport))
		where = "SessionID = '0000000000'";
	else if("1".equals(isReport))
		where = "SessionID not in ('1111111111','7777777777','8888888888','0000000000') and SessionID is not null";
	else if("3".equals(isReport))
		where = "SessionID = '1111111111'";
	else
		where = "SessionID in ('7777777777','8888888888')";
	
	if(!CurUser.getUserID().equals("system"))
		where+=" and O.FINANCEID IN (select OI.orgid from jbo.ecr.ORG_TASK_INFO OI where OI.ORGCODE='"+CurUser.getRelativeOrgID()+"')";
	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.HIS_BATCHDELETE");
	ASObjectModel doTemp = new ASObjectModel(boManager);	
	//主键
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
	String keyStr = "";
	for(String key: keyAttrs){
		keyStr += key+"`";
	}
	
	doTemp.setJboWhere(where);
	doTemp.setVisible("*", false);
	doTemp.setVisible("OccurDate,ContractNo,BusinessType,LoanCardNo,FinanceID,SessionID", true);
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("BusinessType,ContractNo,LoanCardNo",true);
	doTemp.setDDDWCodeTable("BusinessType", 
			"01,贷款业务,02,保理,03,票据贴现,04,贸易融资,05,信用证,06,保函,07,承兑汇票,08,公开授信,09,垫款,10,欠息");
	if(!"1".equals(isReport))
		doTemp.setHeader("Sessionid", "上报状态");
	doTemp.setDDDWCodeTable("SessionID", 
			"7777777777,删除失败,8888888888,删除成功,0000000000,未上报,1111111111,批删后不再上报,,已上报");
	
	//双击打开详情
	String sStyle = "style= \"cursor:pointer\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
    dwTemp.setPageSize(20);

	dwTemp.genHTMLObjectWindow("%");
	
%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List04;Describe=定义按钮;]~*/%>
	<%
	//依次为：
		//0.是否显示
		//1.注册目标组件号(为空则自动取当前组件)
		//2.类型(Button/ButtonWithNoAction/HyperLinkText/TreeviewItem/PlainText/Blank)
		//3.按钮文字
		//4.说明文字
		//5.事件
		//6.资源图片路径
	String sButtons[][] = {
			{isReport.equals("0")?"true":"false","","Button","新增","新增记录","newRecord()","","","",""},
			{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
			{isReport.equals("0")?"true":"false","","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
			{isReport.equals("2")?"true":"false","","Button","不再上报","批删后不再上报","report(1)","","","",""},
			{isReport.equals("2")?"true":"false","","Button","重新上报","批删出错后重新上报","report(0)","","","",""},
		};
	%> 
<%/*~END~*/%>

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
	<script type="text/javascript">

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=删除记录;InputParam=无;OutPutParam=无;]~*/
	function newRecord()
	{
		OpenPage("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteInfo.jsp?ReadOnly=F&isReport=<%=isReport%>&isNew=1","_self","");     
		reloadSelf();
	}
	
	function deleteRecord()
	{
		sContractNo = getItemValue(0,getRow(),"ContractNo");
		
		if (typeof(sContractNo)=="undefined" || sContractNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		
		if(confirm("您真的想删除该信息吗？")) 
		{
			as_delete('myiframe0');
			reloadSelf();
		}
	}
	
	function report(flag)
	{
		var keys = "<%=keyStr.substring(0, keyStr.length()-1)%>";
		var keyArr = keys.split("`");
		var keyArrLen = keyArr.length;
		var values = "";
		for(var k_i=0; k_i<keyArrLen; k_i++){
			values = values+getItemValue(0,getRow(), keyArr[k_i])+"`";
		}
		values = values.substring(0, values.length-1);
		var keyValue = keys+"~"+values;
		var value = getItemValue(0,getRow(), keyArr[0]);
		
		if(typeof(value)=="undefined" || value==null || value=="" || value=="undefined"){
			alert("请选择一条记录!");
			return;
		}
		var sessionid = getItemValue(0,getRow(), "sessionid");
		if(flag=='0'){
			if(sessionid!='7777777777'){
				alert("只有批删失败才能置为重新上报！");
				return;
			}
		}else{
			if(sessionid!='8888888888'){
				alert("只有批删成功才能置为不再上报！");
				return;
			}	
		}
		if(confirm("您真的想将该比业务设为"+(flag=='0'?"重新":"不再")+"上报吗？")) 
		{
			sReturn = PopPage("/BatchDeleteManage/UpdateBatchDelSession.jsp?keyValue="+keyValue+"&tableName=HIS_BATCHDELETE&report="+flag,"_self","");
			if(sReturn=="Success"){
				alert("设置"+(flag=='0'?"重新":"不再")+"上报成功!");
				reloadSelf();
			}else{
				alert("设置"+(flag=='0'?"重新":"不再")+"上报失败!");

			}
		}
	}

	/*~[Describe=查看及修改详情;InputParam=无;OutPutParam=无;]~*/
	function viewAndEdit()
	{
		var keys = "<%=keyStr.substring(0, keyStr.length()-1)%>";
		var keyArr = keys.split("`");
		var keyArrLen = keyArr.length;
		var values = "";
		for(var k_i=0; k_i<keyArrLen; k_i++){
			values = values+getItemValue(0,getRow(), keyArr[k_i])+"`";
		}
		values = values.substring(0, values.length-1);
		var keyValue = keys+"~"+values;
		var value = getItemValue(0,getRow(), keyArr[0]);
		if(typeof(value)=="undefined" || value==null || value=="" || value=="undefined"){
			alert("请选择一条记录!");
			return;
		}
		OpenPage("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteInfo.jsp?keyValue="+keyValue+"&ReadOnly=F&isReport=<%=isReport%>","_self","");
	}
	
	</script>
<%/*~END~*/%>	

<%@ include file="/Frame/resources/include/include_end.jspf"%>
