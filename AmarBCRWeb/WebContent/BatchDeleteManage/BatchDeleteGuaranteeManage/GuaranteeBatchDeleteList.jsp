<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		页面说明: 示例列表页面
	 */
	String PG_TITLE = "担保业务信息批量删除列表";
 
	//获得页面参数
	String sNode = CurPage.getParameter("node");//传递节点参数
	if(sNode==null) sNode="";
	
	//通过JBO产生ASObjectModel对象doTemp
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_GUARANTEEDELETE");
	ASObjectModel doTemp = new ASObjectModel(boManager);	
	//主键
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
	String keyStr = "";
	for(String key: keyAttrs){
		keyStr += key+"`";
	}
	
	String where;//设置where条件。
	if(sNode.equals("UnDelete"))
		//where = "SessionID = '0000000000'";
		where = "SessionID = '1111111111'";
	else if(sNode.equals("Deleted"))
		where = "SessionID not in ('1111111111','7777777777','8888888888','0000000000') and SessionID is not null";
	else if(sNode.equals("NotReport"))
		where = "SessionID = '0000000000'";
	else
		where = "SessionID in ('7777777777','8888888888')";
	
	/* if(!CurUser.getUserID().equals("system"))
		where+=" and O.FINANCEID IN (select OI.orgid from jbo.ecr.ORG_TASK_INFO OI where OI.ORGCODE='"+CurUser.getRelativeOrgID()+"')"; */
	doTemp.setJboWhere(where);
	doTemp.setVisible("*", false);
	doTemp.setVisible("FinanceCode,GBusinessNo,DeleteType,Updatedate,Sessionid", true);
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("GBusinessNo", true);
	doTemp.setDDDWCodeTable("DeleteType", "1,整笔业务删除,2,在保（代偿）责任信息删除,3,代偿信息删除,4,保费缴纳信息删除");
	doTemp.setDDDWCodeTable("SessionID","7777777777,删除失败,8888888888,删除成功,1111111111,未上报,0000000000,批删后不再上报,,已上报");
	if(!"Deleted".equals(sNode))
		doTemp.setHeader("Sessionid", "上报状态");
	
	//双击打开详情
	String sStyle = "style= \"cursor:pointer\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
   	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
   	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
   	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
   	dwTemp.setPageSize(20);

	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{sNode.equals("UnDelete")?"true":"false","","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{sNode.equals("UnDelete")?"true":"false","","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
		{sNode.equals("Result")?"true":"false","","Button","不再上报","批删后不再上报","report(0)","","","",""},
		{sNode.equals("Result")?"true":"false","","Button","重新上报","批删出错后重新上报","report(1)","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeDeleteInfo.jsp","&sNode=<%=sNode%>","right","dialogWidth=37;dialogHeight=35;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}
	
	function deleteRecord(){
		var sGBusinessNo = getItemValue(0,getRow(),"GBusinessNo");
		if (typeof(sGBusinessNo)=="undefined" || sGBusinessNo.length==0){
			alert("请选择一条记录！");
			return;
		}
		
		if(confirm("您真的想删除该信息吗？")){
			as_delete("myiframe0");
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
		if(flag=="0"){
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
			sReturn = PopPage("/BatchDeleteManage/UpdateBatchDelSession.jsp?keyValue="+keyValue+"&tableName=BCR_GUARANTEEDELETE&report="+flag,"_self","");
			if(sReturn=="Success"){
				alert("设置"+(flag=='0'?"重新":"不再")+"上报成功!");
				reloadSelf();
			}else{
				alert("设置"+(flag=='0'?"重新":"不再")+"上报失败!");

			}
		}
	}

	function viewAndEdit(){
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
		OpenPage("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeDeleteInfo.jsp?keyValue="+keyValue+"&sNode=<%=sNode%>","_self","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
