<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		ҳ��˵��:�ĵ������б�
	 */
	//����������
	String sDocNo = CurPage.getParameter("DocNo");
	String sUserID = CurPage.getParameter("UserID");
	if(sDocNo == null) sDocNo = "";
	if(sUserID == null) sUserID = "";

	ASObjectModel doTemp = new ASObjectModel("AttachmentList");
	doTemp.setHtmlEvent("AttachmentNo,FileName,BeginTime,EndTime,ContentType,ContentLength", "ondblclick", "viewFile");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(25);//25��һ��ҳ
	dwTemp.genHTMLObjectWindow(sDocNo);
	
	String sButtons[][] = {
//		{(CurUser.getUserID().equals(sUserID)?"true":"false"),"","Button","����","��������","newRecord()","","","",""},
//		{"true","","Button","�鿴����","�鿴��������","viewFile()","","","",""},
//		{(CurUser.getUserID().equals(sUserID)?"true":"false"),"","Button","ɾ��","ɾ���ĵ���Ϣ","deleteRecord()","","","",""},
		};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		var sDocNo="<%=sDocNo%>";
		AsControl.PopView("/AppConfig/Document/AttachmentChooseDialog.jsp","DocNo="+sDocNo,"dialogWidth=650px;dialogHeight=250px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}

	function deleteRecord(){
		var sAttachmentNo = getItemValue(0,getRow(),"AttachmentNo");
		if (typeof(sAttachmentNo)=="undefined" || sAttachmentNo.length==0){
			alert(getHtmlMessage(1));  //��ѡ��һ����¼��
			return;
		}else{
			if(confirm(getHtmlMessage(2))){ //�������ɾ������Ϣ��
        		as_delete('myiframe0');
    		}
		}
	}

	<%/*~[Describe=�鿴���޸�����;]~*/%>
	function viewFile(){
		var sAttachmentNo = getItemValue(0,getRow(),"AttachmentNo");
		var sDocNo= getItemValue(0,getRow(),"DocNo");
		if (typeof(sAttachmentNo)=="undefined" || sAttachmentNo.length==0){
			alert(getHtmlMessage(1));  //��ѡ��һ����¼��
			return;
		}else{
			AsControl.OpenPage("/AppConfig/Document/AttachmentView.jsp","DocNo="+sDocNo+"&AttachmentNo="+sAttachmentNo);
		}
	}
	
	// �������ع���
	function exportFile(){
		var sAttachmentNo = getItemValue(0,getRow(),"AttachmentNo");
		var sDocNo= getItemValue(0,getRow(),"DocNo");
		if (sAttachmentNo =="undefined"||sAttachmentNo.length == 0){
			alert(getHtmlMessage(1));  //��ѡ��һ����¼��
			return;
		}else{
			// http ��ʽ
			//AsControl.PopView("/AppConfig/Document/AttachmentDownload.jsp","DocNo="+sDocNo+"&AttachmentNo="+sAttachmentNo,"");
			// servlet ��ʽ
			AsControl.PopView("/AppConfig/Document/AttachmentView.jsp","DocNo="+sDocNo+"&AttachmentNo="+sAttachmentNo+"&ViewType=save");
		}
	}
</script>
<%@	include file="/Frame/resources/include/include_end.jspf"%>