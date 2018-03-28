<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "一卡多户"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%
	ASObjectModel doTemp = new ASObjectModel("OneCardToUserList");
	//生成datawindow
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	doTemp.setHTMLStyle("ChineseName"," style={width:220px} ");
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	//设置单页显示20行
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	
%>

	<%
	String sButtons[][] = {
		{"false","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"false","","Button","导出EXCEL","导出EXCEL","as_defaultExport()","","","",""}
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
	<script language=javascript>

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=查看/修改详情;InputParam=无;OutPutParam=无;]~*/
	function viewAndEdit()
	{
		var sPutoutNO=getItemValue(0,getRow(),"AccountNo");	
		if (typeof(sPutoutNO)=="undefined" || sPutoutNO.length==0)
		{
			alert("请选择一条记录！");
			return;
		}	
		popComp("PayPlanInfo","/Icr/BusinessData/Current/PayPlanInfo.jsp","PutoutNO="+sPutoutNO,"dialogWidth=350px;dialogHeight=430px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
	 
	</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
