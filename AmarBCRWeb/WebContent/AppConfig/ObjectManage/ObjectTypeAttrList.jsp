<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: �������������б�
	 */
    //���ҳ�����	
	String sObjectType = CurPage.getParameter("ObjectType");
	if (sObjectType == null) sObjectType = "";

	ASObjectModel doTemp = new ASObjectModel("ObjTypeAttributeList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sObjectType);
	
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	setDialogTitle("�������������б�");
	function newRecord(){
		AsControl.PopComp("/AppConfig/ObjectManage/ObjectTypeAttrInfo.jsp","ObjectType=<%=sObjectType%>","");
        reloadSelf();
	}
	
	function viewAndEdit(){
		var sObjectType = getItemValue(0,getRow(),"ObjectType");
		var sAttributeID = getItemValue(0,getRow(),"AttributeID");
		if(typeof(sAttributeID)=="undefined" || sAttributeID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		AsControl.PopComp("/AppConfig/ObjectManage/ObjectTypeAttrInfo.jsp","ObjectType="+sObjectType+"&AttributeID="+sAttributeID,"");
		reloadSelf();
	}

	function deleteRecord(){
		var sAttributeID = getItemValue(0,getRow(),"AttributeID");
		if(typeof(sAttributeID)=="undefined" || sAttributeID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm(getHtmlMessage('2'))){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>