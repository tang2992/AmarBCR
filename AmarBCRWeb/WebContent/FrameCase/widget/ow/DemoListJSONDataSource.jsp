<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	//����ģʽ��֧�ֵ���
	//String sTempletNo = "TestCustomerInfo";//ģ���
	String jsonASObject="{\"columns\":[{\"colName\":\"NAME\",\"colHeader\":\"����\"}"
		+ ",{\"colName\":\"SEX\",\"colHeader\":\"�Ա�\",\"colEditSourceType\":\"Code\",\"colEditSource\":\"Sex\"}"
		+ ",{\"colName\":\"IMCOME\",\"colCheckFormat\":\"2\",\"colHeader\":\"������\",\"colUnit\":\"(Ԫ)\"}]}";
	String jsonData = "[{\"NAME\":\"FLIAN\",\"SEX\":\"1\",\"IMCOME\":\"120000\"},{\"NAME\":\"lf\",\"SEX\":\"1\",\"IMCOME\":\"100000\"}]";
	ASObjectModel doTemp = ASObjectModel.createASObjectModelfromJSON(jsonASObject);
	doTemp.setDataQueryClass("com.amarsoft.awe.dw.ui.htmlfactory.imp.JsonListHtmlGenerator");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "1";//freeform
	dwTemp.ReadOnly = "1";//ֻ��ģʽ
	dwTemp.genHTMLObjectWindow(jsonData);
	
	String sButtons[][] = {
			
	};
	sButtonPosition = "south";
%>

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<%@include file="/Frame/resources/include/include_end.jspf"%>
