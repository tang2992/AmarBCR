<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
        Author: #{author} #{createddate}
        Content: 示例详情页面
        History Log: 
    */
	String sSerialNo = CurPage.getParameter("SerialNo");
	if(sSerialNo == null) sSerialNo = "";
	String sReadOnly = CurPage.getParameter("ReadOnly");
	if(sReadOnly == null) sReadOnly = "";

	ASObjectModel doTemp = new ASObjectModel("Demurral");
	if(!sSerialNo.equals("")){
		doTemp.setJboWhere("SerialNo=:SerialNo");
	}else{
		doTemp.setJboWhere("1=2");
	}
	doTemp.setVisible("*", true);
	doTemp.setVisible("Serialno,reportType,recordType", false);
	doTemp.setColCount(2);
	//设置必输项
    //设置只读。
    doTemp.setReadOnly("PROPOSER,FLAG,APPLYORG,APPLYORG,APPLYTIME,OPERATOR,OPERATEORG,OPERATETIME,OPERATE",true);
	doTemp.setRequired("CUSTOMERID,DEMURRALPUTOUTNO,REPORTTYPE,REPORTTYPENAME,DEMURRALREASON,OPERATE",true);
	doTemp.setUnit("reportTypeName","<input type=button class=inputDate   value=\"...\" name=button1 onClick=\"javascript:selectType();\"> ");
    doTemp.setUnit("recordTypeName","<input type=button class=inputDate   value=\"...\" name=button1 onClick=\"javascript:selectRelativeType();\"> ");
    doTemp.setEditStyle("Demurralreason", "3");
    doTemp.setHTMLStyle("Demurralreason", "style={height:150px;width:400px;}");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.ReadOnly = sReadOnly;//只读/可写模式
	
	dwTemp.genHTMLObjectWindow(sSerialNo);
	
	String sButtons[][] = {
		{sReadOnly.equals("1")? "false":"true","All","Button","保存","保存所有修改","as_Save()","","","",""},
		{"true","All","Button","返回","返回列表","returnList()","","","",""}
	};
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function as_Save(sPostEvents){
		//as_save("myiframe0","");
		as_save("myiframe0",sPostEvents);
	}
	function returnList(){
		top.close();
	}
	
	function selectType()
	{			
		var sReturn = "";
		var  sStyle = "dialogWidth:580px;dialogHeight:540px;resizable:yes;scrollbars:no;status:no;help:no"
		sReturn = PopComp("SelectMainTypeGridDialog","/DemurralManage/SelcetMainDialog.jsp","",sStyle);
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"REPORTTYPE",sReturnvalues[0]);
		setItemValue(0,0,"REPORTTYPENAME",sReturnvalues[1]);
		setItemValue(0,0,"RECORDTYPE","");
		setItemValue(0,0,"RECORDTYPENAME","");
	}
	
	function selectRelativeType()
	{			
		var sREPORTTYPE = getItemValue(0,0,"REPORTTYPE");
		if(typeof(sREPORTTYPE) == "undefined" || sREPORTTYPE == "")
		{
			alert("请先选择信息类型");//
			return;
		}
		var sReturn = "";
		var  sStyle = "dialogWidth:580px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no"
		if(sREPORTTYPE == "12"){
			sReturn = PopComp("SelectTypeGridDialog","/DemurralManage/SelcetDialog.jsp","ReportType="+sREPORTTYPE,sStyle);
		}else if(sREPORTTYPE == "13"){
			sReturn = PopComp("SelectTypeGridDialog","/DemurralManage/SelcetDialog.jsp","ReportType="+sREPORTTYPE,sStyle);
		}else if(sREPORTTYPE == "14"){
			sReturn = PopComp("SelectTypeGridDialog","/DemurralManage/SelcetDialog.jsp","ReportType="+sREPORTTYPE,sStyle);
		}else if(sREPORTTYPE == "17"){
			sReturn = PopComp("SelectTypeGridDialog","/DemurralManage/SelcetDialog.jsp","ReportType="+sREPORTTYPE,sStyle);
		}else if(sREPORTTYPE == "22"){
			sReturn = PopComp("SelectTypeGridDialog","/DemurralManage/SelcetDialog.jsp","ReportType="+sREPORTTYPE,sStyle);
		}else if(sREPORTTYPE == "25"){
			sReturn = PopComp("SelectTypeGridDialog","/DemurralManage/SelcetDialog.jsp","ReportType="+sREPORTTYPE,sStyle);
		}else{
			alert("该信息类型下没有细分记录类型!");
		}
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"RECORDTYPE",sReturnvalues[0]);
		setItemValue(0,0,"RECORDTYPENAME",sReturnvalues[1]);
	}

	function iniRow(){
		if(getRowCount(0)==0){
			setItemValue(0,0,"Flag","0");
			setItemValue(0,0,"Operate","2");
			setItemValue(0,0,"Proposer","<%=CurUser.getUserID()%>");
			setItemValue(0,0,"Applyorg","<%=CurUser.getOrgID()%>");
			setItemValue(0,0,"Applytime",'<%=DateX.format(new java.util.Date(),"yyyy/MM/dd HH:mm:ss")%>');
		}
	}
	
	iniRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>