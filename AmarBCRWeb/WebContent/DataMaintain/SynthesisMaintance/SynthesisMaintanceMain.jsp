<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	String PG_TITLE = "�ۺ���Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;�ۺ���Ϣά��&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���
	%>

	<%
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"�ۺ���Ϣά��","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����
	%>

	<%@include file="/Resources/CodeParts/Main04.jsp"%>

	<script language=javascript> 
	
	/*~[Describe=treeview����ѡ���¼�;InputParam=��;OutPutParam=��;]~*/
	OpenComp("SynthesisMaintanceList","/DataMaintain/SynthesisMaintance/SynthesisMaintanceList.jsp","","right");

	
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