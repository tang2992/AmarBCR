<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��: ʾ���б�ҳ��
	 */
	String PG_TITLE = "ʾ���б�ҳ��";

	//ͨ��DWģ�Ͳ���ASDataObject����doTemp
	ASDataObject doTemp = new ASDataObject("ExampleList",Sqlca);
	ASDataWindow dwTemp = new ASDataWindow(CurPage ,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	
	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));

	String sButtons[][] = {};
%><%@include file="/Resources/CodeParts/List05.jsp"%>
<script type="text/javascript">
	<%/*��¼��ѡ��ʱ�����¼�*/%>
	function mySelectRow(){
		var sExampleId = getItemValue(0,getRow(),"ExampleId");
		if(!sExampleId) return;
		parent.OpenInfo(sExampleId);
	}

	$(document).ready(function(){
		AsOne.AsInit();
		init();
		bHighlightFirst = true;
		my_load(2,0,'myiframe0');
		mySelectRow();
	});
</script>	
<%@ include file="/IncludeEnd.jsp"%>