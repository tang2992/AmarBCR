<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content: ҵ����Ϣ�б�ҳ��
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List02;Describe=�����������ȡ����;]~*/%>
<%

	//�������
	//��ȡ�������
	String sTableName = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("TableName"));
	if(sTableName == null) sTableName = "";
	String sCompName = "BusinessInfoDetail";
	String sCompPath = "/DataMaintain/BusinessMaintain/BusinessInfoDetail.jsp";
%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "ҵ����Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
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
	
	//����datawindow
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);//��ҳ��ʾ
	
	Vector vTemp = dwTemp.genHTMLDataWindow("%");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List04;Describe=���尴ť;]~*/%>
	<%
	//����Ϊ��
		//0.�Ƿ���ʾ
		//1.ע��Ŀ�������(Ϊ�����Զ�ȡ��ǰ���)
		//2.����(Button/ButtonWithNoAction/HyperLinkText/TreeviewItem/PlainText/Blank)
		//3.��ť����
		//4.˵������
		//5.�¼�
		//6.��ԴͼƬ·��
	String sButtons[][] = {
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"false","","Button","ҵ����Ϣ","�鿴�ÿͻ���ҵ����Ϣ","showBusinessRecord()","","","",""},
		{"true","","Button","��������ɾ����","����ҵ���������ɾ����","batchDelete()","","","",""}
		};
	%> 
<%/*~END~*/%>

<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=List05;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
	<script language=javascript>

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/
	
	function viewAndEdit()
	{

		var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName[0]%>");
		var sTableName = "<%=sTableName%>";
		
    	if(typeof(sKeyValue)=="undefined" || sKeyValue.length==0) {
			alert("��ѡ��һ����Ϣ��");//��ѡ��һ����Ϣ��
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
	 
	/*~[Describe=;InputParam=��;OutPutParam=��;]~*/
	function showBusinessRecord()
	{
		reloadSelf();
	}
	
	/*~[Describe=;InputParam=��;OutPutParam=��;]~*/
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
			alert("��ѡ��һ����¼��");
			return;
		}

		if(sTableName == "ECR_ASSETSDISPOSE")
		{
			alert("ɾ�������ݲ�֧�ֲ����Ŵ��ʲ�������Ϣ��");
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
			alert("��������ɾ����ɹ�!");
		}else{
			alert("��������ɾ����ʧ��!");
		}
	}
	
	</script>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List07;Describe=ҳ��װ��ʱ�����г�ʼ��;]~*/%>
<script language=javascript>	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
	//hideFilterArea();
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>