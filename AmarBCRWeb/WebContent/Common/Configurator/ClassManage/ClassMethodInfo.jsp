<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    �༰������¼����
		Input Param:
                    ClassName��    ������
                    MethodName��   ��������
	 */
	//�������
	String sDiaLogTitle;
	//����������	
	String sClassName =  CurPage.getParameter("ClassName");
	String sMethodName =  CurPage.getParameter("MethodName");
	String sClassDescribe =  CurPage.getParameter("ClassDescribe");
	if(sClassName==null) sClassName="";
	if(sMethodName==null) sMethodName="";
	if(sClassDescribe==null) sClassDescribe="";
	if (sClassName.equals("")){
		sDiaLogTitle = "�� �����·����������� ��";	
	}else{
		if(sMethodName.equals("")){
			sDiaLogTitle = "����"+sClassDescribe+"��["+ sClassName +"]��������������";
		}else{
			sDiaLogTitle = "����"+sClassDescribe+"��["+ sClassName +"]���ġ� "+sMethodName+" �������鿴�޸�����";
		}
	}

	ASObjectModel doTemp = new ASObjectModel("ClassMethodInfo");
	if (!sMethodName.equals("")) {
	   	doTemp.setReadOnly("METHODNAME",true);
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sClassName+","+sMethodName);
	
	String sButtons[][] = {
		{"true","","Button","���沢����","�����޸Ĳ�����","saveRecordAndReturn()","","","",""},
		{"true","","Button","���沢����","�����޸Ĳ�������һ����¼","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("<%=sDiaLogTitle%>");
	function saveRecord(sPostEvents){
		as_save("myiframe0",sPostEvents);	
	}
	
	function saveRecordAndReturn(){
		saveRecord("doReturn('Y');");
	}
	
	function saveRecordAndAdd(){
	    saveRecord("newRecord()");
	}
	
	function doReturn(sIsRefresh){
		top.close();
	}
    
	function newRecord(){
        var sClassName = getItemValue(0,getRow(),"CLASSNAME");
        AsControl.OpenComp("/Common/Configurator/ClassManage/ClassMethodInfo.jsp","ClassName="+sClassName+"&MethodName=","_self");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>