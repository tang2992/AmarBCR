<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	String PG_TITLE = "������Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;������Ϣά��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���
	%>

	<%
	//�������
	
	//����������	
	//���ҳ�����	
	String sRecordType = CurComp.getParameter("recordType");
	if(sRecordType == null) sRecordType = "";
	%>

	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"������Ϣά��","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����

	//������ͼ�ṹ
	//String sFolder1=tviTemp.insertFolder("root","ҵ����Ϣά��","",0);
	tviTemp.insertPage("root","������Ϣά��","������Ϣά��","",1);
	%>

	<%@include file="/Resources/CodeParts/Main04.jsp"%>

	<script language=javascript> 
	
	/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/
	OpenComp("FeedBackList","/ErrorManage/FeedBackManage/FeedBackList.jsp","recordType=<%=sRecordType%>","right");
	
	function TreeViewOnClick()
	{
		//���tviTemp.TriggerClickEvent=true�����ڵ���ʱ������������

		var sCurItemname = getCurTVItem().name;
		var sTableName = getCurTVItem().value;
		if(!sTableName==''){
			OpenComp("FeedBackList","/ErrorManage/FeedBackManage/FeedBackList.jsp","recordType=<%=sRecordType%>","right");
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