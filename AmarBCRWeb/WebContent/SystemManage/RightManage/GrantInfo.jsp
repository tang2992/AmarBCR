<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content: ��Ȩ����б�ҳ��
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "��Ȩ����б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%/*~END~*/%>
<%
	String sUserID =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("UserID"));
	
	if(sUserID==null) sUserID="";

 %>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
	String sSql;
	String sHeaders[][] = {
						   {"OrgID","����"},
						   {"OrgName","��������"},
					       {"Status","״̬"}
						  };
	sSql = "Select OrgID,getOrgName(OrgID) as OrgName,Status from USER_ORG where userID='"+sUserID+"' order BY ORGID";
	       
	ASDataObject doTemp = new ASDataObject(sSql);
	doTemp.setHeader(sHeaders);
	
	doTemp.UpdateTable = "USER_ORG";
	doTemp.setKey("OrgID",true);
	doTemp.setVisible("OrgID",false);
	doTemp.setUpdateable("OrgName",false);
	
	doTemp.setDDDWSql("Status","select ItemNo,ItemName from CODE_LIBRARY where CodeNo='IsInUse'");
	
	ASDataWindow dwTemp = new ASDataWindow(CurPage ,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);

	//��������¼�
	
	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("%");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List04;Describe=���尴ť;]~*/%>
	<%
	//����Ϊ��
		//0.�Ƿ���ʾ
		//1.ע��Ŀ�������(Ϊ�����Զ�ȡ��ǰ���)
		//2.����(Button/ButtonWithNoAction/HyperLinkText/TreeviewItem/PlainText/Blank)
		//3.��ť����
		//4.˵������
		//5.�¼�
		//6.��ԴͼƬ·��
	String sButtons[][] = {
		{"true","","Button","ɾ��","ȡ����Ȩ�û���","cancleGrant()",sResourcesPath},
		{"true","","Button","����","����","goBack()",sResourcesPath}
		};
	%> 
<%/*~END~*/%>

<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=List05;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
	<script language=javascript>

	//---------------------���尴ť�¼�------------------------------------
	function grant()
	{
		popComp("GrantOrgMain","/SystemManage/RightManage/GrantOrgMain.jsp","UserID="+"<%=sUserID%>","");
		reloadSelf();
	}
	function cancleGrant()
	{
		sOrgID = getItemValue(0,getRow(),"OrgID");
		
		if (typeof(sOrgID)=="undefined" || sOrgID.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		
		if(confirm("�������ɾ������Ϣ��")) 
		{
			as_del("myiframe0");
			as_save("myiframe0");  //�������ɾ������Ҫ���ô����
		}
		
	}
	function goBack()
	{
		self.close();
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
