<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: --�ͻ��ʲ��븺ծ��ϸ
		History Log:
			qfang 2011.06.13 ���Ӵ��ݲ���"��������"��ReportDate 
	 */
	String PG_TITLE = "�ͻ��ʲ��븺ծ��ϸ"; //-- ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;��ϸ��Ϣ&nbsp;&nbsp;"; //--Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//--Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//--Ĭ�ϵ�treeview���

	//�������
	String sCustomerType = "";//--�ͻ�����
	String sCustomerID = CurPage.getParameter("CustomerID");
	String sRecordNo = CurPage.getParameter("RecordNo");
	String sReportDate = CurPage.getParameter("ReportDate");
	if(sCustomerID == null) sCustomerID = "";
	if(sReportDate == null) sReportDate = "";

	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"�ͻ��ʲ��븺ծ��ϸ","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�

	//������ͼ�ṹ
	String sSqlTreeView = "from CODE_LIBRARY where CodeNo= 'CusAssetAndOwe' and IsInUse = '1' ";
	tviTemp.initWithSql("SortNo","ItemName","ItemDescribe","","",sSqlTreeView,"Order By SortNo",Sqlca);
%><%@include file="/Resources/CodeParts/View04.jsp"%>
<script type="text/javascript"> 
	//treeview����ѡ���¼�
	function TreeViewOnClick(){
		var sCurItemID = getCurTVItem().id;
		var sCurItemName = getCurTVItem().name;
		var sCurItemDescribe = getCurTVItem().value;

		sCurItemDescribe = sCurItemDescribe.split("@");
		sCurItemDescribe1=sCurItemDescribe[0];  //����������ֶ�����@�ָ��ĵ�1����
		sCurItemDescribe2=sCurItemDescribe[1];  //����������ֶ�����@�ָ��ĵ�2����
		sCurItemDescribe3=sCurItemDescribe[2];  //����������ֶ�����@�ָ��ĵ�3��������������������Ժܶࡣ
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
		//����ͻ�����Ϊ���ſͻ������Զ����"010"��Ŀ��������Ǽ��ſͻ������Զ�չ��"010"�ڵ� add by cbsu 2009-10-21
		var sGroupType = sCustomerType.substring(0,2);
		if (sGroupType != '02') {
			expandNode('010');
		} else {
		    selectItem('010');
		}
		
		if(sCustomerType != '0120'){
			selectItem('010010');//�Զ������ͼ��Ŀǰд����Ҳ�������õ� code_library�н����趨
		}else{
			selectItem('010005');//��С��ҵ�� �Զ������ͼ��Ŀǰд����Ҳ�������õ� code_library�н����趨
		}
	}

	startMenu();
</script>
<%@ include file="/IncludeEnd.jsp"%>