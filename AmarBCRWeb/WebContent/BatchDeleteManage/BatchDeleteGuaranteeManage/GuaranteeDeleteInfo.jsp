<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* ҳ��˵��: ʾ������ҳ�� */
	String PG_TITLE = "�����Ե���ҵ��ɾ����Ϣ����";

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
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_GUARANTEEDELETE");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(jboWhere.length()>0?jboWhere:"");
	
	doTemp.setVisible("*", false);
	doTemp.setRequired("FinanceCode,GBusinessNo,DeleteTypes,UpdateDate",true);
	doTemp.setVisible("FinanceCode,GBusinessNo,DeleteTypes,UpdateDate", true);	
	doTemp.setDefaultValue("UpdateDate", DateX.format(new java.util.Date()));
	doTemp.setEditStyle("UpdateDate", "Date");
	doTemp.setEditStyle("DeleteTypes", "Select");
	doTemp.setDDDWCodeTable("DeleteTypes", "1,����ҵ��ɾ��,2,�ڱ���������������Ϣɾ��,3,������Ϣɾ��,4,���ѽ�����Ϣɾ��");
	
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

	function saveRecord(sPostEvents){
		as_save("myiframe0",sPostEvents);
	}
	
	function saveAndGoBack(){
		saveRecord("goBack()");
	}
	
	function goBack(){
		var sNode="<%=sNode%>";
		if(sNode=='UnDelete'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=UnDelete","right");
		}else if(sNode=='Deleted'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=Deleted","right");
		}else {
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteGuaranteeManage/GuaranteeBatchDeleteList.jsp","node=Result","right");
		}		
	}

	function initRow(){
		if (getRowCount(0)==0){//�統ǰ�޼�¼��������һ��
			//setItemDisabled(0,0,"DeleteTypes",true);
			setItemValue(0,0,"UpdateDate","<%=DateX.format(new java.util.Date())%>");
			//setItemValue(0,0,"SessionID","0000000000");
			setItemValue(0,0,"SessionID","1111111111");
			setItemValue(0,0,"IncrementFlag","1");
			setItemValue(0,0,"Modflag","1");
			setItemValue(0,0,"RecordFlag","40");
		}
    }
	
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
