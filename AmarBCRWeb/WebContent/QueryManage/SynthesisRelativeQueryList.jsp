<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: ҵ����������б�-��ѯδ����
		Input Param:
		Output param:
		History Log: 
            
	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List01;Describe=����ҳ������;]~*/%>
	<%
		String PG_TITLE = "���������б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List02;Describe=�����������ȡ����;]~*/%>
<%

	//�������
	//��ȡ�������
	String sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("MetaTableName"));
	if(sMetaTableName == null) sMetaTableName = "";
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("DBTableName"));
	if(sDBTableName == null) sDBTableName = "";
	String sTableFlag = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("TableFlag"));
	if(sTableFlag == null) sTableFlag = "";
	String sParam = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("Param"));
	if(sParam == null) sParam = "";

	String[]  sCondition = sParam.split("@");
	String sWhereClause = " where 1=1 ";
	for(int j=0;j<sCondition.length;j++){
			sWhereClause = sWhereClause + " and " +  sCondition[j] ;	
	}
	//��ȡҳ�����
	
%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
	ECRDataWindowXml ecrDWX = new ECRDataWindowXml(sMetaTableName,sDBTableName,sTableFlag);
	//2.����Դ����SQL���
	ecrDWX.setWhereSql(sWhereClause);
	ecrDWX.setOrderSql(" ORDER BY Occurdate DESC");
	//3.����ASDataObject����
	ASDataObject doTemp =  ecrDWX.generateASDataObject("List");
	
	String[] sKeyName = ecrDWX.getKeyName();
	String sKeyStr =  sKeyName[0];
	for(int i=1;i<sKeyName.length;i++){
		sKeyStr = sKeyStr +"@" + sKeyName[i];
	}
	
	String sCompNameInfo = "BusinessRelativeInfo";
	String sCompPathInfo = "/DataMaintain/BusinessMaintain/BusinessRelativeInfo.jsp";
	String sParamInfo = "MetaTableName="+sMetaTableName+"&DBTableName="+sDBTableName+"&TableFlag="+sTableFlag+"&KeyName="+sKeyStr;
	
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:parent.openBusinessInfo();\"";
	doTemp.appendHTMLStyle("",sStyle);
	 
    ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	
	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
%>

<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List04;Describe=���尴ť;]~*/%>
	<%
	//����Ϊ��
	String sButtons[][] = {
		};
	%> 
<%/*~END~*/%>


<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=List05;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
	<script language=javascript>
    var sCurCodeNo=""; //��¼��ǰ��ѡ���еĴ����
		
	//---------------------���尴ť�¼�------------------------------------
	
    function openBusinessInfo()
    {
		//˫����ѡ�еļ�¼
    	var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName[0]%>");
    	<%
    		for(int i=1;i<sKeyName.length;i++){
    	%>
    			sKeyValue = sKeyValue +  "@" + getItemValue(0,getRow(),"<%=sKeyName[i]%>");
    	<%				
    		}
    	%>
    	popComp("<%=sCompNameInfo%>","<%=sCompPathInfo%>","<%=sParamInfo%>&KeyValue="+sKeyValue+"&IsQuery=true","");          
    	reloadSelf();
    }	 
   
	</script>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List07;Describe=ҳ��װ��ʱ�����г�ʼ��;]~*/%>
<script language=javascript>	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>
