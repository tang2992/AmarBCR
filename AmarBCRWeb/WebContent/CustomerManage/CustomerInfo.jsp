<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content: --��ҵ�ͻ��ſ�
	 */
	//����������,�ͻ�����
    String sCustomerID =  CurPage.getParameter("CustomerID");
	if(sCustomerID == null) sCustomerID = "";
	
	//�������
    String sToday = StringFunction.getToday();
	String sCertType = "";
    ASResultSet rs = Sqlca.getASResultSet("select CustomerType,CertType from CUSTOMER_INFO where CustomerID = '"+sCustomerID+"' ");
	if(rs.next()){
		sCertType = rs.getString("CertType");
	}
	rs.getStatement().close();
	if(sCertType == null) sCertType = "";
	
	//ͨ����ʾģ�����ASDataObject����doTemp
	ASObjectModel doTemp = new ASObjectModel("EnterpriseInfo01");
	//���֤��������Ӫҵִ�գ�������֤�������ֶ�
	if(sCertType.equals("Ent02")){
		doTemp.setVisible("CorpID",false);
		doTemp.setReadOnly("LicenseNo",true);
	}
	//������֤���� ����ʾģ�����֤��������
	//����ע���ʱ���Χ
	//doTemp.appendHTMLStyle("RegisterCapital"," myvalid=\"parseFloat(myobj.value,10)>=0 \" mymsg=\"ע���ʱ�������ڵ���0��\" ");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request); 
	dwTemp.Style = "2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sCustomerID);
	
	String sButtons[][] = {
		{"true","All","Button","����","���������޸�","saveRecord()","","","",""},
		{"true","All","Button","�ݴ�","��ʱ���������޸�","saveRecordTemp()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	/*~[Describe=����;InputParam=�����¼�;OutPutParam=��;]~*/
	function saveRecord(sPostEvents){
		//¼��������Ч�Լ��
		if (!ValidityCheck()) return;
		setItemValue(0,0,"TempSaveFlag","2");//�ݴ��־��1���ǣ�2����
		as_save("myiframe0",sPostEvents);	
	}
		
	function saveRecordTemp(){
		setItemValue(0,0,"TempSaveFlag","1");//�ݴ��־��1���ǣ�2����
		as_saveTmp("myiframe0");   //���ݴ�
	}
	
	/*~[Describe=��Ч�Լ��;InputParam=��;OutPutParam=ͨ��true,����false;]~*/
	function ValidityCheck(){
		//1��У��Ӫҵִ�յ������Ƿ�С��Ӫҵִ����ʼ��			
		sLicensedate = getItemValue(0,getRow(),"Licensedate");//Ӫҵִ�յǼ���			
		sLicenseMaturity = getItemValue(0,getRow(),"LicenseMaturity");//Ӫҵִ�յ�����
		if(typeof(sLicensedate) != "undefined" && sLicensedate != "" && 
		typeof(sLicenseMaturity) != "undefined" && sLicenseMaturity != ""){
			if(sLicensedate >= "<%=sToday%>"){
				alert(getMessageText('ALS70132'));//Ӫҵִ�յǼ��ձ������ڵ�ǰ���ڣ�
				return false;		    
			}
			if(sLicenseMaturity <= sLicensedate){
				alert(getMessageText('ALS70118'));//Ӫҵִ�յ����ձ�������Ӫҵִ�յǼ��գ�
				return false;		    
			}
		}
		//2��У�鵱���ڹ���(����)��Ϊ�л����񹲺͹�ʱ���ͻ�Ӣ�����Ʋ���Ϊ��			
		sCountryTypeValue = getItemValue(0,getRow(),"CountryCode");//���ڹ���(����)
		sEnglishName = getItemValue(0,getRow(),"EnglishName");//�ͻ�Ӣ������
		if(sCountryTypeValue != 'CHN'){
			if (typeof(sEnglishName) == "undefined" || sEnglishName == "" ){
				alert(getMessageText('ALS70119')); //���ڹ���(����)��Ϊ�л����񹲺͹�ʱ���ͻ�Ӣ��������Ϊ�գ�
				return false;	
			}
		}
		//3��У����������
		sOfficeZip = getItemValue(0,getRow(),"OfficeZIP");//��������
		if(typeof(sOfficeZip) != "undefined" && sOfficeZip != "" ){
			if(!CheckPostalcode(sOfficeZip)){
				alert(getMessageText('ALS70120'));//������������
				return false;
			}
		}
		
		//4��У����ϵ�绰
		sOfficeTel = getItemValue(0,getRow(),"OfficeTel");//��ϵ�绰	
		if(typeof(sOfficeTel) != "undefined" && sOfficeTel != "" ){
			if(!CheckPhoneCode(sOfficeTel)){
				alert(getMessageText('ALS70121'));//��ϵ�绰����
				return false;
			}
		}
		//5��У�鴫��绰
		sOfficeFax = getItemValue(0,getRow(),"OfficeFax");//����绰	
		if(typeof(sOfficeFax) != "undefined" && sOfficeFax != "" ){
			if(!CheckPhoneCode(sOfficeFax)){
				alert(getMessageText('ALS70124'));//����绰����
				return false;
			}
		}
		//6��У�������ϵ�绰
		sFinanceDeptTel = getItemValue(0,getRow(),"FinanceDeptTel");//������ϵ�绰	
		if(typeof(sFinanceDeptTel) != "undefined" && sFinanceDeptTel != "" ){
			if(!CheckPhoneCode(sFinanceDeptTel)){
				alert(getMessageText('ALS70125'));//������ϵ�绰����
				return false;
			}
		}
		//7��У������ʼ���ַ
		sEmailAdd = getItemValue(0,getRow(),"EmailAdd");//�����ʼ���ַ	
		if(typeof(sEmailAdd) != "undefined" && sEmailAdd != "" ){
			if(!CheckEMail(sEmailAdd)){
				alert(getMessageText('ALS70130'));//��˾E��Mail����
				return false;
			}
		}
		
		//8��У�������
		sLoanCardNo = getItemValue(0,getRow(),"LoanCardNo");//������	
		if(typeof(sLoanCardNo) != "undefined" && sLoanCardNo != "" ){
			if(sLoanCardNo.length != 16 && sLoanCardNo.length !=18||!CheckLoanCardID(sLoanCardNo)){
				alert(getMessageText('ALS70101'));//����������							
				return false;
			}
			
			//���������Ψһ��
			sCustomerID = getItemValue(0,getRow(),"CustomerID");//�ͻ�����	
			sReturn=RunMethod("CustomerManage","CheckLoanCardNoChangeCustomer",sCustomerID+","+sLoanCardNo);
			if(typeof(sReturn) != "undefined" && sReturn != "" && sReturn == "Many") {
				alert(getMessageText('ALS70227'));//�ô������ѱ������ͻ�ռ�ã�							
				return false;
			}					
		}
		
		//9:У�鵱�Ƿ����ű�׼���ſͻ�Ϊ��ʱ�����������ϼ���˾���ơ��ϼ���˾��֯����������ϼ���˾������
		sECGroupFlag = getItemValue(0,getRow(),"ECGroupFlag");//�Ƿ����ű�׼���ſͻ�
		sSuperCorpName = getItemValue(0,getRow(),"SuperCorpName");//�ϼ���˾����
		sSuperLoanCardNo = getItemValue(0,getRow(),"SuperLoanCardNo");//�ϼ���˾������
		sSuperCertID = getItemValue(0,getRow(),"SuperCertID");//�ϼ���˾��֯��������
		if(sECGroupFlag == '1'){ //�Ƿ����ű�׼���ſͻ���1���ǣ�2����
			if(typeof(sSuperCorpName) == "undefined" || sSuperCorpName == "" ){
				alert(getMessageText('ALS70126'));
				return false;
			}
			if((typeof(sSuperLoanCardNo) == "undefined" || sSuperLoanCardNo == "") && 
			(typeof(sSuperCertID) == "undefined" || sSuperCertID == "") ){
				alert(getMessageText('ALS70127'));
				return false;
			}
			//���¼�����ϼ���˾��֯�������룬����ҪУ���ϼ���˾��֯��������ĺϷ��ԣ�ͬʱ���ϼ���˾֤����������Ϊ��֯��������֤
			if(typeof(sSuperCertID) != "undefined" && sSuperCertID != "" ){
				if(!CheckORG(sSuperCertID)){
					alert(getMessageText('ALS70128'));//�ϼ���˾��֯������������							
					return false;
				}
				setItemValue(0,getRow(),'SuperCertType',"Ent01");
			}
			//���¼�����ϼ���˾�����ţ�����ҪУ���ϼ���˾�����ŵĺϷ���
			if(typeof(sSuperLoanCardNo) != "undefined" && sSuperLoanCardNo != "" ){
				if(!CheckLoanCardID(sSuperLoanCardNo)){
					alert(getMessageText('ALS70129'));//�ϼ���˾����������							
					return false;
				}				
			}
		}else {	
			if((sSuperCertID != "" && typeof(sSuperCertID) != "undefined" )|| (sSuperLoanCardNo != "" && typeof(sSuperLoanCardNo) != "undefined" )|| (sSuperCorpName != "" && typeof(sSuperCorpName) != "undefined" )){
				alert(getMessageText('ALS70251'));//���Ǽ��ſͻ�������Ҫ��д�ϼ���Ϣ��
				return false;
			}
		}
		//У������绰
		sRelativeType = getItemValue(0,getRow(),"RelativeType");//�����绰	
		if(typeof(sRelativeType) != "undefined" && sRelativeType != "" ){
			if(!CheckPhoneCode(sRelativeType)){
				alert(getMessageText('ALS70255'));//�����绰��������������	
				return false;
			}
		}

           //У�鵱���ڹ���(����)Ϊ�л����񹲺͹� ����ѡ��ʡ��Ϊ��ʱ����������ʡ������      add by zhuang 2010-03-17      
           sCountryTypeValue = getItemValue(0,getRow(),"CountryCode");//���ڹ���(����)regioncode
           sRegionTypeValue = getItemValue(0,getRow(),"RegionCode");//���ڵ�ʡ��          
           if(sCountryTypeValue == 'CHN' && (typeof(sRegionTypeValue) == "undefined" || sRegionTypeValue == "") ){
               alert(getMessageText('ALS70958'));//���ڹ���(����)Ϊ�л����񹲺͹�ʱ,ʡ�ݡ�ֱϽ�С�����������Ϊ�գ�
               return false;                  
           }							
		
		return true;		
	}

    /*~[Describe=������ҵ����ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;InputParam=��;OutPutParam=��;]~*/   
    function selectOrgType(){
        sParaString = "CodeNo"+",OrgType";      
        //'0110'������ҵ�ͻ��������С����徭Ӫ��ѡ��
		setObjectValue("SelectBigOrgType",sParaString,"@OrgType@0@OrgTypeName@1",0,0,"");
    }
	
	/*~[Describe=��������/����ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;InputParam=��;OutPutParam=��;]~*/
	function selectCountryCode(){
		sParaString = "CodeNo"+",CountryCode";			
		sCountryCodeInfo = setObjectValue("SelectCode",sParaString,"@CountryCode@0@CountryCodeName@1",0,0,"");
		if (typeof(sCountryCodeInfo) != "undefined" && sCountryCodeInfo != ""  && sCountryCodeInfo != "_NONE_" 
		&& sCountryCodeInfo != "_CLEAR_" && sCountryCodeInfo != "_CANCEL_"){
			sCountryCodeInfo = sCountryCodeInfo.split('@');
			sCountryCodeValue = sCountryCodeInfo[0];//-- ���ڹ���(����)����
			if(sCountryCodeValue != 'CHN'){ //�����ڹ���(����)��Ϊ�л����񹲺͹�ʱ�������ʡ�ݡ�ֱϽ�С�������������
				setItemValue(0,getRow(),"RegionCode","");
				setItemValue(0,getRow(),"RegionCodeName","");
			}
		}
	}
	
	/*~[Describe=�������õȼ�����ģ��ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;InputParam=��;OutPutParam=��;]~*/
	function selectCreditTempletType(){
		sParaString = "CodeNo"+",CreditTempletType";			
		setObjectValue("SelectCode",sParaString,"@CreditBelong@0@CreditBelongName@1",0,0,"");
	}
	
	/*~[Describe=������Ӧ���ֿ�ģ��ģ��ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;InputParam=��;OutPutParam=��;]~*/
	function selectAnalyseType(sModelType){
		sParaString = "ModelType"+","+sModelType;			
		setObjectValue("selectAnalyseType",sParaString,"@CreditBelong@0@CreditBelongName@1",0,0,"");
	}
	/*~[Describe=����ʡ�ݡ�ֱϽ�С�������ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;InputParam=��;OutPutParam=��;]~*/
	function getRegionCode(flag){
		if (flag != "ent") { //������ҵ�ͻ�����������͸��˵ļ���
			sParaString = "CodeNo"+",AreaCode";			
			setObjectValue("SelectCode",sParaString,"@NativePlace@0@NativePlaceName@1",0,0,"");
		}
	}

	/*~[Describe=���������滮ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;InputParam=��;OutPutParam=��;]~*/
	function getRegionCode(){
		//�жϹ�����û��ѡ�й�
		var sCountryTypeValue = getItemValue(0,getRow(),"CountryCode");
		var sAreaCode = getItemValue(0,getRow(),"RegionCode");
		//�жϹ����Ƿ��Ѿ�ѡ��
		if (typeof(sCountryTypeValue) != "undefined" && sCountryTypeValue != "" ){
			if(sCountryTypeValue == "CHN"){
				sAreaCodeInfo = PopComp("AreaVFrame","/Common/ToolsA/AreaVFrame.jsp","AreaCode="+sAreaCode,"dialogWidth=650px;dialogHeight=450px;center:yes;status:no;statusbar:no","");
			}else{
				alert(getMessageText('ALS70122'));//��ѡ���Ҳ����й�������ѡ�����
				return;
			}
		}else{
			alert(getMessageText('ALS70123'));//��δѡ����ң��޷�ѡ�����
			return;
		}
		//������չ��ܵ��ж�
		if(sAreaCodeInfo == "NO" || sAreaCodeInfo == '_CLEAR_'){
			setItemValue(0,getRow(),"RegionCode","");
			setItemValue(0,getRow(),"RegionCodeName","");
		}else{
			if(typeof(sAreaCodeInfo) != "undefined" && sAreaCodeInfo != ""){
				sAreaCodeInfo = sAreaCodeInfo.split('@');
				sAreaCodeValue = sAreaCodeInfo[0];//-- ������������
				sAreaCodeName = sAreaCodeInfo[1];//--������������
				setItemValue(0,getRow(),"RegionCode",sAreaCodeValue);
				setItemValue(0,getRow(),"RegionCodeName",sAreaCodeName);				
			}
		}
	}	
	
	/*~[Describe=����������ҵ����ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;InputParam=��;OutPutParam=��;]~*/
	function getIndustryType(){
		var sIndustryType = getItemValue(0,getRow(),"IndustryType");
		//������ҵ��������м������������ʾ��ҵ����
		sIndustryTypeInfo = PopComp("IndustryVFrame","/Common/ToolsA/IndustryVFrame.jsp","IndustryType="+sIndustryType,"dialogWidth=650px;dialogHeight=450px;center:yes;status:no;statusbar:no","");
		//������չ��ܵ��ж�
		if(sIndustryTypeInfo == "NO" ||sIndustryTypeInfo == '_CLEAR_' ){
			setItemValue(0,getRow(),"IndustryType","");
			setItemValue(0,getRow(),"IndustryTypeName","");
		}else if(typeof(sIndustryTypeInfo) != "undefined" && sIndustryTypeInfo != ""){
			sIndustryTypeInfo = sIndustryTypeInfo.split('@');
			sIndustryTypeValue = sIndustryTypeInfo[0];//-- ��ҵ���ʹ���
			sIndustryTypeName = sIndustryTypeInfo[1];//--��ҵ��������
			setItemValue(0,getRow(),"IndustryType",sIndustryTypeValue);
			setItemValue(0,getRow(),"IndustryTypeName",sIndustryTypeName);				
		}
	}
	
	/*~[Describe=��������ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;InputParam=��;OutPutParam=��;]~*/
	function getOrg(){
		setObjectValue("SelectAllOrg","","@OrgID@0@OrgName@1",0,0,"");
	}
	
	/*~[Describe=�����û�ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;InputParam=��;OutPutParam=��;]~*/
	function getUser(){
		var sOrg = getItemValue(0,getRow(),"OrgID");
		sParaString = "BelongOrg,"+sOrg;	
		if (sOrg.length != 0 ){
			setObjectValue("SelectUserBelongOrg",sParaString,"@UserID@0@UserName@1",0,0,"");
		}else{
			alert(getMessageText('ALS70133'));//����ѡ��ܻ�������
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>