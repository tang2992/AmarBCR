<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main00;Describe=ע����;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content: �ͻ���Ϣά����ҳ��
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "�ͻ���Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;�ͻ���Ϣά��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main03;Describe=������ͼ;]~*/%>
	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"�ͻ���Ϣά��","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	//������ͼ�ṹ
	tviTemp.insertPage("root","�ͻ���Ϣά��","",1);

	%>
<%/*~END~*/%>


<%/*~BEGIN~���ɱ༭��[Editable=false;CodeAreaID=Main04;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/Main04.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Main05;Describe=��ͼ�¼�;]~*/%>
	<script type="text/javascript"> 
	
	/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/

	function TreeViewOnClick()
	{
		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������

		var sCurItemname = getCurTVItem().name;
		
		if(sCurItemname=='�ͻ���Ϣά��'){
			OpenComp("CustomerManageList","/DataMaintain/CustomerMaintain/CustomerManageList.jsp","","right");
		}else{
			return;							
		}
		
		setTitle(getCurTVItem().name);
	}

	
	
	/*~[Describe=����treeview;InputParam=��;OutPutParam=��;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
		
	</script> 
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Main06;Describe=��ҳ��װ��ʱִ��,��ʼ��;]~*/%>
	<script language="javascript">
	startMenu();
	expandNode('root');	
	selectItem("1");
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>