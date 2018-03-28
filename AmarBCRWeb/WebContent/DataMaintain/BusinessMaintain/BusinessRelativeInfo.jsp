<%@page import="com.amarsoft.awe.dw.ASObjectWindow"%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

	<%
		String PG_TITLE = "ҵ����������б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%

	//�������
	//��ȡ�������
    //TableFlag��ʾ������ʾhis��,����ecr��
	//���������Ĳ�����(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
	
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurPage.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyName = CurPage.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String sKeyValue = CurPage.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";
	//�����ڲ�ѯ���������ر��水ť
	String sIsQuery = CurPage.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//������У����������ر��水ť
	String sQueryType = CurPage.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";
	String sReportType = CurPage.getParameter("ReportType");
	if(sReportType == null) sReportType = "";
	String sType = CurPage.getParameter("Type");
	if(sType == null) sType = "";

	//������������������ʱ����������ҳ�����ֵ�滻����
	//���������������������������OCCURDATE,EXTENTIMES,RETURNTIMES
	//�������仯��ʱ��,�������뵱ǰ���û�,�����µ�ֵ��������
	String sNewName = "";
	String sNewValue = (String) session.getAttribute("ALOANCARDNO");
	if(sNewValue==null){
	}else{
		sNewName = "ALOANCARDNO";
		session.removeAttribute("ALOANCARDNO");
	}
	
%>

