<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Tree00;Describe=ע����;]~*/%>
	<%
	/*
		Author:     qhhui
		Tester:
		Content:    ��Ϣ����ѡ��
		Input Param:
		Output param:
		History Log: 
	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Tree01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "��Ϣ����ѡ����ͼ"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;��Ϣ����ѡ��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Tree03;Describe=������ͼ;]~*/%>
	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"��Ϣ�����б�","right");
    tviTemp.TriggerClickEvent=true;
	
	String sSqlTreeView = " from CODE_LIBRARY where CodeNo='ReportType' and IsInUse = '1'";
	//����������������Ϊ��
	//ID�ֶ�(����),Name�ֶ�(����),Value�ֶ�,Script�ֶ�,Picture�ֶ�,From�Ӿ�(����),OrderBy�Ӿ�,Sqlca
    tviTemp.initWithSql("ItemNo","ItemName","ItemNo","","",sSqlTreeView,"Order By ItemNo",Sqlca);

	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�
	%>
<%/*~END~*/%>


<%/*~BEGIN~���ɱ༭��[Editable=false;CodeAreaID=Tree04;Describe=����ҳ��]~*/%>
	<%@include file="/Resources/CodeParts/Tree04.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Tree05;]~*/%>
	<script type="text/javascript"> 

    //treeview����ѡ���¼�
	function TreeViewOnClick()
	{
		var ItemValue = getCurTVItem().value;
		//���ڵ㲻��ѡ��
		if(ItemValue=='root'){
			top.returnValue="";
			return;
		}else{
			top.returnValue = getCurTVItem().value+"@"+getCurTVItem().name;
		}
		if(confirm("��ѡ����\n\n��Ϣ����: ["+getCurTVItem().name+"]\n\nȷ����?")){
			top.close();
		}else{
		    top.returnValue="";
		}
	}

	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
	
	</script> 
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Tree06;Describe=��ҳ��װ��ʱִ��,��ʼ��]~*/%>
	<script type="text/javascript">
	startMenu();
	expandNode('root');
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>
