<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "У�������Ϣ�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%	
	String sRecordType = CurPage.getParameter("recordType");
	if(sRecordType == null) sRecordType = "";
	/* BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.ECR_ERRHISTORY");
	ASObjectModel doTemp = new ASObjectModel(boManager); */
	ASObjectModel doTemp = new ASObjectModel("BCRERRHISTORY");
	String where = "1=1" ;
	if(!StringX.isEmpty(sRecordType))
		where = "recordType=:recordType" ;
    /* if(!CurUser.getUserID().equals("system")){
    	where  = where+" and O.FINANCEID IN (select UO.Orgid from jbo.ecr.ORG_TASK_INFO UO where UO.OrgCode='"+CurUser.getRelativeOrgID()+"')";
	}  */ 
	doTemp.setJboWhere(where);
	//˫���¼�
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewDetail()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	//���õ�ҳ��ʾ20�� 
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sRecordType);

%>

	<%
	String sButtons[][] = {
		{"true","","Button","����","�����޸Ľ���","viewDetail()","","","",""},
		{"true","","Button","ɾ��","ȷ�����޸�,ɾ���ü�¼","deleteRecord()","","","",""},
		{"true","","Button","����EXCEL","����EXCEL","exportAll()","","","",""}
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">

	//---------------------���尴ť�¼�------------------------------------
	
	/*~[Describe=�鿴/�޸�����;InputParam=��;OutPutParam=��;]~*/
	function viewDetail()
	{
		var sMAINBUSINESSNO = getItemValue(0,getRow(),"MAINBUSINESSNO");
		var sRECORDTYPE = getItemValue(0,getRow(),"RECORDTYPE");
		var sCUSTOMERID = getItemValue(0,getRow(),"CUSTOMERID");
		var sCompName,sCompPath,sDBTableName,sKeyNameMain,sKeyValueMain;

		if (typeof(sMAINBUSINESSNO) == "undefined" || sMAINBUSINESSNO.length == 0){
			alert("��ѡ��һ����¼��");
			return;
			
		}else if(sMAINBUSINESSNO=="MAIN_BUSINESS_NO_NOT_ALLOW_NULL"){
			alert("�����ڶ�Ӧ����ҵ����Ϣ��");	
			return;		
		}
		//��ȡ���ʲ���
		var sReturnValue = AsControl.RunJsp("/ErrorManage/ValidateErrorManage/GetDBTableName.jsp","RECORDTYPE="+sRECORDTYPE+"&MAINBUSINESSNO="+sMAINBUSINESSNO+"&CUSTOMERID="+sCUSTOMERID);
		if(typeof(sReturnValue)=="undefined" || sReturnValue.length==0){
			alert("�������ݱ�");
			return;
		}else{
			var sSplitValue = sReturnValue.split(",");
			sCompName = sSplitValue[0];
			sCompPath = sSplitValue[1];
			sTableName = sSplitValue[2];
			sKeyNameMain = sSplitValue[3];
			sKeyValueMain = sSplitValue[4];
		}

		//�ͻ����⴦��
		if(typeof(sTableName)=="undefined" || sTableName.length==0){
			alert("��ҵ���¼��Ӧ��У�����!");
			return;
		}else if(sTableName == "ECR_CUSTOMERINFO"){
			var sReturn = popComp(sCompName,sCompPath,"CustomerID="+sKeyValueMain+"&QueryType=ERROR","");
		}else if(sTableName =="ECR_ORGANINFO"){
			var sReturn = popComp(sCompName,sCompPath,"sCIFCustomerID="+sKeyValueMain+"&QueryType=ERROR&sTableName="+sTableName,"");
		}else if(sTableName =="ECR_ORGANFAMILY"){
			var sReturn = popComp(sCompName,sCompPath,"sCIFCustomerID="+sKeyValueMain+"&QueryType=ERROR&sTableName="+sTableName,"");
		}else if(sTableName =="BCR_GUARANTEEINFO"){
			var sReturn = popComp(sCompName,sCompPath,"GBusinessNo="+sKeyValueMain+"&QueryType=ERROR","");
		}else{
			var sReturn =  popComp(sCompName,sCompPath,"sTableName="+sTableName+"&KeyName="+sKeyNameMain+"&KeyValue="+sKeyValueMain+"&QueryType=ERROR","");
		}
		if(sReturn=="false"){
			alert("����У�������Ϣ��Ӧ��ҵ����Ϣ�Ѿ�������,��ɾ��������¼!");
		}
		reloadSelf();
	}
	//ɾ����¼
	function deleteRecord()
	{
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		if(confirm("ȷ�����޸�,Ҫɾ���ü�¼��?")) 
		{
			as_delete("myiframe0","reload()");
		}
	}
	/*~[Describe=����EXCEL;InputParam=��;OutPutParam=��;]~*/
	function exportAll()
	{
		//amarExport("myiframe0");
		as_defaultExport();
	}
	
	</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>