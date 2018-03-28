<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content: 业务信息列表页面
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List02;Describe=定义变量，获取参数;]~*/%>
<%

	//定义变量
	//获取组件参数
	String sTableName = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("TableName"));
	if(sTableName == null) sTableName = "";
	String sCompName = "BusinessInfoDetail";
	String sCompPath = "/DataMaintain/BusinessMaintain/BusinessInfoDetail.jsp";
%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "业务信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List03;Describe=定义数据对象;]~*/%>
<%	
	ECRDataWindowXml ecrDWX = new ECRDataWindowXml(sTableName,sTableName,"ECR");
	if(!CurUser.getUserID().equals("system")){
		ecrDWX.setWhereSql(" and O.FINANCEID IN (select OI.orgid from jbo.ecr.ORG_TASK_INFO OI where OI.ORGCODE='"+CurUser.getRelativeOrgID()+"')");
	}else
		ecrDWX.setWhereSql(" where  1=1 " );
	
	ASDataObject doTemp = ecrDWX.generateASDataObject("List");
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:parent.viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
	String[] sKeyName = ecrDWX.getKeyName();
	String sKeyNameMain = sKeyName[0] ;
	for(int i=1;i<sKeyName.length;i++){
		sKeyNameMain = sKeyNameMain + "@" + sKeyName[i];
	}
	
	String sFilterName = ecrDWX.getFilter();
	if(!sFilterName.equals("")){
		doTemp.setColumnAttribute(sFilterName,"IsFilter","1");
		doTemp.generateFilters(Sqlca);
		doTemp.parseFilterData(request,iPostChange);
		CurPage.setAttribute("FilterHTML",doTemp.getFilterHtml(Sqlca));
	}
	
	if(!doTemp.haveReceivedFilterCriteria()) doTemp.WhereClause+="   ";
	
	//生成datawindow
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);//分页显示
	
	Vector vTemp = dwTemp.genHTMLDataWindow("%");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List04;Describe=定义按钮;]~*/%>
	<%
	//依次为：
		//0.是否显示
		//1.注册目标组件号(为空则自动取当前组件)
		//2.类型(Button/ButtonWithNoAction/HyperLinkText/TreeviewItem/PlainText/Blank)
		//3.按钮文字
		//4.说明文字
		//5.事件
		//6.资源图片路径
	String sButtons[][] = {
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"false","","Button","业务信息","查看该客户的业务信息","showBusinessRecord()","","","",""},
		{"true","","Button","插入批量删除表","将该业务插入批量删除表","batchDelete()","","","",""}
		};
	%> 
<%/*~END~*/%>

<%/*~BEGIN~不可编辑区~[Editable=false;CodeAreaID=List05;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
	<script language=javascript>

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=新增记录;InputParam=无;OutPutParam=无;]~*/
	
	function viewAndEdit()
	{

		var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName[0]%>");
		var sTableName = "<%=sTableName%>";
		
    	if(typeof(sKeyValue)=="undefined" || sKeyValue.length==0) {
			alert("请选择一条信息！");//请选择一条信息！
            return ;
		}
    	<%
    		for(int i=1;i<sKeyName.length;i++){
    	%>
    			sKeyValue = sKeyValue +  "@" + getItemValue(0,getRow(),"<%=sKeyName[i]%>");
    	<%				
    		}
    	%>
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
			
			popComp("<%=sCompName%>","<%=sCompPath%>","MetaTableName="+sTableName+"&DBTableName="+sTableName+"&KeyName="+sKeyNameMain+"&KeyValue="+sContractNo+"&Query=true","");
		}else{
			popComp("<%=sCompName%>","<%=sCompPath%>","MetaTableName=<%=sTableName%>&DBTableName=<%=sTableName%>&KeyName=<%=sKeyNameMain%>&KeyValue="+sKeyValue+"&Query=true","");
		}
		reloadSelf();
	}
	 
	/*~[Describe=;InputParam=无;OutPutParam=无;]~*/
	function showBusinessRecord()
	{
		reloadSelf();
	}
	
	/*~[Describe=;InputParam=无;OutPutParam=无;]~*/
	function batchDelete()
	{	
		var sTableName = "<%=sTableName%>";
		var sContractNo = getItemValue(0,getRow(),"<%=sKeyName[0]%>");
		var sOccurDate = getItemValue(0,getRow(),"OCCURDATE");
		var sLoanCardNo = getItemValue(0,getRow(),"LOANCARDNO");
		var sFinanceID = getItemValue(0,getRow(),"FINANCEID");
		var sBusinessType = "";
		var sKeyNameMain;
		var sReturn = "";

		if (typeof(sContractNo)=="undefined" || sContractNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}

		if(sTableName == "ECR_ASSETSDISPOSE")
		{
			alert("删除报文暂不支持不良信贷资产处置信息！");
			return;
		}
		
		if(sTableName == "ECR_ASSURECONT"||sTableName == "ECR_GUARANTYCONT"||sTableName == "ECR_IMPAWNCONT"){
			sContractNo = getItemValue(0,getRow(),"CONTRACTNO");
			sOccurDate = getItemValue(0,getRow(),"OCCURDATE");
			sBusinessType = "0"+ getItemValue(0,getRow(),"BUSINESSTYPE");

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
		}
		
		sReturn = PopPage("/SystemManage/InsertIntoHisBatchDelete.jsp?ContractNo="+sContractNo+"&OccurDate="+sOccurDate+"&LoanCardNo="+sLoanCardNo+"&FinanceID="+sFinanceID+"&BusinessType="+sBusinessType,"_self","");
		if(sReturn=="Success"){
			alert("插入批量删除表成功!");
		}else{
			alert("插入批量删除表失败!");
		}
	}
	
	</script>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List07;Describe=页面装载时，进行初始化;]~*/%>
<script language=javascript>	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
	//hideFilterArea();
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>