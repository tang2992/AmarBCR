<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	String sDONo = CurPage.getParameter("DONo");
	if(sDONo == null) sDONo = "";
	
	ASObjectModel doTemp = new ASObjectModel("DataObjectGroupList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sDONo);

	String sButtons[][] = {
		{"true", "All","Button","��������","��ǰҳ������","afterAdd()","","",""},
		{"true", "All","Button","���ٱ���","���ٱ��浱ǰҳ��","afterSave()","","",""},
		{"true", "All", "Button", "ɾ��", "", "deleteRecord()", "", "", ""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	setDialogTitle("DataWindow��ʾģ�������Ϣ");
	var sDONo = "<%=sDONo%>";
	function afterSave(){
		as_save("myiframe0");
	}
	
	//��������
	function afterAdd(){
		as_add("myiframe0");
		//��������ʱ�����Ĭ��ֵ
		setItemValue(0,getRow(),"DONO",sDONo);
	}
	
	//����ɾ��
	function deleteRecord(){
		var sDockId = getItemValue(0,getRow(),"DOCKID");
		if (typeof(sDockId)=="undefined" || sDockId.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		if(confirm(getHtmlMessage("2"))){ //�������ɾ������Ϣ��
			as_delete("myiframe0");
		}
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>