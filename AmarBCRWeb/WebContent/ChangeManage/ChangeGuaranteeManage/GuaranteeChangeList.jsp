<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		ҳ��˵��: ʾ���б�ҳ��
	 */
	String PG_TITLE = "����ҵ����Ϣ����б�";
 
	//���ҳ�����
	String sNode = CurPage.getParameter("node");//���ݽڵ����
	if(sNode==null) sNode="";
	
	//ͨ��JBO����ASObjectModel����doTemp
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_GUARANTEECHANGE");
	ASObjectModel doTemp = new ASObjectModel(boManager);	
	//����
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
	String keyStr = "";
	for(String key: keyAttrs){
		keyStr += key+"`";
	}
	
	String where;//����where������
	if(sNode.equals("UnChange"))
		where = "SessionID = '1111111111'";
	else if(sNode.equals("Change"))
		where = "SessionID not in ('1111111111','7777777777','8888888888','0000000000') and SessionID is not null";
	else
		where = "SessionID in ('7777777777','8888888888')";
	
	/* if(!CurUser.getUserID().equals("system"))
		where+=" and O.FINANCEID IN (select OI.orgid from jbo.ecr.ORG_TASK_INFO OI where OI.ORGCODE='"+CurUser.getRelativeOrgID()+"')"; */
	doTemp.setJboWhere(where);
	doTemp.setVisible("*", false);
	doTemp.setVisible("FinanceCode,GBusinessNo,NEWGBusinessNo,Updatedate,Sessionid", true);
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("GBusinessNo", true);
	doTemp.setDDDWCodeTable("SessionID","7777777777,���ʧ��,8888888888,����ɹ�,0000000000,δ�ϱ�");
	if(!"Change".equals(sNode))
		doTemp.setHeader("Sessionid", "�ϱ�״̬");
	
	//˫��������
	String sStyle = "style= \"cursor:pointer\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
   	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
   	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
   	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
   	dwTemp.setPageSize(20);

	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{sNode.equals("UnChange")?"true":"false","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{sNode.equals("UnChange")?"true":"false","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
		{sNode.equals("Result")?"true":"false","","Button","�����ϱ�","��ɾ�����ϱ�","report(1)","","","",""},
		{sNode.equals("Result")?"true":"false","","Button","�����ϱ�","��ɾ����������ϱ�","report(0)","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.OpenView("/ChangeManage/ChangeGuaranteeManage/GuaranteeChangeInfo.jsp","&sNode=<%=sNode%>","right","dialogWidth=37;dialogHeight=35;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}
	
	function deleteRecord(){
		var sGBusinessNo = getItemValue(0,getRow(),"GBusinessNo");
		if (typeof(sGBusinessNo)=="undefined" || sGBusinessNo.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		
		if(confirm("�������ɾ������Ϣ��")){
			as_delete("myiframe0");
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
		if(flag=="0"){
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
	}

	function viewAndEdit(){
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
		OpenPage("/ChangeManage/ChangeGuaranteeManage/GuaranteeChangeInfo.jsp?keyValue="+keyValue+"&sNode=<%=sNode%>","_self","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
