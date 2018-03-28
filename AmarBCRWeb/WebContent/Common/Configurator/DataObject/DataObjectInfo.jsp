<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: 数据对象目录详情
	 */
	String PG_TITLE = "数据对象目录详情"; // 浏览器窗口标题 <title> PG_TITLE </title>
	
	//获得组件参数	
	String sDoNo =  CurPage.getParameter("DoNo");
	if(sDoNo==null) sDoNo="";

	ASDataObject doTemp = new ASDataObject("DataObjectInfo",Sqlca);
	
	if (sDoNo.equals("") || sDoNo.equals("null")) {
 	  	doTemp.setRequired("DONO",true);
		doTemp.setReadOnly("DONO",false);
	}else{
		doTemp.setRequired("DONO",false);
		doTemp.setReadOnly("DONO",true);
	}
			
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	//生成HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow(sDoNo);
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
	String sButtons[][] = {
		{"true","","Button","保存","保存修改","saveRecord()","","","",""}
	};
%><%@include file="/Resources/CodeParts/List05.jsp"%>
<script type="text/javascript">
	function saveRecord(){
	    var sDoNo = getItemValue(0,getRow(),"DONO");
	    as_save("myiframe0","openDOView('"+sDoNo+"')");
	}
	
	function openDOView(sDoNo){
		parent.AsControl.OpenView("/Frame/ObjectViewer.jsp","ObjectType=DataObject&ObjectNo="+sDoNo+"&ViewID=001","_self");
	}
    
	function initRow(){
		if (getRowCount(0)==0){
			as_add("myiframe0");
			bIsInsert = true;
		}
	}

	$(document).ready(function(){
		AsOne.AsInit();
		init();
		my_load(2,0,'myiframe0');
		initRow();
	});
</script>	
<%@ include file="/IncludeEnd.jsp"%>