<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content: ��ɫ����ҳ��
		Input Param:
		Output param:
		History Log:

	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "��ɫ�б�"; // ��������ڱ���
	%>
<%/*~END~*/%>




<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List02;Describe=�����������ȡ����;]~*/%>
<%

	//�������
	
	//��ȡ�������
	
	//��ȡҳ�����
    
%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	

	//ͨ����ʾģ�����ASDataObject����doTemp
	String sSql;
	String sHeaders[][] = {
						   {"ROLEID","��ҵ���"},
						   {"ROLENAME","���ü�¼��Χ"},
		                   {"ROLEATTRIBUTE","����ԭ��"},
					       {"ROLEDESCRIBE","����ʱ��"},
					       {"ROLESTATUS","������"},
					       {"INPUTUSER","��ע"}
						  };
	sSql = "select ROLEID,ROLENAME,ROLEATTRIBUTE,ROLEDESCRIBE,ROLESTATUS,INPUTUSER from AWE_ROLE_INFO where 1=1 order by ROLEID ";
	       
	ASDataObject doTemp = new ASDataObject(sSql);

	//���ӹ�����	
	doTemp.setColumnAttribute("RoleID,RoleName","IsFilter","1");
	doTemp.generateFilters(Sqlca);
	doTemp.parseFilterData(request,iPostChange);
	CurPage.setAttribute("FilterHTML",doTemp.getFilterHtml(Sqlca));

	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(200);

	//��������¼�
	dwTemp.setEvent("BeforeDelete","!GrantRight.DelRoleRight(#RoleID)");
	
	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
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
	String sButtons[][] = 
	{
		{"true","","Button","������ɫ","����һ�ֽ�ɫ","newRecord()",sResourcesPath},
		{"true","","Button","��ɫȨ��","�鿴���޸Ľ�ɫȨ��","viewAndEditRight()",sResourcesPath},
		{"true","","Button","����","�鿴�������","viewAndEdit()",sResourcesPath},
		{"true","","Button","ɾ��","ɾ���ý�ɫ","deleteRecord()",sResourcesPath},
		{"true","","Button","���˵���Ȩ","����ɫ��Ȩ���˵�","my_AddMenu()",sResourcesPath},
		{"true","","Button","�����Ч","ͬ������������ʹ���ݿ�����Ч","reloadCacheRole()",sResourcesPath},
	};
        
	
	%>
<%/*~END~*/%>

<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=List05;Describe=����ҳ��;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
	<script language=javascript>

		/*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/
		function newRecord(){
			popComp("RoleInfo","/SystemManage/RoleManage/RoleInfo.jsp","","");
			reloadSelf();
		
		}

		/*~[Describe=�鿴���޸�����;InputParam=��;OutPutParam=��;]~*/
		function viewAndEdit(){
			sRoleID   = getItemValue(0,getRow(),"ROLEID");
			if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
				alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
				return;
			}
			sReturn=popComp("RoleInfo","/SystemManage/RoleManage/RoleInfo.jsp","RoleID="+sRoleID,"");
			//�޸����ݺ�ˢ���б�
			if (typeof(sReturn)!='undefined' && sReturn.length!=0){
				reloadSelf();
			}
		}
    
		/*~[Describe=�ӵ�ǰ��ɫ;InputParam=��;OutPutParam=��;]~*/
		function deleteRecord(){   
			sRoleID = getItemValue(0,getRow(),"ROLEID");
			if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
				alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
				return;
			}
			if(confirm("ɾ���ý�ɫ��ͬʱ��ɾ���ý�ɫ��Ӧ��Ȩ�ޣ�ȷ��ɾ���ý�ɫ��")) 
			{
				as_del("myiframe0");
				as_save("myiframe0");  //�������ɾ������Ҫ���ô����
			}
		}
		/*~[Describe=����ɫ��Ȩ���˵�;InputParam=��;OutPutParam=��;]~*/
		function my_AddMenu(){
			sRoleID   = getItemValue(0,getRow(),"ROLEID");
			if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
				alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
				return;
			}

			PopPage("/SystemManage/RoleManage/AddRoleMenu.jsp?RoleID="+sRoleID,"","dialogWidth=36;dialogHeight=22;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;");       	
		}
	
    	/*~[Describe=�鿴�����޸���ԱȨ��;InputParam=��;OutPutParam=��;]~*/
		function viewAndEditRight(){
			sRoleID=getItemValue(0,getRow(),"ROLEID");
			if(typeof(sRoleID)=="undefined" ||sRoleID.length==0){ 
				alert(getHtmlMessage('1'));
			}
			else{
				popComp("RoleRightConfig","/SystemManage/RoleManage/RightView.jsp","RoleID="+sRoleID,"","");
			}    
		}

		/*~[Describe=��Ч���;InputParam=��;OutPutParam=��;]~*/
		function reloadCacheRole(){
			var sReturn = PopPage("/Common/ToolsB/reloadCacheConfig.jsp?ConfigName=<%=ASConfigure.SYSCONFIG_ROLE%>","","dialogWidth=15;dialogHeight=8;center:yes;status:no;statusbar:no");
			if (typeof(sReturn)== 'undefined' || sReturn.length == 0) {
				alert(getBusinessMessage("903"));//ϵͳ������֪ͨ����Ա��
			}
			else if (sReturn == 1) {
				alert(getBusinessMessage("904"));//����ͬ���ɹ���
			}
			else if (sReturn == 2) {
				alert(getBusinessMessage("905"));//ͬ��ʧ�ܣ�����ԭ�������ԣ�
			}
		}
	</script>
<%/*~END~*/%>




<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
	<script language=javascript>
	function mySelectRow(){     
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
