<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*��ɫ�б�*/
	//ͨ����ʾģ�����ASDataObject����doTemp
	ASObjectModel doTemp = new ASObjectModel("RoleList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{(CurUser.hasRole("099")?"true":"false"),"","Button","������ɫ","����һ�ֽ�ɫ","newRecord()","","","",""},
		{"true","","Button","����","�鿴��ɫ���","viewAndEdit()","","","",""},
		{(CurUser.hasRole("099")?"true":"false"),"","Button","ɾ��","ɾ���ý�ɫ","deleteRecord()","","","",""},
		{"true","","Button","��ɫ���û�","�鿴�ý�ɫ�����û�","viewUser()","","","",""},
		{"true","","Button","���˵���Ȩ","����ɫ��Ȩ���˵�","my_AddMenu()","","","",""},
		{"true","","Button","���ɫ�˵���Ȩ","�������ɫ��Ȩ���˵�","much_AddMenu()","","","",""},
		{(CurUser.hasRole("099")?"true":"false"),"","Button","�����Ч","ͬ������������ʹ���ݿ�����Ч","reloadCacheRole()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		sReturn=popComp("RoleInfo","/AppConfig/RoleManage/RoleInfo.jsp","","");
		if (typeof(sReturn)!='undefined' && sReturn.length!=0) {
			reloadSelf();
		}
	}
	
	function viewAndEdit(){
		var sRoleID = getItemValue(0,getRow(),"RoleID");
		if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
	
		sReturn=popComp("RoleInfo","/AppConfig/RoleManage/RoleInfo.jsp","RoleID="+sRoleID,"");
		//�޸����ݺ�ˢ���б�
		if (typeof(sReturn)!='undefined' && sReturn.length!=0){
			reloadSelf();
		}
	}
	
	function deleteRecord(){
		var sRoleID = getItemValue(0,getRow(),"RoleID");
		if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		if(confirm(getMessageText("ALS70902"))){ //ɾ���ý�ɫ��ͬʱ��ɾ���ý�ɫ��Ӧ��Ȩ�ޣ�ȷ��ɾ���ý�ɫ��
			as_delete("myiframe0");
		}
	}
	
	<%/*~[Describe=����ɫ��Ȩ���˵�;]~*/%>
	function my_AddMenu(){
		var sRoleID = getItemValue(0,getRow(),"RoleID");
		if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		PopPage("/AppConfig/RoleManage/AddRoleMenu.jsp?RoleID="+sRoleID,"","400px;dialogHeight=540px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;");       	
	}
	
	<%/*[Describe=�����ɫ��Ȩ���˵�;]*/%>
	function much_AddMenu(){
		PopPage("/AppConfig/RoleManage/AddMuchRoleMenus.jsp","","dialogWidth=550px;dialogHeight=600px;center:yes;resizable:yes;scrollbars:no;status:no;help:no");
	}
	
	<%/*[Describe=�鿴�ý�ɫ�����û�;]*/%>
	function viewUser(){
		var sRoleID = getItemValue(0,getRow(),"RoleID");
		if (typeof(sRoleID)=="undefined" || sRoleID.length==0){
			alert(getMessageText('AWEW1001'));//��ѡ��һ����Ϣ��
			return;
		}
//		PopPage("/AppConfig/RoleManage/ViewAllUserList.jsp?RoleID="+sRoleID,"","dialogWidth=700px;dialogHeight=540px;center:yes;resizable:yes;scrollbars:no;status:no;help:no");
		AsControl.PopView("/AppConfig/RoleManage/ViewAllUserList.jsp","RoleID="+sRoleID,"dialogWidth=700px;dialogHeight=540px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}
	
	<%/*~[Describe=��Ч���;]~*/%>
	function reloadCacheRole(){
		AsDebug.reloadCacheAll();
	}		
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>