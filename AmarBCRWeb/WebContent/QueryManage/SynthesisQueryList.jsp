<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: �ۺ���Ϣ��ѯ�б�
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "�ͻ���ѯ�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
	ECRDataWindowXml ecrDWX = new ECRDataWindowXml("ECR_DATACHECK","ECR_DATACHECK","ECR");
	//2.����Դ����SQL���
	ecrDWX.setWhereSql(" where 1=1 ");
	//3.����ASDataObject����
	ASDataObject doTemp =  ecrDWX.generateASDataObject("List");
	
	//����������
	doTemp.setColumnAttribute(ecrDWX.getFilter(),"IsFilter","1");
	doTemp.generateFilters(Sqlca);
	doTemp.parseFilterData(request,iPostChange);
	CurPage.setAttribute("FilterHTML",doTemp.getFilterHtml(Sqlca));
	
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:parent.shoDetail();\"";
	doTemp.appendHTMLStyle("",sStyle);
	
	if(!doTemp.haveReceivedFilterCriteria()) doTemp.WhereClause+="   ";//�ɼ�and 1=2
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
	String sButtons[][] = {
		{"true","","Button","ͳ��","ͳ��","shoDetail()",sResourcesPath},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()",sResourcesPath},
		};
	%> 
<%/*~END~*/%>

<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=List05;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
	<script language=javascript>
	
	/*~[Describe=�鿴���޸�����;InputParam=��;OutPutParam=��;]~*/
	function shoDetail()
	{
		var sLoanCardNo = getItemValue(0,getRow(),"LOANCARDNO");
		if (typeof(sLoanCardNo)=="undefined" || sLoanCardNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		popComp("SynthesisQueryInfoDetail","/QueryManage/SynthesisQueryInfoDetail.jsp","LoanCardNo="+sLoanCardNo,"");
		reloadSelf();
	}
	
	function viewAndEdit(){
		var sLoanCardNo = getItemValue(0,getRow(),"LOANCARDNO");
		var sChinaName = getItemValue(0,getRow(),"CUSTOMERNAME");
		if (typeof(sLoanCardNo)=="undefined" || sLoanCardNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		popComp("SynthesisQueryInfo","/QueryManage/SynthesisQueryInfo.jsp","LoanCardNo="+sLoanCardNo,"");
		reloadSelf();
	}
	
	</script>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List07;Describe=ҳ��װ��ʱ�����г�ʼ��;]~*/%>
<script language=javascript>	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>