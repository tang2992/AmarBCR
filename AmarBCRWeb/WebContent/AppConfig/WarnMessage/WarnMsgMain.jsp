<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	String PG_TITLE = "ϵͳ��ʾ��Ϣ";
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;"+PG_TITLE+"&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���

	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"ϵͳ��ʾ��Ϣ","right");
	tviTemp.TriggerClickEvent=true;
 	tviTemp.insertPage("0010", "root", "δ�����Java�����쳣", "", "", 1);
 	tviTemp.insertPage("0020", "root", "AREϵͳ��Ϣ����", "", "", 2);
 	tviTemp.insertPage("0030", "root", "AWEϵͳ��Ϣ����", "", "", 3);
 	tviTemp.insertPage("0040", "root", "DataWindow��Ϣ����", "", "", 4);
 	tviTemp.insertPage("0050", "root", "ҵ�������Ϣ����", "", "", 5);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	function TreeViewOnClick(){
		var sCurItemID = getCurTVItem().id;
		AsControl.OpenView("/AppConfig/WarnMessage/WarnMsgList.jsp","MsgType="+sCurItemID,"right");
		setTitle(getCurTVItem().name);
	}
	
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItem("0010");
	}
		
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>