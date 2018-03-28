<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content: 代码表详情
	 */
	//定义变量
	String sDiaLogTitle = "";
	String sCodeNo =  CurPage.getParameter("CodeNo"); //代码编号
	String sItemNo =  CurPage.getParameter("ItemNo"); //项目编号
	String sCodeName =  CurPage.getParameter("CodeName");
	//将空值转化为空字符串
	if(sCodeNo == null) sCodeNo = "";
	if(sItemNo == null) sItemNo = "";
	if(sCodeName == null) sCodeName = "";
	
	if(sCodeNo.equals("")){
		sDiaLogTitle = "【 代码库新增配置 】";
	}else{
		if(sItemNo==null || sItemNo.equals("")){
			sItemNo="";
			sDiaLogTitle = "【"+sCodeName+"】代码：『"+sCodeNo+"』新增配置";
		}else{
			sDiaLogTitle = "【"+sCodeName+"】代码：『"+sCodeNo+"』查看修改配置";
		}
	}

	ASObjectModel doTemp = new ASObjectModel("CodeItemInfo");
	if(!sCodeNo.equals("")){
		doTemp.setVisible("CodeNo",false); 
	}else{
		doTemp.setRequired("CodeNo",true);
	} 
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sCodeNo+","+sItemNo);
	
	String sButtons[][] = {
		{"true","","Button","保存","保存修改","saveRecord()","","","",""},
		{"true","","Button","保存并新增","保存后新增","saveAndNew()","","","",""}			
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(sPostEvents){
		setItemValue(0,0,"CodeNo","<%=sCodeNo%>");
		as_save("myiframe0",sPostEvents);
	}
	
	function saveAndNew(){
		saveRecord("newRecord()");
	}
   
	function newRecord(){
        OpenComp("CodeItemInfo","/Common/Configurator/CodeManage/CodeItemInfo.jsp","CodeNo=<%=sCodeNo%>&CodeName=<%=sCodeName%>","_self");
	}
	setDialogTitle("<%=sDiaLogTitle%>");
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>