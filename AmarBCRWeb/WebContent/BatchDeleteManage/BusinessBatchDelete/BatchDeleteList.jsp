<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%	
	String PG_TITLE = "����ɾ������ά���б�ҳ��"; // ��������ڱ��� <title> PG_TITLE </title>

	String isReport = CurPage.getParameter("isReport");	//0-δ�ϱ���1-���ϱ���2-��ɾ���,3-�����ϱ�
	if(isReport == null) isReport = "";
	String where = null;
	if("0".equals(isReport))
		where = "SessionID = '0000000000'";
	else if("1".equals(isReport))
		where = "SessionID not in ('1111111111','7777777777','8888888888','0000000000') and SessionID is not null";
	else if("3".equals(isReport))
		where = "SessionID = '1111111111'";
	else
		where = "SessionID in ('7777777777','8888888888')";
	
	if(!CurUser.getUserID().equals("system"))
		where+=" and O.FINANCEID IN (select OI.orgid from jbo.ecr.ORG_TASK_INFO OI where OI.ORGCODE='"+CurUser.getRelativeOrgID()+"')";
	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.HIS_BATCHDELETE");
	ASObjectModel doTemp = new ASObjectModel(boManager);	
	//����
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
	String keyStr = "";
	for(String key: keyAttrs){
		keyStr += key+"`";
	}
	
	doTemp.setJboWhere(where);
	doTemp.setVisible("*", false);
	doTemp.setVisible("OccurDate,ContractNo,BusinessType,LoanCardNo,FinanceID,SessionID", true);
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("BusinessType,ContractNo,LoanCardNo",true);
	doTemp.setDDDWCodeTable("BusinessType", 
			"01,����ҵ��,02,����,03,Ʊ������,04,ó������,05,����֤,06,����,07,�жһ�Ʊ,08,��������,09,���,10,ǷϢ");
	if(!"1".equals(isReport))
		doTemp.setHeader("Sessionid", "�ϱ�״̬");
	doTemp.setDDDWCodeTable("SessionID", 
			"7777777777,ɾ��ʧ��,8888888888,ɾ���ɹ�,0000000000,δ�ϱ�,1111111111,��ɾ�����ϱ�,,���ϱ�");
	
	//˫��������
	String sStyle = "style= \"cursor:pointer\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
    dwTemp.setPageSize(20);

	dwTemp.genHTMLObjectWindow("%");
	
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
			{isReport.equals("0")?"true":"false","","Button","����","������¼","newRecord()","","","",""},
			{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
			{isReport.equals("0")?"true":"false","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
			{isReport.equals("2")?"true":"false","","Button","�����ϱ�","��ɾ�����ϱ�","report(1)","","","",""},
			{isReport.equals("2")?"true":"false","","Button","�����ϱ�","��ɾ����������ϱ�","report(0)","","","",""},
		};
	%> 
<%/*~END~*/%>

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
	<script type="text/javascript">

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=ɾ����¼;InputParam=��;OutPutParam=��;]~*/
	function newRecord()
	{
		OpenPage("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteInfo.jsp?ReadOnly=F&isReport=<%=isReport%>&isNew=1","_self","");     
		reloadSelf();
	}
	
	function deleteRecord()
	{
		sContractNo = getItemValue(0,getRow(),"ContractNo");
		
		if (typeof(sContractNo)=="undefined" || sContractNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		
		if(confirm("�������ɾ������Ϣ��")) 
		{
			as_delete('myiframe0');
			reloadSelf();
		}
	}
	
	function report(flag)
	{
		var keys = "<%=keyStr.substring(0, keyStr.length()-1)%>";
		var keyArr = keys.split("`");
		var keyArrLen = keyArr.length;
		var values = "";
		for(var k_i=0; k_i<keyArrLen; k_i++){
			values = values+getItemValue(0,getRow(), keyArr[k_i])+"`";
		}
		values = values.substring(0, values.length-1);
		var keyValue = keys+"~"+values;
		var value = getItemValue(0,getRow(), keyArr[0]);
		
		if(typeof(value)=="undefined" || value==null || value=="" || value=="undefined"){
			alert("��ѡ��һ����¼!");
			return;
		}
		var sessionid = getItemValue(0,getRow(), "sessionid");
		if(flag=='0'){
			if(sessionid!='7777777777'){
				alert("ֻ����ɾʧ�ܲ�����Ϊ�����ϱ���");
				return;
			}
		}else{
			if(sessionid!='8888888888'){
				alert("ֻ����ɾ�ɹ�������Ϊ�����ϱ���");
				return;
			}	
		}
		if(confirm("������뽫�ñ�ҵ����Ϊ"+(flag=='0'?"����":"����")+"�ϱ���")) 
		{
			sReturn = PopPage("/BatchDeleteManage/UpdateBatchDelSession.jsp?keyValue="+keyValue+"&tableName=HIS_BATCHDELETE&report="+flag,"_self","");
			if(sReturn=="Success"){
				alert("����"+(flag=='0'?"����":"����")+"�ϱ��ɹ�!");
				reloadSelf();
			}else{
				alert("����"+(flag=='0'?"����":"����")+"�ϱ�ʧ��!");

			}
		}
	}

	/*~[Describe=�鿴���޸�����;InputParam=��;OutPutParam=��;]~*/
	function viewAndEdit()
	{
		var keys = "<%=keyStr.substring(0, keyStr.length()-1)%>";
		var keyArr = keys.split("`");
		var keyArrLen = keyArr.length;
		var values = "";
		for(var k_i=0; k_i<keyArrLen; k_i++){
			values = values+getItemValue(0,getRow(), keyArr[k_i])+"`";
		}
		values = values.substring(0, values.length-1);
		var keyValue = keys+"~"+values;
		var value = getItemValue(0,getRow(), keyArr[0]);
		if(typeof(value)=="undefined" || value==null || value=="" || value=="undefined"){
			alert("��ѡ��һ����¼!");
			return;
		}
		OpenPage("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteInfo.jsp?keyValue="+keyValue+"&ReadOnly=F&isReport=<%=isReport%>","_self","");
	}
	
	</script>
<%/*~END~*/%>	

<%@ include file="/Frame/resources/include/include_end.jspf"%>
