<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "���������б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%

	//�������
	//��ȡҳ�����
	//������Ҫ��sTableName(���ݿ���Ҫ���ҵ��ֶ�),KeyName(Ҫ���ҵı�ҵ��Ĺؼ���),KeyValue(Ҫ���ҵı�ҵ��Ĺؼ��ֵ�ֵ)
	//TableFlag��ʾ������ʾhis��,����ecr��
	//���������Ĳ�����(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	
	String sTableFlag = CurPage.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID == null) sCustomerID = "";
	String sKeyNameMain = CurComp.getParameter("KeyName");
	if(sKeyNameMain == null) sKeyNameMain = "";
	String sKeyValueMain = CurComp.getParameter("KeyValue");
	
	String sIsShow = CurPage.getParameter("IsShow");
	if(sIsShow == null) sIsShow = "";
	
	String sIsPatch = CurComp.getParameter("IsPatch");
	if(sIsPatch == null) sIsPatch = "";
	String sWhereClause = "";
	//�Զ���������д�������������������ֵ�Ķ�Ӧ��ϵ
	if(!sKeyNameMain.equals("")){
		String[] stName = sKeyNameMain.split("@");
		String[] stValue = sKeyValueMain.split("@");
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
				sWhereClause = sWhereClause + " and " + stName[j] + " in (" + sValueStr + ")";
			}else{
				sWhereClause = sWhereClause + " and " +  stName[j] + " ='" + stValue[j] +"'";	
			}
		}
	}
	
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	//��������Դ����SQL����where�Ӿ�
	doTemp.setJboWhere("  CustomerID =: CustomerID" + sWhereClause);

	//��ȡ�ñ�����еĹؼ���
	String[] sKeyName = boManager.getManagedClass().getKeyAttributes();
		String sKeyStr="";
	for(String key: sKeyName){
		sKeyStr += key+"@";
	}

	//���ÿͻ�������������·��
	String sCompNameInfo = "FeedBackCustomerInfo";
	String sCompPathInfo = "/ErrorManage/FeedBackManage/FeedBackCustomer/FeedBackCustomerInfo.jsp";
	//���ò���
	String sParamInfo = "sTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+sKeyStr;
	
	//����˫���¼�
   doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(10);

	dwTemp.genHTMLObjectWindow(sCustomerID);
	
%>

	<%
	//����Ϊ��
	String sButtons[][] = {
			{sIsShow.equals("true")?"true":"false","","Button","�����ϱ�","�ر�������¼","report(2)","","","",""},
			{sIsShow.equals("true")?"false":"true","","Button","�ݲ��ϱ�","�ݲ��ر�������¼","report(3)","","","",""},
			{sIsPatch.equals("true")?"true":"false","","Button","©������","��������©���ļ�¼","report(4)","","","",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script language=javascript>
		
	//---------------------���尴ť�¼�------------------------------------
	//�򿪿ͻ�����ҳ��
    function openCustomerInfo(){
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
