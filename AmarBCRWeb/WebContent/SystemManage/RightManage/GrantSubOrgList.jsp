<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: ���������б�
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
	int iLevel  = 0;
	String sOrgID = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("OrgID"));
	if(sOrgID == null) sOrgID = "";
	String sUserID = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("UserID"));
	if(sUserID == null) sUserID = "";
	String sSortNo = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("SortNo"));
	if(sSortNo == null) sSortNo = "";
	
	String sSortNoLength = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("SortNoLength"));
	if(sSortNoLength == null) sSortNoLength = "";
	
	String[] sSortLevel = sSortNoLength.split("@");
	
	for(int i=0;i<sSortLevel.length;i++){
		if(sSortLevel[i].equals(""+sSortNo.length())){
			iLevel = i;
			break;
		}
	}
	
	//��ȡҳ�����
	
%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
	String sHeaders[][] = {
		                  {"OrgID","��������"},
		                  {"OrgName","��������"},
			              {"BankID","���б��"},
			              {"Status","״̬"},
			              {"SortNo","���������"}
	                       };

	String sSql = " select OrgID,OrgName,BankID,Status,SortNo from ORG_INFO where  SortNO like '"+sSortNo+"%' ";
	if(iLevel<sSortLevel.length-1)
		sSql = sSql + " and  length(SortNo)="+sSortLevel[iLevel+1]+" order by OrgID";
	else 
		sSql = sSql + " and  length(SortNo)="+sSortLevel[iLevel]+1+" order by OrgID";

	ASDataObject doTemp = new ASDataObject(sSql);
	doTemp.setHeader(sHeaders);	
	doTemp.UpdateTable="ORG_INFO";
	doTemp.setKey("OrgID",true);
	doTemp.setVisible("SortNo",false);
	
	//���ö�Ӧ��ϵ
	doTemp.setDDDWSql("Status","select ItemNo,ItemName from CODE_LIBRARY where CodeNo='IsInUse'");
    ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
    dwTemp.setPageSize(200);

	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
%>

<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List04;Describe=���尴ť;]~*/%>
	<%
	//����Ϊ��
	String sButtons[][] = {
		{"true","","Button","������������","���û���","relativeRole()",sResourcesPath},
		{"true","","Button","�ǹ�����������","���û���","noRelativeRole()",sResourcesPath},
		{"true","","Button","ȡ����Ȩ","ȡ����Ȩ","deleteRole()",sResourcesPath}
	};
	%> 
<%/*~END~*/%>


<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=List05;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
	<script language=javascript>
	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=���ø��û��Ĺ�Ͻ����������������;InputParam=��;OutPutParam=��;]~*/
	function relativeRole()
    {
        sOrgID=getItemValue(0,getRow(),"OrgID");
        sSortNo=getItemValue(0,getRow(),"SortNo");
        sBankID=getItemValue(0,getRow(),"BankID");
        if(typeof(sOrgID)=="undefined" ||sOrgID.length==0)
        { 
            alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
        }else
        {
            if(confirm("�Ƿ�����¼�����?")){
               	var sResult = "insert_relative";
          		popComp("SaveOperOrg","/SystemManage/RightManage/SaveOperOrg.jsp","UserID=<%=sUserID%>&OrgID="+sOrgID+"&BankID="+sBankID+"&SortNo="+sSortNo+"&Result="+sResult,"");
          		alert("���ù�Ͻ�����ɹ���");
            }
        }    
    }
	/*~[Describe=���ø��û��Ĺ�Ͻ��������������������;InputParam=��;OutPutParam=��;]~*/
	function noRelativeRole()
    {
        sOrgID=getItemValue(0,getRow(),"OrgID");
        sSortNo=getItemValue(0,getRow(),"SortNo");
        sBankID=getItemValue(0,getRow(),"BankID");
        
        if(typeof(sOrgID)=="undefined" ||sOrgID.length==0)
        { 
            alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
        }else
        {
            if(confirm("ֻ���ñ����������漰�����¼�����?")){
            	var sResult = "insert_no_relative";
          		popComp("SaveOperOrg","/SystemManage/RightManage/SaveOperOrg.jsp","UserID=<%=sUserID%>&OrgID="+sOrgID+"&BankID="+sBankID+"&SortNo="+sSortNo+"&Result="+sResult,"");
          		alert("���ù�Ͻ�����ɹ���");
            }
        }    
    }
	/*~[Describe=ɾ�����û��Ĺ�Ͻ����;InputParam=��;OutPutParam=��;]~*/
	function deleteRole()
    {
        sOrgID=getItemValue(0,getRow(),"OrgID");
        sSortNo=getItemValue(0,getRow(),"SortNo");
        
        if(typeof(sOrgID)=="undefined" ||sOrgID.length==0)
        { 
            alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
        }else
        {
        	if(confirm("�Ƿ��Ƿ�ɾ�����û��ù�Ͻ������")){
            	var sResult = "delete";
          	  	popComp("SaveOperOrg","/SystemManage/RightManage/SaveOperOrg.jsp","UserID=<%=sUserID%>&OrgID="+sOrgID+"&SortNo="+sSortNo+"&Result="+sResult,"");
          	 	alert("ɾ����Ͻ�����ɹ���");
            }
        }    
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
