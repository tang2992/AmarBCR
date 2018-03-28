<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    类及方法记录详情
		Input Param:
                    ClassName：    类名称
                    MethodName：   方法名称
	 */
	//定义变量
	String sDiaLogTitle;
	//获得组件参数	
	String sClassName =  CurPage.getParameter("ClassName");
	String sMethodName =  CurPage.getParameter("MethodName");
	String sClassDescribe =  CurPage.getParameter("ClassDescribe");
	if(sClassName==null) sClassName="";
	if(sMethodName==null) sMethodName="";
	if(sClassDescribe==null) sClassDescribe="";
	if (sClassName.equals("")){
		sDiaLogTitle = "【 新类新方法新增配置 】";	
	}else{
		if(sMethodName.equals("")){
			sDiaLogTitle = "【类"+sClassDescribe+"－["+ sClassName +"]】方法新增配置";
		}else{
			sDiaLogTitle = "【类"+sClassDescribe+"－["+ sClassName +"]】的『 "+sMethodName+" 』方法查看修改配置";
		}
	}

	ASObjectModel doTemp = new ASObjectModel("ClassMethodInfo");
	if (!sMethodName.equals("")) {
	   	doTemp.setReadOnly("METHODNAME",true);
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sClassName+","+sMethodName);
	
	String sButtons[][] = {
		{"true","","Button","保存并返回","保存修改并返回","saveRecordAndReturn()","","","",""},
		{"true","","Button","保存并新增","保存修改并新增另一条记录","saveRecordAndAdd()","","","",""},
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