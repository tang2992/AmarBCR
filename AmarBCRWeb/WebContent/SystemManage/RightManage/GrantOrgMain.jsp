<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main00;Describe=ע����;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: ����ά����ҳ��
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>



<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "����ά����ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;����ά����ҳ��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���
	%>
<%/*~END~*/%>
<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List02;Describe=�����������ȡ����;]~*/%>
<%

	//�������
	String sSql;
	String sOrgLevel; 
	String sBelongOrg="";
	String sUserID="";
	
	//���ҳ�����	
	sUserID = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("UserID")); 
	if(sUserID==null) sUserID="";
	
	String sSortNoLength = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("SortNoLength"));
	if(sSortNoLength==null) sSortNoLength="";
%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main03;Describe=������ͼ;]~*/%>
	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"��Ȩ�����б�","right");
	tviTemp.ImageDirectory = sResourcesPath; //������Դ�ļ�Ŀ¼��ͼƬ��CSS��
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����
	
	String[] sSortLevel = sSortNoLength.split("@");
	String sLevel = "";
	
	
	sSql = "select SortNo,OrgName from ORG_INFO where length(SortNo)="+Integer.valueOf(sSortLevel[0]).intValue();
	String sSortNo="",sOrgName="";
	ASResultSet rs = Sqlca.getASResultSet(sSql);
	
	if(rs.next()) {
		sSortNo = rs.getString(1);
		sOrgName = rs.getString(2);
	}
	rs.getStatement().close();
	sLevel = "0";
	String sHQ="",sSubHQ="",sBranch="",sUnderBranch="";
	sHQ = tviTemp.insertFolder("root",sOrgName,sLevel,"",1);
	
	for(int i=1;i<sSortLevel.length;i++){
		if(i==1){
			 sSubHQ = tviTemp.insertFolder(sHQ,"����",""+i,"",1);
		}
		if(i==2){
			sBranch = tviTemp.insertFolder(sSubHQ,"֧��",""+i,"",1);
		}
		if(i==3){
			 sUnderBranch = tviTemp.insertFolder(sBranch,"��������",""+i,"",1);
		}		
	}
	
	
	%>
<%/*~END~*/%>


<%/*~BEGIN~���ɱ༭��[Editable=false;CodeAreaID=Main04;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/View06.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Main05;Describe=��ͼ�¼�;]~*/%>
	<script language=javascript> 
	
	OpenComp("GrantOrgList","/SystemManage/RightManage/GrantOrgList.jsp","OrgLevel=<%=sLevel%>&UserID=<%=sUserID%>&SortNo=<%=sSortNo%>&SortNoLength=<%=sSortNoLength%>","right");
	
	/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/
	function TreeViewOnClick()
	{
		var sOrgLevel = getCurTVItem().value;
		if(sOrgLevel=="1"||sOrgLevel=="2"||sOrgLevel=="3"||sOrgLevel=="<%=sLevel%>")
			OpenComp("GrantOrgList","/SystemManage/RightManage/GrantOrgList.jsp","OrgLevel="+sOrgLevel+"&UserID=<%=sUserID%>&SortNo=<%=sSortNo%>&SortNoLength=<%=sSortNoLength%>","right");	
		
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
	expandNode("root");	
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>
