<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		ҳ��˵��:�ĵ�������Ϣ
		Input Param:
		     ObjectNo: ������
             ObjectType: ��������
             DocNo: �ĵ����
	 */
 	sASWizardHtml = "<div><font size=\"2pt\" color=\"#930055\">&nbsp;&nbsp;�ĵ�������Ϣ</font></div>";
	//�������
	String sObjectNo = "";//--������
	//����������
	String sObjectType = CurPage.getParameter("ObjectType");
	String sRightType = CurPage.getParameter("RightType");//Ȩ��
	if(sRightType == null) sRightType = "";
	if(sObjectType == null) sObjectType = "";
	if(sObjectType.equals("Customer"))
	 	sObjectNo = CurPage.getParameter("CustomerID");
	else
		sObjectNo=  CurPage.getParameter("ObjectNo");
	if(sObjectNo == null) sObjectNo = "";
	//���ҳ��������ĵ���ź��ĵ�¼����ID
	String sDocNo = CurPage.getParameter("DocNo");
	String sUserID = CurPage.getParameter("UserID");
	if(sDocNo == null) sDocNo = "";
	if(sUserID == null) sUserID = "";

	ASObjectModel doTemp = new ASObjectModel("DocumentInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // ����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // �����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sDocNo);

	String sButtons[][] = {
		{(CurUser.getUserID().equals(sUserID)?"true":"false"),"","Button","����","���������޸�","saveRecord()","","","",""},
		{(CurUser.getUserID().equals(sUserID)?"false":"false"),"","Button","�鿴/�޸ĸ���","�鿴/�޸�ѡ���ĵ���ص����и���","viewAndEdit_attachment()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(sPostEvents){
		as_save("myiframe0",sPostEvents);
	}

	<%/*~[Describe=�鿴��������;]~*/%>
	function viewAndEdit_attachment(){
		var sDocNo = getItemValue(0,getRow(),"DocNo");
		var sUserID = getItemValue(0,getRow(),"UserID");//ȡ¼����ID
		var sRightType="<%=sRightType%>";
		if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
        	alert("���ȱ����ĵ����ݣ����ϴ�������");  //��ѡ��һ����¼��
			return;
    	}else{
			AsControl.OpenPage("/AppConfig/Document/AttachmentFrame.jsp", "DocNo="+sDocNo+"&UserID="+sUserID+"&RightType="+sRightType, "frameright");
    		reloadSelf();
		}
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>