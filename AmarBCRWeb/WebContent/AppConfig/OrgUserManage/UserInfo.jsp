<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		ҳ��˵��: �û���Ϣ����
	 */
	String PG_TITLE = "�û���Ϣ����";
	
	//���ҳ�����	
	String sUserID =  CurPage.getParameter("UserID");
	if(sUserID==null) sUserID="";
	
	//ͨ����ʾģ�����ASDataObject����doTemp
	ASObjectModel doTemp = new ASObjectModel("UserInfo");
	doTemp.appendHTMLStyle("UserID"," onkeyup=\"value=value.replace(/[^0-z]/g,&quot;&quot;) \" onbeforepaste=\"clipboardData.setData(&quot;text&quot;)\" ");
	doTemp.setUnit("BelongOrgName","<input type=button class=inputDate value=\"...\" name=button1 onClick=\"javascript:selectOrg();\"> ");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sUserID);

	String sButtons[][] = {
		{((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","���沢����","�����޸�","saveRecord()","","","",""},
		{"false","","Button","����","���ص��б����","doReturn('Y')","","","",""}		
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		if (!ValidityCheck()) return;
		as_save("myiframe0","doReturn('Y')");
	}
    
    function doReturn(sIsRefresh){
        OpenPage("/AppConfig/OrgUserManage/UserList.jsp","_self","");
	}

    <%/*~[Describe=��������ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;]~*/%>
	function selectOrg(){
		sParaString = "OrgID,"+"<%=CurOrg.getOrgID()%>";
		setObjectValue("SelectBelongOrg",sParaString,"@BelongOrg@0@BelongOrgName@1",0,0,"");
	}
	
	<%/*~[Describe=��Ч�Լ��;ͨ��true,����false;]~*/%>
	function ValidityCheck(){
		//1:У��֤������Ϊ���֤����ʱ���֤ʱ�����������Ƿ�֤ͬ������е�����һ��
		sCertType = getItemValue(0,getRow(),"CertType");//֤������
		sCertID = getItemValue(0,getRow(),"CertID");//֤�����
		sBirthday = getItemValue(0,getRow(),"Birthday");//��������
		if(typeof(sBirthday) != "undefined" && sBirthday != "" ){
			if(sCertType == 'Ind01' || sCertType == 'Ind08'){
				//�����֤�е������Զ�������������,�����֤�е��Ա𸳸��Ա�
				if(sCertID.length == 15){
					sSex = sCertID.substring(14);
					sSex = parseInt(sSex);
					sCertID = sCertID.substring(6,12);
					sCertID = "19"+sCertID.substring(0,2)+"/"+sCertID.substring(2,4)+"/"+sCertID.substring(4,6);
					if(sSex%2==0)//����żŮ
						setItemValue(0,getRow(),"Sex","2");
					else
						setItemValue(0,getRow(),"Sex","1");
				}
				if(sCertID.length == 18){
					sSex = sCertID.substring(16,17);
					sSex = parseInt(sSex);
					sCertID = sCertID.substring(6,14);
					sCertID = sCertID.substring(0,4)+"/"+sCertID.substring(4,6)+"/"+sCertID.substring(6,8);
					if(sSex%2==0)//����żŮ
						setItemValue(0,getRow(),"Sex","2");
					else
						setItemValue(0,getRow(),"Sex","1");
				}
				if(sBirthday != sCertID){
					alert(getMessageText('ALS70200'));//�������ں����֤�еĳ������ڲ�һ�£�	
					return false;
				}
			}
			
			if(sBirthday < '1900/01/01'){
				alert(getMessageText('ALS70201'));//�������ڱ�������1900/01/01��	
				return false;
			}
		}
		
		//2��У�鵥λ�绰
		sCompanyTel = getItemValue(0,getRow(),"CompanyTel");//��λ�绰	
		if(typeof(sCompanyTel) != "undefined" && sCompanyTel != "" ){
			if(!CheckPhoneCode(sCompanyTel)){
				alert(getMessageText('ALS70208'));//��λ�绰����
				return false;
			}
		}
		
		//3��У���ֻ�����
		sMobileTel = getItemValue(0,getRow(),"MobileTel");//�ֻ�����
		if(typeof(sMobileTel) != "undefined" && sMobileTel != "" ){
			if(!CheckPhoneCode(sMobileTel)){
				alert(getMessageText('ALS70204'));//�ֻ���������
				return false;
			}
		}
		
		//4��У���������
		sEmail = getItemValue(0,getRow(),"Email");//��������	
		if(typeof(sEmail) != "undefined" && sEmail != "" ){
			if(!CheckEMail(sEmail)){
				alert(getMessageText('ALS70205'));//������������
				return false;
			}
		}		
		return true;	
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>