<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*�������ֶΣ�ColActualName��ͬ����Info����*/
	String sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID == null) sCustomerID = "2010081000000001";

	ASObjectModel doTemp = new ASObjectModel("DemoEntInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.ReadOnly = "0";
	dwTemp.genHTMLObjectWindow(sCustomerID);
	String sButtons[][] = {
		{"true","All","Button","��ȡ���","","getColNo()","","","","btn_icon_save"},
	};
	sButtonPosition = "south";
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function getColNo(){
		alert("CI�ͻ����:"+getItemValue(0,0,"V.CUSTOMERID1")+"\nEI�ͻ����:"+getItemValue(0,0,"CUSTOMERID"));
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
