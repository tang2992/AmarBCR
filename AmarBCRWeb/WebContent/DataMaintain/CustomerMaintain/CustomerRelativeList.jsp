<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "���������б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%

	//�������
	//��ȡҳ�����
    //TableFlag��ʾ������ʾhis��,����ecr��
	//���������Ĳ�����(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurPage.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID == null) sCustomerID = "";
	String sFeedBack = CurPage.getParameter("FeedBack");
	if(sFeedBack == null) sFeedBack = "";
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String sIsQuery = CurComp.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//�ͻ���ϢOrganȡ�ã�����where��������
	String sType = CurComp.getParameter("Type");
	if(sType == null) sType = "";
	
	String sFlag = CurPage.getParameter("sFlag");
	if(sFlag == null) sFlag = "";
	String sIsShow = CurPage.getParameter("IsShow");
	if(sIsShow == null) sIsShow = "";
	
	String sIsPatch = CurComp.getParameter("IsPatch");
	if(sIsPatch == null) sIsPatch = "";
	
	String whereSql ;
	if("organ".equals(sType))
		whereSql = " LSCustomerID=:CustomerID " ;
	else 
		whereSql = " CustomerID =:CustomerID ";
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	String[] sKeyName = boManager.getManagedClass().getKeyAttributes();
	//��ȡ�ñ�����еĹؼ���
	String keyStr = "";
	for(String key: sKeyName){
		keyStr += key+"`";
	}
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(whereSql);
	doTemp.setVisible("*",false);
	doTemp.setColumnFilter("*", false);
	if(sTableName.equals("ECR_CUSTOMERLAW")){
		doTemp.setVisible("Customerid,Lawno,Executedate,Executesum,Occurdate,Incrementflag,Loancardno",true);
		doTemp.setColumnFilter("Lawno", true);
	}else if(sTableName.equals("ECR_CUSTOMERFACT")){
		doTemp.setVisible("Customerid,Factno,Occurdate,Incrementflag,Loancardno",true);
		doTemp.setColumnFilter("Factno", true);
	}else{
		doTemp.setVisible("Customerid,CUSTOMERNAME,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE,AUDITFIRM,AUDITOR,AUDITDATE,Incrementflag",true);
		doTemp.setColumnFilter("REPORTYEAR,REPORTTYPE,REPORTSUBTYPE", true);
	}
	doTemp.setDDDWJbo("REPORTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7507'");
	doTemp.setDDDWJbo("REPORTSUBTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7651'");
	doTemp.setDDDWCodeTable("Incrementflag", "1,����,2,����,8,��Ǩ��");
	//���ÿͻ�������������·��
	String sCompNameInfo = "CustomerRelativeInfo";
	String sCompPathInfo = "/DataMaintain/CustomerMaintain/CustomerRelativeInfo.jsp";
	//���ò���
	String sParamInfo = "sTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+keyStr;
	
	//����˫���¼�
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:openCustomerInfo()\"");
	//����datawindow
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
    dwTemp.setPageSize(20);

    dwTemp.genHTMLObjectWindow(sCustomerID);
    
	String sButtons[][] = {
			{"true","","Button","����","�鿴/�޸�����","openCustomerInfo()","","","","btn_icon_detail",""},
			{(sTableFlag.equals("HIS")||sFlag.equals("Feedback"))?"false":"true","","Button","�鿴��ʷ��¼","�鿴��ʷ��¼","showHISContent()","","","","",""},
			{sFlag.equals("Feedback")?"true":"false","","Button","�����ϱ�","�ر�������¼","report(2)","","","",""},
			{sFlag.equals("Feedback")?"true":"false","","Button","�ݲ��ϱ�","�ݲ��ر�������¼","report(3)","","","",""},
			{sFlag.equals("Feedback")?"true":"false","","Button","©������","��������©���ļ�¼","report(4)","","","",""},
		};
	%> 

	<%@ include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">
	//�鿴��ʷ��¼
	 function showHISContent(){
		 var sTableName="<%=sTableName%>";
		 sTableName=sTableName.replace("ECR","HIS");
		 var sParamInfo="sTableName="+sTableName+"&CustomerID=<%=sCustomerID%>&TableFlag=HIS&IsQuery=<%=sIsQuery%>";
	    AsControl.OpenView("/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp",sParamInfo,"_blank");	      
	 }
    var sCurCodeNo=""; //��¼��ǰ��ѡ���еĴ����
		
	//---------------------���尴ť�¼�------------------------------------
	//�򿪿ͻ�����ҳ��
    function openCustomerInfo(){
    	var keys = "<%=keyStr.substring(0, keyStr.length()-1)%>";
    	var keyArr = keys.split("`");
    	var values = "";
    	for(var k_i=0; k_i<keyArr.length; k_i++){
    		values = values+getItemValue(0,getRow(), keyArr[k_i])+"`";
    	}
    	var sParamInfo="sTableName=<%=sTableName%>&CustomerID=<%=sCustomerID%>&TableFlag=HIS&IsQuery=<%=sIsQuery%>";
    	values = values.substring(0, values.length-1);
    	var keyValue = keys+"~"+values;
    	var value = getItemValue(0,getRow(), keyArr[0]);
    	if(typeof(value)=="undefined" || value==null || value=="" || value=="undefined"){
			alert("��ѡ��һ����¼!");
			return;
		}
    	AsControl.PopView("<%=sCompPathInfo%>", "<%=sParamInfo%>&KeyValue="+keyValue, "");
    }	   
	</script>
<%@include file="/ErrorManage/FeedBackManage/FeedBackFunction.jsp"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
