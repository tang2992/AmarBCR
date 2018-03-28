<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%
	//定义变量
	//获取组件参数
	String sTableName = CurComp.getParameter("TableName");
	if(sTableName == null) sTableName = "";
	String sIsQuery = CurComp.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
%>

	<%
	String PG_TITLE = "业务信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
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
	
	//查询条件
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("Lcontractno,Factoringno,Billno,Fcontractno,Creditletterno,Guaranteebillno,Acontractno,Ccontractno,Floorfundno,Contractno,Assurecontno,Aloancardno,Guarantycontno,Guarantyserialno,Loancardno,CustomerID,Customername,Financeid", true);
	
	doTemp.setDDDWCodeTable("INCREMENTFLAG", "1,新增,2,业务变更,4,删除,6,手工终结,8,已迁移");//信息操作状态
	doTemp.setDDDWJbo("Availabstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7525'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	doTemp.setDDDWJbo("Creditstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	doTemp.setDDDWJbo("Guaranteestatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7583'");
	doTemp.setDDDWJbo("Draftstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7591'");
	doTemp.setDDDWJbo("Floortype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7625'");
	doTemp.setDDDWJbo("Interesttype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7631'");
	doTemp.setDDDWCodeTable("Reporttype", "1,贷款卡号上报,2,自然人证件上报");
	//双击事件
    doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	//获取该业务的主键信息
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
	String sKeyName="";
	for(String key: keyAttrs){
		sKeyName += key+"@";
	}
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);//分页显示
    dwTemp.MultiSelect = true; //允许多选
	
	dwTemp.genHTMLObjectWindow("");
	
	//显示组件和组件路径
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
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","","Button","插入批量删除表","将该业务插入批量删除表","batchDelete()","","","",""},
		{(show1)&&(!sIsQuery.equals("true"))?"true":"false","","Button","主业务担保解除","将该主业务担保解除","removeContract()","","","",""},
		{(show1)&&(!sIsQuery.equals("true"))?"true":"false","","Button","撤销主业务担保解除","将该主业务取消担保解除","unRemoveContract()","","","",""},
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">

/* 	---------------------定义按钮事件------------------------------------ */
	/*~[Describe=新增记录;InputParam=无;OutPutParam=无;]~*/
	

	function viewAndEdit()
	{
		var sTableName = "<%=sTableName%>";
		var sKeyValue="";
		var sKeyName= "<%=sKeyName%>";
		//根据主键名,获取相应的键值
		for(var i=0;i<sKeyName.split("@").length-1;i++){
			sKeyValue+= getItemValue(0,getRow(),sKeyName.split("@")[i])+"@";
		}
		
		var value = getItemValue(0,getRow(),sKeyName.split("@")[0]);
		
    	if(typeof(value)=="undefined" || value.length==0) {
			alert("请选择一条信息！");//请选择一条信息！
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
			alert("您没有勾选任何行！");
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
				alert("删除报文暂不支持不良信贷资产处置信息！");
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
					//欠息批量删除记录合同号填贷款卡号
					sContractNo = getItemValue(0,rows[i],"LOANCARDNO");
				}			
			}
			RunJspAjax("/SystemManage/InsertIntoHisBatchDelete.jsp?ContractNo="+sContractNo+"&OccurDate="+sOccurDate+"&LoanCardNo="+sLoanCardNo+"&FinanceID="+sFinanceID+"&BusinessType="+sBusinessType, "", "");
		}
		alert("插入批量删除表成功!");
		reloadSelf();
	}

	//主业务担保解除
	function removeContract(){
		//合同编号
		var rows = getCheckedRows(0);
		var sTableName = "<%=sTableName%>";
		if (rows==null || rows.length==0)
		{
			alert("您没有勾选任何行！");
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
		
		if(confirm("已确认该业务对应的所有担保在征信源系统已失效？")) { 
			sReturn = PopPage("/SystemManage/RemoveContract.jsp?TableName="+sTableName+"&OccurDate="+sOccurDate+"&KeyName="+sKeyNameMain+"&ContractNo="+sKeyValue+"&KeyValue="+sKeyValue,"_self","");
			if(sReturn == "Failture"){
				alert("业务号："+sKeyValue+"该业务已做过业务解除，不允许重复解除！");
				return;
			}else if(sReturn == "Return"){
				alert("业务号："+sKeyValue+"该业务在历史表中存在待上报记录，需先生成报文！");
				return;
			}else if(sReturn == "Success"){  
				alert("业务号："+sKeyValue+"请运行报文生成单元！");
				
			}else{
				alert("执行主业务担保解除失败，请查看日志！");
				return;
			}
			reloadSelf();
		}else{
			return;
		}
		}
	}

	//撤销担保合同解除
	function unRemoveContract(){
		//合同编号
		var rows = getCheckedRows(0);
		var sTableName = "<%=sTableName%>";
		if (rows==null || rows.length==0)
		{
			alert("您没有勾选任何行！");
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
    	if(confirm("是否执行撤销担保合同解除？")) { 
			sReturn = PopPage("/SystemManage/UnRemoveContract.jsp?TableName="+sTableName+"&OccurDate="+sOccurDate+"&DBKeyName="+sKeyNameMain+"&DBKeyValue="+sKeyValue,"_self","");
			if(sReturn == "Failture1"){
				alert("该业务"+sOccurDate+"时点未执行过业务解除，不允许撤销！");
				return;
			}else if(sReturn == "Failture2"){
				alert("该业务已经做过业务撤销，不允许重复撤销！");
				return;
			}else if(sReturn == "Return"){
				alert("该业务已经生成报文，不能执行撤销操作！");
				return;
			}else if(sReturn == "Success") {
			    alert("主业务担保合同撤销成功！");
				
			}else{
				alert("执行撤销担保合同解除操作失败，请查看日志！");
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