<%@ page contentType="text/html; charset=GBK"%><%@
include file="/Frame/resources/include/include_begin_info.jspf"%><%
	String sGroupID = CurPage.getParameter("GroupID");
	String sItemNo = CurPage.getParameter("ItemNo");
	String sDisplayType = CurPage.getParameter("DisplayType");
	if(sGroupID == null) sGroupID = "";
	if(sItemNo == null) sItemNo = "";
	if(sDisplayType == null) sDisplayType = "";

	ASObjectModel doTemp = new ASObjectModel("GroupPageItemInfo");
	if(!"2".equals(sDisplayType)) doTemp.setVisible("Attribute2",false);//�����Strip��չʾ��������߶ȡ�
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sGroupID+","+sItemNo);

	String sButtons[][] = {
		{"true","All","Button","����","","saveRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"
%><script type="text/javascript">
	function saveRecord(){
		as_save(0,'self.close();');
	}
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>