<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: 财务报表模型列表
	 */
	String sModelNo =  CurPage.getParameter("ModelNo");
	if (sModelNo == null) 	sModelNo = "";

	ASObjectModel doTemp = new ASObjectModel("ReportModelList");
	doTemp.appendHTMLStyle("Col1Def,Col2Def,Col3Def,Col4Def"," style=\"cursor: pointer;\" ondblclick=\"myDBLClick(this)\"");
	//doTemp.appendHTMLStyle("RowSubjectName"," style=\"cursor: pointer;\" ondblclick=\"SelectSubject()\"");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(50);
	dwTemp.genHTMLObjectWindow(sModelNo);
	
	String sButtons[][] = {
		{"true","","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","","Button","保存","保存修改","saveRecord()","","","",""},
		{"true","","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
		{"true","","Button","生成/更新公式解释","公式的中文解释生成/更新到formulaexp字段中","genExplain()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		var sReturn=popComp("ReportModelInfo","/Common/Configurator/ReportManage/ReportModelInfo.jsp","ModelNo=<%=sModelNo%>","");
        //修改数据后刷新列表
		if (typeof(sReturn)!='undefined' && sReturn.length!=0){
			sReturnValues = sReturn.split("@");
			if (sReturnValues[0].length !=0 && sReturnValues[1]=="Y"){
				OpenPage("/Common/Configurator/ReportManage/ReportModelList.jsp?ModelNo="+sReturnValues[0],"_self","");           
            }
        }
	}
    
	function saveRecord(){
		as_save("myiframe0","");
	}

	function myDBLClick(myobj){
		//OW与DW下取得input对象不同
		myobj = $("input:first",myobj)[0];
        editObjectValueWithScriptEditorForAFS(myobj,'<%=sModelNo%>');
    }

	function viewAndEdit(){
		var sModelNo = getItemValue(0,getRow(),"ModelNo");
		var sRowNo = getItemValue(0,getRow(),"RowNo");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		sReturn=popComp("ReportModelInfo","/Common/Configurator/ReportManage/ReportModelInfo.jsp","ModelNo="+sModelNo+"&RowNo="+sRowNo,"");
        //修改数据后刷新列表
		if (typeof(sReturn)!='undefined' && sReturn.length!=0){
			sReturnValues = sReturn.split("@");
			if (sReturnValues[0].length !=0 && sReturnValues[1]=="Y"){
				OpenPage("/Common/Configurator/ReportManage/ReportModelList.jsp?ModelNo="+sReturnValues[0],"_self","");           
            }
        }
	}

	function deleteRecord(){
		var sRowNo = getItemValue(0,getRow(),"RowNo");
		if(typeof(sRowNo)=="undefined" || sRowNo.length==0) {
			alert(getHtmlMessage('1'));//请选择一条信息！
			return ;
		}
		if(confirm(getHtmlMessage('2'))){
			as_delete("myiframe0");
		}
	}
	
	function genExplain(){
		var sReturn = RunMethod("Configurator","GenFinStmtExplain","<%=sModelNo%>");
		if(typeof(sReturn)!="undefined" && sReturn=="succeeded"){
			alert("已将公式的中文解释生成/更新到formulaexp1、formulaexp2字段中。");
		}else{
			alert(sReturn);
		}
	}

	function SelectSubject(){
		setObjectValue("SelectAllSubject","","@RowSubject@0@RowSubjectName@1",0,0,"");			
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>