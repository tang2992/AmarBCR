<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

	<%
		String PG_TITLE = "ҵ����������б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%

	//�������
	//��ȡ�������
	//������Ҫ�У�sTableName(���ݿ���Ҫ���ҵ��ֶ�),KeyName(Ҫ���ҵı�ҵ��Ĺؼ���),KeyValue(Ҫ���ҵı�ҵ��Ĺؼ��ֵ�ֵ)
	//TableFlag��ʾ������ʾhis��,����ecr��
	//���������Ĳ�����(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
	String sTableName = CurComp.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurComp.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyName = CurComp.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String sKeyValue = CurComp.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";

	//������������������ʱ����������ҳ�����ֵ�滻����
	//���������������������������OCCURDATE,EXTENTIMES,RETURNTIMES
	//�������仯��ʱ��,�������뵱ǰ���û�,�����µ�ֵ��������
	String occurDate =(String) session.getAttribute("OCCURDATE");
	if(occurDate==null) occurDate = "OCCURDATE";session.removeAttribute("OCCURDATE");
	String extenTimes = (String) session.getAttribute("EXTENTIMES");
	if(extenTimes==null) extenTimes = "EXTENTIMES";session.removeAttribute("EXTENTIMES");
	String returnTimes = (String) session.getAttribute("RETURNTIMES");
	if(returnTimes==null) returnTimes = "RETURNTIMES";session.removeAttribute("RETURNTIMES");
	
	//���������ͼ�ֵ���ж�Ӧ,����where�Ӿ�
		//����where����
		String jBOWhere="";
		String args="";
		
		String[] stName=sKeyName.split("@");
		String[] stValue=sKeyValue.split("@");
		for(int i=0; i<stName.length; i++){
			String k = stName[i];
			String v = stValue[i];
			if("OCCURDATE".equalsIgnoreCase(k)&&!occurDate.equals("OCCURDATE"))
				k = occurDate;
			if("EXTENTIMES".equalsIgnoreCase(k)&&!extenTimes.equals("EXTENTIMES"))
				k = extenTimes;
			if("RETURNTIMES".equalsIgnoreCase(k)&&!returnTimes.equals("RETURNTIMES"))
				k = returnTimes;
	
			jBOWhere =jBOWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
		jBOWhere = jBOWhere.substring(4);
		if(!args.isEmpty())
			args = args.substring(1);
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	doTemp.setJboWhere(jBOWhere);
	doTemp.setColCount(2); //����
	doTemp.setVisible("MODFLAG,Recordflag",false);
	
	//����ҵ�������չʾ
	doTemp.setReadOnly("Lcontractno,Lduebillno,Contractno,Assurecontno,Guarantycontno,Impawncontno,Occurdate", true);
	doTemp.setEditStyle("Occurdate,Startdate,Enddate,Putoutdate,Putoutenddate,Returndate,Extenstartdate,Extenenddate,Createdate,Evaluatedate,Registdate", "Date");
	doTemp.setRequired("*", true);
	doTemp.setRequired("Customerid,Modflag,Tracenumber,Recordflag,Oldfinanceid,Creditno,Sessionid,Errorcode,Aloancardno,Gloancardno,Evaluatecurrency,Evaluatesum,Evaluatedate,Evaluateoffice,Evaluateofficeid,Registdate,Classify4,Updatedate", false);
	doTemp.setEditStyle("IncrementFlag,Bankflag,Guarantyflag,Availabstatus,Currency,Recycle,Returnmode,Businesstype,Form,Loancharacter,Way,Kind,Extenflag,Classify5,Classify4,Assurecurrency,Assureform,Evaluatecurrency,Guarantytype,Guarantycurrency,Valuecurrency,Impawntype,Impawncurrency", "Select");
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
	doTemp.setDDDWJbo("Way", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7535'");
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
	//��ȡ�ñ�����еĹؼ���
	String[] sName= boManager.getManagedClass().getKeyAttributes();
	String sKeyStr="";
	for(String key: sName){
		sKeyStr += key+"@";
	}

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(args);
%>

	<%
	//����������ť����ʾ���޸�ҵ��������,�޸Ļ������,�޸�չ�ڴ����Ǹ��ݲ�ͬ��״̬��������
	//�����޸�ҵ�������ڰ�ť,ֻ����ʷ�������ʾ
	//�����޸Ļ��������ť,ֻ�л���������ʾ
	//�����޸�չ�ڴ�����ť,ֻ��չ�ڱ������ʾ
	//���ڴӲ�ѯģ�������ת������ҳ��,����ʾ�κ��޸İ�ť
	String sReturnTimes = "false",sExtensionTimes="false",sChangeOccurdate="false",sSave="true";
	if((sTableName.equals("HIS_LOANRETURN")||sTableName.equals("ECR_FINARETURN"))){
		sReturnTimes = "true";
	}
	if(sTableName.equals("HIS_LOANEXTENSION")||sTableName.equals("ECR_FINAEXTENSION")){
		sExtensionTimes = "true";
	}
	
	String sButtons[][] = {
			{"true","","Button","����","����","saveRecord()","","","",""},
			{"true","","Button","�޸�ҵ��������","�޸�ҵ��������","changeOccurDate()","","","",""},
			{sReturnTimes,"","Button","�޸Ļ������","�޸Ļ������","changeReturnTimes()","","","",""},
			{sExtensionTimes,"","Button","�޸�չ�ڴ���","�޸�չ�ڴ���","changeExtensionTimes()","","","",""},
		};
	%> 
	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
	<script language=javascript>
  
	//---------------------���尴ť�¼�------------------------------------
	function saveRecord()
	{	
		if (!ValidityCheck()) return;
		as_save("myiframe0");
	}

	//�޸�ҵ��������
	function changeOccurDate(){
		var sOCCURDATE = getItemValue(0,getRow(),"OCCURDATE");
		if(typeof(sOCCURDATE) != "undefined"&&sOCCURDATE.length!=0){
			var sKeyValueS = getItemValue(0,getRow(),"<%=sName[0]%>");
    	<%
    		for(int i=1;i<sName.length;i++){
    	%>
    			sKeyValueS = sKeyValueS +  "@" + getItemValue(0,getRow(),"<%=sName[i]%>");
    	<%				
    		}
    	%>
			var returnValue = popComp("ChangeOccurDate","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeOccurDate.jsp","sTableName=<%=sTableName%>&KeyName=<%=sKeyStr%>&KeyValue="+sKeyValueS+"&OCCURDATE="+sOCCURDATE,"dilogWidth=19;dialogHeight=14;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			reloadSelf();
		}
	}
	//�޸Ļ������
	function changeReturnTimes(){
		var sReturnTimes = getItemValue(0,getRow(),"RETURNTIMES");
		var sOccurDate = getItemValue(0,getRow(),"OCCURDATE");
		if(typeof(sReturnTimes) != "undefined"&&sReturnTimes.length!=0){
			var sKeyValueS = getItemValue(0,getRow(),"<%=sName[0]%>");
    	<%
    		for(int i=1;i<sName.length;i++){
    	%>
    			sKeyValueS = sKeyValueS +  "@" + getItemValue(0,getRow(),"<%=sName[i]%>");
    	<%				
    		}
    	%>
			var returnValue = popComp("ChangeOccureTimes","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeOccureTimes.jsp","sTableName=<%=sTableName%>&KeyName=<%=sKeyStr%>&KeyValue="+sKeyValueS+"&RETURNTIMES="+sReturnTimes+"&OccurDate="+sOccurDate,"dilogWidth=19;dialogHeight=14;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			reloadSelf();
		}
	}
	//�޸�չ�ڴ���
	function changeExtensionTimes(){
		var sExtensionTimes = getItemValue(0,getRow(),"EXTENTIMES");
		var sOccurDate = getItemValue(0,getRow(),"OCCURDATE");
		if(typeof(sExtensionTimes) != "undefined"&&sExtensionTimes.length!=0){
			var sKeyValueS = getItemValue(0,getRow(),"<%=sName[0]%>");
    	<%
    		for(int i=1;i<sName.length;i++){
    	%>
    			sKeyValueS = sKeyValueS +  "@" + getItemValue(0,getRow(),"<%=sName[i]%>");
    	<%				
    		}
    	%>
			var returnValue = popComp("ChangeOccureTimes","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeOccureTimes.jsp","sTableName=<%=sTableName%>&KeyName=<%=sKeyStr%>&KeyValue="+sKeyValueS+"&EXTENTIMES="+sExtensionTimes+"&OccurDate="+sOccurDate,"dilogWidth=19;dialogHeight=14;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			reloadSelf();
		}
	}
	
	/*~[Describe=����Ͷ��;InputParam=��;OutPutParam=��;]~*/
	function getWay()
	{	
		var sWay = getItemValue(0,0,"WAY");
		var sReturn = PopComp("IndustryVFrame","/DataMaintain/IndustryVFrame.jsp","IndustryType="+sWay,"dialogWidth:730px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"WAY",sReturnvalues[0]);
		setItemValue(0,0,"WAYNAME",sReturnvalues[1]);
	}
	
	/*~[Describe=�����б�ҳ��;InputParam=��;OutPutParam=��;]~*/
	function goBack(){
		top.close();
	}
	/*~[Describe=ҳ��װ��ʱ����DW���г�ʼ��;InputParam=��;OutPutParam=��;]~*/
	function initRow()
	{
		if (getRowCount(0)==0) //���û���ҵ���Ӧ��¼��������һ�����������ֶ�Ĭ��ֵ
		{
			as_add("myiframe0");//������¼
			bIsInsert = true;
		}
    }

	/*~[Describe=��Ч�Լ��;InputParam=��;OutPutParam=ͨ��true,����false;]~*/
	function ValidityCheck()
	{	
		var sTableName = "<%=sTableName%>";
		if(sTableName=="HIS_LOANCONTRACT"||sTableName=="HIS_FACTORING"||sTableName=="HIS_DISCOUNT"||sTableName=="HIS_FINAINFO"
		   ||sTableName=="HIS_CREDITLETTER"||sTableName=="HIS_GUARANTEEBILL"||sTableName=="HIS_ACCEPTANCE"||sTableName=="HIS_CUSTOMERCREDIT"
		   ||sTableName=="HIS_FLOORFUND"||sTableName=="HIS_INTERESTDUE"){
			
			//������У��
			var sLoanCardNo = getItemValue(0,0,"LOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('��������������!');
					return false;
				}
			}
		
		}
		if(sTableName=="HIS_ASSURECONT") {
			
		}else if(sTableName=="HIS_GUARANTYCONT") {
			
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
		}else if(sTableName=="HIS_IMPAWNCONT") {
			var sLoanCardNo = getItemValue(0,0,"ILOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('��������������!');
					return false;
				}
			}
		}else if(sTableName=="HIS_CREDITLETTER") {
			
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
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
