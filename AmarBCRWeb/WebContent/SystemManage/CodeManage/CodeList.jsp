<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: shhu
		Tester:
		Content: ����ά���б�ҳ��
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "����ά���б�ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_CODEMAP");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(" 1=1 ");
	doTemp.setJboOrder(" O.Colname ");
	
	//doTemp.setHTMLStyle("Note"," style={width:150px;}");
	//˫���¼�
	//doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	doTemp.setColumnAttribute("ColName,CTCode,Note","IsFilter","1");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	
	dwTemp.genHTMLObjectWindow("");
	
%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List04;Describe=���尴ť;]~*/%>
	<%
	//����Ϊ��
		//0.�Ƿ���ʾ
		//1.ע��Ŀ�������(Ϊ�����Զ�ȡ��ǰ���)
		//2.����(Button/ButtonWithNoAction/HyperLinkText/TreeviewItem/PlainText/Blank)
		//3.��ť����
		//4.˵������
		//5.�¼�
		//6.��ԴͼƬ·��
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
		};
	%> 
<%/*~END~*/%>

<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=List05;Describe=����ҳ��;]~*/%>
	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
	<script type="text/javascript">

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/
	function newRecord()
	{
		OpenPage("/SystemManage/CodeManage/CodeInfo.jsp","frameright");
	}
	
	function mySelectRow(){
		var sColName = getItemValue(0,getRow(),"ColName");
		var sCTCode = getItemValue(0,getRow(),"CTCode");
		var sPBCode = getItemValue(0,getRow(),"PBCode");
		if (typeof(sColName)=="undefined" || sColName.length==0)
		{
			AsControl.OpenView("/Blank.jsp","TextToShow=����ѡ����Ӧ����Ϣ!","rightdown","");
			return;
		}
		OpenPage("/SystemManage/CodeManage/CodeInfo.jsp?ColName="+sColName+"&CTCode="+sCTCode+"&PBCode="+sPBCode,"frameright"); 
	}
	
	/*~[Describe=ɾ����¼;InputParam=��;OutPutParam=��;]~*/
	function deleteRecord()
	{
		sColName = getItemValue(0,getRow(),"ColName");
		
		if (typeof(sColName)=="undefined" || sColName.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		
		if(confirm("�������ɾ������Ϣ��")) 
		{
			as_delete('myiframe0');
		}
		//reload();
	}

	/*~[Describe=�鿴���޸�����;InputParam=��;OutPutParam=��;]~*/
	function viewAndEdit()
	{
		var sColName = getItemValue(0,getRow(),"ColName");
		var sCTCode = getItemValue(0,getRow(),"CTCode");
		var sPBCode = getItemValue(0,getRow(),"PBCode");
		if (typeof(sColName)=="undefined" || sColName.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		popComp("CodeInfo","/SystemManage/CodeManage/CodeInfo.jsp","ColName="+sColName+"&CTCode="+sCTCode+"&PBCode="+sPBCode,"dialogWidth=600px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
	
	mySelectRow();
	
	</script>
<%/*~END~*/%>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
