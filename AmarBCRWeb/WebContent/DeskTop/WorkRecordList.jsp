 <%@ page contentType="text/html; charset=GBK"%><%@
  include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Describe:--�����ʼ��б�;
		Input Param:
			ObjectNo�� ������
			NoteType�� �ʼ�����
	 */
	String PG_TITLE = "�����ʼ��б�"; // ��������ڱ��� <title> PG_TITLE </title>

	//����������
	String sNoteType = CurPage.getParameter("NoteType");
	String sObjectNo = CurPage.getParameter("ObjectNo");
	if(sNoteType == null) sNoteType = "";
	if(sObjectNo == null) sObjectNo = "";

	ASObjectModel doTemp = new ASObjectModel("WorkRecordList");
	/* if (!sNoteType.equals("All")){
		doTemp.appendJboWhere(" and ObjectType = '"+sNoteType+"' and ObjectNo = '"+sObjectNo+"' ");
	} */
		
	//����DataWindow
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(CurUser.getUserID());

	String sButtons[][] = {
		{"true","","Button","����","�����ͻ��������ʼ�","newRecord()","","","",""},
		{"true","","Button","����","�鿴�ͻ��������ʼ�","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ���ͻ��������ʼ�","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		OpenPage("/DeskTop/WorkRecordInfo.jsp","_self","");
	}

	function deleteRecord(){
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}else if(confirm(getHtmlMessage('2'))){ //�������ɾ������Ϣ��
			as_delete('myiframe0');
		}
	}

	function viewAndEdit(){
		var sSerialNo = getItemValue(0,getRow(),"SerialNo");//--��ǰ��ˮ��
		if (typeof(sSerialNo)=="undefined" || sSerialNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}else{
			OpenPage("/DeskTop/WorkRecordInfo.jsp?SerialNo="+sSerialNo, "_self","");
		}
	}
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>