<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	String jsonASObject="{\"columns\":[{\"colName\":\"NAME\",\"colHeader\":\"����\"}"
		+ ",{\"colName\":\"SEX\",\"colHeader\":\"�Ա�\",\"colEditSourceType\":\"Code\",\"colEditSource\":\"Sex\",\"colEditStyle\":\"Select\"}"
		+ ",{\"colName\":\"IMCOME\",\"colCheckFormat\":\"2\",\"colHeader\":\"������\",\"colUnit\":\"(Ԫ)\"}]}";
	String jsonData = "{\"NAME\":\"FLIAN\",\"SEX\":\"1\",\"IMCOME\":\"120000\"}";
	ASObjectModel doTemp = ASObjectModel.createASObjectModelfromJSON(jsonASObject);
	doTemp.setDataQueryClass("com.amarsoft.awe.dw.ui.htmlfactory.imp.JsonInfoHtmlGenerator");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.ReadOnly = "0"; //����ģʽ  1:ֻ�� 0:��д -2:��ӡ
	dwTemp.genHTMLObjectWindow(jsonData);
	
	String sButtons[][] = {
		{"true","All","Button","��ȡ�ֶ�ֵ","��ȡ�ֶ�ֵ","getValue()","","","",""}
	};
	sButtonPosition = "south";
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script>
	function getValue(){
		alert(getItemHeader(0,0,"NAME")+":"+getItemValue(0,0,"NAME")+" "+getItemHeader(0,0,"SEX")+":"+getItemValue(0,0,"SEX"));
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>