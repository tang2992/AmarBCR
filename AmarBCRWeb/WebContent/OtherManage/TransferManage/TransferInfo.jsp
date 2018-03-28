<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
        Author: #{author} #{createddate}
        Content: 示例详情页面
        History Log: 
    */
	String sMainBusinessNo = CurPage.getParameter("MainBusinessNo");
	if(sMainBusinessNo == null) sMainBusinessNo = "";
	String sRecordScope = CurPage.getParameter("RecordScope");
	if(sRecordScope == null) sRecordScope = "";
	String sFilterCause = CurPage.getParameter("FilterCause");
	if(sFilterCause == null) sFilterCause = "";
	String sType = CurPage.getParameter("sType");
	if(sType == null) sType = "";

	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.ECR_TRANSFERFILTER"));

	doTemp.setRequired("MainBusinessNo,RecordScope,FilterCause",true);
	doTemp.setReadOnly("UpdateTime,Operator",true);
	doTemp.setEditStyle("Note","3");
	doTemp.setEditStyle("FilterCause,Recordscope","Select");
	doTemp.setDDDWJbo("FilterCause","jbo.ecr.CODE_LIBRARY,ItemNo,ItemName,CodeNo='FilterCause'");
	doTemp.setDDDWJbo("Recordscope","jbo.ecr.CODE_LIBRARY,ItemNo,ItemName,CodeNo='Recordscope'");
		if((!sMainBusinessNo.equals(""))||(!sRecordScope.equals("")))
	{	
		doTemp.setReadOnly("MainBusinessNo,RecordScope,FilterCause",true);
		doTemp.setJboWhere("O.MainBusinessNo=:MainBusinessNo and O.RecordScope=:RecordScope and O.FilterCause=:FilterCause");
	}
	if(sType.equals("1")){	
		doTemp.setReadOnly("FilterCause",true);
	    doTemp.setReadOnly("MainBusinessNo,RecordScope",false);
	}
	doTemp.setAlign("*", "1");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform

	dwTemp.genHTMLObjectWindow(sMainBusinessNo+","+sRecordScope+","+sFilterCause);
	
	String sButtons[][] = {
		{"true","All","Button","保存","保存所有修改","saveRecord()","","","",""},
		{"true","All","Button","返回","返回列表","returnList()","","","",""}
	};
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
var bIsInsert=false;
function saveRecord()
{	
	as_save("myiframe0","");
}

function returnList()
{
	top.close();
}

function initRow()
{
	if (getRowCount(0)==0) //如果没有找到对应记录，则新增一条，并设置字段默认值
	{
		setItemValue(0,0,"Operator","<%=CurUser.getUserID()%>");
		setItemValue(0,0,"Updatetime","<%=StringFunction.getToday()%>");
		if("<%=sType%>"==1)
			setItemValue(0,0,"Filtercause","T");
	}
}
</script>
<script type="text/javascript">	
	initRow(); //页面装载时，对DW当前记录进行初始化
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>