<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    财务报表模型详情
	 */
	String sModelNo =  CurPage.getParameter("ModelNo"); //报表记录编号
	String sRowNo =  CurPage.getParameter("RowNo"); //行编号
	if(sModelNo==null) sModelNo="";
	if(sRowNo==null) sRowNo="";
	
	ASObjectModel doTemp = new ASObjectModel("ReportModelInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sModelNo+","+sRowNo);
	
	String sButtons[][] = {
		{"true","","Button","保存并返回","保存修改并返回","saveRecordAndReturn()","","","",""},
		{"true","","Button","保存并新增","保存修改并新增另一条记录","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("财务报表模型详情");
	function saveRecordAndReturn(){
		setItemValue(0,0,"ModelNo","<%=sModelNo%>");
		as_save("myiframe0","doReturn('Y');");
	}
    
	function saveRecordAndAdd(){
		setItemValue(0,0,"ModelNo","<%=sModelNo%>");
		as_save("myiframe0","newRecord()");
	}

    function doReturn(sIsRefresh){
		sObjectNo = getItemValue(0,getRow(),"ModelNo");
		parent.sObjectInfo = sObjectNo+"@"+sIsRefresh;
		parent.closeAndReturn();
	}
    
	function newRecord(){
		sModelNo = getItemValue(0,getRow(),"ModelNo");
		OpenComp("ReportModelInfo","/Common/Configurator/ReportManage/ReportModelInfo.jsp","ModelNo="+sModelNo,"_self","");
	}

	function myDBLClick(myobj){
		editObjectValueWithScriptEditorForAFS(myobj,'<%=sModelNo%>');
	}

	function openScriptEditorForAFSAndSetText(){
		var oMyobj = oTempObj;
		sOutPut = OpenComp("ScriptEditorForAFS","/Common/ScriptEditor/ScriptEditorForAFS.jsp","","");
		if(typeof(sOutPut)!="undefined" && sOutPut!="_CANCEL_"){
			oMyobj.value = amarsoft2Real(sOutPut);
		}
	}

	function SelectSubject(){
		setObjectValue("SelectAllSubject","","@RowSubject@0@ItemName@1",0,0,"");			
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>