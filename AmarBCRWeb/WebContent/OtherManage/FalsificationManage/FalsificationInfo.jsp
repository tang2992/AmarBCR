<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%><%
	
	String sFlag = CurPage.getParameter("Flag");
	if(sFlag == null) sFlag = "";
	String sSerialNo = CurPage.getParameter("SerialNo");
	if(sSerialNo == null) sSerialNo = "";

	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.FALSIFICATION"));
	doTemp.setRequired("CustomerID,LoanCardNo,ErrLoanCardNo",true);
	if(!sSerialNo.equals("")){
		doTemp.setJboWhere("SerialNo=:SerialNo");
	}else{
		doTemp.setJboWhere("1=2");
	}
	doTemp.setVisible("*",false);
	doTemp.setVisible("CustomerId,ErrLoanCardNo,LoanCardNo,InputUser,UpdateUser",true);
	doTemp.setReadOnly("CustomerID,ErrLoanCardNo,InputUser,UpdateUser,InputOrg,UpdateOrg",true);
	doTemp.setEditStyle("InputUser,UpdateUser", "Select");
	doTemp.setDDDWJbo("Inputuser,UpdateUser","jbo.ecr.USER_INFO,UserId,UserName,1=1");
	
	doTemp.setUnit("CustomerID","<input type=button class=inputDate   value=\"...\" name=button1 onClick=\"javascript:getCustomerInfo();\"> ");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	if(sFlag.equals("0")){
		dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	}else{
		dwTemp.ReadOnly = "1";
	}
	dwTemp.genHTMLObjectWindow(sSerialNo);
	
	String sButtons[][] = {
		{sFlag.equals("0") ? "true":"false","All","Button","����","���������޸�","saveRecord()","","","",""},
		{"true","All","Button","����","�����б�","returnList()","","","",""}
	};
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord()
	{	
		if (!ValidityCheck()) return;
		beforeUpdate();
		as_save("myiframe0","");
	}
	
	function ValidityCheck()
	{	
		//������У��
		var sLoanCardNo = getItemValue(0,0,"LoanCardNo");
		var sErrLoanCardNo = getItemValue(0,0,"ErrLoanCardNo");
		
		if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
			if(!CheckLoanCardID(sLoanCardNo)){
				alert('�������������!');
				return false;
			}
		}
		if(typeof(sErrLoanCardNo)!="undefined"&&sErrLoanCardNo!=""){
			if(!CheckLoanCardID(sErrLoanCardNo)){
				alert('����������������!');
				return false;
			}
		}
		return true;
	}

   function getCustomerInfo(){
	   var sStyle = "dialogWidth:880px;dialogHeight:540px;resizable:yes;scrollbars:no;status:no;help:no";
		var sReturnValue = PopComp("SelectCustomer","/OtherManage/FalsificationManage/SelectCustomer.jsp","",sStyle);
		if(typeof(sReturnValue)!="undefined" && sReturnValue !=""){
			var sReturnvalues = sReturnValue.split("@");
			setItemValue(0,0,"CustomerID",sReturnvalues[0]);
			setItemValue(0,0,"ErrLoanCardNo",sReturnvalues[1]);
			
		}
   }
	function returnList(){
		 top.close();
	}
	
	/*~[Describe=ִ�и��²���ǰִ�еĴ���;InputParam=��;OutPutParam=��;]~*/
	function beforeUpdate()
	{
	   	setItemValue(0,0,"UpdateUser","<%=CurUser.getUserID()%>");
		setItemValue(0,0,"UpdateOrg","<%=CurUser.getOrgID()%>");
	   	setItemValue(0,0,"UpdateTime","<%=DateX.format(new java.util.Date(), "yyyy/MM/dd HH:mm:ss")%>");
	}
	
	/*~[Describe=ҳ��װ��ʱ����DW���г�ʼ��;InputParam=��;OutPutParam=��;]~*/
	function initRow()
	{
		if (getRowCount(0)==0) //���û���ҵ���Ӧ��¼��������һ�����������ֶ�Ĭ��ֵ
		{
			setItemValue(0,0,"Flag","0");
	        setItemValue(0,0,"InputUser","<%=CurUser.getUserID() %>");
			setItemValue(0,0,"InputOrg","<%=CurUser.getOrgID()%>");
			setItemValue(0,0,"InputTime","<%=DateX.format(new java.util.Date(), "yyyy/MM/dd HH:mm:ss") %>");
			beforeUpdate();
		}
	}
	
	initRow(); //ҳ��װ��ʱ����DW��ǰ��¼���г�ʼ��
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>