<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: shhu
		Tester:
		Content: �����ϱ�����б�ҳ��
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "�����ϱ�����б�ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
	String sSql;
	String sHeaders[][] = {
						   {"SessionID","�ڴ�"},
						   {"MessageType","��������"},
						   {"RetryType","�Ƿ��ر�"},
						   {"RecordNumber","�ϱ�������"},
					       {"FeedbackNumber","����������"},
					       {"FeedbackDate","������������"}
						  };
	sSql = "select SessionID,getCodeName('1101',MessageType) as MessageType,case RetryType when '0' then '��' else '��' end as RetryType," +
		   "RecordNumber,FeedbackNumber,FeedbackDate " +
		   "from ECR_REPORTSTATUS where 1 = 1 order by SessionID desc";
	       
	ASDataObject doTemp = new ASDataObject(sSql);
	doTemp.setHeader(sHeaders);

	//���ù�����
	doTemp.setFilter(Sqlca,"1","SessionID","Operators=BeginsWith,EndWith,Contains,EqualsString;");
 	doTemp.setFilter(Sqlca,"2","MessageType","Operators=BeginsWith,EndWith,Contains,EqualsString;");
 	doTemp.setFilter(Sqlca,"3","RetryType","Operators=BeginsWith,EndWith,Contains,EqualsString;");
	doTemp.parseFilterData(request,iPostChange);
	CurPage.setAttribute("FilterHTML",doTemp.getFilterHtml(Sqlca));
	
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:parent.viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
	doTemp.setHTMLStyle("SessionID"," style={width:90px;}");
	doTemp.setHTMLStyle("MessageType"," style={width:200px;}");
	doTemp.setHTMLStyle("RetryType"," style={width:60px;}");
	doTemp.setHTMLStyle("RecordNumber"," style={width:70px;}");
	doTemp.setHTMLStyle("FeedbackNumber"," style={width:70px;}");
	doTemp.setHTMLStyle("FeedbackTime"," style={width:85px;}");
	
	ASDataWindow dwTemp = new ASDataWindow(CurPage ,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);

	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("%");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
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
		
	String sButtons[][] = {};
	
	%> 
<%/*~END~*/%>

<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=List05;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>

<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List07;Describe=ҳ��װ��ʱ�����г�ʼ��;]~*/%>
<script language=javascript>	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>
