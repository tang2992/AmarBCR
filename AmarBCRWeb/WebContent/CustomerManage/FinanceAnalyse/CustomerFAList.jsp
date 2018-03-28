<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Describe: --客户财务分析
		Input Param:
			  CustomerID：--当前客户编号
	 */
	//获得组件参数，客户代码
	String sCustomerID = CurPage.getParameter("CustomerID");

 	ASObjectModel doTemp = new ASObjectModel("CustomerFAList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置为Grid风格
	dwTemp.ReadOnly = "1"; //设置为只读
	dwTemp.genHTMLObjectWindow(sCustomerID);

	String sButtons[][] = {
		{"true","","Button","杜邦分析","杜邦分析","dupondInfo()","","","",""},
		{"true","","Button","结构分析","结构分析","structureInfo()","","","",""},
		{"true","","Button","指标分析","指标分析","itemInfo()","","","",""},
		{"true","","Button","趋势分析","趋势分析","trendInfo()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=杜邦分析;]~*/
	function dupondInfo(){
		var sReportDate=getItemValue(0,getRow(),"ReportDate");
		if(typeof(sReportDate)=="undefined" || sReportDate.length==0){
			alert("请选择要分析的报表！");
		}else{
			//返回值：报表的年月
			sMonth = PopPage("/Common/ToolsA/SelectMonth.jsp?rand="+randomNumber(),"","dialogWidth=250px;dialogHeight=180px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no;scrollbar:yes");
			if(typeof(sMonth)=="undefined" || sMonth=="_none_")	 return;
			AsControl.PopView("/CustomerManage/FinanceAnalyse/DBAnalyse.jsp","CustomerID=<%=sCustomerID%>&AccountMonth="+sMonth);
		}
	}
	
	/*~[Describe=结构分析;]~*/
	function structureInfo(){
	    //返回值：报表的期数、报表的年月、报表范围
		sReturnValue = PopPage("/CustomerManage/FinanceAnalyse/AnalyseTerm.jsp?CustomerID=<%=sCustomerID%>","","dialogWidth=550px;dialogHeight=400px;minimize:no;maximize:no;status:yes;center:yes");
	    if(typeof(sReturnValue)=="undefined" || sReturnValue=="_none_" || sReturnValue==null)	return;
	    AsControl.PopView("/CustomerManage/FinanceAnalyse/StructureView.jsp","CustomerID=<%=sCustomerID%>&Term=" + sReturnValue);
	}

	/*~[Describe=指标分析;]~*/
	function itemInfo(){
	    //返回值：报表的期数、报表的年月、报表范围
		sReturnValue = PopPage("/CustomerManage/FinanceAnalyse/AnalyseTerm.jsp?CustomerID=<%=sCustomerID%>","","dialogWidth=550px;dialogHeight=400px;minimize:no;maximize:no;status:yes;center:yes");
	    if(typeof(sReturnValue)=="undefined" || sReturnValue=="_none_" || sReturnValue==null)	return;
	    AsControl.PopView("/CustomerManage/FinanceAnalyse/ItemView.jsp","CustomerID=<%=sCustomerID%>&Term="+sReturnValue);
	}

	/*~[Describe=趋势分析;]~*/
	function trendInfo(){
	    //返回值：报表的期数、报表的年月、报表范围
		sReturnValue = PopPage("/CustomerManage/FinanceAnalyse/AnalyseTerm_Trend.jsp?CustomerID=<%=sCustomerID%>","","dialogWidth=550px;dialogHeight=400px;minimize:no;maximize:no;status:yes;center:yes");
		if(typeof(sReturnValue)=="undefined" || sReturnValue=="_none_" || sReturnValue==null)	return;
		AsControl.PopView("/CustomerManage/FinanceAnalyse/TrendView.jsp","CustomerID=<%=sCustomerID%>&Term="+sReturnValue);
	}
</script>
<%@	include file="/Frame/resources/include/include_end.jspf"%>