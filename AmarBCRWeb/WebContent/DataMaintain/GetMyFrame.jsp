<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Tree00;Describe=ע����;]~*/%>
	<%
	/*
		Tester:
		Content:    ����ѡ��
		Input Param:
		Output param:
		History Log: 
	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Tree01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "����ѡ����ͼ"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;��������ѡ��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Tree03;Describe=������ͼ;]~*/%>
	<%
	String sDataType  = CurPage.getParameter("DataType");
	String sIniteValue  = CurPage.getParameter("IniteValue");
	if(sIniteValue==null){
		sIniteValue = "";
	}
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"�����б�","right");
    tviTemp.TriggerClickEvent=true;
	
	String sSqlTreeView = " from WEB_CODEMAP where ColName='"+sDataType+"'";
	//����������������Ϊ��
	//ID�ֶ�(����),Name�ֶ�(����),Value�ֶ�,Script�ֶ�,Picture�ֶ�,From�Ӿ�(����),OrderBy�Ӿ�,Sqlca
    tviTemp.initWithSql("PbCode","Note","PbCode","","",sSqlTreeView,"Order By PbCode",Sqlca);

	//tviTemp.ImageDirectory = sResourcesPath; //������Դ�ļ�Ŀ¼��ͼƬ��CSS��
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�
	%>
<%/*~END~*/%>


<%/*~BEGIN~���ɱ༭��[Editable=false;CodeAreaID=Tree04;Describe=����ҳ��]~*/%>
	<%@include file="/Resources/CodeParts/Tree04.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Tree05;]~*/%>
	<script language=javascript> 

    //treeview����ѡ���¼�
	function TreeViewOnClick()
	{
		var sCurItemValue = getCurTVItem().value;
		var sType = getCurTVItem().type;
		if(sCurItemValue != 'root'){
			if(sType == "page"){
				top.returnValue = getCurTVItem().value+"@"+getCurTVItem().name;
				if(confirm("��ѡ����\n\n����: ["+getCurTVItem().name+"]\n\nȷ����?")){
					top.close();
				}else{
				    top.returnValue="";
				}
			}else{
				alert("ҳ�ڵ���Ϣ����ѡ��������ѡ��");
			}
		}
	}

	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
	
	</script> 
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Tree06;Describe=��ҳ��װ��ʱִ��,��ʼ��]~*/%>
	<script language="JavaScript">
	startMenu();
	expandNode('root');
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>