<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	String PG_TITLE = "����ҵ����Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;����ҵ����Ϣά��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "180";//Ĭ�ϵ�treeview���
	%>

	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"����ҵ����Ϣά��","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	//������ͼ�ṹ
	tviTemp.insertPage("root","������Ϣ","INIT_GUARANTEEINFO","",1);
	tviTemp.insertPage("root","������ͬ��Ϣ","INIT_GUARANTEECONT","",2);
	tviTemp.insertPage("root","����������Ϣ","INIT_INSUREDS","",3);
	tviTemp.insertPage("root","ծȨ�˼�����ͬ��Ϣ","INIT_CREDITORINFO","",4);
	tviTemp.insertPage("root","����������Ϣ","INIT_COUNTERGUARANTOR","",5);
	tviTemp.insertPage("root","ʵ���ڱ�������Ϣ","INIT_GUARANTEEDUTY","",6);
	tviTemp.insertPage("root","�����ſ���Ϣ","INIT_COMPENSATORYINFO","",7);
	tviTemp.insertPage("root","������ϸ��Ϣ","INIT_COMPENSATORYDETAIL","",8);
	tviTemp.insertPage("root","׷����ϸ��Ϣ","INIT_RECOVERYDETAIL","",9);
	tviTemp.insertPage("root","���ѽ��ɸſ���Ϣ","INIT_PREMIUMINFO","",10);
	tviTemp.insertPage("root","���ѽ�����ϸ��Ϣ","INIT_PREMIUMDETAIL","",11);
	%>

	<%@include file="/Resources/CodeParts/Main04.jsp"%>

	<script language=javascript> 
	
	/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/

	function TreeViewOnClick()
	{
		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������

		var sCurItemname = getCurTVItem().name;
		var sTableName = getCurTVItem().value;
		if(typeof(sTableName)!="undefined"&&sTableName.length!=0&&sCurItemname!="����ҵ����Ϣ����"){
			OpenComp("GuaranteeManageList","/DataMaintain/GuaranteeMaintain/GuaranteeManageList.jsp","TableName="+sTableName,"right");
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