<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	String PG_TITLE = "多法人报文生成";

	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.ORG_TASK_INFO");
	ASObjectModel doTemp = new ASObjectModel(boManager);

	if(!"system".equals(CurUser.getUserID()))
		doTemp.setJboWhere(" O.OrgCode='" + CurUser.getRelativeOrgID()+ "'"); 
		
	doTemp.setJboOrder(" O.SortNo ");
	doTemp.setVisible("Attribute1,Sortno,Taskrundate", false);
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("Orgid,Orgname,Orgcode", true);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(10);
	dwTemp.MultiSelect = true; //允许多选
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
			{"true","","Button","报文生成","执行报文生成任务","doReport()","","","","",""},
			{"system".equals(CurUser.getUserID())?"true":"false","","Button","添加机构","添加报文生成机构","newRecord()","","","","",""},
			{"system".equals(CurUser.getUserID())?"true":"false","","Button","修改机构信息","修改报文生成机构","viewAndEdit()","","","","",""},
			{"true","","Button","查看联系人信息","查看机构联系人信息","viewContact()","","","","",""},
			{"system".equals(CurUser.getUserID())?"true":"false","","Button","查看所有联系人","查看所有机构联系人信息","viewAllContact()","","","","",""},
			{"system".equals(CurUser.getUserID())?"true":"false","","Button","删除","删除报文生成机构","deleteRecord()","","","","",""},
	};
%><%@
include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		OpenPage("/WebTask/OrgAndContactFrame.jsp?isNew=1","_self","");
		reloadSelf();
	}

	function deleteRecord(){
		var ORGID = getItemValue(0,getRow(),"OrgId");
		if (typeof(ORGID)=="undefined" || ORGID.length==0){
			alert("请选择一条记录！");
			return;
		}		
		if(confirm("您真的想删除该信息吗？")){
			as_delete("myiframe0");
		} 
	}
	
	function viewAndEdit(){
		var sOrgId = getItemValue(0,getRow(),"OrgId");
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if (typeof(sOrgId)=="undefined" || sOrgId.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
		}else{
			//OpenPage("/Icr/WebTask/ReportOrgInfo.jsp?OrgId="+sOrgId,"_self","");
			OpenPage("/WebTask/OrgAndContactFrame.jsp?OrgId="+sOrgId+"&OrgCode="+sOrgCode,"_self","");
		}
	}
	
	function viewContact(){
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if (typeof(sOrgCode)=="undefined" || sOrgCode.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
		}else{
			popComp("ContactPersons","/WebTask/ContactPersons.jsp","OrgCode="+sOrgCode,"dialogWidth=800px;dialogHeight=600px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			//OpenPage("/Icr/WebTask/ContactPersons.jsp?OrgCode="+sOrgCode,"_self","");
		}
	}
	
	function viewAllContact(){
		popComp("ContactPersonList","/WebTask/ContactPersonList.jsp","","dialogWidth=800px;dialogHeight=600px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		//OpenPage("/Icr/WebTask/ContactPersonList.jsp?","_self","");
	}
	
	function doReport(){
		var rows= getCheckedRows(0);
		if(rows.length<1){
			alert("您没有勾选任何行");
			return;
		}else{
			var orglist = "";
			for(var i =0;i<rows.length;i++){
				orglist = orglist+"~"+getItemValue(0,rows[i],"OrgId");
			}
		}
		if(typeof(orglist)!="undefined"||orglist.length!=0){
		orglist = orglist.substring(1);
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun",
				"taskName=report,orgList="+orglist+",userID=<%=CurUser.getUserID()%>");
		alert(ret);
		return;
		}
		reloadSelf();
	}
	
</script>	
<%@
 include file="/Frame/resources/include/include_end.jspf"%>