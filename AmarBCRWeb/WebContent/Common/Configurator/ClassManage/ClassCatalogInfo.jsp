<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
		/*
		Content:    �༰����Ŀ¼����
		Input Param:
                    ClassName��    ������
	 */
	//�������
	String sDiaLogTitle;
	//����������	
	String sClassName =  CurPage.getParameter("ClassName");
	String sClassDescribe =  CurPage.getParameter("ClassDescribe");
	if(sClassName==null){
		sClassName="";
		sDiaLogTitle = "�� ������ ��";
	}else{
		sDiaLogTitle = "��"+sClassDescribe+"����������"+sClassName+"���鿴�޸�����";	
	}

	ASObjectModel doTemp = new ASObjectModel("ClassCatalogInfo");
 	if (sClassName != "")	doTemp.setReadOnly("ClassName",true);
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sClassName);
	
	String sButtons[][] = {
		{"true","","Button","����","�����޸�","saveRecord()","","","",""},
		{"true","","Button","���沢����","�����޸Ĳ�������һ����¼","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("<%=sDiaLogTitle%>");
	function saveRecord(sPostEvents){
		as_save("myiframe0",sPostEvents);
	}
	function saveRecordAndAdd(){
		saveRecord("newRecord()");
	}
	function newRecord(){
		OpenComp("ClassCatalogInfo","/Common/Configurator/ClassManage/ClassCatalogInfo.jsp","ClassName=","_self","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>