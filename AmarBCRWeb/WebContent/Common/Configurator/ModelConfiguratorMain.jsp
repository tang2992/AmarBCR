<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: ��������
	 */
	String PG_TITLE = "ģ������"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;��������&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���

	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"ϵͳģ������","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�

	//������ͼ�ṹ
	//tviTemp.insertPage("0010","root","��������","AsControl.OpenComp('/AppConfig/FlowManage/FlowCatalogList.jsp','','right')","",1);
	tviTemp.insertPage("0020","root","�ͻ�����ģ��","AsControl.OpenComp('/Common/Configurator/EvaluateManage/EvaluateCatalogList.jsp','Type=CreditLevel','right')","",2);
	//tviTemp.insertPage("0030","root","���նȲ���ģ��","AsControl.OpenComp('/Common/Configurator/EvaluateManage/EvaluateCatalogList.jsp','Type=Risk','right')","",3);
	tviTemp.insertPage("0040","root","���շ���ģ��","AsControl.OpenComp('/Common/Configurator/EvaluateManage/EvaluateCatalogList.jsp','Type=Classify','right')","",4);
	tviTemp.insertPage("0050","root","������ģ������","AsControl.OpenComp('/Common/Configurator/ClassifyManage/ClassifyCatalogList.jsp','','right')","",5);
	String sFolder1=tviTemp.insertFolder("0060","root","���񱨱�ģ������","","",6);
	tviTemp.insertPage("0060010",sFolder1,"�����Ŀ","AsControl.OpenComp('/Common/Configurator/ReportManage/FinanceItemList.jsp','','right')","",1);
	tviTemp.insertPage("0060020",sFolder1,"���񱨱�","AsControl.OpenComp('/Common/Configurator/ReportManage/ReportCatalogList.jsp','','right')","",2);
	tviTemp.insertPage("0070","root","Ԥ������","AsControl.OpenComp('/Common/Configurator/AlarmManage/AlarmFrame.jsp','','right')","",7);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	/*~[Describe=treeview����ѡ���¼�;]~*/
	function TreeViewOnClick(){
		eval(html2Real(getCurTVItem().value));
        setTitle(getCurTVItem().name);
	}
	
	/*~[Describe=����treeview;]~*/
	function startMenu(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandAll();
		selectItem('0020');
	}
	
	startMenu();
</script>
<%@ include file="/IncludeEnd.jsp"%>