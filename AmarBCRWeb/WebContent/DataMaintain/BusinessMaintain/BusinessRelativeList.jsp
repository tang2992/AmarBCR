<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "���������б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%

	//�������
	//��ȡ�������
	//��ҳ��������ҵ�����ʾ�Ĺ���ҳ��,���ڱ�ϵͳ���е�ҵ���б����ɱ�ҳ�����ɵ�
    //TableFlag��ʾ������ʾhis��,����ecr��
	//��������������������QueryType,Query,IsPatch(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableName1 = CurPage.getParameter("sTableName1");
	if(sTableName1 == null) sTableName1 = "";
	String sTableFlag = CurPage.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sMainName = CurPage.getParameter("KeyName");
	if(sMainName == null) sMainName = "";
	String sKeyValue= CurPage.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";

	//����ѯģ�鴫��Ĳ���,�����ڲ�ѯ���������ر��水ť
	String sIsQuery = CurPage.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//�Լ������ҳ�洫��Ĳ���,�����ڲ�ѯ���������ذ�ť
	String sQueryType = CurPage.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";
	//��������Ѻ����Ѻʱ���Ӵ�������� 
	String sKeyName1 = CurPage.getParameter("KeyName1");
	if(sKeyName1 == null) sKeyName1 = "";
	String sKeyValue1 = CurPage.getParameter("KeyValue1");
	if(sKeyValue1 == null) sKeyValue1 = "";
	String sIsPatch = CurComp.getParameter("IsPatch");
	if(sIsPatch == null) sIsPatch = "";
	String sFlag = CurComp.getParameter("sFlag");
	if(sFlag == null) sFlag = "";
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);

	//����where����
	String jBOWhere="";
	String args="";

	String[] sKeyName= boManager.getManagedClass().getKeyAttributes();
	String stName="";
	for(String key: sKeyName){
		stName += key+"@";
	}

	if(("HIS".equals(sTableFlag))&&sTableName.equals(sTableName1)){
		//��������Ѻ����Ѻʱ���Ӵ�����������д�������������������ֵ�Ķ�Ӧ��ϵ
		String[] stName1 = sKeyName1.split("@");
		String[] stValue1 = sKeyValue1.split("@");
		int length=2;//�������е�����ʷ��ͨ������ͬ���뼰������ͬ�������������ҵ��Ҳ��ʹ�ò�ʹ�õ���Ѻ����
		for(int i=0;i<length;i++){
			String k=stName1[i];
			String v=stValue1[i];
			jBOWhere =jBOWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
	}else{
			//���ڷ�����һ����ͬ�����ݵ�������õĻ�����������
			if(sKeyValue.indexOf("-")>0){
				String[] sValue = sKeyValue.split("-");
				String sValueStr = "";
				for(int i=0;i<sValue.length;i++){
					if(sValueStr.equals(""))
						sValueStr = sValueStr + "'" + sValue[i] +"'";
					else
						sValueStr = sValueStr + ",'" + sValue[i] +"'";
				}
				jBOWhere+=" and " + sMainName +" in("+sValueStr+")";
			}else{
					jBOWhere =jBOWhere+" and "+sMainName+"=:"+sMainName;
					args = args+","+sKeyValue;
					}
			}

	jBOWhere = jBOWhere.substring(4);
	if(!args.isEmpty()) 
		args = args.substring(1);
   doTemp.setJboWhere(jBOWhere);
   doTemp.setJboOrder("  OCCURDATE desc ");
    doTemp.setVisible("*", false);
    //����
    doTemp.setVisible("Lcontractno,LoancardNo,Financeid,CustomerName,Startdate,Enddate,Availabstatus,Occurdate,Lduebillno,Putoutamount,Balance,Putoutdate,Putoutenddate,Extenflag,Returntimes,Returndate,Returnmode,Returnsum,Extentimes,Extensum,Extenstartdate,Extenenddate", true);
    doTemp.setVisible("Contractno,Assurecontno,Aloancardno,Assurername,Occurdate,Incrementflag,Createdate,Certid,Availabstatus,Reporttype,Guarantycontno,Guarantyserialno,Pledgorname,Gloancardno,Guarantysum,Impawncontno,Impawserialno,Impawno,Impawnname,Iloancardno,Impawnsum",true);
    //����
    doTemp.setVisible("Factoringno,Customername,Factoringstatus,Businesssum,Businessdate,Guarantyflag,Fduebillno", true); 
    //Ʊ������
     doTemp.setVisible("Billno,Discountsum,Discountdate,Acceptmaturity,Billstatus",true);
    //ó������
    doTemp.setVisible("Fcontractno,Discountsum,Discountdate,Acceptmaturity,Billstatus",true);
    //����֤
    doTemp.setVisible("Creditletterno,Createsum,Createdate,Availabterm,Creditstatus",true);
    //�жһ�Ʊ
    doTemp.setVisible("Acontractno,Acceptno,Accepdate,Accepsum,Accependdate,Draftstatus",true);
    //��������
    doTemp.setVisible("Ccontractno,Creditlimit,Creditstartdate,Creditenddate",true);
    //���
    doTemp.setVisible("Floorfundno,Floorsum,Floordate,Floorbalance",true);
    //ǷϢ
    doTemp.setVisible("Customerid,Interesttype,Interestbalance",true);
    
    if(sTableFlag.equals("HIS")){
        doTemp.setVisible("SessionID", true); 
    }
    if(sFlag.equals("Feedback")){
    		doTemp.setVisible("TraceNumber,Errorcode", true); 
    }
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("Lcontractno,Lduebillno,FactoringNO,Billno,Fduebillno,Fcontractno,Creditletterno,Guaranteebillno,Acontractno,Ccontractno,Billno,CustomerID,Assurecontno,Guarantycontno,Impawncontno,Occurdate", true);
    doTemp.setDDDWJbo("Extenflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7573'");
	doTemp.setDDDWJbo("Returnmode", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7545'");
	doTemp.setDDDWCodeTable("IncrementFlag", "1,����,2,ҵ����,4,ɾ��,6,�ֹ��ս�,8,��Ǩ��");//��Ϣ����״̬
	doTemp.setDDDWJbo("Availabstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7525'");
	doTemp.setDDDWJbo("Guarantyflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7523'");
	doTemp.setDDDWJbo("Factoringstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7551'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	doTemp.setDDDWJbo("Creditstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	doTemp.setDDDWJbo("Draftstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7591'");
	doTemp.setDDDWJbo("Interesttype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7631'");
	doTemp.setDDDWCodeTable("Reporttype", "1,��������,2,��Ȼ�˵���");//��Ϣ����״̬
	//������ʾ�������������·��,�Լ����ݵĲ���
	String sCompNameInfo = "BusinessRelativeInfo";
	String sCompPathInfo = "/DataMaintain/BusinessMaintain/BusinessRelativeInfo.jsp";
	String sParamInfo = "sTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+stName+"&IsQuery="+sIsQuery+"&QueryType="+sQueryType;
	
	//����˫��������ҳ��
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:openBusinessInfo()\"");
	 
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(10);
	
	dwTemp.genHTMLObjectWindow(args==null ||args.length()<1 ?"%":args);
%>

	<%
	String sButtons[][] = {
			{"true","","Button","����","�鿴/�޸�����","openBusinessInfo()","","","",""},
			{("HIS".equals(sTableFlag)||sFlag.equals("Feedback"))?"false":"true","","Button","�鿴��ʷ��¼","�鿴��ʷ��¼","showHISContent()","","","",""},
			{(!sIsPatch.equals("true")&&sFlag.equals("Feedback"))?"true":"false","","Button","�����ϱ�","�ر�������¼","report(2)","","","",""},
			{(!sIsPatch.equals("true")&&sFlag.equals("Feedback"))?"true":"false","","Button","�ݲ��ϱ�","�ݲ��ر�������¼","report(3)","","","",""},
			{(!sIsPatch.equals("true")&&sFlag.equals("Feedback"))?"true":"false","","Button","©������","��������©���ļ�¼","report(4)","","","",""},
	};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">
	//��ʾ��ʷ��Ϣ
	function showHISContent(){
<%-- 		<%
				sTableName = StringFunction.replace(sTableName,"HIS","ECR");
		%> --%>
			popComp("","/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp","sTableName=<%=StringFunction.replace(sTableName,"ECR","HIS")%>&KeyName1=<%=sKeyName1%>&KeyValue1=<%=sKeyValue1%>&KeyName=<%=sMainName%>&KeyValue=<%=sKeyValue%>&TableFlag=HIS&IsQuery=<%=sIsQuery%>&QueryType=<%=sQueryType%>","");         
	}
		
	//---------------------���尴ť�¼�------------------------------------
	//˫����ѡ�еļ�¼
    function openBusinessInfo()
    {
    	var stKeyValue = getItemValue(0,getRow(),"<%=stName.split("@")[0]%>");
    	if(typeof(stKeyValue)=="undefined"||stKeyValue==""){
        	alert("��ѡ��һ�����ݣ�");
			return;
    	}
    	var sReportType = getItemValue(0,getRow(),"REPORTTYPE");
    	<%
    		for(int i=1;i<stName.split("@").length;i++){
    	%>
    			stKeyValue = stKeyValue +  "@" + getItemValue(0,getRow(),"<%=stName.split("@")[i]%>");
    	<%				
    		}
    	%>
    	 popComp("<%=sCompNameInfo%>","<%=sCompPathInfo%>","<%=sParamInfo%>&KeyValue="+stKeyValue+"&ReportType="+sReportType,""); 
    	reloadSelf();
    }	  
	</script>
<%@include file="/ErrorManage/FeedBackManage/FeedBackFunction.jsp"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
