<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	String PG_TITLE = "一卡多户";
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;"+PG_TITLE+"&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "1";//默认的treeview宽度

	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"一卡多户","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true;
 	tviTemp.insertPage("root","一卡多户","",1);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	function TreeViewOnClick(){
		var sCurItemID = getCurTVItem().id;
		var sCurItemname = getCurTVItem().name;
	   if(sCurItemname=='一卡多户'){
		   //AsControl.OpenComp("/Icr/OtherManage/AccountChangeList.jsp","IsReported=0","right");
		   OpenComp("OnetoManyList","/OtherManage/FalsificationManage/OnetoManyList.jsp","","right");
		}else{
			return;
		}
	  setTitle(getCurTVItem().name);
	}
	
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItem("1");
	}
		
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>