<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMDAJAX.jsp"%>

<%	
	//定义变量
	String sSql = ""; 
	String sDBTableName = ""; 
	String sKeyNameMain = "";
	String sKeyValueMain = "";
	//获取参数
	String sRecordType = CurPage.getParameter("RECORDTYPE");
	if(sRecordType == null) sRecordType = "";
	String sMainBusinessNo = CurPage.getParameter("MAINBUSINESSNO");
	if(sMainBusinessNo == null) sMainBusinessNo = "";
	String sCustomerID =CurPage.getParameter("CUSTOMERID");
	if(sCustomerID == null) sCustomerID = "";
	//单独判断担保对应的主合同
	String sBusinessType = "";
	String sRecordType1 ="";
	if(sRecordType.equals("22")||sRecordType.equals("32")){
		sSql = "Select distinct BusinessType from ECR_AssureCont where ContractNo='"+sMainBusinessNo+"'";
	}else if(sRecordType.equals("23")||sRecordType.equals("33")){
		sSql = "Select distinct BusinessType from ECR_GuarantyCont where ContractNo='"+sMainBusinessNo+"'";
	}else if(sRecordType.equals("24")||sRecordType.equals("34")){
		sSql = "Select distinct BusinessType from ECR_ImpawnCont where ContractNo='"+sMainBusinessNo+"'";
	}
		
	if(!sSql.equals("")){
		ASResultSet rs = Sqlca.getASResultSet( new SqlObject(sSql));
		while(rs.next()) 
		{
			sBusinessType = rs.getString(1);
			break;
		}
		rs.getStatement().close();
	}
	
	if(sBusinessType==null||sBusinessType.equals(""))
	{
		sRecordType1 = "";
	}else if(sBusinessType.equals("1"))
	{	
		//贷款业务
		sRecordType1 = "8";	
	}else if(sBusinessType.equals("2"))
	{	
		//保理业务
		sRecordType1 = "12";	
	}else if(sBusinessType.equals("4"))
	{
		//贸易融资业务
		sRecordType1 = "14";	
	}else if(sBusinessType.equals("5"))
	{
		//信用证业务
		sRecordType1 = "18";	
	}else if(sBusinessType.equals("6"))
	{
		//保函业务
		sRecordType1 = "19";	
	}else if(sBusinessType.equals("7"))
	{
		//银行承兑汇票业务
		sRecordType1 = "20";	
	}
	
	//访问组件控制
	String sCompName = "";
	String sCompPath = "/DataMaintain/BusinessMaintain/";
	//用于显示错误信息和删除错误信息
	String myBusinessType = "";
	//客户00
	//String sCustomerID="";
	if(sRecordType.equals("1")||sRecordType.equals("2")||sRecordType.equals("3")||
		 sRecordType.equals("4")||sRecordType.equals("5")||sRecordType.equals("6")||
		 sRecordType.equals("7")||sRecordType.equals("43")||sRecordType.equals("44")||
		 sRecordType.equals("45")||sRecordType.equals("46")||sRecordType.equals("47"))
	{
		sDBTableName = "ECR_CUSTOMERINFO";
		sKeyNameMain = "CUSTOMERID";
		sSql = "Select CustomerID from ECR_CustomerInfo where CustomerID='"+sCustomerID+"'" ;
		ASResultSet	rs2 = Sqlca.getASResultSet(new SqlObject(sSql));
		while(rs2.next())
		{
			sCustomerID = rs2.getString("CustomerID");
			break;
		}
		rs2.getStatement().close();
		myBusinessType = "00";
	}//贷款业务01
	else if(sRecordType.equals("8")||sRecordType.equals("9")||sRecordType.equals("10")||sRecordType.equals("11")||sRecordType1.equals("8"))
	{
		sDBTableName = "ECR_LOANCONTRACT";
		sKeyNameMain = "LCONTRACTNO";
		myBusinessType = "01";
	}//保理业务02
	else if(sRecordType.equals("12")||sRecordType1.equals("12"))
	{
	    sDBTableName = "ECR_FACTORING";
	    sKeyNameMain = "FACTORINGNO";
	    myBusinessType = "02";
	}//票据贴现业务03
	else if(sRecordType.equals("13"))
	{
		sDBTableName = "ECR_DISCOUNT";
		sKeyNameMain = "BILLNO";
		myBusinessType = "03";
	}//贸易融资业务04
	else if(sRecordType.equals("14")|| sRecordType.equals("15")|| sRecordType.equals("16")|| sRecordType.equals("17")||sRecordType1.equals("14"))
	{
		sDBTableName = "ECR_FINAINFO";
		sKeyNameMain = "FCONTRACTNO";
		myBusinessType = "04";
	}//信用证业务05
	else if(sRecordType.equals("18")||sRecordType1.equals("18"))
	{
		sDBTableName = "ECR_CREDITLETTER";
		sKeyNameMain = "CREDITLETTERNO";
		myBusinessType = "05";
	}//保函业务06
	else if(sRecordType.equals("19")||sRecordType1.equals("19"))
	{
		sDBTableName = "ECR_GUARANTEEBILL";
		sKeyNameMain = "GUARANTEEBILLNO";
		myBusinessType = "06";
	}//银行承兑汇票业务07
	else if(sRecordType.equals("20")||sRecordType1.equals("20"))
	{
		sDBTableName = "ECR_ACCEPTANCE";
		sKeyNameMain = "ACCEPTNO";
		myBusinessType = "07";
	}//公开授信业务08
	else if(sRecordType.equals("21"))
	{
		sDBTableName = "ECR_CUSTOMERCREDIT";
		sKeyNameMain = "CCONTRACTNO";
		myBusinessType = "08";
	}//垫款业务09
	else if(sRecordType.equals("25")) 
	{
		sDBTableName = "ECR_FLOORFUND";
		sKeyNameMain = "FLOORFUNDNO";
		myBusinessType = "09";
	}//欠息业务10
	else if(sRecordType.equals("26"))
	{
		sDBTableName = "ECR_INTERESTDUE";
		sKeyNameMain = "CUSTOMERID";
		myBusinessType = "10";
		sSql = "Select CustomerID from "+sDBTableName+" where LoanCardNo='"+sMainBusinessNo+"'" ;
		ASResultSet	rs3 = Sqlca.getASResultSet( new SqlObject(sSql));
		if(rs3.next())
		{
			sCustomerID = rs3.getString("CustomerID");
		}
		rs3.getStatement().close();
	}//不良信贷资产处置信息11
	else if(sRecordType.equals("51")) 
	{
		sDBTableName = "ECR_ASSETSDISPOSE";
		sKeyNameMain = "BUSINESSNO";
	}else if(sRecordType.equals("71")){ //机构基本信息 为了风格保持一致，设置虚拟业务类型11
		sDBTableName = "ECR_ORGANINFO";
		sKeyNameMain = "CIFCUSTOMERID";
		myBusinessType = "11";
	}else if(sRecordType.equals("72")){ //机构家族成员信息 为了风格保持一致，设置虚拟业务类型12
		sDBTableName = "ECR_ORGANFAMILY";
		sKeyNameMain = "CIFCUSTOMERID";
		myBusinessType = "12";
	}else if(sRecordType.equals("811")){ //机构家族成员信息 为了风格保持一致，设置虚拟业务类型12
		sDBTableName = "BCR_GUARANTEEINFO";
		sKeyNameMain = "GBUSINESSNO";
		myBusinessType = "12";
	}
	//配置访问路径
	if(sDBTableName.equals("ECR_CUSTOMERINFO")){
		sCompName = "CustomerInfoDetail";
		sCompPath = "/DataMaintain/CustomerMaintain/CustomerInfoDetail.jsp";
	}else if(sDBTableName.equals("ECR_ORGANINFO")||sDBTableName.equals("ECR_ORGANFAMILY")){
		sCompName = "OrgnizationRelativeList";
		sCompPath = "/DataMaintain/OrgnizationManage/OrgnizationRelativeList.jsp";
	}else if(sDBTableName.equals("BCR_GUARANTEEINFO")){
		sCompName = "GuaranteeRelativeList";
		sCompPath = "/DataMaintain/GuaranteeMaintain/GuaranteeRelativeList.jsp";
	}else{
		sCompName = "BusinessInfoDetail";
		sCompPath = sCompPath + "BusinessInfoDetail.jsp";
	}
	//设置主键值
	if(sDBTableName.equals("ECR_CUSTOMERINFO")||sDBTableName.equals("ECR_INTERESTDUE")){
		sKeyValueMain = sCustomerID ;
	}else{
		sKeyValueMain = sMainBusinessNo ;
	}
	session.setAttribute("errType",myBusinessType+","+sMainBusinessNo);
	//返回值
	String sReturnValue = sCompName+","+sCompPath +","+  sDBTableName+","+sKeyNameMain+","+sKeyValueMain;
 out.println(sReturnValue);

%><%@ include file="/IncludeEndAJAX.jsp"%>