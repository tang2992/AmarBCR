<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "���������б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%

	//�������
	//��ȡ�������
	//��ҳ��������ҵ�����ʾ�Ĺ���ҳ��,���ڱ�ϵͳ���е�ҵ���б����ɱ�ҳ�����ɵ�
	//������Ҫ�У�sTableName(���ݿ���Ҫ���ҵ��ֶ�),KeyName(Ҫ���ҵı�ҵ��Ĺؼ���),KeyValue(Ҫ���ҵı�ҵ��Ĺؼ��ֵ�ֵ)
	//TableFlag��ʾ������ʾhis��,����ecr��
	//��������������������QueryType,Query,IsPatch(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
	String sTableName = CurComp.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurComp.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyNameMain = CurComp.getParameter("KeyName");
	if(sKeyNameMain == null) sKeyNameMain = "";
	String sKeyValueMain = CurComp.getParameter("KeyValue");
	if(sKeyValueMain == null) sKeyValueMain = "";
	
	String sIsPatch = CurComp.getParameter("IsPatch");
	if(sIsPatch == null) sIsPatch = "";
	
	//�Զ���������д�������������������ֵ�Ķ�Ӧ��ϵ
	String[] stName = sKeyNameMain.split("@");
	String[] stValue = sKeyValueMain.split("@");
	String sWhereClause = "";
	for(int j=0;j<stName.length;j++){
		//���ڷ�����һ����ͬ�����ݵ�������õĻ�����������
		if(stValue[j].indexOf("-")>0){
			String[] sValue = stValue[j].split("-");
			String sValueStr = "";
			for(int i=0;i<sValue.length;i++){
				if(sValueStr.equals(""))
					sValueStr = sValueStr + "'" + sValue[i] +"'";
				else
					sValueStr = sValueStr + ",'" + sValue[i] +"'";
			}
			sWhereClause = stName[j] + " in (" + sValueStr + ")";
		}else{
			sWhereClause =stName[j] + " ='" + stValue[j] +"'";	
		}
	}
	
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	//���ò�ѯ����where�Ӿ�
    doTemp.setJboWhere(sWhereClause);
	//������������order�Ӿ�
    doTemp.setJboOrder("  OCCURDATE desc ");
    doTemp.setVisible("*", false);
    //����
    doTemp.setVisible("Lcontractno,LoancardNo,Financeid,CustomerName,Startdate,Enddate,Availabstatus,Occurdate,Lduebillno,Putoutamount,Balance,Putoutdate,Putoutenddate,Extenflag,Returntimes,Returndate,Returnmode,Returnsum,Extentimes,Extensum,Extenstartdate,Extenenddate", true);
    doTemp.setVisible("Contractno,Assurecontno,Aloancardno,Assurername,Occurdate,Incrementflag,Createdate,Certid,Availabstatus,Reporttype,Guarantycontno,Guarantyserialno,Pledgorname,Gloancardno,Guarantysum,Impawncontno,Impawserialno,Impawno,Impawnname,Iloancardno,Impawnsum",true);
    //����
    doTemp.setVisible("Factoringno,Customername,Factoringstatus,Businesssum,Businessdate,Guarantyflag,Fduebillno,Tracenumber,Sessionid,Errorcode", true); 
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
	
	//��ȡ���е�����
		String[] sKeyName= boManager.getManagedClass().getKeyAttributes();
	String sKeyStr="";
	for(String key: sKeyName){
		sKeyStr += key+"@";
	}
	
	//������ʾ�������������·��,�Լ����ݵĲ���
	String sCompNameInfo = "FeedBackRelativeInfo";
	String sCompPathInfo = "/ErrorManage/FeedBackManage/FeedBackBusiness/FeedBackRelativeInfo.jsp";
	String sParamInfo = "saTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+sKeyStr;
	
	//����˫��������ҳ��
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:openBusinessInfo()\"");
	
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(10);
	
	dwTemp.genHTMLObjectWindow("");
	
%>

	<%
	//�ӷ���ҳ����ת������ҳ�����ʾ�ر���ذ�ť
	String sButtons[][] = {
			{sIsPatch.equals("true")?"false":"true","","Button","�����ϱ�","�ر�������¼","report(2)","","","",""},
			{sIsPatch.equals("true")?"false":"true","","Button","�ݲ��ϱ�","�ݲ��ر�������¼","report(3)","","","",""},
			{sIsPatch.equals("true")?"false":"true","","Button","©������","��������©���ļ�¼","report(4)","","","",""},
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script language=javascript>
		
	//---------------------���尴ť�¼�------------------------------------
	//˫����ѡ�еļ�¼
    function openBusinessInfo()
    {
    	var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName[0]%>");
    	<%
    		for(int i=1;i<sKeyName.length;i++){
    	%>
    			sKeyValue = sKeyValue +  "@" + getItemValue(0,getRow(),"<%=sKeyName[i]%>");
    	<%				
    		}
    	%>
    	popComp("<%=sCompNameInfo%>","<%=sCompPathInfo%>","<%=sParamInfo%>&KeyValue="+sKeyValue,""); 
    	reloadSelf();
    }	 
 
	</script>
<%@include file="/ErrorManage/FeedBackManage/FeedBackFunction.jsp"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
