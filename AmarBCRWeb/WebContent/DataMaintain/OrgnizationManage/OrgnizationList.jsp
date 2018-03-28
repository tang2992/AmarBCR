<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	/*
		页面说明: 示例列表页面
	 */
	String PG_TITLE = "机构信息列表页面";
	//获得页面参数
	String IsQuery =  CurPage.getParameter("IsQuery");
	if(IsQuery==null) IsQuery="";
	
	ASObjectModel doTemp = new ASObjectModel("EcrOrginfoList");
	String jboWhere = doTemp.getJboWhere();
	if(!CurUser.getUserID().equals("system")){
		jboWhere = jboWhere + " and  FINANCEID IN (select a.ORGID from jbo.ecr.ORG_TASK_INFO a where a.orgcode='"+CurUser.getRelativeOrgID()+"')";
	}
	doTemp.setJboWhere(jboWhere);
	
	/* sASWizardHtml = "<font color=red>本页面数据量较大，请通过查询条件查询</font>";
	doTemp.setJboWhereWhenNoFilter(" and 1=2 "); */
	
	doTemp.setDDDWJbo("REGISTERTYPE","jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9039'");
	//双击事件
    doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(15);

	//生成HTMLDataWindow
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

	function viewAndEdit(){
		var sCIFCustomerID = getItemValue(0,getRow(),"CIFCUSTOMERID");
		if (typeof(sCIFCustomerID)=="undefined" || sCIFCustomerID.length==0){
			alert("请选择一条记录！");
			return;
		}
		 
     	AsControl.OpenView("/DataMaintain/OrgnizationManage/OrgnizationRelativeList.jsp","IsQuery=<%=IsQuery%>&sCIFCustomerID="+sCIFCustomerID,"_blank","");  
		reloadSelf();
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
