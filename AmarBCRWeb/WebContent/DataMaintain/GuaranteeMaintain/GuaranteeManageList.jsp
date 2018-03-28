<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%
	//�������
	//��ȡ�������
	String sTableName = CurComp.getParameter("TableName");
	if(sTableName == null) sTableName = "";
	String sIsQuery = CurComp.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
%>

	<%
	String PG_TITLE = "����ҵ����Ϣ�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	doTemp.setVisible("Rate,AnnualRate,RecoverySum,LossSum,ChargingStartDate,ChargingEndDate,Attribute1,UpdateDate,Inputorg,Inputuser,Inputtime,Updateorg,Updateuser,Updatetime", false);

	String jBOWhere="1=1";
    doTemp.setJboWhere(jBOWhere);
	
	//��ѯ����
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("GBusinessNo,GContractNo,InsuredName,CertId,BusinessType,GuarantyType,CounterType,InsuredType,InsuredState,CreditorType,Way,ContractFlag,CounterGType,CounterGFlag,GContractFlag,RecoveryFlag,PayType,PremiumMode,PremiumFrequency,PremiumState,PeriodPremiumState", true);
	
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
	//doTemp.setDDDWJbo("Way", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7535'");
	
	//˫���¼�
    doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	//��ȡ��ҵ���������Ϣ
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
	String sKeyName="";
	for(String key: keyAttrs){
		sKeyName += key+"@";
	}
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);//��ҳ��ʾ
    dwTemp.MultiSelect = false; //�����ѡ
	
	dwTemp.genHTMLObjectWindow("");
	
	//��ʾ��������·��
	String sCompName = "GuaranteeInfoDetail";
	String sCompPath = "/DataMaintain/GuaranteeMaintain/GuaranteeInfoDetail.jsp";
%>

	<%
	String sButtons[][] = {
		{"true","","Button","����","��������","add()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">

/* 	---------------------���尴ť�¼�------------------------------------ */
	/*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/
	
	function add()
	{
		var sTableName = "<%=sTableName%>";
		var sFlag ="new";
		var sGBusinessNo ="";
		OpenComp("<%=sCompName%>","<%=sCompPath%>","&Flag="+sFlag+"&TableName=<%=sTableName%>&GBusinessNo="+sGBusinessNo+"","right");	
	}

	function viewAndEdit()
	{
		var sTableName = "<%=sTableName%>";
		var sKeyValue="";
		var sKeyName= "<%=sKeyName%>";
		var sFlag ="info";
		var sGBusinessNo ="";
		//����������,��ȡ��Ӧ�ļ�ֵ
		for(var i=0;i<sKeyName.split("@").length-1;i++){
			sKeyValue+= getItemValue(0,getRow(),sKeyName.split("@")[i])+"@";
		}		
		var value = getItemValue(0,getRow(),sKeyName.split("@")[0]);		
    	if(typeof(value)=="undefined" || value.length==0) {
			alert("��ѡ��һ����Ϣ��");//��ѡ��һ����Ϣ��
            return ;
		}
    	
    	if(sTableName == "INIT_GUARANTEEINFO"||sTableName == "INIT_GUARANTEECONT"||sTableName == "INIT_GUARANTEEDUTY"||sTableName == "INIT_COMPENSATORYINFO"||sTableName == "INIT_PREMIUMINFO"){
    		sGBusinessNo = getItemValue(0,getRow(),"GBusinessNo");
    		OpenComp("<%=sCompName%>","<%=sCompPath%>","&Flag="+sFlag+"&TableName=<%=sTableName%>&GBusinessNo="+sGBusinessNo+"","right");
    	}else{
    		OpenComp("<%=sCompName%>","<%=sCompPath%>","&Flag="+sFlag+"&TableName=<%=sTableName%>&KeyName="+sKeyName+"&KeyValue="+sKeyValue+"","right");
    	}
    	
		reloadSelf(); 
		
	}	

	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>