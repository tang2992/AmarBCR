<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Info00;Describe=ע����;]~*/%>
	<%
	/*
		Author: shhu
		Tester:
		Content: ��������ҳ��
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Info01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "����ά��ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Info02;Describe=�����������ȡ����;]~*/%>
<%

	//�������
	//����������
	//���ҳ�����	
	String sColName =  CurPage.getParameter("ColName");
	if(sColName==null) sColName="";
	String sCTCode =  CurPage.getParameter("CTCode");
	if(sCTCode==null) sCTCode="";
	String sPBCode =  CurPage.getParameter("PBCode");
	if(sPBCode==null) sPBCode="";
	
	//System.out.println("----sColName=:"+sColName+",sCTCode=:"+sCTCode+",sPBCode=:"+sPBCode);
	
%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Info03;Describe=�������ݶ���;]~*/%>
	<%
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_CODEMAP");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(" 1=1 ");
	
	doTemp.setRequired("ColName,CTCode,PBCode",true);
	
	doTemp.setEditStyle("Note","3");
	
	if((!sColName.equals(""))||(!sCTCode.equals("")))
	{	
		doTemp.setReadOnly("ColName",true);
		doTemp.setJboWhere(" ColName =:ColName and CTCode =:CTCode and PBCode =:PBCode ");
	}else{
		//doTemp.setJboWhere(" 1=2 ");
	}
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // ����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // �����Ƿ�ֻ�� 1:ֻ�� 0:��д
	
	dwTemp.genHTMLObjectWindow(sColName+","+sCTCode+","+sPBCode);
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Info04;Describe=���尴ť;]~*/%>
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
		{"true","","Button","����","���������޸�","saveRecord()","","","",""},
		//{"true","","Button","����","�����б�ҳ��","goBack()","","","",""}
		};
	%> 
<%/*~END~*/%>

<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=Info05;Describe=����ҳ��;]~*/%>
	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=Info06;Describe=���尴ť�¼�;]~*/%>
	<script type="text/javascript">

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=����;InputParam=�����¼�;OutPutParam=��;]~*/
	function saveRecord(sPostEvents)
	{
		as_save("myiframe0",sPostEvents);		
	}
	
	/*~[Describe=�����б�ҳ��;InputParam=��;OutPutParam=��;]~*/
	function goBack()
	{
		top.close();
	}

	</script>
<%/*~END~*/%>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
