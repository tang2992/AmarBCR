<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: ���ͳ�Ʋ�ѯ������
	 */
	String PG_TITLE = "���ͳ�Ʋ�ѯ������"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;"+PG_TITLE+"&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���
	
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"���ͳ�Ʋ�ѯ","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�

	//������ͼ�ṹ
	String sSqlTreeView = "" ;
	sSqlTreeView = "from CODE_LIBRARY where CodeNo= 'XQueryListnew' and IsInUse='1' ";
	tviTemp.initWithSql("SortNo","ItemName","ItemDescribe","","",sSqlTreeView,"Order By SortNo",Sqlca);
	//����������������Ϊ��
	//ID�ֶ�(����),Name�ֶ�(����),Value�ֶ�,Script�ֶ�,Picture�ֶ�,From�Ӿ�(����),OrderBy�Ӿ�,Sqlca
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	/*~[Describe=treeview����ѡ���¼�;]~*/
	function TreeViewOnClick(){
		var sCurItemDescribe = getCurTVItem().value;
		sCurItemDescribe = sCurItemDescribe.split("@");
		sCurItemDescribe1=sCurItemDescribe[0];  //����������ֶ�����@�ָ��ĵ�1����
		sCurItemDescribe2=sCurItemDescribe[1];  //����������ֶ�����@�ָ��ĵ�2����
		sCurItemDescribe3=sCurItemDescribe[2];  //����������ֶ�����@�ָ��ĵ�3����

		if(sCurItemDescribe1 != "null" && sCurItemDescribe1 != "root"&&sCurItemDescribe1 != ""){
			OpenComp(sCurItemDescribe2,sCurItemDescribe1,sCurItemDescribe3,"right");
			setTitle(getCurTVItem().name);
		}
	}
	
	/*~[Describe=����treeview;]~*/
	function startMenu() {
		<%=tviTemp.generateHTMLTreeView()%>
		expandAll();
	}

	startMenu();
</script>
<%@ include file="/IncludeEnd.jsp"%>