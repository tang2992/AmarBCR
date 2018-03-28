<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		页面说明: 用户信息详情
	 */
	String PG_TITLE = "用户信息详情";
	
	//获得页面参数	
	String sUserID =  CurPage.getParameter("UserID");
	if(sUserID==null) sUserID="";
	
	//通过显示模版产生ASDataObject对象doTemp
	ASObjectModel doTemp = new ASObjectModel("UserInfo");
	doTemp.appendHTMLStyle("UserID"," onkeyup=\"value=value.replace(/[^0-z]/g,&quot;&quot;) \" onbeforepaste=\"clipboardData.setData(&quot;text&quot;)\" ");
	doTemp.setUnit("BelongOrgName","<input type=button class=inputDate value=\"...\" name=button1 onClick=\"javascript:selectOrg();\"> ");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sUserID);

	String sButtons[][] = {
		{((CurUser.hasRole("099") || CurUser.hasRole("299"))?"true":"false"),"","Button","保存并返回","保存修改","saveRecord()","","","",""},
		{"false","","Button","返回","返回到列表界面","doReturn('Y')","","","",""}		
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

    <%/*~[Describe=弹出机构选择窗口，并置将返回的值设置到指定的域;]~*/%>
	function selectOrg(){
		sParaString = "OrgID,"+"<%=CurOrg.getOrgID()%>";
		setObjectValue("SelectBelongOrg",sParaString,"@BelongOrg@0@BelongOrgName@1",0,0,"");
	}
	
	<%/*~[Describe=有效性检查;通过true,否则false;]~*/%>
	function ValidityCheck(){
		//1:校验证件类型为身份证或临时身份证时，出生日期是否同证件编号中的日期一致
		sCertType = getItemValue(0,getRow(),"CertType");//证件类型
		sCertID = getItemValue(0,getRow(),"CertID");//证件编号
		sBirthday = getItemValue(0,getRow(),"Birthday");//出生日期
		if(typeof(sBirthday) != "undefined" && sBirthday != "" ){
			if(sCertType == 'Ind01' || sCertType == 'Ind08'){
				//将身份证中的日期自动赋给出生日期,把身份证中的性别赋给性别
				if(sCertID.length == 15){
					sSex = sCertID.substring(14);
					sSex = parseInt(sSex);
					sCertID = sCertID.substring(6,12);
					sCertID = "19"+sCertID.substring(0,2)+"/"+sCertID.substring(2,4)+"/"+sCertID.substring(4,6);
					if(sSex%2==0)//奇男偶女
						setItemValue(0,getRow(),"Sex","2");
					else
						setItemValue(0,getRow(),"Sex","1");
				}
				if(sCertID.length == 18){
					sSex = sCertID.substring(16,17);
					sSex = parseInt(sSex);
					sCertID = sCertID.substring(6,14);
					sCertID = sCertID.substring(0,4)+"/"+sCertID.substring(4,6)+"/"+sCertID.substring(6,8);
					if(sSex%2==0)//奇男偶女
						setItemValue(0,getRow(),"Sex","2");
					else
						setItemValue(0,getRow(),"Sex","1");
				}
				if(sBirthday != sCertID){
					alert(getMessageText('ALS70200'));//出生日期和身份证中的出生日期不一致！	
					return false;
				}
			}
			
			if(sBirthday < '1900/01/01'){
				alert(getMessageText('ALS70201'));//出生日期必须晚于1900/01/01！	
				return false;
			}
		}
		
		//2：校验单位电话
		sCompanyTel = getItemValue(0,getRow(),"CompanyTel");//单位电话	
		if(typeof(sCompanyTel) != "undefined" && sCompanyTel != "" ){
			if(!CheckPhoneCode(sCompanyTel)){
				alert(getMessageText('ALS70208'));//单位电话有误！
				return false;
			}
		}
		
		//3：校验手机号码
		sMobileTel = getItemValue(0,getRow(),"MobileTel");//手机号码
		if(typeof(sMobileTel) != "undefined" && sMobileTel != "" ){
			if(!CheckPhoneCode(sMobileTel)){
				alert(getMessageText('ALS70204'));//手机号码有误！
				return false;
			}
		}
		
		//4：校验电子邮箱
		sEmail = getItemValue(0,getRow(),"Email");//电子邮箱	
		if(typeof(sEmail) != "undefined" && sEmail != "" ){
			if(!CheckEMail(sEmail)){
				alert(getMessageText('ALS70205'));//电子邮箱有误！
				return false;
			}
		}		
		return true;	
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>