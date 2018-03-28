<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		页面说明:文档基本信息
		Input Param:
		     ObjectNo: 对象编号
             ObjectType: 对象类型
             DocNo: 文档编号
	 */
 	sASWizardHtml = "<div><font size=\"2pt\" color=\"#930055\">&nbsp;&nbsp;文档基本信息</font></div>";
	//定义变量
	String sObjectNo = "";//--对象编号
	//获得组件参数
	String sObjectType = CurPage.getParameter("ObjectType");
	String sRightType = CurPage.getParameter("RightType");//权限
	if(sRightType == null) sRightType = "";
	if(sObjectType == null) sObjectType = "";
	if(sObjectType.equals("Customer"))
	 	sObjectNo = CurPage.getParameter("CustomerID");
	else
		sObjectNo=  CurPage.getParameter("ObjectNo");
	if(sObjectNo == null) sObjectNo = "";
	//获得页面参数，文档编号和文档录入人ID
	String sDocNo = CurPage.getParameter("DocNo");
	String sUserID = CurPage.getParameter("UserID");
	if(sDocNo == null) sDocNo = "";
	if(sUserID == null) sUserID = "";

	ASObjectModel doTemp = new ASObjectModel("DocumentInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // 设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // 设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sDocNo);

	String sButtons[][] = {
		{(CurUser.getUserID().equals(sUserID)?"true":"false"),"","Button","保存","保存所有修改","saveRecord()","","","",""},
		{(CurUser.getUserID().equals(sUserID)?"false":"false"),"","Button","查看/修改附件","查看/修改选中文档相关的所有附件","viewAndEdit_attachment()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(sPostEvents){
		as_save("myiframe0",sPostEvents);
	}

	<%/*~[Describe=查看附件详情;]~*/%>
	function viewAndEdit_attachment(){
		var sDocNo = getItemValue(0,getRow(),"DocNo");
		var sUserID = getItemValue(0,getRow(),"UserID");//取录入人ID
		var sRightType="<%=sRightType%>";
		if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
        	alert("请先保存文档内容，再上传附件！");  //请选择一条记录！
			return;
    	}else{
			AsControl.OpenPage("/AppConfig/Document/AttachmentFrame.jsp", "DocNo="+sDocNo+"&UserID="+sUserID+"&RightType="+sRightType, "frameright");
    		reloadSelf();
		}
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>