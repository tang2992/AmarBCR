<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

	<%
		String PG_TITLE = "ҵ����������б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%

	//�������
	//��ȡ�������
	//TableFlag��ʾ������ʾhis��,����ecr��
	//���������Ĳ�����(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
	String sTableName = CurComp.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurComp.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyName = CurComp.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String sKeyValue = CurComp.getParameter("KeyValue");
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	//�������������Ҷ���
	for(DataElement de:boManager.getManagedClass().getAttributes()){
		if(de.getType()==DataElement.DOUBLE || de.getType()==DataElement.INT || de.getType()==DataElement.LONG){
			doTemp.setAlign(de.getName(), "3");
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
	
	if(sTableFlag.equals("ECR"))
		doTemp.setVisible("TRACENUMBER,MODFLAG,SESSIONID,SESSIONIDNAME,ERRORCODE",false);
	//����ҵ�������չʾ
	doTemp.setReadOnly("Lcontractno,Lduebillno", true);
	doTemp.setEditStyle("Occurdate,Startdate,Enddate,Putoutdate,Putoutenddate,Returndate,Extenstartdate,Extenenddate", "Date");
	doTemp.setRequired("*", true);
	doTemp.setRequired("Customerid,Modflag,Tracenumber,Recordflag,Oldfinanceid,Creditno,Sessionid,Errorcode,Classify4", false);
	doTemp.setEditStyle("IncrementFlag,Bankflag,Guarantyflag,Availabstatus,Currency,Recycle,Returnmode,Businesstype,Form,Loancharacter,Way,Kind,Extenflag,Classify5,Classify4", "Select");
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
		}
	doTemp.setDDDWJbo("Form", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7531'");
	doTemp.setDDDWJbo("Loancharacter", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7533'");
	doTemp.setDDDWJbo("Way", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7535'");
	doTemp.setDDDWJbo("Kind", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7537'");
	doTemp.setDDDWJbo("Extenflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7573'");
	doTemp.setDDDWJbo("Classify5", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7541'");
	doTemp.setDDDWJbo("Classify4", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7539'");
	
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
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
 
	dwTemp.genHTMLObjectWindow(args);
	
%>

	<%
	
	String sButtons[][] = {
			{sTableFlag.equals("ECR")?"true":"false","","Button","����","����","saveRecord()","","","",""},
		};
	%> 
	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>

	<script type="text/javascript">
  
	//---------------------���尴ť�¼�------------------------------------
	function saveRecord()
	{	
		if (!ValidityCheck()) return;
		as_save("myiframe0");
	}
	
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
        if(sTableName=="ECR_CREDITLETTER") {
			
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
	
	/*~[Describe=�����б�ҳ��;InputParam=��;OutPutParam=��;]~*/
	function goBack(){
		top.close();
	}
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
