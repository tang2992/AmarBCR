<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Describe: �������񱨱�׼����Ϣ ��ҳ��������ڱ�����Ϣ����������
	 */
	String PG_TITLE = "����˵��"; // ��������ڱ��� <title> PG_TITLE </title>
	//�������������ͻ���š�ģʽ����
	String sCustomerID = CurPage.getParameter("CustomerID"); 
	String sModelClass = CurPage.getParameter("ModelClass"); 

	ASObjectModel doTemp = new ASObjectModel("AddFSPre");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request); 
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow("");
	
	//�������в��񱨱�ĳ�ʼ������
	//dwTemp.setEvent("AfterInsert","!BusinessManage.InitFinanceReport(CustomerFS,#CustomerID,#ReportDate,#ReportScope,#RecordNo,ModelClass^'"+sModelClass+"',,AddNew,"+CurOrg.getOrgID()+","+CurUser.getUserID()+")");

	String sButtons[][] = {
		{"true","","Button","ȷ��","ȷ��","doCreation()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("�������񱨱�");
	/*~[Describe=����;]~*/
	function saveRecord(sPostEvents){
		if (!ValidityCheck()) return;	
		sReportDate = getItemValue(0,0,"ReportDate");
		sReportScope = getItemValue(0,0,"ReportScope");
		if(sReportScope == '01')
			sReportScopeName = "�ϲ�";
		else if(sReportScope == '02')
			sReportScopeName = "����";
		else
			sReportScopeName = "����";
		//�����Ҫ���Խ��б���ǰ��Ȩ���ж�
		sPassRight = AsControl.RunJsp("/CustomerManage/EntManage/FinanceCanPassAjax.jsp","ReportDate="+sReportDate+"&ReportScope="+sReportScope);
		if(sPassRight=="pass"){
			var sPrefix = "CFS";//ǰ׺
			//��ȡ��ˮ��
			var sSerialNo = getSerialNo("CUSTOMER_FSRECORD","RecordNo",sPrefix);
			//����ˮ�������Ӧ�ֶ�
			setItemValue(0,0,"RecordNo",sSerialNo);
			as_save("myiframe0",sPostEvents);
		}else{
			alert(sReportDate +"�·ݵ�"+sReportScopeName+"�ھ����񱨱��Ѵ��ڣ�������ѡ��");
		}
	}

	function doCreation(){
		saveRecord("goBack()");
	}
	
	function goBack(){
		top.returnValue= "ok";
		top.close();
	}
	
	/*~[Describe=����ѡ��;]~*/
	function getMonth(sObject){
		sReturnMonth = PopPage("/Common/ToolsA/SelectMonth.jsp?rand="+randomNumber(),"","dialogWidth=250px;dialogHeight=180px;center:yes;status:no;statusbar:no");
		if(typeof(sReturnMonth) != "undefined"){
			setItemValue(0,0,sObject,sReturnMonth);
		}
	}
	
	/*~[Describe=��Ч�Լ��;ͨ��true,����false;]~*/
	function ValidityCheck(){
		//У�鱨���ֹ�����Ƿ���ڵ�ǰ����
		var sReportDate = getItemValue(0,0,"ReportDate");//�����ֹ����
		var sToday = "<%=StringFunction.getToday()%>";//��ǰ����
		sToday = sToday.substring(0,7);//��ǰ���ڵ�����
		if(typeof(sReportDate) != "undefined" && sReportDate != "" ){
			if(sReportDate >= sToday){
				alert(getMessageText('ALS70163'));//�����ֹ���ڱ������ڵ�ǰ���ڣ�
				return false;		    
			}
		}
		return true;
	}
	
	function initRow(){
		if (getRowCount(0)==0){ //���û���ҵ���Ӧ��¼��������һ�����������ֶ�Ĭ��ֵ
			as_add("myiframe0");//������¼
			setItemValue(0,0,"CustomerID","<%=sCustomerID%>");
		}
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>