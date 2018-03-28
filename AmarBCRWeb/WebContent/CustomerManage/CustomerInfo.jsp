<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content: --企业客户概况
	 */
	//获得组件参数,客户代码
    String sCustomerID =  CurPage.getParameter("CustomerID");
	if(sCustomerID == null) sCustomerID = "";
	
	//定义变量
    String sToday = StringFunction.getToday();
	String sCertType = "";
    ASResultSet rs = Sqlca.getASResultSet("select CustomerType,CertType from CUSTOMER_INFO where CustomerID = '"+sCustomerID+"' ");
	if(rs.next()){
		sCertType = rs.getString("CertType");
	}
	rs.getStatement().close();
	if(sCertType == null) sCertType = "";
	
	//通过显示模版产生ASDataObject对象doTemp
	ASObjectModel doTemp = new ASObjectModel("EnterpriseInfo01");
	//如果证件类型是营业执照，则隐藏证件号码字段
	if(sCertType.equals("Ent02")){
		doTemp.setVisible("CorpID",false);
		doTemp.setReadOnly("LicenseNo",true);
	}
	//改用验证规则 见显示模板的验证规则配置
	//设置注册资本范围
	//doTemp.appendHTMLStyle("RegisterCapital"," myvalid=\"parseFloat(myobj.value,10)>=0 \" mymsg=\"注册资本必须大于等于0！\" ");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request); 
	dwTemp.Style = "2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sCustomerID);
	
	String sButtons[][] = {
		{"true","All","Button","保存","保存所有修改","saveRecord()","","","",""},
		{"true","All","Button","暂存","暂时保存所有修改","saveRecordTemp()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	/*~[Describe=保存;InputParam=后续事件;OutPutParam=无;]~*/
	function saveRecord(sPostEvents){
		//录入数据有效性检查
		if (!ValidityCheck()) return;
		setItemValue(0,0,"TempSaveFlag","2");//暂存标志（1：是；2：否）
		as_save("myiframe0",sPostEvents);	
	}
		
	function saveRecordTemp(){
		setItemValue(0,0,"TempSaveFlag","1");//暂存标志（1：是；2：否）
		as_saveTmp("myiframe0");   //再暂存
	}
	
	/*~[Describe=有效性检查;InputParam=无;OutPutParam=通过true,否则false;]~*/
	function ValidityCheck(){
		//1：校验营业执照到期日是否小于营业执照起始日			
		sLicensedate = getItemValue(0,getRow(),"Licensedate");//营业执照登记日			
		sLicenseMaturity = getItemValue(0,getRow(),"LicenseMaturity");//营业执照到期日
		if(typeof(sLicensedate) != "undefined" && sLicensedate != "" && 
		typeof(sLicenseMaturity) != "undefined" && sLicenseMaturity != ""){
			if(sLicensedate >= "<%=sToday%>"){
				alert(getMessageText('ALS70132'));//营业执照登记日必须早于当前日期！
				return false;		    
			}
			if(sLicenseMaturity <= sLicensedate){
				alert(getMessageText('ALS70118'));//营业执照到期日必须晚于营业执照登记日！
				return false;		    
			}
		}
		//2：校验当所在国家(地区)不为中华人民共和国时，客户英文名称不能为空			
		sCountryTypeValue = getItemValue(0,getRow(),"CountryCode");//所在国家(地区)
		sEnglishName = getItemValue(0,getRow(),"EnglishName");//客户英文名称
		if(sCountryTypeValue != 'CHN'){
			if (typeof(sEnglishName) == "undefined" || sEnglishName == "" ){
				alert(getMessageText('ALS70119')); //所在国家(地区)不为中华人民共和国时，客户英文名不能为空！
				return false;	
			}
		}
		//3：校验邮政编码
		sOfficeZip = getItemValue(0,getRow(),"OfficeZIP");//邮政编码
		if(typeof(sOfficeZip) != "undefined" && sOfficeZip != "" ){
			if(!CheckPostalcode(sOfficeZip)){
				alert(getMessageText('ALS70120'));//邮政编码有误！
				return false;
			}
		}
		
		//4：校验联系电话
		sOfficeTel = getItemValue(0,getRow(),"OfficeTel");//联系电话	
		if(typeof(sOfficeTel) != "undefined" && sOfficeTel != "" ){
			if(!CheckPhoneCode(sOfficeTel)){
				alert(getMessageText('ALS70121'));//联系电话有误！
				return false;
			}
		}
		//5：校验传真电话
		sOfficeFax = getItemValue(0,getRow(),"OfficeFax");//传真电话	
		if(typeof(sOfficeFax) != "undefined" && sOfficeFax != "" ){
			if(!CheckPhoneCode(sOfficeFax)){
				alert(getMessageText('ALS70124'));//传真电话有误！
				return false;
			}
		}
		//6：校验财务部联系电话
		sFinanceDeptTel = getItemValue(0,getRow(),"FinanceDeptTel");//财务部联系电话	
		if(typeof(sFinanceDeptTel) != "undefined" && sFinanceDeptTel != "" ){
			if(!CheckPhoneCode(sFinanceDeptTel)){
				alert(getMessageText('ALS70125'));//财务部联系电话有误！
				return false;
			}
		}
		//7：校验电子邮件地址
		sEmailAdd = getItemValue(0,getRow(),"EmailAdd");//电子邮件地址	
		if(typeof(sEmailAdd) != "undefined" && sEmailAdd != "" ){
			if(!CheckEMail(sEmailAdd)){
				alert(getMessageText('ALS70130'));//公司E－Mail有误！
				return false;
			}
		}
		
		//8：校验贷款卡编号
		sLoanCardNo = getItemValue(0,getRow(),"LoanCardNo");//贷款卡编号	
		if(typeof(sLoanCardNo) != "undefined" && sLoanCardNo != "" ){
			if(sLoanCardNo.length != 16 && sLoanCardNo.length !=18||!CheckLoanCardID(sLoanCardNo)){
				alert(getMessageText('ALS70101'));//贷款卡编号有误！							
				return false;
			}
			
			//检验贷款卡编号唯一性
			sCustomerID = getItemValue(0,getRow(),"CustomerID");//客户名称	
			sReturn=RunMethod("CustomerManage","CheckLoanCardNoChangeCustomer",sCustomerID+","+sLoanCardNo);
			if(typeof(sReturn) != "undefined" && sReturn != "" && sReturn == "Many") {
				alert(getMessageText('ALS70227'));//该贷款卡编号已被其他客户占用！							
				return false;
			}					
		}
		
		//9:校验当是否征信标准集团客户为是时，则需输入上级公司名称、上级公司组织机构代码或上级公司贷款卡编号
		sECGroupFlag = getItemValue(0,getRow(),"ECGroupFlag");//是否征信标准集团客户
		sSuperCorpName = getItemValue(0,getRow(),"SuperCorpName");//上级公司名称
		sSuperLoanCardNo = getItemValue(0,getRow(),"SuperLoanCardNo");//上级公司贷款卡编号
		sSuperCertID = getItemValue(0,getRow(),"SuperCertID");//上级公司组织机构代码
		if(sECGroupFlag == '1'){ //是否征信标准集团客户（1：是；2：否）
			if(typeof(sSuperCorpName) == "undefined" || sSuperCorpName == "" ){
				alert(getMessageText('ALS70126'));
				return false;
			}
			if((typeof(sSuperLoanCardNo) == "undefined" || sSuperLoanCardNo == "") && 
			(typeof(sSuperCertID) == "undefined" || sSuperCertID == "") ){
				alert(getMessageText('ALS70127'));
				return false;
			}
			//如果录入了上级公司组织机构代码，则需要校验上级公司组织机构代码的合法性，同时将上级公司证件类型设置为组织机构代码证
			if(typeof(sSuperCertID) != "undefined" && sSuperCertID != "" ){
				if(!CheckORG(sSuperCertID)){
					alert(getMessageText('ALS70128'));//上级公司组织机构代码有误！							
					return false;
				}
				setItemValue(0,getRow(),'SuperCertType',"Ent01");
			}
			//如果录入了上级公司贷款卡编号，则需要校验上级公司贷款卡编号的合法性
			if(typeof(sSuperLoanCardNo) != "undefined" && sSuperLoanCardNo != "" ){
				if(!CheckLoanCardID(sSuperLoanCardNo)){
					alert(getMessageText('ALS70129'));//上级公司贷款卡编号有误！							
					return false;
				}				
			}
		}else {	
			if((sSuperCertID != "" && typeof(sSuperCertID) != "undefined" )|| (sSuperLoanCardNo != "" && typeof(sSuperLoanCardNo) != "undefined" )|| (sSuperCorpName != "" && typeof(sSuperCorpName) != "undefined" )){
				alert(getMessageText('ALS70251'));//并非集团客户，不需要填写上级信息！
				return false;
			}
		}
		//校验机构电话
		sRelativeType = getItemValue(0,getRow(),"RelativeType");//机构电话	
		if(typeof(sRelativeType) != "undefined" && sRelativeType != "" ){
			if(!CheckPhoneCode(sRelativeType)){
				alert(getMessageText('ALS70255'));//机构电话有误！请重新输入	
				return false;
			}
		}

           //校验当所在国家(地区)为中华人民共和国 且所选的省市为空时，必须输入省市名称      add by zhuang 2010-03-17      
           sCountryTypeValue = getItemValue(0,getRow(),"CountryCode");//所在国家(地区)regioncode
           sRegionTypeValue = getItemValue(0,getRow(),"RegionCode");//所在的省市          
           if(sCountryTypeValue == 'CHN' && (typeof(sRegionTypeValue) == "undefined" || sRegionTypeValue == "") ){
               alert(getMessageText('ALS70958'));//所在国家(地区)为中华人民共和国时,省份、直辖市、自治区不能为空！
               return false;                  
           }							
		
		return true;		
	}

    /*~[Describe=弹出企业类型选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/   
    function selectOrgType(){
        sParaString = "CodeNo"+",OrgType";      
        //'0110'大型企业客户，不能有“个体经营”选项
		setObjectValue("SelectBigOrgType",sParaString,"@OrgType@0@OrgTypeName@1",0,0,"");
    }
	
	/*~[Describe=弹出国家/地区选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function selectCountryCode(){
		sParaString = "CodeNo"+",CountryCode";			
		sCountryCodeInfo = setObjectValue("SelectCode",sParaString,"@CountryCode@0@CountryCodeName@1",0,0,"");
		if (typeof(sCountryCodeInfo) != "undefined" && sCountryCodeInfo != ""  && sCountryCodeInfo != "_NONE_" 
		&& sCountryCodeInfo != "_CLEAR_" && sCountryCodeInfo != "_CANCEL_"){
			sCountryCodeInfo = sCountryCodeInfo.split('@');
			sCountryCodeValue = sCountryCodeInfo[0];//-- 所在国家(地区)代码
			if(sCountryCodeValue != 'CHN'){ //当所在国家(地区)不为中华人民共和国时，需清除省份、直辖市、自治区的数据
				setItemValue(0,getRow(),"RegionCode","");
				setItemValue(0,getRow(),"RegionCodeName","");
			}
		}
	}
	
	/*~[Describe=弹出信用等级评估模板选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function selectCreditTempletType(){
		sParaString = "CodeNo"+",CreditTempletType";			
		setObjectValue("SelectCode",sParaString,"@CreditBelong@0@CreditBelongName@1",0,0,"");
	}
	
	/*~[Describe=弹出对应评分卡模型模板选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function selectAnalyseType(sModelType){
		sParaString = "ModelType"+","+sModelType;			
		setObjectValue("selectAnalyseType",sParaString,"@CreditBelong@0@CreditBelongName@1",0,0,"");
	}
	/*~[Describe=弹出省份、直辖市、自治区选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function getRegionCode(flag){
		if (flag != "ent") { //区分企业客户的行政区域和个人的籍贯
			sParaString = "CodeNo"+",AreaCode";			
			setObjectValue("SelectCode",sParaString,"@NativePlace@0@NativePlaceName@1",0,0,"");
		}
	}

	/*~[Describe=弹出行政规划选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function getRegionCode(){
		//判断国家有没有选中国
		var sCountryTypeValue = getItemValue(0,getRow(),"CountryCode");
		var sAreaCode = getItemValue(0,getRow(),"RegionCode");
		//判断国家是否已经选了
		if (typeof(sCountryTypeValue) != "undefined" && sCountryTypeValue != "" ){
			if(sCountryTypeValue == "CHN"){
				sAreaCodeInfo = PopComp("AreaVFrame","/Common/ToolsA/AreaVFrame.jsp","AreaCode="+sAreaCode,"dialogWidth=650px;dialogHeight=450px;center:yes;status:no;statusbar:no","");
			}else{
				alert(getMessageText('ALS70122'));//所选国家不是中国，无需选择地区
				return;
			}
		}else{
			alert(getMessageText('ALS70123'));//尚未选择国家，无法选择地区
			return;
		}
		//增加清空功能的判断
		if(sAreaCodeInfo == "NO" || sAreaCodeInfo == '_CLEAR_'){
			setItemValue(0,getRow(),"RegionCode","");
			setItemValue(0,getRow(),"RegionCodeName","");
		}else{
			if(typeof(sAreaCodeInfo) != "undefined" && sAreaCodeInfo != ""){
				sAreaCodeInfo = sAreaCodeInfo.split('@');
				sAreaCodeValue = sAreaCodeInfo[0];//-- 行政区划代码
				sAreaCodeName = sAreaCodeInfo[1];//--行政区划名称
				setItemValue(0,getRow(),"RegionCode",sAreaCodeValue);
				setItemValue(0,getRow(),"RegionCodeName",sAreaCodeName);				
			}
		}
	}	
	
	/*~[Describe=弹出国标行业类型选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function getIndustryType(){
		var sIndustryType = getItemValue(0,getRow(),"IndustryType");
		//由于行业分类代码有几百项，分两步显示行业代码
		sIndustryTypeInfo = PopComp("IndustryVFrame","/Common/ToolsA/IndustryVFrame.jsp","IndustryType="+sIndustryType,"dialogWidth=650px;dialogHeight=450px;center:yes;status:no;statusbar:no","");
		//增加清空功能的判断
		if(sIndustryTypeInfo == "NO" ||sIndustryTypeInfo == '_CLEAR_' ){
			setItemValue(0,getRow(),"IndustryType","");
			setItemValue(0,getRow(),"IndustryTypeName","");
		}else if(typeof(sIndustryTypeInfo) != "undefined" && sIndustryTypeInfo != ""){
			sIndustryTypeInfo = sIndustryTypeInfo.split('@');
			sIndustryTypeValue = sIndustryTypeInfo[0];//-- 行业类型代码
			sIndustryTypeName = sIndustryTypeInfo[1];//--行业类型名称
			setItemValue(0,getRow(),"IndustryType",sIndustryTypeValue);
			setItemValue(0,getRow(),"IndustryTypeName",sIndustryTypeName);				
		}
	}
	
	/*~[Describe=弹出机构选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function getOrg(){
		setObjectValue("SelectAllOrg","","@OrgID@0@OrgName@1",0,0,"");
	}
	
	/*~[Describe=弹出用户选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function getUser(){
		var sOrg = getItemValue(0,getRow(),"OrgID");
		sParaString = "BelongOrg,"+sOrg;	
		if (sOrg.length != 0 ){
			setObjectValue("SelectUserBelongOrg",sParaString,"@UserID@0@UserName@1",0,0,"");
		}else{
			alert(getMessageText('ALS70133'));//请先选择管户机构！
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>