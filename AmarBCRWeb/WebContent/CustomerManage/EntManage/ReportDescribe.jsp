<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Describe: ����˵��
		Input Param:
			--sRecordNo:	������ˮ��
	 */
	//�������
	boolean isEditable=true;
	//����������,������ˮ��
	String sRecordNo = CurPage.getParameter("RecordNo");
	String sEditable = CurPage.getParameter("Editable");
	if("false".equals(sEditable)) isEditable=false;

	ASObjectModel doTemp = new ASObjectModel("ReportDescribe");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request); 
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sRecordNo);

	String sButtons[][] = {
		{isEditable?"true":"false","","Button","����","���������޸�","saveRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	var bIsInsert = false; //���DW�Ƿ��ڡ�����״̬��
	/*~[Describe=����;InputParam=�����¼�;OutPutParam=��;]~*/
	function saveRecord(){
		//��ǰ�·ݲ��񱨱��Ѵ���
		if(checkFSMonth()){
			sReportDate = getItemValue(0,getRow(),"ReportDate");
			alert(sReportDate +" �Ĳ��񱨱��Ѵ��ڣ�");
			return;
		}
		setItemValue(0,0,"UserID","<%=CurUser.getUserID()%>");
		setItemValue(0,0,"OrgID","<%=CurUser.getOrgID()%>");
		as_save("myiframe0");
	}
	
	/*~[Describe=��ȡ�·�;InputParam=�����¼�;OutPutParam=��;]~*/
	function getMonth(sObject){
		sReturnMonth = PopPage("/Common/ToolsA/SelectMonth.jsp?rand="+randomNumber(),"","dialogWidth=18;dialogHeight=12;center:yes;status:no;statusbar:no");
		if(typeof(sReturnMonth) != "undefined"){
			setItemValue(0,0,sObject,sReturnMonth);
		}
	}
	/*~[Describe=��ⱨ���·��Ƿ��Ѵ���;InputParam=�����¼�;OutPutParam=��;]~*/
	function checkFSMonth(){
		sCustomerID = getItemValue(0,getRow(),"CustomerID");
		sRecordNo = getItemValue(0,getRow(),"RecordNo");
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sReturn=RunMethod("CustomerManage","CheckFSRecord",sCustomerID+","+sRecordNo+","+sReportDate);
		if(sReturn>0)return true;
		return false;
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>