<%	
	String sShow = "true";
	//ֻҪ��HIS��,�������ۺϲ�ѯ���õ�ҳ��,����ӵ�в鿴Ȩ�޶���ӵ��ά��Ȩ��,��ô�����ذ�ť
	if(sQueryType.equals("ERROR")){
		if(sTableFlag.equals("HIS")||sIsQuery.equals("true")||(CurUser.hasRole("0200")&&!CurUser.hasRole("0201"))){
		sShow = "false";
		}	
	}else{
		if(sTableFlag.equals("HIS")||sIsQuery.equals("true")||(CurUser.hasRole("0100")&&!CurUser.hasRole("0101"))){
			sShow = "false";
		}	
	}

	ASObjectModel doTemp = null;
	if(sTableName.toUpperCase().equals("ECR_LOANDUEBILL") ||sTableName.toUpperCase().equals("HIS_LOANDUEBILL")){
		 doTemp = new ASObjectModel("LoanduebillInfo");
		 doTemp.setJboClass("jbo.ecr."+sTableName);
	}else{ 

		BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
		doTemp = new ASObjectModel(boManager);

	//�������������Ҷ���
	for(DataElement de:boManager.getManagedClass().getAttributes()){
		if(de.getType()==DataElement.DOUBLE || de.getType()==DataElement.INT || de.getType()==DataElement.LONG){
			doTemp.setAlign(de.getName(), "3");
		}
	}
	}

	//����where����
	String jBOWhere="";
	String args="";
	
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

	doTemp.setJboWhere(jBOWhere);
	doTemp.setColCount(2); //����

	if(sTableFlag.equals("ECR")){
		doTemp.setVisible("TRACENUMBER,MODFLAG,SESSIONID,ERRORCODE,Recordflag,Updatedate",false);
	}else if(sTableFlag.equals("HIS")){
		doTemp.setVisible("MODFLAG,Recordflag,Updatedate",false);
	}

	if(sReportType.equals("2"))
	{   
		 if(sTableName.equals("ECR_ASSURECONT"))
		doTemp.setVisible("ALoanCardNo,REPORTTYPE",false);
		if(sTableName.equals("ECR_GUARANTYCONT"))//��Ѻ
		doTemp.setVisible("GLoanCardNo,REPORTTYPE",false);
		if(sTableName.equals("ECR_IMPAWNCONT"))//��Ѻ
		 doTemp.setVisible("ILoanCardNo,REPORTTYPE",false);
	   
	}else{
		 doTemp.setVisible("CERTTYPE,CERTID,REPORTTYPE",false);
	}
	//����ҵ�������չʾ
	doTemp.setReadOnly("Lcontractno,Lduebillno,Contractno,Assurecontno,Guarantycontno,Impawncontno,WayName", true);
	doTemp.setEditStyle("Occurdate,Startdate,Enddate,Putoutdate,Putoutenddate,Returndate,Extenstartdate,Extenenddate,Createdate,Evaluatedate,Registdate", "Date");
	doTemp.setRequired("*", true);
	doTemp.setRequired("Customerid,Modflag,Tracenumber,Recordflag,Oldfinanceid,Creditno,Sessionid,Errorcode,Aloancardno,Gloancardno,Evaluatecurrency,Evaluatesum,Evaluatedate,Evaluateoffice,Evaluateofficeid,Registdate,Classify4,Updatedate", false);
	doTemp.setEditStyle("IncrementFlag,Bankflag,Guarantyflag,Availabstatus,Currency,Recycle,Returnmode,Businesstype,Form,Loancharacter,Kind,Extenflag,Classify5,Classify4,Assurecurrency,Assureform,Evaluatecurrency,Guarantytype,Guarantycurrency,Valuecurrency,Impawntype,Impawncurrency", "Select");
	doTemp.setDDDWCodeTable("IncrementFlag", "1,����,2,ҵ����,4,ɾ��,6,�ֹ��ս�,8,��Ǩ��");//��Ϣ����״̬
	doTemp.setDDDWJbo("Bankflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7521'");
	doTemp.setDDDWJbo("Guarantyflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7523'");
	doTemp.setDDDWJbo("Availabstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7525'");
	doTemp.setDDDWJbo("Currency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWCodeTable("Recycle", "1,��,2,��");//��Ϣ����״̬
	doTemp.setDDDWJbo("Returnmode", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7545'");
	if(sTableName.equals("ECR_LOANDUEBILL")){
		doTemp.setDDDWJbo("Businesstype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7529'");
	} else if (sTableName.equals("ECR_FINADUEBILL")){
		doTemp.setDDDWJbo("Businesstype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7569'");
		}else{
		doTemp.setDDDWJbo("Businesstype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7605'");
		}
	doTemp.setDDDWJbo("Form", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7531'");
	doTemp.setDDDWJbo("Loancharacter", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7533'");
	doTemp.setDDDWJbo("Kind", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7537'");
	doTemp.setDDDWJbo("Extenflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7573'");
	doTemp.setDDDWJbo("Classify5", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7541'");
	doTemp.setDDDWJbo("Classify4", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7539'");
	doTemp.setDDDWJbo("Assurecurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWJbo("Assureform", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7603'");
	doTemp.setDDDWJbo("Evaluatecurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWJbo("Guarantytype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7617'");
	doTemp.setDDDWJbo("Guarantycurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWJbo("Valuecurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWJbo("Impawntype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7621'");
	doTemp.setDDDWJbo("Impawncurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setUnit("WayName","<input type=button class=inputDate   value=\"...\" name=button2 onClick=\"javascript:getWay();\"> ");
	
	//����ҵ�������չʾ
	doTemp.setReadOnly("Factoringno", true);
	doTemp.setEditStyle("Businessdate,Balancechangedate", "Date");
	doTemp.setEditStyle("Factoringtype,Factoringstatus,Floorflag", "Select");
	doTemp.setDDDWJbo("Factoringtype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7549'");
	doTemp.setDDDWJbo("Factoringstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7551'");
	doTemp.setDDDWJbo("Floorflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7513'");
	//Ʊ������ҵ�������չʾ
	doTemp.setReadOnly("Billno", true);
	doTemp.setRequired("Acceptername,Aloancardno", false);
	doTemp.setEditStyle("Discountdate,Acceptmaturity", "Date");
	doTemp.setEditStyle("Billtype,Billstatus", "Select");
	doTemp.setDDDWJbo("Billtype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7555'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	//ó������ҵ�������չʾ
	doTemp.setReadOnly("Fcontractno,Fduebillno", true);
	doTemp.setRequired("Acceptername,Aloancardno", false);
	doTemp.setEditStyle("Discountdate,Acceptmaturity", "Date");
	doTemp.setEditStyle("Billtype,Billstatus", "Select");
	doTemp.setDDDWJbo("Billtype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7555'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	//����֤ҵ�������չʾ
	doTemp.setReadOnly("Creditletterno", true);
	doTemp.setRequired("Logoutdate", false);
	doTemp.setEditStyle("Availabterm,Logoutdate,Balancereportdate", "Date");
	doTemp.setEditStyle("Payterm,Creditstatus", "Select");
	doTemp.setDDDWJbo("Payterm", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='2579'");
	doTemp.setDDDWJbo("Creditstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	//����ҵ�������չʾ
	doTemp.setReadOnly("Guaranteebillno", true);
	doTemp.setRequired("Enddate", false);
	doTemp.setEditStyle("Balanceoccurdate", "Date");
	doTemp.setEditStyle("Guaranteetype,Guaranteestatus", "Select");
	doTemp.setDDDWJbo("Guaranteetype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='2579'");
	doTemp.setDDDWJbo("Guaranteestatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	//�жһ�Ʊҵ�������չʾ
	doTemp.setReadOnly("Acontractno,Acceptno", true);
	doTemp.setRequired("Acceppaydate", false);
	doTemp.setEditStyle("Accepdate,Accependdate,Acceppaydate", "Date");
	doTemp.setEditStyle("Draftstatus", "Select");
	doTemp.setDDDWJbo("Draftstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7591'");
	//��������ҵ�������չʾ
	doTemp.setReadOnly("Ccontractno", true);
	doTemp.setRequired("Creditlogoutdate,Creditlogoutcause", false);
	doTemp.setEditStyle("Creditstartdate,Creditenddate,Creditlogoutdate", "Date");
	doTemp.setEditStyle("Creditlogoutcause", "Select");
	doTemp.setDDDWJbo("Creditlogoutcause", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='8511'");
	//���ҵ�������չʾ
	doTemp.setReadOnly("Floorfundno", true);
	doTemp.setEditStyle("Floordate", "Date");
	doTemp.setEditStyle("Floortype", "Select");
	doTemp.setDDDWJbo("Floortype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7625'");
	//ǷϢҵ�������չʾ
	doTemp.setEditStyle("Changedate", "Date");
	doTemp.setEditStyle("Interesttype", "Select");
	doTemp.setDDDWJbo("Interesttype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7631'");
	//�����ʲ�����ҵ�������չʾ
	doTemp.setReadOnly("Businessno", true);
	doTemp.setRequired("Loancardno,Organizationcode,Businessregistryno,Recoveryamount", false);
	doTemp.setEditStyle("Disposedate", "Date");
	doTemp.setEditStyle("Disposetype", "Select");
	doTemp.setDDDWJbo("Disposetype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7639'");

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform

	if("false".equals(sShow))dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	else dwTemp.ReadOnly = "0";
	
	dwTemp.genHTMLObjectWindow(args);
%>

	<%
	
	String sButtons[][] = {
			{sShow,"","Button","����","����","saveRecord()","","","",""},
			//{sShow.equals("true")&&sTableName.equals("ECR_ASSURECONT")?"true":"false","","Button","���ı�֤�˴�����","���ı�֤�˴�����","changeALoanCardNo()","","","",""},
			{"info".equals(sType)?"true":"false","","Button","�鿴��ʷ��¼","�鿴��ʷ��¼","showHISContent()","","","",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>

	<script type="text/javascript">
	function saveRecord()
	{	
		if (!ValidityCheck()) return;
		as_save("myiframe0");
	}
	//��ʾ��ʷ��Ϣ
 	function showHISContent(){
	<%-- 	<%
			if(sTableName.indexOf("HIS")>=0)
				sTableName = StringFunction.replace(sTableName,"HIS","ECR");
		%> --%>
			popComp("","/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp","sTableName=<%=StringFunction.replace(sTableName,"ECR","HIS")%>&KeyName=<%=sKeyName%>&KeyValue=<%=sKeyValue%>&TableFlag=HIS&IsQuery=<%=sIsQuery%>&QueryType=<%=sQueryType%>","");         
	}
	//---------------------���尴ť�¼�------------------------------------

	/*~[Describe=�����б�ҳ��;InputParam=��;OutPutParam=��;]~*/
	function goBack(){
		top.close();
	}
	
	/*~[Describe=��Ч�Լ��;InputParam=��;OutPutParam=ͨ��true,����false;]~*/
	function ValidityCheck()
	{	
		var sTableName = "<%=sTableName%>";
		if(sTableName=="ECR_LOANCONTRACT"||sTableName=="ECR_FACTORING"||sTableName=="ECR_DISCOUNT"||sTableName=="ECR_FINAINFO"
		   ||sTableName=="ECR_CREDITLETTER"||sTableName=="ECR_GUARANTEEBILL"||sTableName=="ECR_ACCEPTANCE"||sTableName=="ECR_CUSTOMERCREDIT"
		   ||sTableName=="ECR_FLOORFUND"||sTableName=="ECR_INTERESTDUE"){

			//������У��
			var sLoanCardNo = getItemValue(0,0,"LOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('��������������!');
					return false;
				}
			}
		}
		if(sTableName=="ECR_ASSURECONT") {
			//������У��
			var sLoanCardNo = getItemValue(0,0,"ALOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('��������������!');
					return false;
				}
			}
			
		}else if(sTableName=="ECR_GUARANTYCONT") {

			//������У��
			var sLoanCardNo = getItemValue(0,0,"GLOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('��������������!');
					return false;
				}
			}
			var sEVALUATEOFFICEID = getItemValue(0,0,"EVALUATEOFFICEID");
			if(typeof(sEVALUATEOFFICEID)!="undefined"&&sEVALUATEOFFICEID!=""){
				if(!CheckORG(sEVALUATEOFFICEID)){
					alert('����������֯����������������!');
					return false;
				}
			}
		}else if(sTableName=="ECR_IMPAWNCONT") {
			var sLoanCardNo = getItemValue(0,0,"ILOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('��������������!');
					return false;
				}
			}
		}else if(sTableName=="ECR_CREDITLETTER") {
			
			var sCREDITSTATUS = getItemValue(0,0,"CREDITSTATUS");
			var sLOGOUTDATE = getItemValue(0,0,"LOGOUTDATE");
			if(sCREDITSTATUS=="2") {
				if(typeof(sLOGOUTDATE)=="undefined"||sLOGOUTDATE==""){
					alert('����֤״̬Ϊע��ʱ����֤ע������Ϊ������!');
					return false;
				}	
			}else {
				if(typeof(sLOGOUTDATE)!="undefined"&&sLOGOUTDATE!=""){
					alert('����֤״̬��Ϊע��ʱ����֤ע�����ڱ���Ϊ��!');
					return false;
				}
			}
		}
		return true;
	}

    //��ȡ��ҵͶ��
    function getWay(){
    	var sReturn = PopComp("GetMyFrame","/DataMaintain/GetMyFrame.jsp","DataType=7535","dialogWidth:320px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnValues = sReturn.split("@");
		setItemValue(0,0,"Way",sReturnValues[0]);
		setItemValue(0,0,"WayName",sReturnValues[1]);
    }
	
    function changeALoanCardNo(){
		var sALoanCardNo = getItemValue(0,getRow(),"ALOANCARDNO");
		if(typeof(sALoanCardNo) != "undefined"&&sALoanCardNo.length!=0){
			var sKeyValueS = getItemValue(0,getRow(),"<%=sKeyName.split("@")[0]%>");
    	<%
    		for(int i=1;i<sKeyName.split("@").length;i++){
    	%>
    			sKeyValueS = sKeyValueS +  "@" + getItemValue(0,getRow(),"<%=sKeyName.split("@")[i]%>");
    	<%				
    		}
    	%>
			var returnValue = popComp("ChangeALoanCardNo","/ErrorManage/ValidateErrorManage/ChangeALoanCardNo.jsp","DBTableName=<%=sTableName%>&KeyName=<%=sKeyName%>&KeyValue="+sKeyValueS+"&ALOANCARDNO="+sALoanCardNo,"dilogWidth=19;dialogHeight=14;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			reloadSelf();
		}
	}
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
