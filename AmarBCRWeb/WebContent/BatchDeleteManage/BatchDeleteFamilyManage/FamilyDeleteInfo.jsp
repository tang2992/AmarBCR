<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* ҳ��˵��: ʾ������ҳ�� */
	String PG_TITLE = "�����Ա����";

	// ���ҳ�����
	String sNode = CurPage.getParameter("sNode");
	if(sNode==null) sNode="";
	String keyValue = CurPage.getParameter("keyValue");//����
	if(keyValue == null) keyValue = "";
	
	String keyStr = null;
	String valueStr = null;
	String jboWhere = "";
	String args = "";
	if(keyValue.length()>0){
		String[] kv = keyValue.split("~");
		keyStr = kv[0];
		valueStr = kv[1];
		String[] kArr = keyStr.split("`");
		String[] vArr = valueStr.split("`");
		for(int ii=0; ii<kArr.length; ii++){
			String k = kArr[ii];
			String v = vArr[ii];
			jboWhere = jboWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
		jboWhere = jboWhere.substring(4);
		args = args.substring(1);
	}
	
	//ͨ��JBO����ASObjectModel����doTemp
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.HIS_BATCHDELETEFAMILY");
	ASObjectModel doTemp = new ASObjectModel(boManager);	
	doTemp.setJboWhere(jboWhere.length()>0?jboWhere:"");
	
	doTemp.setDefaultValue("cccurDate", DateX.format(new java.util.Date()));
	doTemp.setVisible("*", false);
	doTemp.setVisible("Cifcustomerid,Managercerttype,Managercertid,Memberrelatype,Membercerttype,Membercertid,updateDate,FinanceID", true);
	doTemp.setRequired("Cifcustomerid,Managercerttype,Managercertid,Memberrelatype,Membercerttype,Membercertid,updateDate,FinanceID",true);
	
	doTemp.setDDDWCodeTable("Memberrelatype", "1,��ż,2,��ĸ,3,��Ů,4,����Ѫ��,5,��������");
	doTemp.setDDDWJbo("Managercerttype,Membercerttype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");
	doTemp.setEditStyle("updateDate", "Date");
	doTemp.setEditStyle("Managercerttype,Membercerttype,Memberrelatype", "Select");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	// �����Ƿ�ֻ�� 1:ֻ�� 0:��д
	if(sNode.equals("UnDelete")){
		dwTemp.ReadOnly = "0";
	}
	else{
		dwTemp.ReadOnly = "1";
	}
	
	dwTemp.genHTMLObjectWindow(args.length()>0?args:"%");
	 
	String sButtons[][] = {
		{sNode.equals("UnDelete")?"true":"false","","Button","����","���������޸�","saveRecord()","","","",""},
		{sNode.equals("UnDelete")?"true":"false","","Button","���沢����","���沢�����б�","saveAndGoBack()","","","",""},
		{"true","","Button","����","�����б�ҳ��","goBack()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(sPostEvents){
		if (!ValidityCheck()) return;
		as_save("myiframe0",sPostEvents);
	}
	
	function saveAndGoBack(){
		saveRecord("goBack()");
	}
	
	function ValidityCheck(){
		//��Ҫ��ϵ�����֤����У��
	    var sMANAGERCERTTYPE=getItemValue(0,0,"MANAGERCERTTYPE");
		var sMANAGERCERTID=getItemValue(0,0,"MANAGERCERTID");
		if(sMANAGERCERTTYPE=="0"&&(!CheckLicense(sMANAGERCERTID))){
			alert(getBusinessMessage('156')); 
		return false;
		}
		
		//�����Ա���֤����У��
		var sMEMBERCERTTYPE=getItemValue(0,0,"MEMBERCERTTYPE");
		var sMEMBERCERTID=getItemValue(0,0,"MEMBERCERTID");
		if(sMEMBERCERTTYPE=="0"&&(!CheckLicense(sMEMBERCERTID))){
			alert(getBusinessMessage('156')); 
			return false;
		}
		return true;
	}
	
	function goBack(){
		var sNode="<%=sNode%>";
		if(sNode=='UnDelete'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteFamilyManage/FamilyDeleteList.jsp","node=UnDelete","right");
		}else if(sNode=='Deleted'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteFamilyManage/FamilyDeleteList.jsp","node=Deleted","right");
		}else if(sNode=='Result'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteFamilyManage/FamilyDeleteList.jsp","node=Result","right");
		}
	}


	function initRow(){
		if (getRowCount(0)==0){//�統ǰ�޼�¼��������һ��
			setItemValue(0,0,"OccurDate","<%=DateX.format(new java.util.Date())%>");
			setItemValue(0,0,"SessionID","0000000000");
			setItemValue(0,0,"IncrementFlag","1");
			setItemValue(0,0,"RecordFlag","40");
		}
    }
	
	initRow();
	
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
