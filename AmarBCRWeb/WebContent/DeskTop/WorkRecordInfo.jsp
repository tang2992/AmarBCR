<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Describe:--�����ʼ�����;
		Input Param:
			ObjectNo��������
			NoteType���ʼ�����
			SerialNo���ʼ���ˮ��
	 */
	//���ҳ�����
	String sNoteType = CurPage.getParameter("NoteType");
	String sObjectNo = CurPage.getParameter("ObjectNo");
	String sSerialNo = CurPage.getParameter("SerialNo");
	if(sNoteType == null) sNoteType = "";
	if(sObjectNo == null) sObjectNo = "";
	if(sSerialNo == null) sSerialNo = "";
	
	//ͨ����ʾģ�����ASDataObject����doTemp
	ASObjectModel doTemp = new ASObjectModel("WorkRecordInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request); 
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sSerialNo);

	String sButtons[][] = {
		{"true","","Button","����","���������޸�","saveRecord()","","","",""},
		{sNoteType.indexOf("All")>=0?"true":"false","","Button","����","�����б�ҳ��","goBack()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("�����ʼ�");
	function saveRecord(sPostEvents){
		as_save("myiframe0",sPostEvents);	
	}
	
	function goBack(){
		OpenPage("/DeskTop/WorkRecordList.jsp","_self","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>