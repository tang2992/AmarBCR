<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��: �ĵ�������ҳ��
	 */
	String PG_TITLE = "�ĵ�������ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;��ϸ��Ϣ&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���

	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"�ĵ�����","right");
	tviTemp.TriggerClickEvent = true; //�Ƿ��Զ�����ѡ���¼�

	//������ͼ�ṹ
	tviTemp.insertPage("010","root","�ͻ�����ĵ�", "Customer","",1);
	tviTemp.insertPage("020","root","�����ĵ�", "Other","",2);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	function TreeViewOnClick(){
		var sObjectType = getCurTVItem().value;
		AsControl.OpenComp("/AppConfig/Document/DocumentFrame.jsp","ObjectType="+sObjectType,"right");
		setTitle(getCurTVItem().name);
	}
	
	function initTreeView() {
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItem("010");
	}

	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>