<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	String sSerialNo = CurPage.getParameter("ObjectNo");
	System.out.println("sSerialNo = "+sSerialNo);
	if(sSerialNo == null) sSerialNo = "";
	
	ASObjectModel doTemp = new ASObjectModel("DemoWizardInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";
	dwTemp.genHTMLObjectWindow(sSerialNo);
	
	String sButtons[][] = {
		{"true","","Button","��һ��","ɾ����ǰ��¼","toNextStep()","","","",""},
	};
%>
<%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function toNextStep(){
		as_save(0, "changeWizard()");
	}
	
	function changeWizard(){
		var sSerialNo = getItemValue(0, 0, "SerialNo");
		parent.wizard.setObjectNo(sSerialNo);
		parent.wizard.toNextStep();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>