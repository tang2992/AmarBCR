<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main00;Describe=ע����;]~*/%>
	<%
	/*
		Author:hywang
		Tester:
		Content: �������н���
		Input Param:
		Output param:
		History Log: 
	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "�������й���"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;�������й���&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main02;Describe=�����������ȡ����;]~*/%>
	<%
	//�������
	//����������	
	//���ҳ�����	
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main03;Describe=������ͼ;]~*/%>
	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"�����б�","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����
	
	String taskName = CurPage.getParameter("taskName");
	if(taskName==null) taskName = "" ;
	String selectItem = "3";
	if(taskName.contains("feedback"))
		selectItem = "11";

	//������ͼ�ṹ
	String sReport = tviTemp.insertFolder("root","����ȡ����Ԫ","����ȡ����Ԫ","",1);//����sortNo
	tviTemp.insertPage(sReport,"INIT-��������","initTaskFile","",1);
	tviTemp.insertPage(sReport,"PREPARE-���ݳ�ȡ","prepareTaskFile","",2);
	tviTemp.insertPage(sReport,"VALIDATE-����У��","validateTaskFile","",3);
	tviTemp.insertPage(sReport,"TRANSFER-����Ǩ��","transferTaskFile","",4);
	String sReport1 = tviTemp.insertFolder("root","���ɱ��ĵ�Ԫ","���ɱ��ĵ�Ԫ","",2);
	tviTemp.insertPage(sReport1,"REPORT-�����ɼ�����","reportTaskFile","",1);
	tviTemp.insertPage(sReport1,"REPORT-ҵ��������","changeTaskFile","",2);
	tviTemp.insertPage(sReport1,"REPORT-����ɾ������","batchdelTaskFile","",3);
	String sOther =  tviTemp.insertFolder("root","��������Ԫ","��������Ԫ","",3);//����sortNo	
	//tviTemp.insertPage(sOther,"BATCHDEL-����ɾ��","batchdelTaskFile","",1);
	tviTemp.insertPage(sOther,"FEEDBACK-��������","feedbackTaskFile","",1);
	
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
		var sCurItemValue = getCurTVItem().value;
		var sCurItemName = getCurTVItem().name;		
		if(sCurItemValue=='feedbackTaskFile'||sCurItemValue=='transferTaskFile'||sCurItemValue=='initTaskFile'||sCurItemValue=='prepareTaskFile'||sCurItemValue=='validateTaskFile'){
			OpenComp("ECRTaskUnit","/WebTask/ECRTaskUnit.jsp","taskName="+sCurItemValue,"right");
		}else if(sCurItemValue=='reportTaskFile'||sCurItemValue=='changeTaskFile'||sCurItemValue=='batchdelTaskFile'){
			OpenComp("ECRTaskUnit","/WebTask/ECRTaskUnit.jsp","taskName="+sCurItemValue,"right");
		}
		setTitle(sCurItemName);
	}

	/*~[Describe=����treeview;InputParam=��;OutPutParam=��;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>;
	}
	
	</script> 
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Main06;Describe=��ҳ��װ��ʱִ��,��ʼ��;]~*/%>
	<script type="text/javascript">
	startMenu();
	expandNode('root');	
	expandNode(<%=sReport%>);
	expandNode(<%=sReport1%>);
	expandNode(<%=sOther%>);
	selectItem(<%=selectItem%>);
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>
