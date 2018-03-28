<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "客户信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	
	ASObjectModel doTemp = new ASObjectModel("EcrOrginfoList");//EcrOrginfolist
	
	String jboWhere = " LSCUSTOMERID is not null";
	if(!CurUser.getUserID().equals("system")){
		jboWhere = jboWhere + " and  FINANCEID IN (select a.ORGID from jbo.ecr.ORG_TASK_INFO a where a.orgcode='"+CurUser.getRelativeOrgID()+"')";
	}
	doTemp.setJboWhere(jboWhere);
	
	/* sASWizardHtml = "<font color=red>本页面数据量较大，请通过查询条件查询</font>";
	doTemp.setJboWhereWhenNoFilter(" and 1=2 "); */
	
	doTemp.setDDDWJbo("REGISTERTYPE","jbo.ecr.WEB_CODEMAP,Pbcode,Note,Colname='9039'");	
	//doTemp.set
	//双击事件
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //设置为Grid风格
	//dwTemp.MultiSelect = true; //允许多选
	dwTemp.ReadOnly = "1";	 //编辑模式
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	%>

	<%

	String sButtons[][] = {
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","","btn_icon_detail",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=新增记录;InputParam=无;OutPutParam=无;]~*/

	function viewAndEdit()
	{
		var sCustomerID  = getItemValue(0,getRow(),"LSCUSTOMERID");
		if(typeof(sCustomerID)=="undefined" || sCustomerID.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
            return ;
		}
		popComp("CustomerInfoDetail","/DataMaintain/CustomerMaintain/CustomerInfoDetail.jsp","CustomerID="+sCustomerID,"");
		reloadSelf();
	}
	 
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>