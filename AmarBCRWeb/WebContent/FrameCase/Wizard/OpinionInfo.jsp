<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	String sSerialNo = CurPage.getParameter("ObjectNo");
	//System.out.println("sSerialNo = "+sSerialNo);
	if(sSerialNo == null) sSerialNo = "";
	//System.out.println(CurPage.getAttribute("IsSubmit"));
	boolean flag = "1".equals(Sqlca.getString(new SqlObject("select Flag from DEMO_WIZARD_INFO where SerialNo = :SerialNo").setParameter("SerialNo", sSerialNo)));
	
	ASObjectModel doTemp = new ASObjectModel("DemoWizardInfo");
	doTemp.setVisible("Opinion", true);
	doTemp.setRequired("Opinion", true);
	if(flag) doTemp.setReadOnly("Opinion", true);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";
	dwTemp.genHTMLObjectWindow(sSerialNo);
	
	String sFlag = String.valueOf(!flag);
	String sButtons[][] = {
			{sFlag,"","Button","��һ��","","parent.wizard.toPrevStep()","","","",""},
			{sFlag,"","Button","�ύ","","as_save(0, 'parent.wizard.reload()')","","","",""},
			{sFlag,"","Button","�ݴ�","","as_saveTmp(0)","","","",""},
	};
%>
<%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>