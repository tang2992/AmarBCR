<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "����ά���б�ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%
    String sFlag = CurPage.getParameter("Flag");
    if(sFlag==null)sFlag="";
    
	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.FALSIFICATION"));
	//����datawindow
	doTemp.setVisible("SerialNo,Flag,UpdateOrg,UpdateUser,UpdateTime", false);
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("CustomerId,LoanCardNo,ErrLoanCardNo", true);
	if(sFlag.equals("0")){
		doTemp.setJboWhere("Flag='0'");
	}else if(sFlag.equals("1")){
		doTemp.setJboWhere("Flag='1'");
	}
	doTemp.setDDDWJbo("Inputuser,UpdateUser","jbo.ecr.USER_INFO,UserId,UserName,1=1");
	doTemp.setDDDWJbo("InputOrg,UpdateOrg", "jbo.ecr.ORG_INFO,OrgId,OrgName,1=1");
	doTemp.setHTMLStyle("Inputuser,inputorg", "style={width:180px;}");
	
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	//���õ�ҳ��ʾ20��
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	
%>

	<%
	String sButtons[][] = {
			{sFlag.equals("0") ? "true":"false","","Button","����������Ϣ","¼��һ�ʴ�����Ϣ","newRecord()","","","",""},
			{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
			{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
			{sFlag.equals("0") ? "true":"false","","Button","���ݴ���","����ñʴ�����¼","falsification()","","","",""},
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
	<script type="text/javascript">
	function newRecord(){
		AsControl.PopView("/OtherManage/FalsificationManage/FalsificationInfo.jsp","Flag=<%=sFlag%>","dialogWidth=800;dialogHeight=400;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
	function deleteRecord(){
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		if(confirm("�������ɾ������Ϣ��")) 
		{
			as_delete("myiframe0");
		}
	}
	function falsification(){
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");
		var sCustomerID = getItemValue(0,getRow(),"CustomerID");
		var sLoanCardNo = getItemValue(0,getRow(),"LoanCardNo");
		var sErrLoanCardNo = getItemValue(0,getRow(),"ErrLoanCardNo");
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		if(confirm("�ò���������ɾ����ʷ�ϱ�����,ɾ������������Ϣ�������ͻ�����,��ȷ��Ҫ��������?")) 
		{
			var sReturn = popComp("DeleteRelativeData","/OtherManage/FalsificationManage/DeleteRelativeData.jsp","SerialNo="+sSerialNo+"&CustomerID="+sCustomerID+"&LoanCardNo="+sLoanCardNo+"&ErrLoanCardNo="+sErrLoanCardNo,"");
			if(typeof(sReturn)!="undefined" && sReturn !=""){
				if(sReturn=="success"){
					alert("��������ɹ�!");
					alert("���������Ѿ���������ɾ��������������ɾ�����ĺ��ϱ���");
				}else if(sReturn=="false"){
					alert("��������ʧ��!");
				}
			}else{
				alert("��������ʧ��!");
			}
		}
		reloadSelf();
	}

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=�鿴/�޸�����;InputParam=��;OutPutParam=��;]~*/
	function viewAndEdit()
	{
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		popComp("FalsificationInfo","/OtherManage/FalsificationManage/FalsificationInfo.jsp","SerialNo="+sSerialNo+"&Flag=<%=sFlag%>","");
		reloadSelf();
	}
	 
	</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
