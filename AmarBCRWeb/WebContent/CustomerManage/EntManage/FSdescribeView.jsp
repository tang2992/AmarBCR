<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: --客户资产与负债明细
		History Log:
			qfang 2011.06.13 增加传递参数"报表日期"：ReportDate 
	 */
	String PG_TITLE = "客户资产与负债明细"; //-- 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;详细信息&nbsp;&nbsp;"; //--默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//--默认的内容区文字
	String PG_LEFT_WIDTH = "200";//--默认的treeview宽度

	//定义变量
	String sCustomerType = "";//--客户类型
	String sCustomerID = CurPage.getParameter("CustomerID");
	String sRecordNo = CurPage.getParameter("RecordNo");
	String sReportDate = CurPage.getParameter("ReportDate");
	if(sCustomerID == null) sCustomerID = "";
	if(sReportDate == null) sReportDate = "";

	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"客户资产与负债明细","right");
	tviTemp.TriggerClickEvent=true; //是否自动触发选中事件

	//定义树图结构
	String sSqlTreeView = "from CODE_LIBRARY where CodeNo= 'CusAssetAndOwe' and IsInUse = '1' ";
	tviTemp.initWithSql("SortNo","ItemName","ItemDescribe","","",sSqlTreeView,"Order By SortNo",Sqlca);
%><%@include file="/Resources/CodeParts/View04.jsp"%>
<script type="text/javascript"> 
	//treeview单击选中事件
	function TreeViewOnClick(){
		var sCurItemID = getCurTVItem().id;
		var sCurItemName = getCurTVItem().name;
		var sCurItemDescribe = getCurTVItem().value;

		sCurItemDescribe = sCurItemDescribe.split("@");
		sCurItemDescribe1=sCurItemDescribe[0];  //代码表描述字段中用@分隔的第1个串
		sCurItemDescribe2=sCurItemDescribe[1];  //代码表描述字段中用@分隔的第2个串
		sCurItemDescribe3=sCurItemDescribe[2];  //代码表描述字段中用@分隔的第3个串，根据情况，还可以很多。
		if(sCurItemDescribe1 != "null" && sCurItemDescribe1 != "root"){
			var reportDate = "<%=sReportDate%>";
			var recordNo = "<%=sRecordNo%>";
			OpenComp(sCurItemDescribe2,sCurItemDescribe1,"ComponentName="+sCurItemName+"&CustomerID=<%=sCustomerID%>&RecordNo="+recordNo+"&ReportDate="+reportDate,"right");
			setTitle(getCurTVItem().name);
		}
	}
	
	function startMenu(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
	
		var sCustomerType = "<%=sCustomerType%>";
		//如果客户类型为集团客户，则自动点击"010"项目，如果不是集团客户，则自动展开"010"节点 add by cbsu 2009-10-21
		var sGroupType = sCustomerType.substring(0,2);
		if (sGroupType != '02') {
			expandNode('010');
		} else {
		    selectItem('010');
		}
		
		if(sCustomerType != '0120'){
			selectItem('010010');//自动点击树图，目前写死，也可以设置到 code_library中进行设定
		}else{
			selectItem('010005');//中小企业。 自动点击树图，目前写死，也可以设置到 code_library中进行设定
		}
	}

	startMenu();
</script>
<%@ include file="/IncludeEnd.jsp"%>