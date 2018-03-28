<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: 基础配置
	 */
	String PG_TITLE = "基础配置"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;基础配置&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度

	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"所有类","right");
	tviTemp.TriggerClickEvent=true; //是否自动触发选中事件

	//定义树图结构
	String sSql = "Select ClassName from CLASS_CATALOG Order By ClassName";
	String sTreeView[][] = Sqlca.getStringMatrix(sSql);

	int iTreeNode=1;
	for(int i=0;i<sTreeView.length;i++){
		tviTemp.insertPage("root",sTreeView[i][0],"","",iTreeNode++);
	}
	tviTemp.insertPage("root","所有","","",iTreeNode++);
%><%@include file="/Resources/CodeParts/View04.jsp"%>
<script type="text/javascript"> 
	/*~[Describe=treeview单击选中事件;InputParam=无;OutPutParam=无;]~*/
	function TreeViewOnClick(){
		var sClassName="";
		sNodeValue = getCurTVItem().value;
		if(sNodeValue==""){
			sClassName = getCurTVItem().name;
		}else{
			sClassName = getCurTVItem().value;
		}
		if(sClassName=="所有") sClassName="";
		OpenComp("ClassCatalogList","/Common/Configurator/ClassManage/ClassCatalogList.jsp","ClassName="+sClassName,"right","");
       setTitle(getCurTVItem().name);
	}
	
	/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/
	function startMenu(){
		<%=tviTemp.generateHTMLTreeView()%>
	}

	startMenu();
	expandNode('root');		
</script>
<%@ include file="/IncludeEnd.jsp"%>