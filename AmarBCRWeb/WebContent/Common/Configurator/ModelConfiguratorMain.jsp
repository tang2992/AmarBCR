<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: 基础配置
	 */
	String PG_TITLE = "模型配置"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;基础配置&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度

	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"系统模型配置","right");
	tviTemp.TriggerClickEvent=true; //是否自动触发选中事件

	//定义树图结构
	//tviTemp.insertPage("0010","root","审批流程","AsControl.OpenComp('/AppConfig/FlowManage/FlowCatalogList.jsp','','right')","",1);
	tviTemp.insertPage("0020","root","客户评级模型","AsControl.OpenComp('/Common/Configurator/EvaluateManage/EvaluateCatalogList.jsp','Type=CreditLevel','right')","",2);
	//tviTemp.insertPage("0030","root","风险度测算模型","AsControl.OpenComp('/Common/Configurator/EvaluateManage/EvaluateCatalogList.jsp','Type=Risk','right')","",3);
	tviTemp.insertPage("0040","root","风险分类模型","AsControl.OpenComp('/Common/Configurator/EvaluateManage/EvaluateCatalogList.jsp','Type=Classify','right')","",4);
	tviTemp.insertPage("0050","root","决策流模型设置","AsControl.OpenComp('/Common/Configurator/ClassifyManage/ClassifyCatalogList.jsp','','right')","",5);
	String sFolder1=tviTemp.insertFolder("0060","root","财务报表模型设置","","",6);
	tviTemp.insertPage("0060010",sFolder1,"财务科目","AsControl.OpenComp('/Common/Configurator/ReportManage/FinanceItemList.jsp','','right')","",1);
	tviTemp.insertPage("0060020",sFolder1,"财务报表","AsControl.OpenComp('/Common/Configurator/ReportManage/ReportCatalogList.jsp','','right')","",2);
	tviTemp.insertPage("0070","root","预警设置","AsControl.OpenComp('/Common/Configurator/AlarmManage/AlarmFrame.jsp','','right')","",7);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	/*~[Describe=treeview单击选中事件;]~*/
	function TreeViewOnClick(){
		eval(html2Real(getCurTVItem().value));
        setTitle(getCurTVItem().name);
	}
	
	/*~[Describe=生成treeview;]~*/
	function startMenu(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandAll();
		selectItem('0020');
	}
	
	startMenu();
</script>
<%@ include file="/IncludeEnd.jsp"%>