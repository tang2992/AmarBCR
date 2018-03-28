<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "客户信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%
	ASObjectModel doTemp = new ASObjectModel("QueryCustomerList");
	 
	if(!CurUser.getUserID().equals("system")){
		doTemp.setJboWhere(doTemp.getJboWhere()+" and  O.FINANCEID IN (select OI.ORGID from jbo.ecr.ORG_TASK_INFO OI where OI.OrgCode='"+CurUser.getRelativeOrgID()+"')");
	}
	
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);//分页显示
	dwTemp.genHTMLObjectWindow("");
	
%>
<%

	String sButtons[][] = {
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","","btn_icon_detail",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
	<script language=javascript>

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=新增记录;InputParam=无;OutPutParam=无;]~*/

	function viewAndEdit()
	{
		var sCustomerID  = getItemValue(0,getRow(),"CIFCUSTOMERID");
		if(typeof(sCustomerID)=="undefined" || sCustomerID.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
            return ;
		}
		popComp("CustomerInfoDetail","/DataMaintain/CustomerMaintain/CustomerInfoDetail.jsp","CustomerID="+sCustomerID+"&Query=true","");
		reloadSelf();
	}
	 
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>