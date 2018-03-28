<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: 数据对象目录列表
	 */
	String PG_TITLE = "数据对象目录列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	
	//获得组件参数	
	String sDoNo =  CurPage.getParameter("DoNo");
	String sDoName =  CurPage.getParameter("DoName");
	if(sDoNo==null) sDoNo="";
	if(sDoName==null) sDoName="";
    
	ASDataObject doTemp = new ASDataObject("DataObjectList",Sqlca);
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);

	//定义后续事件
	dwTemp.setEvent("BeforeDelete","!Configurator.DelDOLibrary(#DoNo)");
	
	//生成HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
	String sButtons[][] = {
		{"true","","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
	};
%><%@include file="/Resources/CodeParts/List05.jsp"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.PopView("/Common/Configurator/DataObject/DataObjectView.jsp","");
		reloadSelf();
	}
	
	function viewAndEdit(){
       	var sDoNo = getItemValue(0,getRow(),"DoNo");
       	if(typeof(sDoNo)=="undefined" || sDoNo.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		openObject("DataObject",sDoNo,"001");
	}
    
	function deleteRecord(){
		var sDoNo = getItemValue(0,getRow(),"DoNo");
		if(typeof(sDoNo)=="undefined" || sDoNo.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		
		if(confirm(getHtmlMessage('45'))){
			as_del("myiframe0");
			as_save("myiframe0");  //如果单个删除，则要调用此语句
		}
	}
	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
<%	if(!doTemp.haveReceivedFilterCriteria()) {%>
		//showFilterArea();
<%	}%>
</script>	
<%@ include file="/IncludeEnd.jsp"%>