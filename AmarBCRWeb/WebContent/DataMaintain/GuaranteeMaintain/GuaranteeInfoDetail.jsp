<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* 页面说明: 示例详情页面 */
	String PG_TITLE = "担保业务信息详情";

	//获得页面参数
	String sGBusinessNo =  CurPage.getParameter("GBusinessNo");
	if(sGBusinessNo==null) sGBusinessNo="";
	String sTableName =  CurPage.getParameter("TableName");
	if(sTableName==null) sTableName="";
	String sKeyValue =  CurPage.getParameter("KeyValue");
	if(sKeyValue==null||"".equals(sKeyValue)) sKeyValue=sGBusinessNo+"@";
	String sKeyName= CurPage.getParameter("KeyName");
	if(sKeyName==null) sKeyName="";
	String sFlag =  CurPage.getParameter("Flag");
	if(sFlag==null) sFlag="";
	ASObjectModel doTemp = null;
	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr."+sTableName.toUpperCase());
	doTemp = new ASObjectModel(boManager);

	//更改where条件
	String jBOWhere="";
	String args="";
	if(sFlag.equals("new")){
		System.out.print(sKeyName+"@"+sKeyValue);
		jBOWhere="1=1";
	}else{
		if(sGBusinessNo == ""){
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
		}else{
			jBOWhere="GBusinessNo=:GBusinessNo";
			args=sGBusinessNo;
		}		
	}
	doTemp.setJboWhere(jBOWhere);
	
	if(!sFlag.equals("new")){
		doTemp.setReadOnly("GBusinessNo", true);
	}
	doTemp.setReadOnly("Inputuser,Inputtime,Updateuser,Updatetime", true);
	doTemp.setVisible("ATTRIBUTE1,OldFinanceID,Incrementflag,Modflag,Tracenumber,Recordflag,Sessionid,Errorcode,Inputorg,Updateorg", false);	
	doTemp.setRequired("GBusinessNo,OrgId,InsuredType,InsuredName,CertType,CertId,GatherDate,BusinessType,GuarantyType,GuarantySum,GStartDate,GEndDate,Rate", true);
	doTemp.setRequired("InsuredType,InsuredName,CertType,CertId,InsuredState,CreditorType,ContractFlag,CounterGType,CounterGName,CertType,CertId,CounterGSum,CounterGFlag", true);
	doTemp.setRequired("GContractFlag,GContractBalance,BalanceChangeDate,BillingDate,RecoveryFlag,LastCDate,OwnCSum,OwnCBalance,RecoverySum,LossSum,CompensatorDate,CompensatorySum,RecoveryDate,RecoverySum", true);
	doTemp.setRequired("PayType,PremiumSum,PremiumMode,ChargingStartDate,PremiumState,PremiumBalance,UnpaidSum,PayableDate,PayableSum,PeriodPremiumState,CreditorName", true);
	doTemp.setDefaultValue("Inputtime,Updatetime", DateX.format(new java.util.Date()));
	doTemp.setEditStyle("GatherDate,UPDATEDATE,GStartDate,GEndDate,GContractEndDate,BalanceChangeDate,BillingDate,LastCDate,LastRecoveryDate,CompensatorDate,RecoveryDate,BillingDate,ChargingStartDate,ChargingEndDate,ChargingStartDate,ChargingEndDate,PayableDate,PaidDate","Date");
	doTemp.setEditStyle("InsuredType,CertType,BusinessType,GuarantyType,CounterType,InsuredState,ContractFlag,CreditorType,CounterGType,CounterGFlag,GContractFlag,RecoveryFlag,PayType,PremiumMode,PremiumFrequency,PremiumState,PeriodPremiumState", "Select");
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
	doTemp.setDefaultValue("UpdateDate",DateX.format(new java.util.Date(), "yyyy/MM/dd")); 
	
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // 设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // 设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(args);//传入参数,逗号分割 

	String sButtons[][] = {
			{"true","","Button","保存","保存所有修改","saveRecord()","","","",""},
			{"true","","Button","返回","返回列表页面","goBack()","","","",""} 
		};
	
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	
	function saveRecord(){
		if (!ValidityCheck()) return;
		setItemValue(0,0,"Updateorg","<%=CurOrg.getOrgID()%>");
		setItemValue(0,0,"Updateuser","<%=CurUser.getUserID()%>");
		setItemValue(0,0,"Updatetime","<%=DateX.format(new java.util.Date())%>");
		as_save("myiframe0"); 
	}
	
	function ValidityCheck(){
		var sTable="<%=sTableName%>";
		if("INIT_GUARANTEEINFO"==sTable || "INIT_INSUREDS"==sTable || "INIT_CREDITORINFO"==sTable || "INIT_COUNTERGUARANTOR"==sTable){
			var sCertType = getItemValue(0,0,"CertType");
			var sCertId = getItemValue(0,0,"CertId");			
			if(sCertType=="a"){
				//组织机构代码证
				if(typeof(sCertId)!="undefined"&&sCertId!=""){
					if(!CheckORG(sCertId)){
						alert('组织机构代码输入有误!');
						return false;
					}
				}
			}else if(sCertType=="c"){
				//贷款卡
				if(typeof(sCertId)!="undefined"&&sCertId!=""){
					if(!CheckLoanCardID(sCertId)){
						alert('贷款卡编号输入有误!');
						return false;
					}
				}
			}else if(sCertType=="d"){
				//机构信用代码
				if(CreditCodeCheck(sCertId)==false&&typeof(sCertId)!="undefined"&&sCertId!=""){
					alert("机构信用代码格式错误！");
					return false;
				}
			}			
		}
		return true;
	}
	
	function goBack(){
		var sTable="<%=sTableName%>";
		OpenComp("GuaranteeManageList","/DataMaintain/GuaranteeMaintain/GuaranteeManageList.jsp","TableName="+sTable,"right");
	}	
	
	function initRow(){
		if (getRowCount(0)==0){//如当前无记录，则新增一条
			setItemValue(0,0,"GBusinessNo","<%=sGBusinessNo%>");
			setItemValue(0,0,"Inputorg","<%=CurOrg.getOrgID()%>");
			setItemValue(0,0,"Inputuser","<%=CurUser.getUserID()%>");
			setItemValue(0,0,"Inputtime","<%=DateX.format(new java.util.Date())%>");
			setItemValue(0,0,"Updateorg","<%=CurOrg.getOrgID()%>");
			setItemValue(0,0,"Updateuser","<%=CurUser.getUserID()%>");
			setItemValue(0,0,"Updatetime","<%=DateX.format(new java.util.Date())%>");
		}
		
    }
	
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
