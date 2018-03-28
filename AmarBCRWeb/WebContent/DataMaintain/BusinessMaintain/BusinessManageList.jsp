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
	String PG_TITLE = "ҵ����Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);

	String jBOWhere="1=1";
	if(!CurUser.getUserID().equals("system"))
		jBOWhere=" O.FINANCEID IN (select OI.ORGID from jbo.ecr.ORG_TASK_INFO OI where OI.ORGCODE='"+CurUser.getRelativeOrgID()+"')";
    doTemp.setJboWhere(jBOWhere);
   
	doTemp.setVisible("Modflag,Tracenumber,Errorcode,Recordflag,Oldfinanceid,Creditno,Sessionid,Bankflag,Recycle,Guarantyflag,Currency,Availabbalance", false);
	doTemp.setVisible("Classify4,Classify5,Factoringtype,Factoringstatus,Businessdate,Balancechangedate,Floorflag", false);
	doTemp.setVisible("Billtype,Acceptername,Aloancardno,Billsum", false);
	doTemp.setVisible("Payterm,Depositscale,Logoutdate,Balance,Balancereportdate", false);
	doTemp.setVisible("Guaranteetype,Balanceoccurdate", false);
	doTemp.setVisible("Acceppaydate,Assurescale", false);
	doTemp.setVisible("Creditlogoutdate,Creditlogoutcause", false);
	doTemp.setVisible("Businessno,Returnmode", false);
	doTemp.setVisible("Businesstype,Assurecurrency,Assureform,Certtype,Certid", false);
	doTemp.setVisible("Evaluatecurrency,Evaluatesum,Evaluatedate,Evaluateoffice,Evaluateofficeid,Guarantytype,Guarantycurrency,Registorgname,Registdate,Guarantyexplain", false);
	doTemp.setVisible("Valuecurrency,Valuesum,Impawntype,Impawncurrency", false);
	doTemp.setVisible("Balance,Disposedate,Disposetype,Recoveryamount", false);
	
	//��ѯ����
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("Lcontractno,Factoringno,Billno,Fcontractno,Creditletterno,Guaranteebillno,Acontractno,Ccontractno,Floorfundno,Contractno,Assurecontno,Aloancardno,Guarantycontno,Guarantyserialno,Loancardno,CustomerID,Customername,Financeid", true);
	
	doTemp.setDDDWCodeTable("INCREMENTFLAG", "1,����,2,ҵ����,4,ɾ��,6,�ֹ��ս�,8,��Ǩ��");//��Ϣ����״̬
	doTemp.setDDDWJbo("Availabstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7525'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	doTemp.setDDDWJbo("Creditstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	doTemp.setDDDWJbo("Guaranteestatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7583'");
	doTemp.setDDDWJbo("Draftstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7591'");
	doTemp.setDDDWJbo("Floortype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7625'");
	doTemp.setDDDWJbo("Interesttype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7631'");
	doTemp.setDDDWCodeTable("Reporttype", "1,������ϱ�,2,��Ȼ��֤���ϱ�");
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
    dwTemp.MultiSelect = true; //�����ѡ
	
	dwTemp.genHTMLObjectWindow("");
	
	//��ʾ��������·��
	String sCompName = "BusinessInfoDetail";
	String sCompPath = "/DataMaintain/BusinessMaintain/BusinessInfoDetail.jsp";
%>

	<%
	    boolean show1=false, show2=false;
		if("ECR_LOANCONTRACT".equalsIgnoreCase(sTableName)
				||"ECR_FACTORING".equalsIgnoreCase(sTableName)
				||"ECR_FINAINFO".equalsIgnoreCase(sTableName)
				||"ECR_CREDITLETTER".equalsIgnoreCase(sTableName)
				||"ECR_GUARANTEEBILL".equalsIgnoreCase(sTableName)
				||"ECR_ACCEPTANCE".equalsIgnoreCase(sTableName)){
			show1=true;
		}
		if("ECR_ASSURECONT".equalsIgnoreCase(sTableName)
				||"ECR_GUARANTYCONT".equalsIgnoreCase(sTableName)
				||"ECR_IMPAWNCONT".equalsIgnoreCase(sTableName)){
			show2=true;
		}
	String sButtons[][] = {
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","��������ɾ����","����ҵ���������ɾ����","batchDelete()","","","",""},
		{(show1)&&(!sIsQuery.equals("true"))?"true":"false","","Button","��ҵ�񵣱����","������ҵ�񵣱����","removeContract()","","","",""},
		{(show1)&&(!sIsQuery.equals("true"))?"true":"false","","Button","������ҵ�񵣱����","������ҵ��ȡ���������","unRemoveContract()","","","",""},
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">

/* 	---------------------���尴ť�¼�------------------------------------ */
	/*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/
	

	function viewAndEdit()
	{
		var sTableName = "<%=sTableName%>";
		var sKeyValue="";
		var sKeyName= "<%=sKeyName%>";
		//����������,��ȡ��Ӧ�ļ�ֵ
		for(var i=0;i<sKeyName.split("@").length-1;i++){
			sKeyValue+= getItemValue(0,getRow(),sKeyName.split("@")[i])+"@";
		}
		
		var value = getItemValue(0,getRow(),sKeyName.split("@")[0]);
		
    	if(typeof(value)=="undefined" || value.length==0) {
			alert("��ѡ��һ����Ϣ��");//��ѡ��һ����Ϣ��
            return ;
		}
    	
		 if(sTableName == "ECR_ASSURECONT"||sTableName == "ECR_GUARANTYCONT"||sTableName == "ECR_IMPAWNCONT"){
			var sContractNo = getItemValue(0,getRow(),"CONTRACTNO");
			var sBusinessType = getItemValue(0,getRow(),"BUSINESSTYPE");
			var sKeyNameMain;

			switch (sBusinessType){
			case "1":
				sTableName = "ECR_LOANCONTRACT";
				sKeyNameMain = "LContractNo";
				break;
			case "2":
				sTableName = "ECR_FACTORING";
				sKeyNameMain = "FactoringNo";
				break;
			case "3":
				sTableName = "ECR_DISCOUNT";
				sKeyNameMain = "BillNo";
				break;
			case "4":
				sTableName = "ECR_FINAINFO";
				sKeyNameMain = "FContractNo";
				break;
			case "5":
				sTableName = "ECR_CREDITLETTER";
				sKeyNameMain = "CreditLetterNo";
				break;
			case "6":
				sTableName = "ECR_GUARANTEEBILL";
				sKeyNameMain = "GuaranteeBillNo";
				break;
			case "7":
				sTableName = "ECR_ACCEPTANCE";
				sKeyNameMain = "AcceptNo";
				break;
			default:
				break;
			} 
			popComp("<%=sCompName%>","<%=sCompPath%>","sTableName="+sTableName+"&KeyName1=<%=sKeyName%>&KeyValue1="+sKeyValue+"&KeyName="+sKeyNameMain+"&KeyValue="+sContractNo+"&sIsQuery=<%=sIsQuery%>","");
		}else{
			popComp("<%=sCompName%>","<%=sCompPath%>","&sIsQuery=<%=sIsQuery%>&sTableName=<%=sTableName%>&KeyName=<%=sKeyName%>&KeyValue="+sKeyValue,"");
		}	
		reloadSelf();
	}

	function batchDelete()
	{	
		var rows = getCheckedRows(0);
		var sTableName = "<%=sTableName%>";
		
		if (rows==null || rows.length==0)
		{
			alert("��û�й�ѡ�κ��У�");
			return;
		}
		
		for(var i=0;i<rows.length;i++){
			var sContractNo = getItemValue(0,rows[i],"<%=sKeyName.split("@")[0]%>");
			var sOccurDate = getItemValue(0,rows[i],"OCCURDATE");
			var sLoanCardNo = getItemValue(0,rows[i],"LOANCARDNO");
			var sFinanceID = getItemValue(0,rows[i],"FINANCEID");
			var sBusinessType = "";
			var sKeyNameMain;
			var sReturn;
	
			if(sTableName == "ECR_ASSETSDISPOSE")
			{
				alert("ɾ�������ݲ�֧�ֲ����Ŵ��ʲ�������Ϣ��");
				return;
			}
	
			if(sTableName == "ECR_ASSURECONT"||sTableName == "ECR_GUARANTYCONT"||sTableName == "ECR_IMPAWNCONT"){
				sContractNo = getItemValue(0,rows[i],"CONTRACTNO");
				sOccurDate = getItemValue(0,rows[i],"OCCURDATE");
				sBusinessType = "0"+ getItemValue(0,rows[i],"BUSINESSTYPE");
	
				switch (sBusinessType) {
					case "01":
						sTableName = "ECR_LOANCONTRACT";
						sKeyNameMain = "LContractNo";
						break;
					case "02":
						sTableName = "ECR_FACTORING";
						sKeyNameMain = "FactoringNo";
						break;
					case "03":
						sTableName = "ECR_DISCOUNT";
						sKeyNameMain = "BillNo";
						break;
					case "04":
						sTableName = "ECR_FINAINFO";
						sKeyNameMain = "FContractNo";
						break;
					case "05":
						sTableName = "ECR_CREDITLETTER";
						sKeyNameMain = "CreditLetterNo";
						break;
					case "06":
						sTableName = "ECR_GUARANTEEBILL";
						sKeyNameMain = "GuaranteebillNo";
						break;
					case "07":
						sTableName = "ECR_ACCEPTANCE";
						sKeyNameMain = "AcceptNo";
						break;
					case "08":
						sTableName = "ECR_CUSTOMERCREDIT";
						sKeyNameMain = "CContractNo";
						break;
					default:
						break;
				}
				sReturn = PopPage("/Common/ToolsB/GetMainbusinessInfo.jsp?TableName="+sTableName+"&KeyNameMain="+sKeyNameMain+"&KeyValueMain="+sContractNo,"_self","");
				sReturns = sReturn.split("!");
				sLoanCardNo = sReturns[0];
				sFinanceID = sReturns[1];
			} else {
				if(sTableName=="ECR_LOANCONTRACT"){sBusinessType="01";}
				else if(sTableName=="ECR_FACTORING"){sBusinessType="02";}
				else if(sTableName=="ECR_DISCOUNT"){sBusinessType="03";}
				else if(sTableName=="ECR_FINAINFO"){sBusinessType="04";}
				else if(sTableName=="ECR_CREDITLETTER"){sBusinessType="05";}
				else if(sTableName=="ECR_GUARANTEEBILL"){sBusinessType="06";}
				else if(sTableName=="ECR_ACCEPTANCE"){sBusinessType="07";}
				else if(sTableName=="ECR_CUSTOMERCREDIT"){sBusinessType="08";}
				else if(sTableName=="ECR_FLOORFUND"){sBusinessType="09";}
				else if(sTableName=="ECR_INTERESTDUE"){
					sBusinessType="10";
					//ǷϢ����ɾ����¼��ͬ��������
					sContractNo = getItemValue(0,rows[i],"LOANCARDNO");
				}			
			}
			RunJspAjax("/SystemManage/InsertIntoHisBatchDelete.jsp?ContractNo="+sContractNo+"&OccurDate="+sOccurDate+"&LoanCardNo="+sLoanCardNo+"&FinanceID="+sFinanceID+"&BusinessType="+sBusinessType, "", "");
		}
		alert("��������ɾ����ɹ�!");
		reloadSelf();
	}

	//��ҵ�񵣱����
	function removeContract(){
		//��ͬ���
		var rows = getCheckedRows(0);
		var sTableName = "<%=sTableName%>";
		if (rows==null || rows.length==0)
		{
			alert("��û�й�ѡ�κ��У�");
			return;
		}
		for(var i=0;i<rows.length;i++){
		var sKeyValue = getItemValue(0,rows[i],"<%=sKeyName.split("@")[0]%>");
		var sOccurDate = getItemValue(0,rows[i],"OCCURDATE");
		var sReturn;
		var sKeyNameMain;
		if(sTableName =="ECR_LOANCONTRACT") sKeyNameMain = "LContractNo";
		if(sTableName =="ECR_FACTORING") sKeyNameMain = "FactoringNo";
		if(sTableName =="ECR_DISCOUNT") sKeyNameMain = "BillNo";
		if(sTableName =="ECR_FINAINFO") sKeyNameMain = "FContractNo";
		if(sTableName =="ECR_CREDITLETTER") sKeyNameMain = "CreditLetterNo";
		if(sTableName =="ECR_GUARANTEEBILL") sKeyNameMain = "GuaranteeBillNo";
		if(sTableName =="ECR_ACCEPTANCE") sKeyNameMain = "AcceptNo";
		
		if(confirm("��ȷ�ϸ�ҵ���Ӧ�����е���������Դϵͳ��ʧЧ��")) { 
			sReturn = PopPage("/SystemManage/RemoveContract.jsp?TableName="+sTableName+"&OccurDate="+sOccurDate+"&KeyName="+sKeyNameMain+"&ContractNo="+sKeyValue+"&KeyValue="+sKeyValue,"_self","");
			if(sReturn == "Failture"){
				alert("ҵ��ţ�"+sKeyValue+"��ҵ��������ҵ�������������ظ������");
				return;
			}else if(sReturn == "Return"){
				alert("ҵ��ţ�"+sKeyValue+"��ҵ������ʷ���д��ڴ��ϱ���¼���������ɱ��ģ�");
				return;
			}else if(sReturn == "Success"){  
				alert("ҵ��ţ�"+sKeyValue+"�����б������ɵ�Ԫ��");
				
			}else{
				alert("ִ����ҵ�񵣱����ʧ�ܣ���鿴��־��");
				return;
			}
			reloadSelf();
		}else{
			return;
		}
		}
	}

	//����������ͬ���
	function unRemoveContract(){
		//��ͬ���
		var rows = getCheckedRows(0);
		var sTableName = "<%=sTableName%>";
		if (rows==null || rows.length==0)
		{
			alert("��û�й�ѡ�κ��У�");
			return;
		}
		for(var i=0;i<rows.length;i++){
		var sKeyValue = getItemValue(0,rows[i],"<%=sKeyName.split("@")[0]%>");
		var sOccurDate = getItemValue(0,rows[i],"OCCURDATE");
		var sReturn;
		var sKeyNameMain ="<%=sKeyName.split("@")[0]%>"; 
	
    	if(sTableName =="ECR_LOANCONTRACT") sKeyNameMain = "LContractNo";
		if(sTableName =="ECR_FACTORING") sKeyNameMain = "FactoringNo";
		if(sTableName =="ECR_DISCOUNT") sKeyNameMain = "BillNo";
		if(sTableName =="ECR_FINAINFO") sKeyNameMain = "FContractNo";
		if(sTableName =="ECR_CREDITLETTER") sKeyNameMain = "CreditLetterNo";
		if(sTableName =="ECR_GUARANTEEBILL") sKeyNameMain = "GuaranteeBillNo";
		if(sTableName =="ECR_ACCEPTANCE") sKeyNameMain = "AcceptNo";
    	if(confirm("�Ƿ�ִ�г���������ͬ�����")) { 
			sReturn = PopPage("/SystemManage/UnRemoveContract.jsp?TableName="+sTableName+"&OccurDate="+sOccurDate+"&DBKeyName="+sKeyNameMain+"&DBKeyValue="+sKeyValue,"_self","");
			if(sReturn == "Failture1"){
				alert("��ҵ��"+sOccurDate+"ʱ��δִ�й�ҵ����������������");
				return;
			}else if(sReturn == "Failture2"){
				alert("��ҵ���Ѿ�����ҵ�������������ظ�������");
				return;
			}else if(sReturn == "Return"){
				alert("��ҵ���Ѿ����ɱ��ģ�����ִ�г���������");
				return;
			}else if(sReturn == "Success") {
			    alert("��ҵ�񵣱���ͬ�����ɹ���");
				
			}else{
				alert("ִ�г���������ͬ�������ʧ�ܣ���鿴��־��");
				return;
			}
			reloadSelf();
		}else{
			return;
		}
		}
	}

	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>