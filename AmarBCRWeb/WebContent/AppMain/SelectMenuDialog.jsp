<%@page import="com.amarsoft.awe.res.AppManager"%>
<%@ page import="com.amarsoft.web.ui.mainmenu.AmarMenu"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	String sMenuId = CurPage.getParameter("MenuId");
	if(sMenuId == null) sMenuId = "";

	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"UI�������","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����
	
	ArrayList<String> ExcludeIDs = new ArrayList<String>();
	AmarMenu menu = new AmarMenu(CurUser, AppManager.getMainAppID(), ExcludeIDs);
	menu.fillMenu(tviTemp);
	
	String sButtons[][] = {
	};
%><%@include file="/Resources/CodeParts/View07.jsp"%>
<script type="text/javascript">
function startMenu(){
	<%=tviTemp.generateHTMLTreeView()%>
	expandNode('root');
	selectItem('<%=sMenuId%>');
}
function TreeViewOnClick(){}
function TreeViewOnDBLClick(){
	doSure();
}
function doSure(){
	var node = getCurTVItem();
	if(node.type == "folder"){
		alert("��ѡ��ĩ�˹��ܲ˵���");
		return;
	}
	top.returnValue = node.id+"@"+node.name;
	top.close();
}
startMenu();
</script>
<%@ include file="/IncludeEnd.jsp"%>