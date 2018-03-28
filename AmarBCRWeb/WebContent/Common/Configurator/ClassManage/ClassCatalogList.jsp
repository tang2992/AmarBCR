<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: 类及方法目录列表
	 */
	String PG_TITLE = "类及方法目录列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
  	//获得组件参数	
	String sClassName =  CurPage.getParameter("ClassName");   //类名
	if (sClassName == null) sClassName = "";
	
	ASObjectModel doTemp = new ASObjectModel("ClassCatalogList");
	if(sClassName!=null && !sClassName.equals("")){
		doTemp.appendJboWhere(" AND ClassName='"+sClassName+"'");
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(8);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"false","","Button","保存","保存修改","saveRecord()","","","",""},
		{"true","","Button","删除","删除所选中的记录","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.PopComp("/Common/Configurator/ClassManage/ClassCatalogInfo.jsp","","");
       	reloadSelf();
	}
	
    /*~[Describe=查看及修改该类对应方法;InputParam=无;OutPutParam=无;]~*/
	function viewAndEdit(){
       	var sClassName = getItemValue(0,getRow(),"ClassName");
       	var sClassDescribe = getItemValue(0,getRow(),"ClassDescribe");
       	if(typeof(sClassName)=="undefined" || sClassName.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
       	AsControl.PopComp("/Common/Configurator/ClassManage/ClassCatalogInfo.jsp","ClassName="+sClassName+"&ClassDescribe="+sClassDescribe,"");
       	reloadSelf();     
	}
    
	function saveRecord(){
		as_save("myiframe0","");
	}

    /*~[Describe=查看及修改详情;InputParam=无;OutPutParam=无;]~*/
	function mySelectRow(){
       	var sClassName = getItemValue(0,getRow(),"ClassName");
       	var sClassDescribe = getItemValue(0,getRow(),"ClassDescribe");
		if(typeof(sClassName)=="undefined" || sClassName.length==0) {
		}else{
			AsControl.OpenView("/Common/Configurator/ClassManage/ClassMethodList.jsp","ClassName="+sClassName+"&ClassDescribe="+sClassDescribe,"rightdown","");
		}
	}

	function deleteRecord(){
		var sClassName = getItemValue(0,getRow(),"ClassName");
		if(typeof(sClassName)=="undefined" || sClassName.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		if(confirm(getHtmlMessage('54'))){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>