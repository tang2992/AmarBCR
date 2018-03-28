<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
		/*
		Content: 查询树型信息详情
		Input Param:
               SelName：查询名称
	 */
	//获得页面参数	
	String sSelName =  CurPage.getParameter("SelName");
	if(sSelName == null) sSelName = "";
	
	ASObjectModel doTemp = new ASObjectModel("TreeViewSelectInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sSelName);
	
	String sButtons[][] = {
		{"true","","Button","保存并返回","保存修改并返回","saveRecordAndReturn()","","","",""},
		{"true","","Button","保存并新增","保存修改并新增另一条记录","saveRecordAndAdd()","","","",""},
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