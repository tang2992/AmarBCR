<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	/*
		ҳ��˵��: ʾ���б�ҳ��
	 */
	String PG_TITLE = "����ҵ�������Ϣ";
	//���ҳ�����
	String sGBusinessNo =  CurPage.getParameter("GBusinessNo");
	if(sGBusinessNo==null) sGBusinessNo="";
	String sFlag =  CurPage.getParameter("sFlag");
	if(sFlag==null) sFlag="";
	String sTable =  CurPage.getParameter("sTable");
	if(sTable==null) sTable="";
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String IsQuery = CurComp.getParameter("IsQuery");
	if(IsQuery == null) IsQuery = "";

	   //��ʷ��from��������
	if(sFlag.equals("his")||sFlag.equals("Feedback")){		
		sTable=sTable.replace("BCR_", "HIS_");
	}
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr."+sTable.toUpperCase());
	//��ȡ�ñ�����еĹؼ���
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
		String sKeyName="";
	for(String key: keyAttrs){
		sKeyName += key+"@";
	}
		
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	 String jBOWhere="";
	jBOWhere="GBusinessNo=:GBusinessNo";
	doTemp.setJboWhere(jBOWhere);
	doTemp.setVisible("Rate,AnnualRate,RecoverySum,LossSum,ChargingStartDate,ChargingEndDate,Attribute1,UpdateDate,,OldFinanceID,Modflag,Tracenumber,Recordflag,Sessionid,Errorcode", false);
	if(sFlag.equals("Feedback")){
		doTemp.setVisible("Sessionid,Errorcode", true);
	}	
	doTemp.setDDDWJbo("InsuredType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='InsuredType'");
	doTemp.setDDDWJbo("CertType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CertType'");
	doTemp.setDDDWJbo("BusinessType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='BusinessType'");
	doTemp.setDDDWJbo("GuarantyType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='GuarantyType'");
	doTemp.setDDDWJbo("CounterType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CounterType'");
	doTemp.setDDDWJbo("InsuredState", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='InsuredState'");
	doTemp.setDDDWJbo("ContractFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='ContractFlag'");
	doTemp.setDDDWJbo("CreditorType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CreditorType'");
	doTemp.setDDDWJbo("CounterGType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CounterGType'");
	doTemp.setDDDWJbo("CounterGFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CounterGFlag'");
	doTemp.setDDDWJbo("GContractFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='GContractFlag'");
	doTemp.setDDDWJbo("RecoveryFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='RecoveryFlag'");
	doTemp.setDDDWJbo("PayType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PayType'");
	doTemp.setDDDWJbo("PremiumMode", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PremiumMode'");
	doTemp.setDDDWJbo("PremiumFrequency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PremiumFrequency'");
	doTemp.setDDDWJbo("PremiumState", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PremiumState'");
	doTemp.setDDDWJbo("PeriodPremiumState", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PeriodPremiumState'");
	doTemp.setDDDWJbo("IncrementFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='IncrementFlag'");
	//doTemp.setDDDWJbo("Way", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7535'");
	
	//��ѯ����
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("GBusinessNo,GContractNo,InsuredName,CertId,BusinessType,GuarantyType,CounterType,InsuredType,InsuredState,CreditorType,Way,ContractFlag,CounterGType,CounterGFlag,GContractFlag,RecoveryFlag,PayType,PremiumMode,PremiumFrequency,PremiumState,PeriodPremiumState,SESSIONID", true);

 	//˫���¼�
    doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
		
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(10);

	dwTemp.genHTMLObjectWindow(sGBusinessNo);

	String sButtons[][] = {
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{sFlag.equals("Detail")?"true":"false","","Button","�鿴��ʷ��¼","�鿴��ʷ��¼","showHISContent('"+sTable+"','"+sGBusinessNo+"')","","","",""},
		{sFlag.equals("his")?"true":"false","","Button","����","����","goBack()","","","",""},
		{sFlag.equals("Feedback")?"true":"false","","Button","�����ϱ�","�����ϱ�","report(2)","","","",""},
		{sFlag.equals("Feedback")?"true":"false","","Button","�ݲ��ϱ�","�ݲ��ϱ�","report(3)","","","",""},
		{sFlag.equals("Feedback")?"true":"false","","Button","©������","��������©���ļ�¼","report(4)","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

	function goBack(){
		top.close();
	}
		
	function viewAndEdit(){
		var sFlag="<%=sFlag%>";
		var sGBusinessNo = getItemValue(0,getRow(),"GBusinessNo");
		var sSessionID = getItemValue(0,getRow(),"SESSIONID");
		if (typeof(sGBusinessNo)=="undefined" || sGBusinessNo.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		var sKeyValue="";
		var sKeyName="<%=sKeyName%>";
		var sTable="<%=sTable%>";
		for(var i=0;i<sKeyName.split("@").length-1;i++){ 
			sKeyValue+= getItemValue(0,getRow(),sKeyName.split("@")[i])+"@";
		}
		AsControl.OpenView("/DataMaintain/GuaranteeMaintain/GuaranteeInfoBaseInfo.jsp","sSessionID="+sSessionID+"&sKeyName="+sKeyName+"&sKeyValue="+sKeyValue+"&sTable="+sTable+"&IsQuery=<%=IsQuery%>&sFlag="+sFlag,"_self","");
	}
	//��ʾ��ʷ��¼
	function showHISContent(sTable,sGBusinessNo){
		AsControl.OpenView("/DataMaintain/GuaranteeMaintain/GuaranteeInfoBaseList.jsp","sFlag=his&sTable="+sTable+"&sGBusinessNo="+sGBusinessNo,"_blank","");
	}
	function report(action){
		var sTableName = "<%=sTable%>";
		var sTraceNumber = getItemValue(0,getRow(),"TRACENUMBER");
		var sSessionID = getItemValue(0,getRow(),"SESSIONID");
		var sGBusinessNo = getItemValue(0,getRow(),"GBusinessNo");
		var sWhere;
		var sReturn;
		
		if(typeof(sSessionID)=="undefined"||sSessionID==''){
			alert("����ѡ��һ����¼!");
			return;		
		}
		//�����Ѿ��ϱ�����ҵ���ܲ��������ݲ���
		if(typeof(sSessionID) != "undefined" && sSessionID!="9999999999" && sSessionID!="1111111111" && sSessionID!="0000000000" && sSessionID!="6666666666" &&(action=="2"||action=="3"))
		{
			if(confirm("�ñ�ҵ���Ѿ��ϱ�����,�Ƿ�ӷ����������ɾ��������¼?")){
				PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TraceNumber="+sTraceNumber,"_self","");
				alert("������¼�Ѵӷ����������ɾ��!");
				return;
			}
		}
		//û����Ϣ���ٱ��,���������ϱ�
		if((typeof(sTraceNumber) == "undefined" || sTraceNumber.length == 0)&&action=="2")
		{
			alert("��Ϣ���ٱ�Ų�����,�޷������ر�!");
			return;
		}
		if(action=="2"){
			if(confirm("ȷ�������ϱ�?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("�����ر���־�ɹ�!");
				}else{
					alert("�����ر���־ʧ��!");
				}
			}
		}else if(action=="3"){
			if(confirm("ȷ���ݲ��ϱ�?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("�����ݲ��ϱ���־�ɹ�!");
				}else{
					alert("�����ݲ��ϱ���־ʧ��!");
				}
			}
		}else if(action=="4"){
			if(confirm("ȷ����������?")){
			 	var sKeyName="<%=sKeyName%>".split("@");
			var sWhere = " where 1=1 and   "+sKeyName[0]+"='" + getItemValue(0,getRow(), sKeyName[0]) + "'";
	   
	     	
	    		for(var  i=1;i<sKeyName.length;i++){

	    			sKeyValue =  getItemValue(0,getRow(),sKeyName[i]);
	    			if("CIFCUSTOMERID"=="RETURNTIMES")
	    				sWhere = sWhere + " and  "+sKeyName[i]+" ='" + sKeyValue+"'";
	    			else
	    				sWhere = sWhere + " and  "+sKeyName[i]+"='" + sKeyValue + "'";
			 		}
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("���ò�����־�ɹ�!");
				}else{
					alert("���ò�����־ʧ��!");
				}
			}
		}
		reloadSelf();
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
