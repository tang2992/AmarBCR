<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	String PG_TITLE = "ҵ����Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;ҵ����Ϣά��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "180";//Ĭ�ϵ�treeview���
	%>

	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"ҵ����Ϣά��","right");
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
	tviTemp.insertPage("root","�����Ϣ","ECR_FLOORFUND","",9);
	tviTemp.insertPage("root","ǷϢ��Ϣ","ECR_INTERESTDUE","",10);
	tviTemp.insertPage("root","��֤��Ϣ","ECR_ASSURECONT","",21);
	tviTemp.insertPage("root","��Ѻ��Ϣ","ECR_GUARANTYCONT","",22);
	tviTemp.insertPage("root","��Ѻ��Ϣ","ECR_IMPAWNCONT","",23);
	tviTemp.insertPage("root","�����Ŵ��ʲ�������Ϣ","ECR_ASSETSDISPOSE","",51);
	%>

	<%@include file="/Resources/CodeParts/Main04.jsp"%>

	<script language=javascript> 
	
	/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/

	function TreeViewOnClick()
	{
		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������

		var sCurItemname = getCurTVItem().name;
		var sTableName = getCurTVItem().value;
		if(typeof(sTableName)!="undefined"&&sTableName.length!=0&&sCurItemname!="ҵ����Ϣά��"){
			OpenComp("BusinessManageList","/DataMaintain/BusinessMaintain/BusinessManageList.jsp","TableName="+sTableName,"right");
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
	selectItem("1");
	</script>

<%@ include file="/IncludeEnd.jsp"%>