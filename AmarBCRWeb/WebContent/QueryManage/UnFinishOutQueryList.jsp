<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml,com.amarsoft.app.datax.ecr.common.Tools,java.util.*"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%
	//�������
	//��ȡ�������
	String sTableName = CurComp.getParameter("TableName");
	if(sTableName == null) sTableName = "";
	int index = 0;
%>

	<%
	String PG_TITLE = "ҵ����Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%	
	String occurDate = "";
	Calendar cal = Calendar.getInstance();
	cal.setTime(new java.util.Date());
	occurDate=Tools.getCurrentDay("1");
	if(cal.get(Calendar.HOUR_OF_DAY)<22)  //22��֮ǰȡ���죬22��֮��ȡ����
		occurDate=Tools.getLastDay("1");
	String[][] sTable  = {
			{"ECR_LOANCONTRACT","AVAILABSTATUS='1' and EndDate<'" + occurDate + "'"},
			{"ECR_FACTORING","BALANCE>0 and FactoringStatus='2'"},//����ҵ��״̬������,����,���Բ����д��ֶ�,���������ж�
			{"ECR_DISCOUNT","BILLSTATUS<>'2' and AcceptMaturity<'" + occurDate + "'"},//����,����,ת����
			{"ECR_FINAINFO","AVAILABSTATUS='1' and EndDate<'" + occurDate + "'"},//����,����
			{"ECR_CREDITLETTER","CREDITSTATUS='1' and AvailabTerm<'" + occurDate + "'"},//������ע��
			{"ECR_GUARANTEEBILL","GUARANTEESTATUS='1' and EndDate<'" + occurDate + "'"},//�����ͽ��
			{"ECR_ACCEPTANCE","DRAFTSTATUS<>'3' and AccepEndDate<'" + occurDate + "'"},//����,δ���˳�,����
			{"ECR_CUSTOMERCREDIT","(CreditLogOutCause is null and CreditEndDate > '"+occurDate+"') or CreditLogOutDate > '"+occurDate+"' and CreditEndDate<'" + occurDate + "'"}
		};

	for(int i=0;i<sTable.length;i++){
		if(sTable[i][0].equals(sTableName)){
			index = i;
			break;
		}
	}
	//��ȡmetadata.xml����,��ȡ��ص���Ϣ
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	String jBOWhere="";
	jBOWhere +=sTable[index][1];
	//��������Ȩ��,���û���Ͻ������
    if(!CurUser.getUserID().equals("system"))
    	jBOWhere += " and  O.FINANCEID IN (select OI.ORGID from jbo.ecr.ORG_TASK_INFO OI where OI.OrgCode='"+CurUser.getRelativeOrgID()+"')" ;	
   doTemp.setJboWhere(jBOWhere);

	doTemp.setVisible("Modflag,Tracenumber,Errorcode,Recordflag,Oldfinanceid,Creditno,Sessionid,Bankflag,Recycle,Guarantyflag,Currency,Availabbalance,Customerid", false);
	doTemp.setVisible("Classify4,Classify5,Factoringtype,Factoringstatus,Businessdate,Balancechangedate,Floorflag", false);
	doTemp.setVisible("Billtype,Acceptername,Aloancardno,Billsum", false);
	doTemp.setVisible("Payterm,Depositscale,Logoutdate,Balance,Balancereportdate", false);
	doTemp.setVisible("Guaranteetype,Balanceoccurdate", false);
	doTemp.setVisible("Acceppaydate,Assurescale", false);
	doTemp.setVisible("Creditlogoutdate,Creditlogoutcause", false);
	doTemp.setVisible("Businessno,Returnmode", false);
	doTemp.setVisible("Businesstype,Assurecurrency,Assureform,Certtype,Certid", false);
	
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
	
	//����˫���¼�
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");

	
	//��ȡ��ҵ���������Ϣ
	String[] sKeyName =boManager.getManagedClass().getKeyAttributes();
	String sKeyNameMain="";
	for(String key: sKeyName){
		sKeyNameMain += key+"@";
	}
	
	//���ù�����

	//����datawindow
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);//��ҳ��ʾ
	
	dwTemp.genHTMLObjectWindow("");
	
	//��ʾ��������·��
	String sCompName = "BusinessInfoDetail";
	String sCompPath = "/DataMaintain/BusinessMaintain/BusinessInfoDetail.jsp";
	
%>

	<%
	String sButtons[][] = {
			{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		};
	%> 
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
	<script type="text/javascript">

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/
	
	//����������,��ȡ��Ӧ�ļ�ֵ
	function viewAndEdit()
	{
		var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName[0]%>");
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
		popComp("<%=sCompName%>","<%=sCompPath%>","sTableName=<%=sTableName%>&KeyName=<%=sKeyNameMain%>&KeyValue="+sKeyValue+"&sIsQuery=true","");
		reloadSelf();
	}
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>