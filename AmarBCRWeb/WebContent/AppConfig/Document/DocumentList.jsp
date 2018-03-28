<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		页面说明:文档信息列表
		Input Param:
       		    ObjectNo: 对象编号
       		    ObjectType: 对象类型           		
	 */
	String PG_TITLE = "文档信息列表";
	//定义变量                     
	String sObjectNo = "";//--对象编号
	
	//获得组件参数
	String sObjectType = CurPage.getParameter("ObjectType");
	String sRightType = CurPage.getParameter("RightType");//权限
	if(sObjectType == null) sObjectType = "";
	if(sRightType == null) sRightType = "";
	if(sObjectType.equals("Customer"))
	 	sObjectNo = CurPage.getParameter("CustomerID");
	else
		sObjectNo = CurPage.getParameter("ObjectNo");
	if(sObjectNo == null) sObjectNo = "";

	ASObjectModel doTemp = new ASObjectModel("DocumentList");
	if(sObjectType.equals("Customer")) //客户文档
		doTemp.appendJboWhere(" AND DOC_RELATIVE.OBJECTTYPE='Customer' ");
	else doTemp.appendJboWhere(" AND DOC_RELATIVE.OBJECTTYPE<>'Customer' ");
	
	//根据对象编号进行查询
    if (!sObjectNo.equals(""))
    	doTemp.appendJboWhere(" AND DR.ObjectNo='" + sObjectNo + "' ");
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(25);
	dwTemp.genHTMLObjectWindow(sObjectType);

	String sButtons[][] = {
		{"true","","Button","新增","新增文档信息","newRecord()","","","",""},
		{"true","","Button","删除","删除文档信息","deleteRecord()","","","",""},
		{"false","","Button","文档详情","查看文档详情","viewAndEdit_doc()","","","",""},
		{"false","","Button","附件详情","查看附件详情","viewAndEdit_attachment()","","","",""},
		{"false","","Button","导出附件","导出附件文档信息","exportFile()","","","",""},
	};
	if(sObjectNo.equals("")){
		sButtons[0][0]="false";
		sButtons[1][0]="false";
	}
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.OpenComp("/AppConfig/Document/DocumentInfo.jsp","UserID=<%=CurUser.getUserID()%>","rightdown");
	}

	function deleteRecord(){
		var sUserID=getItemValue(0,getRow(),"UserID");//取文档录入人	
		var sDocNo = getItemValue(0,getRow(),"DocNo");
		if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
			alert(getHtmlMessage(1));  //请选择一条记录！
			return;
		}else if(sUserID=='<%=CurUser.getUserID()%>'){
			if(confirm(getHtmlMessage(2))){ //您真的想删除该信息吗？
				as_delete('myiframe0');
			}
		}else{
			alert(getHtmlMessage('3'));
			return;
		}
	}

	<%/*~[Describe=查看及修改详情;]~*/%>
	function viewAndEdit_doc(){
		var sDocNo=getItemValue(0,getRow(),"DocNo");
		var sUserID=getItemValue(0,getRow(),"UserID");//取文档录入人		     	
    	if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
        	alert(getHtmlMessage(1));  //请选择一条记录！
			return;
    	}else{
    		AsControl.OpenComp("/AppConfig/Document/DocumentInfo.jsp","DocNo="+sDocNo+"&UserID="+sUserID,"rightdown");
        }
	}
	
	<%/*~[Describe=查看及修改附件详情;]~*/%>
	function viewAndEdit_attachment(){
    	var sDocNo=getItemValue(0,getRow(),"DocNo");
    	var sUserID=getItemValue(0,getRow(),"UserID");//取文档录入人
    	var sRightType="<%=sRightType%>";
    	if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
        	alert(getHtmlMessage(1));  //请选择一条记录！
			return;         
    	}else{
    		//AsControl.PopComp("/AppConfig/Document/AttachmentList.jsp","DocNo="+sDocNo+"&UserID="+sUserID+"&RightType="+sRightType);
    		AsControl.PopComp("/AppConfig/Document/AttachmentFrame.jsp", "DocNo="+sDocNo+"&UserID="+sUserID+"&RightType="+sRightType, "");
    		reloadSelf();
      	}
	}
	
	<%/*~[Describe=导出附件;]~*/%>
	function exportFile(){
    	OpenPage("/AppConfig/Document/ExportFile.jsp","_self","");
	}
	function mySelectRow(){
		var sDocNo=getItemValue(0,getRow(),"DocNo");
		var sUserID=getItemValue(0,getRow(),"UserID");//取文档录入人		     	
    	if (typeof(sDocNo)=="undefined" || sDocNo.length==0){
        	alert(getHtmlMessage(1));  //请选择一条记录！
			return;
    	}else{
    		AsControl.OpenComp("/AppConfig/Document/DocumentFrameMix.jsp","DocNo="+sDocNo+"&UserID="+sUserID,"rightdown");
        }
	}
	mySelectRow();
</script>
<%@	include file="/Frame/resources/include/include_end.jspf"%>