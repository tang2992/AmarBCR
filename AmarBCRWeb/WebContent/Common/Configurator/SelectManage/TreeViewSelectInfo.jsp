<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
		/*
		Content: ��ѯ������Ϣ����
		Input Param:
               SelName����ѯ����
	 */
	//���ҳ�����	
	String sSelName =  CurPage.getParameter("SelName");
	if(sSelName == null) sSelName = "";
	
	ASObjectModel doTemp = new ASObjectModel("TreeViewSelectInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sSelName);
	
	String sButtons[][] = {
		{"true","","Button","���沢����","�����޸Ĳ�����","saveRecordAndReturn()","","","",""},
		{"true","","Button","���沢����","�����޸Ĳ�������һ����¼","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecordAndReturn(){
        as_save("myiframe0","doReturn();");        
	}
    
	function saveRecordAndAdd(){
        as_save("myiframe0","newRecord()");
	}

	function doReturn(){
		OpenPage("/Common/Configurator/SelectManage/TreeViewSelectList.jsp","_self","");
	}
    
	function newRecord(){
		OpenPage("/Common/Configurator/SelectManage/TreeViewSelectInfo.jsp","_self","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>