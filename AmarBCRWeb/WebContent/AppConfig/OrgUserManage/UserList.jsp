<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		ҳ��˵��: �û������б�
	 */
	String PG_TITLE = "�û������б�"; // ��������ڱ��� <title> PG_TITLE </title>
	
	//��ȡ�������
	String sOrgID = CurPage.getParameter("OrgID");
	if(sOrgID == null) sOrgID = "";
	String sSortNo = (new ASOrg(sOrgID, Sqlca)).getSortNo();
	if(sSortNo==null) sSortNo="";
	
	//ͨ����ʾģ�����ASDataObject����doTemp
	ASObjectModel doTemp = new ASObjectModel("UserList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
    dwTemp.setPageSize(20);
	
	//����HTMLDataWindow
	dwTemp.genHTMLObjectWindow(sSortNo+"%");
	
	String sButtons[][] = {
            {((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","����","�ڵ�ǰ������������Ա","my_add()","","","",""},			
			{"false","","Button","����","������Ա����ǰ����","my_import()","","","",""},
            {((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","ͣ��","�ӵ�ǰ������ɾ������Ա","my_disable()","","","",""},
            {((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","����","�ӵ�ǰ���������ø���Ա","my_enable()","","","",""},
            {"true","","Button","����","�鿴�û�����","viewAndEdit()","","","",""},
            {"true","","Button","�û���Դ","�鿴�û���Ȩ��Դ","viewResources()","","","",""},
            {((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","�û���ɫ","�鿴�����޸���Ա��ɫ","viewAndEditRole()","","","",""},
            {((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","�������½�ɫ","�������½�ɫ","my_Addrole()","","","",""},
			{((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","���û����½�ɫ","���û����½�ɫ","MuchAddrole()","","","",""},
            {((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","ת��","ת����Ա����������","UserChange()","","","",""},                       
            {((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","��ʼ����","��ʼ�����û�����","ClearPassword()","","","",""}            
        };
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function my_add(){
		OpenPage("/AppConfig/OrgUserManage/UserInfo.jsp","_self","");
	}
	
	function viewAndEdit(){
		var sUserID = getItemValue(0,getRow(),"UserID");
		if (typeof(sUserID)=="undefined" || sUserID.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}else{
			OpenPage("/AppConfig/OrgUserManage/UserInfo.jsp?UserID="+sUserID,"_self","");
		}
	}
	
	/*~[Describe=�鿴�û���Ȩ��Դ;InputParam=��;OutPutParam=��;]~*/
	function viewResources(){
		var sUserID = getItemValue(0,getRow(),"UserID");
		if(typeof(sUserID)=="undefined" || sUserID.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}else{
			AsControl.PopView("/AppConfig/OrgUserManage/ViewUserResources.jsp","UserID="+sUserID,"");
		}
	}

	<%/*~[Describe=�鿴�����޸���Ա��ɫ;]~*/%>
	function viewAndEditRole(){
        var sUserID=getItemValue(0,getRow(),"UserID");
        if(typeof(sUserID)=="undefined" ||sUserID.length==0){
            alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
        }else{
        	var sStatus=getItemValue(0,getRow(),"Status");
        	if(sStatus!="1")
        		alert(sUserID+"�������û����޷��鿴�û���ɫ��");
        	else
            	sReturn=popComp("UserRoleList","/AppConfig/OrgUserManage/UserRoleList.jsp","UserID="+sUserID,"");
        }    
    }
    
    <%/*~[Describe=�������½�ɫ;]~*/%>    
    function my_Addrole(){
	    var sUserID=getItemValue(0,getRow(),"UserID");
 		if(typeof(sUserID)=="undefined" ||sUserID.length==0){
		    alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
    	}else{
        	var sStatus=getItemValue(0,getRow(),"Status");
        	if(sStatus!="1")
        		alert(sUserID+"�������û����޷��������½�ɫ��");
        	else
        		PopPage("/AppConfig/OrgUserManage/AddUserRole.jsp?UserID="+sUserID,"","dialogWidth=550px;dialogHeight=350px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;");       	
    	}
	}
	
	<%/*~[Describe=���û����½�ɫ;]~*/%>
	function MuchAddrole(){
		var sUserID=getItemValue(0,getRow(),"UserID");
 		if(typeof(sUserID)=="undefined" ||sUserID.length==0){ 
		    alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
    	}else{
    		var sStatus=getItemValue(0,getRow(),"Status");
        	if(sStatus!="1")
        		alert(sUserID+"�������û����޷����û����½�ɫ��");
        	else
        		PopPage("/AppConfig/OrgUserManage/AddMuchUserRole.jsp?UserID="+sUserID,"","dialogWidth=550px;dialogHeight=600px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;");       	
		}
	}

	<%/*~[Describe=ת����Ա����������;]~*/%>
	function UserChange(){
        var sUserID = getItemValue(0,getRow(),"UserID");
        var sFromOrgID = getItemValue(0,getRow(),"BelongOrg");
        var sFromOrgName = getItemValue(0,getRow(),"BelongOrgName");
        if(typeof(sUserID)=="undefined" ||sUserID.length==0){
            alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
        }else{
            //��ȡ��ǰ�û�
			sOrgID = "<%=CurOrg.getOrgID()%>";
			sParaStr = "OrgID,"+sOrgID;
			sOrgInfo = setObjectValue("SelectBelongOrg",sParaStr,"",0,0);	
		    if(sOrgInfo == "" || sOrgInfo == "_CANCEL_" || sOrgInfo == "_NONE_" || sOrgInfo == "_CLEAR_" || typeof(sOrgInfo) == "undefined"){
			    if( typeof(sOrgInfo) != "undefined"&&sOrgInfo != "_CLEAR_")alert(getMessageText('ALS70953'));//��ѡ��ת�ƺ�Ļ�����
			    return;
		    }else{
			    sOrgInfo = sOrgInfo.split('@');
			    sToOrgID = sOrgInfo[0];
			    sToOrgName = sOrgInfo[1];
			    
			    if(sFromOrgID == sToOrgID){
					alert(getMessageText('ALS70954'));//��������Աת����ͬһ�����н��У�������ѡ��ת�ƺ������
					return;
				}
				//����ҳ�����
				sReturn = AsControl.RunJsp("/AppConfig/OrgUserManage/UserShiftActionAjax.jsp","UserID="+sUserID+"&FromOrgID="+sFromOrgID+"&FromOrgName="+sFromOrgName+"&ToOrgID="+sToOrgID+"&ToOrgName="+sToOrgName); 
				if(sReturn == "TRUE"){
	                alert(getMessageText("ALS70914"));//��Աת�Ƴɹ���
	                reloadSelf();           	
	            }else if(sReturn == "FALSE"){
	                alert(getMessageText("ALS70915"));//��Աת��ʧ�ܣ�
	            }
			}
		}
	}
	
	<%/*~[Describe=������Ա����ǰ����;]~*/%>
	function my_import(){
       sParaString = "BelongOrg"+","+"<%=sOrgID%>";		
		sUserInfo = setObjectValue("SelectImportUser",sParaString,"",0,0,"");
		if(typeof(sUserInfo) != "undefined" && sUserInfo != "" && sUserInfo != "_NONE_" && sUserInfo != "_CANCEL_" && sUserInfo != "_CLEAR_"){
       		sInfo = sUserInfo.split("@");
	        sUserID = sInfo[0];
	        sUserName = sInfo[1];
	        if(typeof(sUserID) != "undefined" && sUserID != ""){
	        	if(confirm(getMessageText("ALS70912"))){ //��ȷ������ѡ��Ա���뵽����������
        			var sReturn = RunJavaMethodSqlca("com.amarsoft.app.awe.config.orguser.action.UserManageAction","addUser","UserID="+sUserID+",OrgID=<%=sOrgID%>");
					if(sReturn == "SUCCESS"){
		        		alert(getMessageText("ALS70913"));//��Ա����ɹ���
		        		reloadSelf();
	        		}
	        	}else{
	        		alert(getMessageText("ALS70915")); //��Աת��ʧ��!
	        	}
	        }
       	}
	}

	<%/*~[Describe=�ӵ�ǰ������ɾ������Ա;]~*/%>
	function my_disable(){
		var sUserID = getItemValue(0,getRow(),"UserID");
		if(typeof(sUserID) == "undefined" || sUserID.length == 0){
			alert(getMessageText('AWEW1001'));//��ѡ��һ����Ϣ��
		}else if(confirm("�������ͣ�ø��û���")){
            var sReturn = RunJavaMethodSqlca("com.amarsoft.app.awe.config.orguser.action.UserManageAction","disableUser","UserID="+sUserID);
            if(sReturn == "SUCCESS"){
			    alert("��Ϣͣ�óɹ���");
			    reloadSelf();
			}
		}
	}

	<%/*~[Describe=�����û�;]~*/%>
	function my_enable(){
		var sUserID = getItemValue(0,getRow(),"UserID");
		if(typeof(sUserID) == "undefined" || sUserID.length == 0){
			alert(getMessageText('AWEW1001'));//��ѡ��һ����Ϣ��
		}else if(confirm("����������ø��û���")){
            var sReturn = RunJavaMethodSqlca("com.amarsoft.app.awe.config.orguser.action.UserManageAction","enableUser","UserID="+sUserID);
            if(sReturn == "SUCCESS"){
			    alert("��Ϣ���óɹ���");
			    reloadSelf();
			}
		}
	}
	
	<%/*~[Describe=��ʼ���û�����;]~*/%>
	function ClearPassword(){
        var sUserID = getItemValue(0,getRow(),"UserID");
        var sInitPwd = "000000bcr";
        if (typeof(sUserID)=="undefined" || sUserID.length==0){
		    alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}else if(confirm(getMessageText("ALS70916"))){ //��ȷ��Ҫ��ʼ�����û���������
		    var sReturn = RunJavaMethodTrans("com.amarsoft.app.awe.config.orguser.action.ClearPasswordAction","initPWD","UserId="+sUserID+",InitPwd="+sInitPwd);
			if(sReturn == "SUCCESS"){
			    alert(getMessageText("ALS70917"));//�û������ʼ���ɹ���
			    reloadSelf();
			}else{
				alert("�û������ʼ���ɹ���");
			}
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>