<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	//����������
	String sRoleID = CurPage.getParameter("RoleID");
	if(sRoleID == null) sRoleID = "";
	
	ASObjectModel doTemp = new ASObjectModel("ViewAllUserList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sRoleID);

	String sButtons[][] = {
		{"true","","Button","����Excel","����Excel","exportAll()","","","",""},
	};
%> <%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	setDialogTitle("��ɫ���û��б�");
	<%/*~[Describe=����;InputParam=��;OutPutParam=��;]~*/%>
	function exportAll(){
		as_defaultExport();
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>