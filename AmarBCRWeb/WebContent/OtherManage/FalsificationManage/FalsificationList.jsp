<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "串户维护列表页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%
    String sFlag = CurPage.getParameter("Flag");
    if(sFlag==null)sFlag="";
    
	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.FALSIFICATION"));
	//生成datawindow
	doTemp.setVisible("SerialNo,Flag,UpdateOrg,UpdateUser,UpdateTime", false);
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("CustomerId,LoanCardNo,ErrLoanCardNo", true);
	if(sFlag.equals("0")){
		doTemp.setJboWhere("Flag='0'");
	}else if(sFlag.equals("1")){
		doTemp.setJboWhere("Flag='1'");
	}
	doTemp.setDDDWJbo("Inputuser,UpdateUser","jbo.ecr.USER_INFO,UserId,UserName,1=1");
	doTemp.setDDDWJbo("InputOrg,UpdateOrg", "jbo.ecr.ORG_INFO,OrgId,OrgName,1=1");
	doTemp.setHTMLStyle("Inputuser,inputorg", "style={width:180px;}");
	
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	//设置单页显示20行
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	
%>

	<%
	String sButtons[][] = {
			{sFlag.equals("0") ? "true":"false","","Button","新增串户信息","录入一笔串户信息","newRecord()","","","",""},
			{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
			{"true","","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
			{sFlag.equals("0") ? "true":"false","","Button","数据处理","处理该笔串户记录","falsification()","","","",""},
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
	<script type="text/javascript">
	function newRecord(){
		AsControl.PopView("/OtherManage/FalsificationManage/FalsificationInfo.jsp","Flag=<%=sFlag%>","dialogWidth=800;dialogHeight=400;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
	function deleteRecord(){
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		if(confirm("您真的想删除该信息吗？")) 
		{
			as_delete("myiframe0");
		}
	}
	function falsification(){
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");
		var sCustomerID = getItemValue(0,getRow(),"CustomerID");
		var sLoanCardNo = getItemValue(0,getRow(),"LoanCardNo");
		var sErrLoanCardNo = getItemValue(0,getRow(),"ErrLoanCardNo");
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		if(confirm("该操作将批量删除历史上报数据,删除反馈错误信息和修正客户数据,您确定要这样做吗?")) 
		{
			var sReturn = popComp("DeleteRelativeData","/OtherManage/FalsificationManage/DeleteRelativeData.jsp","SerialNo="+sSerialNo+"&CustomerID="+sCustomerID+"&LoanCardNo="+sLoanCardNo+"&ErrLoanCardNo="+sErrLoanCardNo,"");
			if(typeof(sReturn)!="undefined" && sReturn !=""){
				if(sReturn=="success"){
					alert("串户处理成功!");
					alert("串户数据已经插入批量删除表，请生成批量删除报文后上报。");
				}else if(sReturn=="false"){
					alert("串户处理失败!");
				}
			}else{
				alert("串户处理失败!");
			}
		}
		reloadSelf();
	}

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=查看/修改详情;InputParam=无;OutPutParam=无;]~*/
	function viewAndEdit()
	{
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		popComp("FalsificationInfo","/OtherManage/FalsificationManage/FalsificationInfo.jsp","SerialNo="+sSerialNo+"&Flag=<%=sFlag%>","");
		reloadSelf();
	}
	 
	</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
