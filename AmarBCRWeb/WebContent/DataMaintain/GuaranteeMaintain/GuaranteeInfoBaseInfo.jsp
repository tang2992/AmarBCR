<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* ҳ��˵��: ʾ������ҳ�� */
	String PG_TITLE = "����ҵ�������Ϣ����";

	// ���ҳ�����
	String sGBusinessNo =  CurPage.getParameter("GBusinessNo");
	if(sGBusinessNo==null) sGBusinessNo="";
	String sKeyValue =  CurPage.getParameter("sKeyValue");
	if(sKeyValue==null||"".equals(sKeyValue)) sKeyValue=sGBusinessNo+"@";
	String sKeyName= CurPage.getParameter("sKeyName");
	if(sKeyName==null) sKeyName="";
	String sSessionID= CurPage.getParameter("sSessionID");
	if(sSessionID==null) sSessionID="";
	String sTable =  CurPage.getParameter("sTable");
	if(sTable==null) sTable="";
	String sFlag =  CurPage.getParameter("sFlag");
	if(sFlag==null) sFlag="";
	String sFlags =  CurPage.getParameter("sFlags");
	if(sFlags==null) sFlags="";
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String sIsQuery = CurComp.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//�����ڴ���ҳ���еı������ذ�ť������
	String sQueryType = CurComp.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";

	String sShow = "true";
	//ֻҪ��HIS��,�������ۺϲ�ѯ���õ�ҳ��,����ӵ�в鿴Ȩ�޶���ӵ��ά��Ȩ��,��ô�����ذ�ť
	if(sQueryType.equals("ERROR")){
		if(sFlag.equals("his")||sIsQuery.equals("true")||(CurUser.hasRole("0200")&&!CurUser.hasRole("0201"))){
		sShow = "false";
		}	
	}else{
		if(sFlag.equals("his")||sIsQuery.equals("true")||(CurUser.hasRole("0100")&&!CurUser.hasRole("0101"))){
			sShow = "false";
		}	
	}
	
	//��ʷ��from��������
	if(sFlag.equals("his"))
		sTable=sTable.replace("BCR_", "HIS_");
	
	ASObjectModel doTemp = null;
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr."+sTable.toUpperCase());
	doTemp = new ASObjectModel(boManager);
	//�������������Ҷ���
	for(DataElement de:boManager.getManagedClass().getAttributes()){
		if(de.getType()==DataElement.DOUBLE || de.getType()==DataElement.INT || de.getType()==DataElement.LONG){
			doTemp.setAlign(de.getName(), "3");
		}
	}

	//����where����
	String jBOWhere="";
	String args="";

	if(sKeyName.isEmpty()&&(!sFlag.equals("new"))){
		 jBOWhere="GBusinessNo=:GBusinessNo";
	     args=sGBusinessNo;
	}else{
		String[] nameArr=sKeyName.split("@");
		String[] valueArr=sKeyValue.split("@");
		for(int i=0; i<nameArr.length; i++){
			String k = nameArr[i];
			String v = valueArr[i];
			jBOWhere =jBOWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
		jBOWhere = jBOWhere.substring(4);
		args = args.substring(1);
	} 
	//��ʷ��from��������
	/* 	if(sFlag.equals("his")){			
			for(int i=0;i<sKeyName.split("@").length-1;i++)
			doTemp.WhereClause+=" and  "+sKeyName.split("@")[i]+"='"+sKeyValue.split("@")[i]+"' " +" and SESSIONID='"+sSessionID+"'" ;
		} */
    doTemp.setJboWhere(jBOWhere);
	doTemp.setReadOnly("GBusinessNo", true);
    
    doTemp.setVisible("ATTRIBUTE1,OldFinanceID,Modflag,Tracenumber,Recordflag,Sessionid,Errorcode", false);	
	doTemp.setRequired("GBusinessNo,OrgId,InsuredType,InsuredName,CertType,CertId,GatherDate,BusinessType,GuarantyType,GuarantySum,GStartDate,GEndDate,Rate", true);
	doTemp.setRequired("InsuredType,InsuredName,CertType,CertId,InsuredState,CreditorType,ContractFlag,CounterGType,CounterGName,CertType,CertId,CounterGSum,CounterGFlag", true);
	//���ڸ�ʽ
	doTemp.setRequired("GContractFlag,GContractBalance,BalanceChangeDate,BillingDate,RecoveryFlag,LastCDate,OwnCSum,OwnCBalance,RecoverySum,LossSum,CompensatorDate,CompensatorySum,RecoveryDate,RecoverySum", true);
	doTemp.setRequired("PayType,PremiumSum,PremiumMode,ChargingStartDate,PremiumState,PremiumBalance,UnpaidSum,PayableDate,PayableSum,PeriodPremiumState,CreditorName", true);
	
	doTemp.setEditStyle("GatherDate,UPDATEDATE,GStartDate,GEndDate,GContractEndDate,BalanceChangeDate,BillingDate,LastCDate,LastRecoveryDate,CompensatorDate,RecoveryDate,BillingDate,ChargingStartDate,ChargingEndDate,ChargingStartDate,ChargingEndDate,PayableDate,PaidDate,occurdate","Date");
	doTemp.setEditStyle("InsuredType,CertType,BusinessType,GuarantyType,CounterType,InsuredState,ContractFlag,CreditorType,CounterGType,CounterGFlag,GContractFlag,RecoveryFlag,PayType,PremiumMode,PremiumFrequency,PremiumState,PeriodPremiumState,IncrementFlag", "Select");
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
	doTemp.setDefaultValue("UpdateDate",DateX.format(new java.util.Date(), "yyyy/MM/dd")); 
	doTemp.setColCount(2);
   
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // ����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // �����Ƿ�ֻ�� 1:ֻ�� 0:��д
	if("false".equals(sShow))dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	else dwTemp.ReadOnly = "0";
	dwTemp.genHTMLObjectWindow(args);//�������,���ŷָ� 
	
	
	String sButtons[][] = {
		{sShow,"","Button","����","���������޸�","saveRecord()","","","",""},
		{((sFlags.equals("Info")&&!sFlag.equals("his"))||"syn".equals(sFlag))?"false":"true","","Button","����","�����б�ҳ��","goBack('"+sFlag+"')","","","",""},
		{(sFlags.equals("Info")&&!sFlag.equals("his"))?"true":"false","","Button","�鿴��ʷ��¼","�鿴��ʷ��¼","showHISContent('"+sTable+"','"+sKeyValue.split(",")[0]+"')","","","",""} 
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		if (!ValidityCheck()) return;
		as_save("myiframe0");
	}
	//���У����Ϣ
	function ValidityCheck(){
		var sTable="<%=sTable%>";
		if("INIT_GUARANTEEINFO"==sTable || "INIT_INSUREDS"==sTable || "INIT_CREDITORINFO"==sTable || "INIT_COUNTERGUARANTOR"==sTable){
			var sCertType = getItemValue(0,0,"CertType");
			var sCertId = getItemValue(0,0,"CertId");			
			if(sCertType=="a"){
				//��֯��������֤
				if(typeof(sCertId)!="undefined"&&sCertId!=""){
					if(!CheckORG(sCertId)){
						alert('��֯����������������!');
						return false;
					}
				}
			}else if(sCertType=="c"){
				//���
				if(typeof(sCertId)!="undefined"&&sCertId!=""){
					if(!CheckLoanCardID(sCertId)){
						alert('��������������!');
						return false;
					}
				}
			}else if(sCertType=="d"){
				//�������ô���
				if(CreditCodeCheck(sCertId)==false&&typeof(sCertId)!="undefined"&&sCertId!=""){
					alert("�������ô����ʽ����");
					return false;
				}
			}			
		}
		return true;
	}

	function goBack(sFlag){
		if(sFlag=="his"){
			OpenComp("GuaranteeInfoBaseList","/DataMaintain/GuaranteeMaintain/GuaranteeInfoBaseList.jsp","sTable=<%=sTable%>&sFlag=his&GBusinessNo=<%=sKeyValue.split("@")[0]%>&IsQuery=<%=sIsQuery%>","_self");
		}else{					
		 OpenComp("GuaranteeInfoBaseList","/DataMaintain/GuaranteeMaintain/GuaranteeInfoBaseList.jsp","sTable=<%=sTable%>&sFlag=Detail&GBusinessNo=<%=sKeyValue.split("@")[0]%>&IsQuery=<%=sIsQuery%>","_self");
		}
	}
	
	//��ʾ��ʷ��¼
	function showHISContent(sTable){
		AsControl.OpenView("/DataMaintain/GuaranteeMaintain/GuaranteeInfoBaseList.jsp","sFlag=his&sTable="+sTable+"&GBusinessNo=<%=sKeyValue.split("@")[0]%>","_blank","");
	}
	
	function initRow(){
		if (getRowCount(0)==0){//�統ǰ�޼�¼��������һ��
			setItemValue(0,getRow(),"GBusinessNo","<%=sGBusinessNo%>");
		}
    }
	
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
