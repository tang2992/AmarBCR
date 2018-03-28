<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "反馈信息列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%	

	String sRecordType = CurComp.getParameter("recordType");
	if(sRecordType == null) sRecordType = "";
	
	/* BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.ECR_FEEDBACK");
	ASObjectModel doTemp = new ASObjectModel(boManager); */
	ASObjectModel doTemp = new ASObjectModel("ECRFEEDBACK"); 
	
	String jBOWhere =" recordType not in ('73','74') ";//删除反馈不需要处理，删除只需知道是否成功
	if(!sRecordType.equals("")){
		jBOWhere  += "  and  recordType =:recordType";
	}
	if(!CurUser.getUserID().equals("system")){
		jBOWhere = jBOWhere+" and O.FINANCEID IN (select UO.Orgid from jbo.ecr.ORG_TASK_INFO UO where UO.OrgCode='"+CurUser.getRelativeOrgID()+"')";
	}  
	doTemp.setJboWhere(jBOWhere);
	
	//设置双击属性
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewDetail()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	//设置单页显示20行 
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sRecordType);

%>

	<%
	String sButtons[][] = {
			{"true","","Button","详情","进入修改界面","viewDetail()","","","",""},
			{"true","","Button","删除","确认已修改,删除该记录","deleteRecord()","","","",""},
	    	{"true","","Button","导出EXCEL","导出EXCEL","as_defaultExport()","","","",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">

	//---------------------定义按钮事件------------------------------------
	
	/*~[Describe=查看/修改详情;InputParam=无;OutPutParam=无;]~*/

	function viewDetail(){
		var sTRACENUMBER = getItemValue(0,getRow(),"TRACENUMBER");
		if (typeof(sTRACENUMBER)=="undefined" || sTRACENUMBER.length==0)
		{
			alert("请选择一条记录！");
			return;
		}

		var sMAINBUSINESSNO = getItemValue(0,getRow(),"MAINBUSINESSNO");
		var sLOANCARDNO = getItemValue(0,getRow(),"LOANCARDNO");
		var sCUSTOMERID = getItemValue(0,getRow(),"CUSTOMERID");
		var sRECORDTYPE = getItemValue(0,getRow(),"RECORDTYPE");
		var sRECORDKEY  = getItemValue(0,getRow(),"RECORDKEY");

		if(!(typeof(sMAINBUSINESSNO)=="undefined" || sMAINBUSINESSNO.length==0)){
			if((parseInt(sRECORDTYPE )<8) || (parseInt(sRECORDTYPE)>=43&&parseInt(sRECORDTYPE)<=47)){
				var sRetrun = popComp("FeedBackInfoDetail","/ErrorManage/FeedBackManage/FeedBackInfoDetail.jsp","CUSTOMERID="+sCUSTOMERID+"&sRECORDTYPE="+sRECORDTYPE,"");
				if(sRetrun=="false"){
					alert("这条反馈信息对应的业务信息已经不存在,请删除这条记录!");
				}
			}else if(parseInt(sRECORDTYPE)>70 && parseInt(sRECORDTYPE)<=78){//机构反馈
				var sRetrun = popComp("FeedBackOrganDetail","/ErrorManage/FeedBackManage/FeedbackOrgan/FeedBackOrganTreeview.jsp","MAINBUSINESSNO="+sMAINBUSINESSNO+"&sRECORDTYPE="+sRECORDTYPE,"");
				if(sRetrun=="false"){
					alert("这条反馈信息对应的业务信息已经不存在,请删除这条记录!");
				}
			}else{
				var sRetrun = popComp("FeedBackInfoDetail","/ErrorManage/FeedBackManage/FeedBackInfoDetail.jsp","MAINBUSINESSNO="+sMAINBUSINESSNO+"&LOANCARDNO="+sLOANCARDNO+"&RECORDKEY="+sRECORDKEY+"&sRECORDTYPE="+sRECORDTYPE,"");
				if(sRetrun=="false"){
					alert("这条反馈信息对应的业务信息已经不存在,请删除这条记录!");
				}
			}
		}
		reloadSelf();
	}
	function deleteRecord()
	{
		var sTRACENUMBER = getItemValue(0,getRow(),"TRACENUMBER");
		if (typeof(sTRACENUMBER)=="undefined" || sTRACENUMBER.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		
		if(confirm("您真的想删除该信息吗？")) 
		{
			as_delete("myiframe0","reloadSelf()");
		}
	}

	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>