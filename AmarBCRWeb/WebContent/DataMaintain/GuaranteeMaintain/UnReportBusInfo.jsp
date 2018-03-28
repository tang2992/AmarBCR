<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		页面说明: 用户信息详情
	 */
	String PG_TITLE = "用户信息详情";
	
	//获得页面参数	
	String sMainBusinessNo =  CurPage.getParameter("MainBusinessNo");
	if(sMainBusinessNo==null) sMainBusinessNo="";
	System.out.println("sMainBusinessNo================="+sMainBusinessNo);
	//通过显示模版产生ASDataObject对象doTemp
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_UNREPORTBUSINESSNO");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(" MAINBUSINESSNO=:MAINBUSINESSNO ");
	
	doTemp.setRequired("MAINBUSINESSNO",true);
	doTemp.setReadOnly("InputDate", true);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // 设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // 设置是否只读 1:只读 0:可写
	
	dwTemp.genHTMLObjectWindow(sMainBusinessNo);

	String sButtons[][] = {
		{"true","","Button","保存并返回","保存并返回","saveRecord()","","","",""},
		{"true","","Button","返回","返回到列表界面","doReturn('Y')","","","",""}		
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		as_save("myiframe0","doReturn('Y')");
	}
    
    function doReturn(sIsRefresh){
        OpenPage("/DataMaintain/GuaranteeMaintain/UnReportBusList.jsp","_self","");
	}
	/*~[Describe=页面装载时，对DW进行初始化;InputParam=无;OutPutParam=无;]~*/
	function initRow(){
		if (getRowCount(0)==0){
			setItemValue(0,0,"InputDate","<%=StringFunction.getToday()%>");
			bIsInsert = true;
		}
	}
	initRow();
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>