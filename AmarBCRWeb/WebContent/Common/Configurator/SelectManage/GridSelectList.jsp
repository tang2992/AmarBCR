<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: 列表查询选择
		History Log: 
		  zywei 2007/10/11 新增Attribute4为是否根据检索条件查询，即解决大数据量查询引起的响应延迟
	 */
	ASObjectModel doTemp = new ASObjectModel("GridSelectList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		OpenPage("/Common/Configurator/SelectManage/GridSelectInfo.jsp","_self","");      
	}
	
	function viewAndEdit(){
		var sSelName = getItemValue(0,getRow(),"SelName");
		if(typeof(sSelName) == "undefined" || sSelName.length == 0){
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
       OpenPage("/Common/Configurator/SelectManage/GridSelectInfo.jsp?SelName="+sSelName,"_self","");           
	}
    
	function deleteRecord(){
		var sSelName = getItemValue(0,getRow(),"SelName");
		if(typeof(sSelName) == "undefined" || sSelName.length == 0){
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		if(confirm(getHtmlMessage('2'))){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>