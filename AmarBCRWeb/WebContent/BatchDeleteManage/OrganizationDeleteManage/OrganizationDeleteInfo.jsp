<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* ҳ��˵��: ʾ������ҳ�� */
	String PG_TITLE = "����ɾ����Ϣ����";

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
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.HIS_BATCHDELETEORGAN");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(jboWhere.length()>0?jboWhere:"");
	
	doTemp.setVisible("*", false);
	doTemp.setRequired("Cifcustomerid,Segmenttype,Updatedate,FinanceId",true);
	doTemp.setVisible("Cifcustomerid,Segmenttype,Updatedate,FinanceId", true);
	
	doTemp.setDDDWCodeTable("SEGMENTTYPE", "B,ȫ��,C,�������Զ�,D,����״̬��,E,������Ϣ��,F,�߹ܼ���Ҫ��ϵ�˶�,G,��Ҫ�ɶ���,H,��Ҫ������ҵ��,I,���ܵ�λ��");
	doTemp.setDDDWCodeTable("MANAGERTYPE", "0,ʵ�ʿ�����,1,���³�,2,�ܾ���/��Ҫ������,3,��������,4,���³� ,5,����������");
	doTemp.setHTMLStyle("SEGMENTTYPE", "onChange=\"parent.getRelative()\"");
	doTemp.setDefaultValue("OCCURDATE", DateX.format(new java.util.Date()));
	doTemp.setEditStyle("Updatedate", "Date");
	doTemp.setEditStyle("SEGMENTTYPE", "Select");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
   	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	if("UnDelete".equals(sNode))dwTemp.ReadOnly = "0"; // �����Ƿ�ֻ�� 1:ֻ�� 0:��д
	else dwTemp.ReadOnly = "1";
   	
	dwTemp.genHTMLObjectWindow(args.length()>0?args:"%");

	String sButtons[][] = {
		{sNode.equals("UnDelete")?"true":"false","","Button","����","���������޸�","saveRecord()","","","",""},
		{sNode.equals("UnDelete")?"true":"false","","Button","���沢����","���沢�����б�","saveAndGoBack()","","","",""},
		{"true","","Button","����","�����б�ҳ��","goBack()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	 function getRelative(){
		var type=getItemValue(0,0,"SEGMENTTYPE");
		
		if(type=="F"){
			 setItemDisabled(0,0,"MANAGERTYPE",false);
		}else{
			setItemValue(0,0,"MANAGERTYPE","");
			setItemDisabled(0,0,"MANAGERTYPE",true);
		}
	
	 }

	function saveRecord(sPostEvents){
		if(!beforeSave()){
			return false;
		}
		as_save("myiframe0",sPostEvents);
	}
	
	function beforeSave(){
		var sUpdateDate=getItemValue(0,0,"UPDATEDATE");
		var sSEGMENTTYPE=getItemValue(0,0,"SEGMENTTYPE");
		if(sUpdateDate=='2012/01/01'&&sSEGMENTTYPE!='B'){
			alert("ɾ���ö�ʱ��2012/01/01���ǺϷ��ĸ�������!");
			return false;
		}		
		return true;
	}
	
	function saveAndGoBack(){
		saveRecord("goBack()");
	}
	
	function goBack(){
		var sNode="<%=sNode%>";
		if(sNode=='UnDelete'){
			AsControl.OpenView("/BatchDeleteManage/OrganizationDeleteManage/OrganBatchDeleteList.jsp","node=UnDelete","right");
		}else if(sNode=='Deleted'){
			AsControl.OpenView("/BatchDeleteManage/OrganizationDeleteManage/OrganBatchDeleteList.jsp","node=Deleted","right");
		}else {
			AsControl.OpenView("/BatchDeleteManage/OrganizationDeleteManage/OrganBatchDeleteList.jsp","node=Result","right");
		}		
	}

	function initRow(){
		if (getRowCount(0)==0){//�統ǰ�޼�¼��������һ��
			setItemDisabled(0,0,"MANAGERTYPE",true);
			setItemValue(0,0,"OccurDate","<%=DateX.format(new java.util.Date())%>");
			setItemValue(0,0,"SessionID","0000000000");
			setItemValue(0,0,"IncrementFlag","1");
			setItemValue(0,0,"RecordFlag","40");
		}else{
			var type=getItemValue(0,0,"SEGMENTTYPE");			
			if(type=="F"){
				 setItemDisabled(0,0,"MANAGERTYPE",false);
			}else{
				setItemValue(0,0,"MANAGERTYPE","");
				 setItemDisabled(0,0,"MANAGERTYPE",true);
			}
		}
    }
	
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
