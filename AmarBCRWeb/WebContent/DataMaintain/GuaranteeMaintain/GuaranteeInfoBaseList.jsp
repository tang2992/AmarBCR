<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	/*
		页面说明: 示例列表页面
	 */
	String PG_TITLE = "担保业务基础信息";
	//获得页面参数
	String sGBusinessNo =  CurPage.getParameter("GBusinessNo");
	if(sGBusinessNo==null) sGBusinessNo="";
	String sFlag =  CurPage.getParameter("sFlag");
	if(sFlag==null) sFlag="";
	String sTable =  CurPage.getParameter("sTable");
	if(sTable==null) sTable="";
	//在只能查询的模块中隐藏保存按钮
	String IsQuery = CurComp.getParameter("IsQuery");
	if(IsQuery == null) IsQuery = "";

	   //历史表将from条件更改
	if(sFlag.equals("his")||sFlag.equals("Feedback")){		
		sTable=sTable.replace("BCR_", "HIS_");
	}
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr."+sTable.toUpperCase());
	//获取该表的所有的关键字
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
		String sKeyName="";
	for(String key: keyAttrs){
		sKeyName += key+"@";
	}
		
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	 String jBOWhere="";
	jBOWhere="GBusinessNo=:GBusinessNo";
	doTemp.setJboWhere(jBOWhere);
	doTemp.setVisible("Rate,AnnualRate,RecoverySum,LossSum,ChargingStartDate,ChargingEndDate,Attribute1,UpdateDate,,OldFinanceID,Modflag,Tracenumber,Recordflag,Sessionid,Errorcode", false);
	if(sFlag.equals("Feedback")){
		doTemp.setVisible("Sessionid,Errorcode", true);
	}	
	doTemp.setDDDWJbo("InsuredType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='InsuredType'");
	doTemp.setDDDWJbo("CertType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CertType'");
	doTemp.setDDDWJbo("BusinessType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='BusinessType'");
	doTemp.setDDDWJbo("GuarantyType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='GuarantyType'");
	doTemp.setDDDWJbo("CounterType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CounterType'");
	doTemp.setDDDWJbo("InsuredState", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='InsuredState'");
	doTemp.setDDDWJbo("ContractFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='ContractFlag'");
	doTemp.setDDDWJbo("CreditorType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CreditorType'");
	doTemp.setDDDWJbo("CounterGType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CounterGType'");
	doTemp.setDDDWJbo("CounterGFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='CounterGFlag'");
	doTemp.setDDDWJbo("GContractFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='GContractFlag'");
	doTemp.setDDDWJbo("RecoveryFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='RecoveryFlag'");
	doTemp.setDDDWJbo("PayType", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PayType'");
	doTemp.setDDDWJbo("PremiumMode", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PremiumMode'");
	doTemp.setDDDWJbo("PremiumFrequency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PremiumFrequency'");
	doTemp.setDDDWJbo("PremiumState", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PremiumState'");
	doTemp.setDDDWJbo("PeriodPremiumState", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='PeriodPremiumState'");
	doTemp.setDDDWJbo("IncrementFlag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='IncrementFlag'");
	//doTemp.setDDDWJbo("Way", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7535'");
	
	//查询条件
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("GBusinessNo,GContractNo,InsuredName,CertId,BusinessType,GuarantyType,CounterType,InsuredType,InsuredState,CreditorType,Way,ContractFlag,CounterGType,CounterGFlag,GContractFlag,RecoveryFlag,PayType,PremiumMode,PremiumFrequency,PremiumState,PeriodPremiumState,SESSIONID", true);

 	//双击事件
    doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
		
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(10);

	dwTemp.genHTMLObjectWindow(sGBusinessNo);

	String sButtons[][] = {
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{sFlag.equals("Detail")?"true":"false","","Button","查看历史记录","查看历史记录","showHISContent('"+sTable+"','"+sGBusinessNo+"')","","","",""},
		{sFlag.equals("his")?"true":"false","","Button","返回","返回","goBack()","","","",""},
		{sFlag.equals("Feedback")?"true":"false","","Button","重新上报","重新上报","report(2)","","","",""},
		{sFlag.equals("Feedback")?"true":"false","","Button","暂不上报","暂不上报","report(3)","","","",""},
		{sFlag.equals("Feedback")?"true":"false","","Button","漏报补报","补报该条漏报的记录","report(4)","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

	function goBack(){
		top.close();
	}
		
	function viewAndEdit(){
		var sFlag="<%=sFlag%>";
		var sGBusinessNo = getItemValue(0,getRow(),"GBusinessNo");
		var sSessionID = getItemValue(0,getRow(),"SESSIONID");
		if (typeof(sGBusinessNo)=="undefined" || sGBusinessNo.length==0){
			alert("请选择一条记录！");
			return;
		}
		var sKeyValue="";
		var sKeyName="<%=sKeyName%>";
		var sTable="<%=sTable%>";
		for(var i=0;i<sKeyName.split("@").length-1;i++){ 
			sKeyValue+= getItemValue(0,getRow(),sKeyName.split("@")[i])+"@";
		}
		AsControl.OpenView("/DataMaintain/GuaranteeMaintain/GuaranteeInfoBaseInfo.jsp","sSessionID="+sSessionID+"&sKeyName="+sKeyName+"&sKeyValue="+sKeyValue+"&sTable="+sTable+"&IsQuery=<%=IsQuery%>&sFlag="+sFlag,"_self","");
	}
	//显示历史记录
	function showHISContent(sTable,sGBusinessNo){
		AsControl.OpenView("/DataMaintain/GuaranteeMaintain/GuaranteeInfoBaseList.jsp","sFlag=his&sTable="+sTable+"&sGBusinessNo="+sGBusinessNo,"_blank","");
	}
	function report(action){
		var sTableName = "<%=sTable%>";
		var sTraceNumber = getItemValue(0,getRow(),"TRACENUMBER");
		var sSessionID = getItemValue(0,getRow(),"SESSIONID");
		var sGBusinessNo = getItemValue(0,getRow(),"GBusinessNo");
		var sWhere;
		var sReturn;
		
		if(typeof(sSessionID)=="undefined"||sSessionID==''){
			alert("请先选择一条记录!");
			return;		
		}
		//正常已经上报过的业务不能补报或者暂不报
		if(typeof(sSessionID) != "undefined" && sSessionID!="9999999999" && sSessionID!="1111111111" && sSessionID!="0000000000" && sSessionID!="6666666666" &&(action=="2"||action=="3"))
		{
			if(confirm("该笔业务已经上报过了,是否从反馈错误表中删除该条记录?")){
				PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TraceNumber="+sTraceNumber,"_self","");
				alert("该条记录已从反馈错误表中删除!");
				return;
			}
		}
		//没有信息跟踪编号,不能重新上报
		if((typeof(sTraceNumber) == "undefined" || sTraceNumber.length == 0)&&action=="2")
		{
			alert("信息跟踪编号不存在,无法进行重报!");
			return;
		}
		if(action=="2"){
			if(confirm("确定重新上报?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("设置重报标志成功!");
				}else{
					alert("设置重报标志失败!");
				}
			}
		}else if(action=="3"){
			if(confirm("确定暂不上报?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("设置暂不上报标志成功!");
				}else{
					alert("设置暂不上报标志失败!");
				}
			}
		}else if(action=="4"){
			if(confirm("确定反馈补报?")){
			 	var sKeyName="<%=sKeyName%>".split("@");
			var sWhere = " where 1=1 and   "+sKeyName[0]+"='" + getItemValue(0,getRow(), sKeyName[0]) + "'";
	   
	     	
	    		for(var  i=1;i<sKeyName.length;i++){

	    			sKeyValue =  getItemValue(0,getRow(),sKeyName[i]);
	    			if("CIFCUSTOMERID"=="RETURNTIMES")
	    				sWhere = sWhere + " and  "+sKeyName[i]+" ='" + sKeyValue+"'";
	    			else
	    				sWhere = sWhere + " and  "+sKeyName[i]+"='" + sKeyValue + "'";
			 		}
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("设置补报标志成功!");
				}else{
					alert("设置补报标志失败!");
				}
			}
		}
		reloadSelf();
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
