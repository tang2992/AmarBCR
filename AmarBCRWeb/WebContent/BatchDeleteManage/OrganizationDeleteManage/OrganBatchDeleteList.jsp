<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		ҳ��˵��: ʾ���б�ҳ��
	 */
	String PG_TITLE = "������Ϣ����ɾ���б�";
 
	//���ҳ�����
	String sNode = CurPage.getParameter("node");//���ݽڵ����
	if(sNode==null) sNode="";
	
	//ͨ��JBO����ASObjectModel����doTemp
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.HIS_BATCHDELETEORGAN");
	ASObjectModel doTemp = new ASObjectModel(boManager);	
	//����
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
	String keyStr = "";
	for(String key: keyAttrs){
		keyStr += key+"`";
	}
	
	String where;//����where������
	if(sNode.equals("UnDelete"))
		where = "SessionID = '0000000000'";
	else if(sNode.equals("Deleted"))
		where = "SessionID not in ('1111111111','7777777777','8888888888','0000000000') and SessionID is not null";
	else if(sNode.equals("NotReport"))
		where = "SessionID = '1111111111'";
	else
		where = "SessionID in ('7777777777','8888888888')";
	
	if(!CurUser.getUserID().equals("system"))
		where+=" and O.FINANCEID IN (select OI.orgid from jbo.ecr.ORG_TASK_INFO OI where OI.ORGCODE='"+CurUser.getRelativeOrgID()+"')";
	doTemp.setJboWhere(where);
	doTemp.setVisible("*", false);
	doTemp.setVisible("Cifcustomerid,Segmenttype,Updatedate,Sessionid", true);
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("Cifcustomerid", true);
	doTemp.setVisible("Cifcustomerid,Segmenttype,Updatedate,Sessionid", true);
	doTemp.setDDDWCodeTable("SEGMENTTYPE", "B,ȫ��,C,�������Զ�,D,����״̬��,E,������Ϣ��,F,�߹ܼ���Ҫ��ϵ�˶�,G,��Ҫ�ɶ���,H,��Ҫ������ҵ��,I,���ܵ�λ��");
	//doTemp.setDDDWCodeTable("MANAGERTYPE", "0,ʵ�ʿ�����,1,���³�,2,�ܾ���/��Ҫ������,3,��������,4,���³� ,5,����������");
	doTemp.setDDDWCodeTable("SessionID","7777777777,ɾ��ʧ��,8888888888,ɾ���ɹ�,0000000000,δ�ϱ�,1111111111,��ɾ�����ϱ�,,���ϱ�");
	if(!"Deleted".equals(sNode))
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
		{sNode.equals("UnDelete")?"true":"false","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{sNode.equals("UnDelete")?"true":"false","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
		{sNode.equals("Result")?"true":"false","","Button","�����ϱ�","��ɾ�����ϱ�","report(1)","","","",""},
		{sNode.equals("Result")?"true":"false","","Button","�����ϱ�","��ɾ����������ϱ�","report(0)","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.OpenView("/BatchDeleteManage/OrganizationDeleteManage/OrganizationDeleteInfo.jsp","&sNode=<%=sNode%>","right","dialogWidth=37;dialogHeight=35;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}
	
	function deleteRecord(){
		var sCIFCUSTOMERID = getItemValue(0,getRow(),"CIFCUSTOMERID");
		if (typeof(sCIFCUSTOMERID)=="undefined" || sCIFCUSTOMERID.length==0){
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
		if(confirm("������뽫�ñ�ҵ����Ϊ"+(flag=='0'?"����":"����")+"�ϱ���")) 
		{
			sReturn = PopPage("/BatchDeleteManage/UpdateBatchDelSession.jsp?keyValue="+keyValue+"&tableName=HIS_BATCHDELETEORGAN&report="+flag,"_self","");
			if(sReturn=="Success"){
				alert("����"+(flag=='0'?"����":"����")+"�ϱ��ɹ�!");
				reloadSelf();
			}else{
				alert("����"+(flag=='0'?"����":"����")+"�ϱ�ʧ��!");

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
		OpenPage("/BatchDeleteManage/OrganizationDeleteManage/OrganizationDeleteInfo.jsp?keyValue="+keyValue+"&sNode=<%=sNode%>","_self","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
