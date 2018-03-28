<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		ҳ��˵��:�ĵ���Ϣ�б�
		Input Param:
       		    ObjectNo: ������
       		    ObjectType: ��������           		
	 */
	String PG_TITLE = "�ĵ���Ϣ�б�";
	//�������                     
	String sObjectNo = "";//--������
	
	//����������
	String sObjectType = CurPage.getParameter("ObjectType");
	String sRightType = CurPage.getParameter("RightType");//Ȩ��
	if(sObjectType == null) sObjectType = "";
	if(sRightType == null) sRightType = "";
	if(sObjectType.equals("Customer"))
	 	sObjectNo = CurPage.getParameter("CustomerID");
	else
		sObjectNo = CurPage.getParameter("ObjectNo");
	if(sObjectNo == null) sObjectNo = "";

	ASObjectModel doTemp = new ASObjectModel("DocumentList");
	if(sObjectType.equals("Customer")) //�ͻ��ĵ�
		doTemp.appendJboWhere(" AND DOC_RELATIVE.OBJECTTYPE='Customer' ");
	else doTemp.appendJboWhere(" AND DOC_RELATIVE.OBJECTTYPE<>'Customer' ");
	
	//���ݶ����Ž��в�ѯ
    if (!sObjectNo.equals(""))
    	doTemp.appendJboWhere(" AND DR.ObjectNo='" + sObjectNo + "' ");
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(25);
	dwTemp.genHTMLObjectWindow(sObjectType);

	String sButtons[][] = {
		{"true","","Button","����","�����ĵ���Ϣ","newRecord()","","","",""},
		{"true","","Button","ɾ��","ɾ���ĵ���Ϣ","deleteRecord()","","","",""},
		{"false","","Button","�ĵ�����","�鿴�ĵ�����","viewAndEdit_doc()","","","",""},
		{"false","","Button","��������","�鿴��������","viewAndEdit_attachment()","","","",""},
		{"false","","Button","��������","���������ĵ���Ϣ","exportFile()","","","",""},
	};
	if(sObjectNo.equals("")){
		sButtons[0][0]="false";
		sButtons[1][0]="false";
	}
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.OpenComp("/AppConfig/Document/DocumentInfo.jsp","UserID=<%=CurUser.getUserID()%>","rightdown");
	}

	function deleteRecord(){
		var sUserID=getItemValue(0,getRow(),"UserID");//ȡ�ĵ�¼����	
		var sDocNo = getItemValue(0,getRow(),"DocNo");
		if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
			alert(getHtmlMessage(1));  //��ѡ��һ����¼��
			return;
		}else if(sUserID=='<%=CurUser.getUserID()%>'){
			if(confirm(getHtmlMessage(2))){ //�������ɾ������Ϣ��
				as_delete('myiframe0');
			}
		}else{
			alert(getHtmlMessage('3'));
			return;
		}
	}

	<%/*~[Describe=�鿴���޸�����;]~*/%>
	function viewAndEdit_doc(){
		var sDocNo=getItemValue(0,getRow(),"DocNo");
		var sUserID=getItemValue(0,getRow(),"UserID");//ȡ�ĵ�¼����		     	
    	if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
        	alert(getHtmlMessage(1));  //��ѡ��һ����¼��
			return;
    	}else{
    		AsControl.OpenComp("/AppConfig/Document/DocumentInfo.jsp","DocNo="+sDocNo+"&UserID="+sUserID,"rightdown");
        }
	}
	
	<%/*~[Describe=�鿴���޸ĸ�������;]~*/%>
	function viewAndEdit_attachment(){
    	var sDocNo=getItemValue(0,getRow(),"DocNo");
    	var sUserID=getItemValue(0,getRow(),"UserID");//ȡ�ĵ�¼����
    	var sRightType="<%=sRightType%>";
    	if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
        	alert(getHtmlMessage(1));  //��ѡ��һ����¼��
			return;         
    	}else{
    		//AsControl.PopComp("/AppConfig/Document/AttachmentList.jsp","DocNo="+sDocNo+"&UserID="+sUserID+"&RightType="+sRightType);
    		AsControl.PopComp("/AppConfig/Document/AttachmentFrame.jsp", "DocNo="+sDocNo+"&UserID="+sUserID+"&RightType="+sRightType, "");
    		reloadSelf();
      	}
	}
	
	<%/*~[Describe=��������;]~*/%>
	function exportFile(){
    	OpenPage("/AppConfig/Document/ExportFile.jsp","_self","");
	}
	function mySelectRow(){
		var sDocNo=getItemValue(0,getRow(),"DocNo");
		var sUserID=getItemValue(0,getRow(),"UserID");//ȡ�ĵ�¼����		     	
    	if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
        	alert(getHtmlMessage(1));  //��ѡ��һ����¼��
			return;
    	}else{
    		AsControl.OpenComp("/AppConfig/Document/DocumentFrameMix.jsp","DocNo="+sDocNo+"&UserID="+sUserID,"rightdown");
        }
	}
	mySelectRow();
</script>
<%@	include file="/Frame/resources/include/include_end.jspf"%>