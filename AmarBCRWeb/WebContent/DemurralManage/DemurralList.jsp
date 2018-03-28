<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	String PG_TITLE = "异议信息列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%	
    String sFlag = CurPage.getParameter("Flag");
    if(sFlag==null) sFlag="";
    String sUserId = CurUser.getUserID();
    if(sUserId==null) sUserId="";
    
    String sReadOnly = "1" ;
	if(sFlag.equals("0")){
		sReadOnly = "0" ;
	}
    
	ASObjectModel doTemp = new ASObjectModel("Demurral");
	doTemp.setVisible("Operate,Flag,Proposer,Applyorg,Operator,Applytime,Operateorg,Operatetime", false);
	if(sFlag.equals("1") || sFlag.equals("4")){
    	doTemp.setJboWhere("Flag='1' ");
    	doTemp.setVisible("CUSTOMERID,DEMURRALPUTOUTNO,DEMURRALREASON,OPERATE,APPLYTIME", true);
    }else if(sFlag.equals("2") || sFlag.equals("3")){
    	doTemp.setJboWhere("Flag=:Flag and Proposer =:Proposer");
    	doTemp.setVisible("CUSTOMERID,DEMURRALPUTOUTNO,OPERATE,APPLYTIME,OPERATETIME",true);
    }else{
    	doTemp.setJboWhere("Flag=:Flag and Proposer =:Proposer");
    	doTemp.setVisible("CUSTOMERID,DEMURRALPUTOUTNO,OPERATE", true);
    }
    //双击事件
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewTab()\"");
    
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	
	dwTemp.genHTMLObjectWindow(sFlag+","+sUserId);

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{sFlag.equals("0") ? "true":"false","","Button","新增申请","新增申请","newApply()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewTab()","","","",""},
		{sFlag.equals("0") ? "true":"false","","Button","提交申请","提交申请","doSubmit()","","","",""},
		{sFlag.equals("0") ? "true":"false","","Button","删除","删除","takeBack()","","","",""},
		{sFlag.equals("4") ? "true":"false","","Button","批准申请","批准申请","approveApply()","","","",""},
		{sFlag.equals("4") ? "true":"false","","Button","退回申请","不同意/退回申请","sendBack()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

<script type="text/javascript">
	function newApply()
	{
		sCompID = "DemurralInfo";
		sCompURL = "/DemurralManage/DemurralInfo.jsp";
		popComp(sCompID,sCompURL,"&ReadOnly=<%=sReadOnly%>","");
		reloadSelf();		
	}
	/*~[Describe=查看/修改详情;InputParam=无;OutPutParam=无;]~*/
	function viewTab()
	{
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		popComp("DemurralInfo","/DemurralManage/DemurralInfo.jsp","SerialNo="+sSerialno+"&ReadOnly="+"<%=sReadOnly%>","");
		reloadSelf();
	}
	/*~[Describe=取消申请;InputParam=无;OutPutParam=无;]~*/
	function takeBack()
	{
		//获得申请类型、申请流水号
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}
		
		if(confirm("你确定要删除该申请？"))//
		{
			as_delete("myiframe0");
		}
	}
	/*~[Describe=批准申请;InputParam=无;OutPutParam=无;]~*/
	function approveApply()
	{
		//获得申请类型、申请流水号
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}
		
		if(confirm("你确定要批准该申请？"))
		{
			var returnValue = PopPage("/DemurralManage/ApproveApply.jsp?Serialno="+sSerialno+"&Flag=2","","resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
		}
		reloadSelf();
	}
	/*~[Describe=提交;InputParam=无;OutPutParam=无;]~*/
	function doSubmit()
	{
		//获得申请类型、申请流水号、流程编号、阶段编号
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}
		if(confirm("你确定要提交该申请？"))
		{
			var returnValue = PopPage("/DemurralManage/ApproveApply.jsp?Serialno="+sSerialno+"&Flag=1","","resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
		}
		reloadSelf();
		
	}
	//退回
	function sendBack()
	{
		//获得申请类型、申请流水号
		var sSerialno=getItemValue(0,getRow(),"SERIALNO");
		
		if (typeof(sSerialno)=="undefined" || sSerialno.length==0)
		{
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}	
		if(confirm("你确定要退回该申请吗？")){
		
			var returnValue = PopPage("/DemurralManage/ApproveApply.jsp?Serialno="+sSerialno+"&Flag=3","","resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
		}
		reloadSelf();	
	}

</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>