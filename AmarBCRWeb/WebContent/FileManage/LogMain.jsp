<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.are.ARE"
%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main00;Describe=ע����;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content: ��־�ļ�������ҳ��
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>
<%
	String folder = ARE.getProperty("ECR_HOME")+"/log";
	//
	String sRight="";
	boolean bRight = false;
	
	bRight =CurUser.hasRole("400");
	if(bRight==true)    
		sRight="delete,download,view";
	else{
		bRight = CurUser.hasRole("400");
		if(bRight==true)    sRight="view";
	}
	
	String directoryDefine[][]={
		{"��־����",folder,".*\\.log",sRight}
	};
	
	session.setAttribute("DirectoryDefine",directoryDefine);

%>
<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "��־�ļ�������ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;��־�ļ�������ҳ��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main03;Describe=������ͼ;]~*/%>
	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"��־�ļ�����","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	//������ͼ�ṹ
	tviTemp.insertPage("root","��־�ļ�����","",1);
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
		var sCurItemname = getCurTVItem().name;
		
		if(sCurItemname=='��־�ļ�����'){
			OpenPage("/FileManage/GeneralFileManage.jsp?Flag=0","right","");
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
	<script type="text/javascript">
	startMenu();
	expandNode('root');		
	selectItem("1");
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>