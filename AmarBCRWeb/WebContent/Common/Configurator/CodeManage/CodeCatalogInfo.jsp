<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content: ����Ŀ¼����
	 */
	//����������	
	String sCodeNo =  CurPage.getParameter("CodeNo"); //������
	String sCodeTypeOne =  CurPage.getParameter("CodeTypeOne");   //����
	String sCodeTypeTwo =  CurPage.getParameter("CodeTypeTwo");   //С��
	if(sCodeNo==null) sCodeNo="";

	ASObjectModel doTemp = new ASObjectModel("CodeCatalogInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sCodeNo);
	
	String sButtons[][] = {
		{"true","","Button","����","�����޸�","saveRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("����Ŀ¼����");
	setItemValue(0,0,"CodeTypeOne","<%=sCodeTypeOne%>");
	setItemValue(0,0,"CodeTypeTwo","<%=sCodeTypeTwo%>");
	var sOldCodeNo = getItemValue(0, 0, "CodeNo");
	function saveRecord(){
		if(!validate()) return;
		as_save("myiframe0","doReturn('Y');");
	}
    
    function doReturn(sIsRefresh){
		sObjectNo = getItemValue(0,getRow(),"CodeNo");
		parent.sObjectInfo = sObjectNo+"@"+sIsRefresh;
		parent.closeAndReturn();
	}
    
    function validate(){
    	var sCodeNo = getItemValue(0, 0, "CodeNo");
    	var sResult = AsControl.RunJavaMethodSqlca("com.amarsoft.app.configurator.bizlets.CodeCatalogAction", "validate", "CodeNo="+sCodeNo+",OldCodeNo="+sOldCodeNo);
    	if(sResult != "SUCCESS"){
    		alert(sResult);
    		return false;
    	}
    	return true;
    }
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>