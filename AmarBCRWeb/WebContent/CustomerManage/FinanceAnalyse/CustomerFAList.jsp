<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Describe: --�ͻ��������
		Input Param:
			  CustomerID��--��ǰ�ͻ����
	 */
	//�������������ͻ�����
	String sCustomerID = CurPage.getParameter("CustomerID");

 	ASObjectModel doTemp = new ASObjectModel("CustomerFAList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1"; //����Ϊֻ��
	dwTemp.genHTMLObjectWindow(sCustomerID);

	String sButtons[][] = {
		{"true","","Button","�Ű����","�Ű����","dupondInfo()","","","",""},
		{"true","","Button","�ṹ����","�ṹ����","structureInfo()","","","",""},
		{"true","","Button","ָ�����","ָ�����","itemInfo()","","","",""},
		{"true","","Button","���Ʒ���","���Ʒ���","trendInfo()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=�Ű����;]~*/
	function dupondInfo(){
		var sReportDate=getItemValue(0,getRow(),"ReportDate");
		if(typeof(sReportDate)=="undefined" || sReportDate.length==0){
			alert("��ѡ��Ҫ�����ı���");
		}else{
			//����ֵ�����������
			sMonth = PopPage("/Common/ToolsA/SelectMonth.jsp?rand="+randomNumber(),"","dialogWidth=250px;dialogHeight=180px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no;scrollbar:yes");
			if(typeof(sMonth)=="undefined" || sMonth=="_none_")	 return;
			AsControl.PopView("/CustomerManage/FinanceAnalyse/DBAnalyse.jsp","CustomerID=<%=sCustomerID%>&AccountMonth="+sMonth);
		}
	}
	
	/*~[Describe=�ṹ����;]~*/
	function structureInfo(){
	    //����ֵ���������������������¡�����Χ
		sReturnValue = PopPage("/CustomerManage/FinanceAnalyse/AnalyseTerm.jsp?CustomerID=<%=sCustomerID%>","","dialogWidth=550px;dialogHeight=400px;minimize:no;maximize:no;status:yes;center:yes");
	    if(typeof(sReturnValue)=="undefined" || sReturnValue=="_none_" || sReturnValue==null)	return;
	    AsControl.PopView("/CustomerManage/FinanceAnalyse/StructureView.jsp","CustomerID=<%=sCustomerID%>&Term=" + sReturnValue);
	}

	/*~[Describe=ָ�����;]~*/
	function itemInfo(){
	    //����ֵ���������������������¡�����Χ
		sReturnValue = PopPage("/CustomerManage/FinanceAnalyse/AnalyseTerm.jsp?CustomerID=<%=sCustomerID%>","","dialogWidth=550px;dialogHeight=400px;minimize:no;maximize:no;status:yes;center:yes");
	    if(typeof(sReturnValue)=="undefined" || sReturnValue=="_none_" || sReturnValue==null)	return;
	    AsControl.PopView("/CustomerManage/FinanceAnalyse/ItemView.jsp","CustomerID=<%=sCustomerID%>&Term="+sReturnValue);
	}

	/*~[Describe=���Ʒ���;]~*/
	function trendInfo(){
	    //����ֵ���������������������¡�����Χ
		sReturnValue = PopPage("/CustomerManage/FinanceAnalyse/AnalyseTerm_Trend.jsp?CustomerID=<%=sCustomerID%>","","dialogWidth=550px;dialogHeight=400px;minimize:no;maximize:no;status:yes;center:yes");
		if(typeof(sReturnValue)=="undefined" || sReturnValue=="_none_" || sReturnValue==null)	return;
		AsControl.PopView("/CustomerManage/FinanceAnalyse/TrendView.jsp","CustomerID=<%=sCustomerID%>&Term="+sReturnValue);
	}
</script>
<%@	include file="/Frame/resources/include/include_end.jspf"%>