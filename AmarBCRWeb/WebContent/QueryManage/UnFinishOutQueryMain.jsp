<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	String PG_TITLE = "����ҵ����Ϣͳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;����ҵ����Ϣͳ��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "180";//Ĭ�ϵ�treeview���
	%>

	<%
	String sSelectID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("SelectID"));
	if(sSelectID == null) sSelectID = "";
	%>

	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"δ����ҵ����Ϣͳ��","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	//������ͼ�ṹ
	//String sFolder1=tviTemp.insertFolder("root","ҵ����Ϣά��","",0);
	tviTemp.insertPage("root","����ҵ��","ECR_LOANCONTRACT","",1);
	tviTemp.insertPage("root","����ҵ��","ECR_FACTORING","",2);
	tviTemp.insertPage("root","Ʊ������","ECR_DISCOUNT","",3);
	tviTemp.insertPage("root","ó������","ECR_FINAINFO","",4);
	tviTemp.insertPage("root","����֤","ECR_CREDITLETTER","",5);
	tviTemp.insertPage("root","����ҵ��","ECR_GUARANTEEBILL","",6);
	tviTemp.insertPage("root","�жһ�Ʊ","ECR_ACCEPTANCE","",7);
	tviTemp.insertPage("root","��������","ECR_CUSTOMERCREDIT","",8);
	%>
<%/*~END~*/%>


<%/*~BEGIN~���ɱ༭��[Editable=false;CodeAreaID=Main04;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/Main04.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��[Editable=true;CodeAreaID=Main05;Describe=��ͼ�¼�;]~*/%>
	<script language=javascript> 
	
	/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/

	function TreeViewOnClick()
	{
		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������

		var sCurItemname = getCurTVItem().name;
		var sTableName = getCurTVItem().value;
		if(typeof(sTableName)!="undefined"&&sTableName.length!=0&&sCurItemname!="δ����ҵ����Ϣͳ��"){
			OpenComp("UnFinishOutQueryList","/QueryManage/UnFinishOutQueryList.jsp","TableName="+sTableName,"right");
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

	<script language="javascript">
	startMenu();
	expandNode('root');	
	<%
	if(sSelectID.equals("")){
	%>
	selectItem("1");
	<%}
	else{
	%>
	selectItem("<%=sSelectID%>");
	<%}%>
	</script>
<%@ include file="/IncludeEnd.jsp"%>