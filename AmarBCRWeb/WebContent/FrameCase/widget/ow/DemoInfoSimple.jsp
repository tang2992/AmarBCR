<%@page import="com.amarsoft.are.lang.StringX"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	String sSerialNo = CurPage.getParameter("SerialNo");
	String sPrevUrl = CurPage.getParameter("PrevUrl");
	if(sSerialNo == null) sSerialNo = "";
	if(sPrevUrl == null) sPrevUrl = "";

	ASObjectModel doTemp = new ASObjectModel("TestCustomerInfo"); //ͨ����ʾģ������
	doTemp.setColTips("", "����Tips");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.genHTMLObjectWindow(sSerialNo);
	String sButtons[][] = {
		{"true","All","Button","����","���������޸�","as_save(0)","","","",""},
		{String.valueOf(!StringX.isSpace(sPrevUrl)),"All","Button","����","�����б�","returnList()","","","",""}
	};
	sButtonPosition = "south";
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function returnList(){
		OpenPage("<%=sPrevUrl%>", "_self");
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>