<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: 数据对象详情
	 */
	String PG_TITLE = "数据对象详情"; // 浏览器窗口标题 <title> PG_TITLE </title>
	
	//获得组件参数	
	String sDoNo =  CurPage.getParameter("DoNo");
	String sColIndex =  CurPage.getParameter("ColIndex");

	if(sDoNo==null) sDoNo="";
	if(sColIndex==null) sColIndex="";

	ASDataObject doTemp = new ASDataObject("DOLibraryInfo",Sqlca);
	if (!sDoNo.equals("")) {
 	  	doTemp.setRequired("DoNo",false);
		doTemp.setReadOnly("DoNo",true);
	}
		
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	
	//定义后续事件
	dwTemp.setEvent("AfterUpdate","!Configurator.UpdateDOUpdateTime("+StringFunction.getTodayNow()+","+CurUser.getUserID()+","+sDoNo+")");
	
	//生成HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow(sDoNo+","+sColIndex);
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
	String sButtons[][] = {
		{"true","","Button","保存","保存修改","saveRecord('reviewSelf()')","","","",""},
		{"true","","Button","保存并返回","保存修改并返回","saveRecordAndReturn()","","","",""},
	};
%><%@include file="/Resources/CodeParts/List05.jsp"%>
<script type="text/javascript">
	function saveRecord(sFun){
		if(!validate()) return;
	    as_save("myiframe0", sFun);
	}
	
	function reviewSelf(){
		var sDoNo =  getItemValue(0, 0, "DoNo");
		var sColIndex =  getItemValue(0, 0, "ColIndex");
		AsControl.OpenComp("/Common/Configurator/DataObject/DOLibraryInfo.jsp", "DoNo="+sDoNo+"&ColIndex="+sColIndex, "_self");
	}
	
	function saveRecordAndReturn(){
		saveRecord("doReturn('Y');");
	}
    
    function doReturn(sIsRefresh){
		sObjectNo = getItemValue(0,getRow(),"DoNo");
       parent.sObjectInfo = sObjectNo+"@"+sIsRefresh;
		parent.closeAndReturn();
	}

    var sOldColIndex = "";
	function initRow(){
		if (getRowCount(0)==0){
			as_add("myiframe0");
           setItemValue(0,0,"DoNo","<%=sDoNo%>");            
            setItemValue(0,0,"ColKey","0");
            setItemValue(0,0,"ColVisible","1");
            setItemValue(0,0,"ColReadOnly","0");
            setItemValue(0,0,"ColRequired","0");
            setItemValue(0,0,"ColSortable","1");
            setItemValue(0,0,"ColCheckItem","0");
            setItemValue(0,0,"ColTransferBack","0");
            setItemValue(0,0,"IsForeignKey","0");
            setItemValue(0,0,"IsInUse","1");
            setItemValue(0,0,"ColColumnType","1");
            setItemValue(0,0,"ColCheckFormat","1");
            setItemValue(0,0,"ColAlign","1");
            setItemValue(0,0,"ColEditStyle","1");            
            setItemValue(0,0,"ColType","String");
            setItemValue(0,0,"ColUpdateable","1");
            setItemValue(0,0,"ColLimit","0");
            setItemValue(0,0,"IsFilter","0");
            bIsInsert = true;
		}
		sOldColIndex = getItemValue(0, 0, "ColIndex");
	}

	function validate(){
		var sColIndex = getItemValue(0, 0, "ColIndex");
		if(sColIndex != sOldColIndex){
			var sResult = AsControl.RunJavaMethodSqlca("com.amarsoft.app.configurator.bizlets.DoLibraryAction", "validate", "DoNo=<%=sDoNo%>,ColIndex="+sColIndex+",OldColIndex="+sOldColIndex);
			if(sResult != "SUCCESS"){
				alert(sResult);
				return false;
			}
		}
		return true;
	}
	
	AsOne.AsInit();
	init();
	bFreeFormMultiCol=true;
	my_load(2,0,'myiframe0');
	initRow();
</script>	
<%@ include file="/IncludeEnd.jsp"%>