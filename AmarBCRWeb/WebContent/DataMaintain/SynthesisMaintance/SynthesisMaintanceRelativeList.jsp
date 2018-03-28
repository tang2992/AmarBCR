<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "�ۺ���Ϣά���б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%

	//�������
	//��ȡ�������
	//��ҳ��������ҵ�����ʾ�Ĺ���ҳ��,���ڱ�ϵͳ���е�ҵ���б����ɱ�ҳ�����ɵ�
	//������Ҫ�������MetaTableName(xml����name),DBTableName(���ݿ���Ҫ���ҵ��ֶ�),KeyName(Ҫ���ҵı�ҵ��Ĺؼ���),KeyValue(Ҫ���ҵı�ҵ��Ĺؼ��ֵ�ֵ)
	//TableFlag��ʾ������ʾhis��,����ecr��
	//��������������������QueryType,Query,IsPatch(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
	String sTableName = CurComp.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurComp.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyNameMain = CurComp.getParameter("KeyName");
	if(sKeyNameMain == null) sKeyNameMain = "";
	String sKeyValueMain = CurComp.getParameter("KeyValue");
	if(sKeyValueMain == null) sKeyValueMain = "";
	

	//�Զ���������д�������������������ֵ�Ķ�Ӧ��ϵ
	String[] stName = sKeyNameMain.split("@");
	String[] stValue = sKeyValueMain.split("@");
	String jBOWhere = "";
	String args="";
	for(int j=0;j<stName.length;j++){
		//���ڷ�����һ����ͬ�����ݵ�������õĻ�����������
		if(stValue[j].indexOf("-")>0){
			String[] sValue = stValue[j].split("-");
			String sValueStr = "";
			for(int i=0;i<sValue.length;i++){
				if(sValueStr.equals(""))
					sValueStr = sValueStr + "'" + sValue[i] +"'";
				else
					sValueStr = sValueStr + ",'" + sValue[i] +"'";
			}
			jBOWhere +=  " and " + stName[j] + " in (" + sValueStr + ")";
		}else{
			jBOWhere += " and " +  stName[j] + " =:" + stName[j];	
			args += ","+stValue[j];
		}
	}
	
	jBOWhere = jBOWhere.substring(4);
	if(!args.isEmpty()) 
		args = args.substring(1);
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	String[] keyAttrs= boManager.getManagedClass().getKeyAttributes();
	String sKeyName="";
	for(String key: keyAttrs){
		sKeyName += key+"@";
	}
	//���ò�ѯ����where�Ӿ�
	doTemp.setJboWhere(jBOWhere);
	//������������order�Ӿ�
	doTemp.setJboOrder (" OCCURDATE desc");
	//����˫��������ҳ��
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:openBusinessInfo()\"");
	
	doTemp.setVisible("Modflag,Tracenumber,Recordflag,Oldfinanceid,Creditno,Sessionid,Errorcode,Bankflag,Currency,Availabbalance,Recycle,Classify4,Classify5,Factoringtype,Factoringstatus,Businessdate,Balancechangedate,Floorflag,Billtype,Acceptername,Aloancardno,Billsum", false);
	doTemp.setVisible("Payterm,Logoutdate,Balance,Depositscale,Balancereportdate,Guaranteetype,Balanceoccurdate,Acceppaydate,Assurescale,Creditlogoutdate,Creditlogoutcause,Floortype,Returnmode", false);
    
	//doTemp.setVisible("Lcontractno,Occurdate,incrementflag,customerid,loancardno,customername,financeid,Putoutamount,Startdate,Enddate,guarantyflag,availabstatus", true);
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("Lcontractno,Fcontractno,Factoringno,Billno,Creditletterno,Guaranteebillno,Acontractno,Acceptance,Floorfundno,Ccontractno", true);
    doTemp.setDDDWJbo("guarantyflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7523'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	doTemp.setDDDWJbo("Creditstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	doTemp.setDDDWJbo("Guaranteestatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7583'");
	doTemp.setDDDWJbo("Draftstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7591'");
	doTemp.setDDDWCodeTable("IncrementFlag", "1,����,2,ҵ����,4,ɾ��,6,�ֹ��ս�,8,��Ǩ��");//��Ϣ����״̬
	doTemp.setDDDWJbo("Availabstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7525'");
	
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(10);
	
	dwTemp.genHTMLObjectWindow(args);
		
	//������ʾ�������������·��,�Լ����ݵĲ���
	String sCompNameInfo = "SynthesisMaintanceRelativeInfo";
	String sCompPathInfo = "/DataMaintain/SynthesisMaintance/SynthesisMaintanceRelativeInfo.jsp";
	String sParamInfo = "sTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+sKeyName;
	
%>

	<%
	String sButtons[][] = {
			{sTableFlag.equals("ECR")?"true":"false","","Button","��������ɾ����","����ҵ���������ɾ����","batchDelete()","","","",""},
			{sTableFlag.equals("ECR")?"true":"false","","Button","ȫ����������ɾ����","ȫ����������ɾ����","batchDeleteAll()","","","",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script language=javascript>
    var sCurCodeNo=""; //��¼��ǰ��ѡ���еĴ����
		
	//---------------------���尴ť�¼�------------------------------------
	//˫����ѡ�еļ�¼
    function openBusinessInfo()
    {
    	var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName.split("@")[0]%>");
    	<%
    		for(int i=1;i<sKeyName.split("@").length;i++){
    	%>
    			sKeyValue = sKeyValue +  "@" + getItemValue(0,getRow(),"<%=sKeyName.split("@")[i]%>");
    	<%				
    		}
    	%>
    	popComp("<%=sCompNameInfo%>","<%=sCompPathInfo%>","<%=sParamInfo%>&KeyValue="+sKeyValue,""); 
    	reloadSelf();
    }	 
  
	/*~[Describe=;InputParam=��;OutPutParam=��;]~*/
	function batchDelete()
	{	
		var sContractNo = getItemValue(0,getRow(),"<%=sKeyName.split("@")[0]%>");
		if (typeof(sContractNo)=="undefined" || sContractNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		
		if(confirm("�Ƿ񽫸���ҵ���¼��������ɾ����?")){
			var sTableName = "<%=sTableName%>";
			var sOccurDate = getItemValue(0,getRow(),"OCCURDATE");
			var sLoanCardNo = getItemValue(0,getRow(),"LOANCARDNO");
			var sFinanceID = getItemValue(0,getRow(),"FINANCEID");
			var sBusinessType = "";
			
			if(sTableName=="ECR_LOANCONTRACT"){sBusinessType="01"}
			else if(sTableName=="ECR_FACTORING"){sBusinessType="02"}
			else if(sTableName=="ECR_DISCOUNT"){sBusinessType="03"}
			else if(sTableName=="ECR_FINAINFO"){sBusinessType="04"}
			else if(sTableName=="ECR_CREDITLETTER"){sBusinessType="05"}
			else if(sTableName=="ECR_GUARANTEEBILL"){sBusinessType="06"}
			else if(sTableName=="ECR_ACCEPTANCE"){sBusinessType="07"}
			else if(sTableName=="ECR_CUSTOMERCREDIT"){sBusinessType="08"}
			else if(sTableName=="ECR_FLOORFUND"){sBusinessType="09"}
			else if(sTableName=="ECR_INTERESTDUE"){sBusinessType="10"}
			
			var sReturn = PopPage("/SystemManage/InsertIntoHisBatchDelete.jsp?ContractNo="+sContractNo+"&OccurDate="+sOccurDate+"&LoanCardNo="+sLoanCardNo+"&FinanceID="+sFinanceID+"&BusinessType="+sBusinessType,"_self","");
			if(sReturn=="Success"){
				alert("��������ɾ����ɹ�!");
			}else if(sReturn=="Exist"){
				alert("������¼�Ѿ�������ɾ���������!");
			}else{
				alert("��������ɾ����ʧ��!");
			}
		}
	}
	
	/*~[Describe=;InputParam=��;OutPutParam=��;]~*/
	function batchDeleteAll()
	{	
		var count = getRowCount(0);//����
		if(count<1){
			alert("��ǰ���κμ�¼��");
			return ;
		}
		
		if(confirm("�Ƿ��б�������ҵ���¼��������ɾ����?")){
			var sTableName = "<%=sTableName%>";
			var sLoanCardNo = "<%=sKeyValueMain%>";
			var sBusinessType = "";
			
			if(sTableName=="ECR_LOANCONTRACT"){sBusinessType="01";}
			else if(sTableName=="ECR_FACTORING"){sBusinessType="02";}
			else if(sTableName=="ECR_DISCOUNT"){sBusinessType="03";}
			else if(sTableName=="ECR_FINAINFO"){sBusinessType="04";}
			else if(sTableName=="ECR_CREDITLETTER"){sBusinessType="05";}
			else if(sTableName=="ECR_GUARANTEEBILL"){sBusinessType="06";}
			else if(sTableName=="ECR_ACCEPTANCE"){sBusinessType="07";}
			else if(sTableName=="ECR_CUSTOMERCREDIT"){sBusinessType="08";}
			else if(sTableName=="ECR_FLOORFUND"){sBusinessType="09";}
			else if(sTableName=="ECR_INTERESTDUE"){sBusinessType="10";}
			
			var sReturn = AsControl.PopView("/SystemManage/InsertIntoHisBatchDeleteAll.jsp","LoanCardNo="+sLoanCardNo+"&BusinessType="+sBusinessType+"&TableName="+sTableName,"");
			if(sReturn=="Success"){
				alert("��������ɾ����ɹ�!");
			}else {
				alert("��������ɾ����ʧ��!");
			}
		}
	}
	
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
