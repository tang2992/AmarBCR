<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	String sDoNo = CurPage.getParameter("DoNo");
	String sColName = CurPage.getParameter("ColName");

	ASObjectModel doTemp = new ASObjectModel("ObjectModelEventList");
	doTemp.setLockCount(2); //��������
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "0";//�༭ģʽ
	dwTemp.setPageSize(20);
	dwTemp.ConvertCode2Title = "1";
	dwTemp.genHTMLObjectWindow(sDoNo+","+sColName);

	String sButtons[][] = {
		{"true", "All", "Button", "����", "����һ��", "afterAdd()", "", "", "", "btn_icon_add"},
		{"true", "All", "Button", "����", "�����޸�����", "afterSave()", "", "", "", "btn_icon_save"},
		{"true", "All", "Button", "ɾ��", "ɾ��ѡ����", "deleteRecord()", "", "", "", ""},
	};
%>
<script type="text/javascript">
function afterAdd(){
	as_add(0);
	//��������ʱ�����Ĭ��ֵ
	setItemValue(0, getRow(), "DONO", "<%=sDoNo%>");
	setItemValue(0, getRow(), "COLNAME", "<%=sColName%>");
}
function afterSave(){
	as_save(0);
}
//����ɾ��
function deleteRecord(){
	if(!confirm('ȷʵҪɾ����?')) return;
	as_delete(0);
}
</script>
<%@ include file="/Frame/resources/include/ui/include_list.jspf"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>