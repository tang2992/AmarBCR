<%@ page contentType="text/html; charset=GBK"%><%@
include file="/Frame/resources/include/include_begin_info.jspf"%><%
	String sClassifyID = CurPage.getParameter("ClassifyID");
	if(sClassifyID == null) sClassifyID = "";

	ASObjectModel doTemp = new ASObjectModel("GroupPageTreeConf");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sClassifyID);

	String sButtons[][] = {
		{"true","All","Button","����","","saveRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"
%><script type="text/javascript">
	setDialogTitle("���ҳ�������Ϣ");
	function saveRecord(){
		as_save(0, "setReturn()");
	}
	function setReturn(){
		top.returnValue = getItemValue(0, getRow(), "ClassifyID") +"@"+ getItemValue(0, getRow(), "SortNo");
		top.close();
	}
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>